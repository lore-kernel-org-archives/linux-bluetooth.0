Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20120329091236.GA22600@x220>
References: <1332892776-12060-1-git-send-email-andre.guedes@openbossa.org>
	<1332892776-12060-3-git-send-email-andre.guedes@openbossa.org>
	<20120329091236.GA22600@x220>
Date: Thu, 29 Mar 2012 14:13:10 -0300
Message-ID: <CACJA=fWJ_u7CMW0+8XMjbV5kxZ7y8PrsEFh7p2dEBsOTSnBLXg@mail.gmail.com>
Subject: Re: [RFC 2/3] Bluetooth: Add dst_type parameter to hci_connect
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

On Thu, Mar 29, 2012 at 6:12 AM, Johan Hedberg <johan.hedberg@gmail.com> wrote:
> Hi Andre,
>
> On Tue, Mar 27, 2012, Andre Guedes wrote:
>> +             le->dst_type = (dst_type == MGMT_ADDR_LE_RANDOM) ?
>> +                             ADDR_LE_DEV_RANDOM : ADDR_LE_DEV_PUBLIC;
>
> You might want to make a simple helper function for the type conversion.
>
> Also, I'm not so sure it's a good idea to directly reuse mgmt API
> defines for the L2CAP socket interface. The values may in the end be the
> same but probably there should be separate defines in l2cap.h.

I'm not sure too.

I think it would be better we define address type macros in
bluetooth.h and replace its prefix by BDADDR_TYPE_. So we would have
something like this in bluetooth.h:

+/* BD Address type */
+#define BDADDR_TYPE_BREDR      0x00
+#define BDADDR_TYPE_LE_PUBLIC  0x01
+#define BDADDR_TYPE_LE_RANDOM  0x02
+#define BDADDR_TYPE_INVALID    0xff

What do you think?

Thanks,

Andre
