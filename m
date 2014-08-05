Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CABBYNZJsbwsT9d5AxpDwtWVZFw60mY5TevGbTJqO_AowV4G2fw@mail.gmail.com>
References: <34DE67E73839C446B4269BCE8A1F303A01248EBDD5@CAMEUREXM01.EUROPE.ROOT.PRI>
	<CABBYNZJsbwsT9d5AxpDwtWVZFw60mY5TevGbTJqO_AowV4G2fw@mail.gmail.com>
Date: Tue, 5 Aug 2014 13:55:33 +0200
Message-ID: <CANq1E4SdffkdwvH1WhjqZ9V0GHLs0TUq-rQRj7tEVvhuzQL-TA@mail.gmail.com>
Subject: Re: Re: HoG: Support multi output report
From: David Herrmann <dh.herrmann@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Murat Kilivan <Murat.Kilivan@csr.com>,
	Aravind Parvathala <Aravind.Parvathala@csr.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi

On Mon, Aug 4, 2014 at 10:21 AM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>> What did you mean by another instance? Is there a way to configure the blue-z stack to create separate instances (are they hidraw device instances or something else) for each of the HID output report?
>
> Take a look at android/hog.c it supports multiple instances already
> you basically can have more than one HID service in your primaries
> which I believe is what PTS does.
>
>> Any suggestions on how to achieve that? Can the HID report map be configured such that there are two different collections, each with one output report so that the kernel enumerates them as two different device instances?
>
> They are two completely separate instances with their own report map
> and in that case we would create each individual instance as a
> separate uHID device.
>
> @David: If we got multiple output reports how do the driver discover them?

Ok, I now took the time to read through the HoG specs. It says:

    "For data transferred to HID Device from Report Host,
     Report ID is removed from data received from a
     USB HID Class driver before being transmitted to the
     HID Device (usually a write command to a Report
     characteristic value or as a write request to a
     Report characteristic value for HID Service data)."

Each UHID_OUTPUT message received by BlueZ contains the report-ID as
1-byte prefix of the message. Therefore, you're supposed to strip it
from the message and forward it to the right target.

I have no idea how GATT works, but I assume you write to an attribute
that is named after the report-ID of the output report. So you parse
this 1-byte prefix, select the correct attribute based on this
information and then send the message (without the 1-byte prefix) to
the selected attribute.

Looking at hog.c in the input-profile, I can see this:


        static int report_type_cmp(gconstpointer a,
                                                gconstpointer b)
        {
               const struct report *report = a;
               uint8_t type = GPOINTER_TO_UINT(b);

               return report->type - type;
        }

        ...forward_report()...
        l = g_slist_find_custom(hogdev->reports,
                                                GUINT_TO_POINTER(type),
                                                report_type_cmp);
        if (!l)
               return;

Now I assume you rather want this:

        static int report_type_cmp(gconstpointer a,
                                                gconstpointer b)
        {
                const struct report *report = a;
                const struct report *cmp = b;

                if (report->type != cmp->type)
                       return report->type - cmp->type;

                return report->id - cmp->id;
        }

        ...forward_report()...
        struct report rep = { .type = HOGP_REPORT_TYPE_OUTPUT,
                                .id = hogdev->has_report_id ?
ev->u.output.data[0] : 0 };
        l = g_slist_find_custom(hogdev->reports,
                                                &rep,
                                                report_type_cmp);
        if (!l)
               return;

(sorry for the formatting.. I hope you get my point)

Note that your hack with "hogdev->has_report_id" is no longer needed
in my new UHID extensions. The kernel then informs you whether the
device uses report-IDs or not. That is, you know for sure whether the
first byte of a message is a report-ID or whether it must be skipped.

Thanks
David
