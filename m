Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CABBYNZLvF_SeW80apJaZH44Yzr83f304nkztdyHRQh2-u_sDEA@mail.gmail.com>
References: <45F17F5803927D43967AFEED068E781E0879A30E@CAMEUREXM02.EUROPE.ROOT.PRI>
	<20140724083116.GB9891@t440s.lan>
	<45F17F5803927D43967AFEED068E781E0879ACDB@CAMEUREXM02.EUROPE.ROOT.PRI>
	<20140724100820.GA13332@t440s.lan>
	<CANq1E4QBGf68iHuhLX8SX4A=Rokg4p6OWpgY1hMKhnJvze4PGA@mail.gmail.com>
	<CABBYNZJgxPy1qpqNuB-wW7Pq5dh_zixQG0x2J0=icddvwdg1_A@mail.gmail.com>
	<CANq1E4QNBP_fGpcxzgsg=gh4aGDXFdi-+Abx=OsK74v9f-kwRQ@mail.gmail.com>
	<CABBYNZLvF_SeW80apJaZH44Yzr83f304nkztdyHRQh2-u_sDEA@mail.gmail.com>
Date: Mon, 28 Jul 2014 17:15:16 +0200
Message-ID: <CANq1E4TO1D3wy7_fDOeN-c7+8BGczWAdeYDz+rY4FYCdEsQMfw@mail.gmail.com>
Subject: Re: Bluetooth Low Energy service crash report - when trying read a
 HID feature report
From: David Herrmann <dh.herrmann@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Murat Kilivan <Murat.Kilivan@csr.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi

On Mon, Jul 28, 2014 at 12:21 PM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> Hi David, Murat,
>
> On Mon, Jul 28, 2014 at 11:53 AM, David Herrmann <dh.herrmann@gmail.com> wrote:
>> Hi
>>
>>>> The kernel bails out if size==0, so this never happens. The bt_uhid_*
>>>> helpers are fine, however, hog.c forward_report() is totally broken.
>>>> You use:
>>>>
>>>> bt_uhid_register(hogdev->uhid, UHID_OUTPUT, forward_report, hogdev);
>>>> bt_uhid_register(hogdev->uhid, UHID_FEATURE, forward_report, hogdev);
>>>>
>>>> Therefore, you register *THE SAME* handler for UHID_OUTPUT *AND*
>>>> UHID_FEATURE. However, in forward_report() you access ev->u.output,
>>>> but this is only valid for UHID_OUTPUT. If you get a UHID_FEATURE
>>>> report you must never access anything but ev->u.feature!
>>>
>>> Does the ev->u.features structure matches HID protocol, can I send as
>>> it is or do I need to reformat it?
>>
>> The uhid.h header includes these definitions:
>>
>> struct uhid_feature_req {
>>         __u32 id;
>>         __u8 rnum;
>>         __u8 rtype;
>> } __attribute__((__packed__));
>>
>> struct uhid_feature_answer_req {
>>         __u32 id;
>>         __u16 err;
>>         __u16 size;
>>         __u8 data[UHID_DATA_MAX];
>> } __attribute__((__packed__));
>
> That I got it, what I was asking was if that is the exact same format
> used in HID so that I could sent as it is to the remote device. Im
> afraid the answer is no because id and some other fields seems to be
> just for context tracking as you mention bellow.

Sorry, I wasn't really clear. uhid_feature_req contains 3 fields:

"id" contains a random ID from the kernel. This has no meaning besides
tracking feature_req and feature_answer_req. That is, once your device
answers to the feature request, you must copy the ID into the
uhid_feature_answer_req and send it to the kernel. Note that UHID ever
only has one uhid_feature_req is parallel. Therefore, you can safe the
"id" field in some global context and use it for the next
uhid_feature_answer_req you send. If the kernel cancelled a request
(timeout, interrupted, ...), it will ignore any answer with that ID in
the future.

"rnum": This is the report-number of the feature request.

"rtype": This is the report-type of the feature request. It can be
INPUT, OUTPUT or FEATURE. This is really misleading as you might
expect this is always FEATURE. That's not true though. The
UHID_FEATURE request really should have been called UHID_GET_REPORT.

What you should do once you receive a UHID_FEATURE event from the
kernel, is send a GET_REPORT request to the device. Setting the
report-number to "rnum" and the report-type to "rtype". Once the
device answers to the GET_REPORT, write a "uhid_feature_answer_req" to
the kernel by copying the "id" into it and the answer from the device.
"err" should be set to 0. If something failed, set "err" to a
error-number and leave the other fields untouched (besides "id"). The
answer from the device should be copied untouched into "data" and
"size" set to the length.

The GET_REPORT logic is described in the HIDP specs, so I guess the
HoG specs contain it, too. Note that the spec only allows a _single_
GET_REPORT requests at a time. Therefore, if you sent one out, you
must wait for the answer before sending a new one. Luckily, the kernel
enforces this, so it only sends a new request in case the old one
timed out (5s I think, or 1s?). You can safely do the same in HoG.

>>>> Furthermore, if you receive UHID_FEATURE, the kernel blocks until you
>>>> send the answer as UHID_FEATURE_ANSWER.
>>>
>>> So if I got this right in addition to send the request we should
>>> process the response as UHID_FEATURE_ANSWER otherwise it will block
>>> other events?
>>
>> Kernel HID drivers can use a kernel-internal function to query an
>> HID-feature. This call is blocking and waits for the answer from the
>> device. uhid copied that design to avoid rewriting all drivers.
>> Therefore, IFF you get an UHID_FEATURE event, you have to send the
>> feature request to the device, somewhere store the context, and once
>> the device answers you have to find that context again and write the
>> answer via UHID_FEATURE_ANSWER to the kernel. The "id" field in
>> uhid_feature_req and uhid_feature_answer_req must match and are used
>> for context-tracking.
>>
>> Note that this is only used for HID drivers that require synchronous
>> feature queries. All other drivers use UHID_OUTPUT for all outoing
>> reports. The "rtype" field specifies whether it's an INPUT, OUTPUT or
>> FEATURE report that has to be written. It it thus totally ok to ignore
>> UHID_FEATURE as only few drivers use it.
>
> @Murat, I guess your input is needed here, why are you using
> UHID_FEATURE instead of UHID_OUTPUT? Can we drop UHID_FEATURE or your
> driver really requires it?

I really recommend reading Documentation/hid/hid-transport.txt in the
kernel sources. It's a pretty new document (linux-3.14 I think), but
it describes the design of generic HID transport drivers in detail.
The kernel-internal APIs have been adjusted accordingly, UHID still
follows the old style. I'm currently reworking the API. I will put
linux-bluetooth on CC once ready.
It should be a lot easier to write HoG when you understand these
internals, and hid-transport.txt was written for exactly that purpose.
Please provide feedback to linux-input@vger.kernel.org in case
something is unclear. If you put me on CC, I promise to answer any
questions.

Thanks
David
