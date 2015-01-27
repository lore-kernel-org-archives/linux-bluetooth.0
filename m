Return-Path: <cyrus@holtmann.org>
From: Gilbert Gao <Gilbert.Gao@Qisda.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
CC: Marcel Holtmann <marcel@holtmann.org>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: RE: BlueZ question about HID profile
Date: Tue, 27 Jan 2015 03:44:49 +0000
Message-ID: <7FF7EC0D6ACE2E4297FA998A42F07AD6195B2527@QS-MBX02.benq.corp.com>
References: <m3oaqfl79f.fsf@carbon.jhcloos.org>
	<D043D131-E9F8-43C1-8671-0EACAE810420@holtmann.org>
	<m361cklxwo.fsf@carbon.jhcloos.org>
	<C5CDA647-8415-44F3-9F89-0D596D76498F@holtmann.org>
	<m3zj9wkfsw.fsf@carbon.jhcloos.org>
	<7FF7EC0D6ACE2E4297FA998A42F07AD6195AF357@QS-MBX02.benq.corp.com>
	<E1E9C166-A11C-4A76-8B60-BF168C918F2B@holtmann.org>
	<7FF7EC0D6ACE2E4297FA998A42F07AD6195B2106@QS-MBX02.benq.corp.com>
 <CABBYNZK_YSjw0U7kCW9V1jmFDALyFPynfe2rwa8P4C2yQo36eg@mail.gmail.com>
In-Reply-To: <CABBYNZK_YSjw0U7kCW9V1jmFDALyFPynfe2rwa8P4C2yQo36eg@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

Thanks a lot!
Assuming we have the input source and BlueZ working as a HID device,
what interface BlueZ will expose for us to send a key press to remote? /dev/xxx or function call?
In another word, how to transfer the key press from input device to BlueZ?

Best Regards,
Gilbert

-----Original Message-----
From: Luiz Augusto von Dentz [mailto:luiz.dentz@gmail.com]
Sent: Tuesday, January 27, 2015 12:13 AM
To: Gilbert Gao
Cc: Marcel Holtmann; linux-bluetooth@vger.kernel.org
Subject: Re: BlueZ question about HID profile

Hi,

On Fri, Jan 23, 2015 at 12:10 PM, Gilbert Gao <Gilbert.Gao@qisda.com> wrote:
>
> Hi,
>
> I add KEYB to sdp:
> #sdptool add KEYB
>
> And HID service can be found and connected by a remote dongle on PC,
> From log, connect_event_cb() is called, but this function calls input_device_set_channel(), in which find_device() returns NULL, because the global variable "devices" is NULL, so the connection can not be established.
> I want to know how to modify here for successful connection as a keyboard.
>
> And I'm not very clear which interfaces should be called for HID device role to send data(such as a key press).
>
> Sicerely expect your advice! Thank you!

First of all, no top posting in the mailing list please, second the
sdptool shall not be used since you did not have any plugin to
implement it won't work, in order for this to work input plugin
probably needs changes, it just happens to connect because the PSM are
the same for both roles but since there is no actual record for the
host the plugin will never be initialize to work with the device
connecting thus the error you are seeing.

We could in theory enable HID device record but then input needs to
handle incoming connections and interface with some event input that
you might have to register over D-Bus, if you don't really have an
input device to be used as a source you could use uinput to emulate
one then bluetoothd would have to listen to the events, translate (not
sure if this step is really needed though) them to HID and then send
to the remote.

> Best Regards,
> Gilbert
>
>
> -----Original Message-----
> From: Gilbert Gao
> Sent: Tuesday, January 06, 2015 10:26 AM
> To: 'Marcel Holtmann'
> Cc: linux-bluetooth@vger.kernel.org
> Subject: RE: BlueZ question about HID profile
>
> Dear Marcel,
>
> Thank you very much!
> But now I'm not very clear about BlueZ HID implementation.
> Could you help to point out how to modify for a HID device role or any sample code?
>
> Best Regards,
> Gilbert
>
> -----Original Message-----
> From: Marcel Holtmann [mailto:marcel@holtmann.org]
> Sent: Tuesday, January 06, 2015 9:38 AM
> To: Gilbert Gao
> Cc: linux-bluetooth@vger.kernel.org
> Subject: Re: BlueZ question about HID profile
>
> Hi Gilbert,
>
>> Here is an emergent question about BlueZ feature:
>> I read the doc "supported-features.txt", which says BlueZ supports HID host.
>> And my question is whether HID device is supported?
>> Or can I use BlueZ HID profile to implement the Bluetooth HID device such as a Bluetooth mouse or keyboard?
>
> it should be pretty simple to implement a HID device role. There have been external projects in the past that did this. The reason why this is not in BlueZ is mainly due to the fact that we would need to get the input events from some kind of source. So if you have that figured out, then it should be simple to provided HID device role.
>
> Regards
>
> Marcel
>
>
> **********************Confidentiality Notice************************
> The opinions and views expressed in this e-mail are solely those of the author and do not necessarily represent our company and its affiliates. If this e-mail is not originally intended for you, or received by you in error, do not disclose its content to anyone and delete it immediately. This e-mail may contain information that is legally privileged, confidential or exempt from disclosure.
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



--
Luiz Augusto von Dentz
**********************Confidentiality Notice************************
The opinions and views expressed in this e-mail are solely those of the author and do not necessarily represent our company and its affiliates. If this e-mail is not originally intended for you, or received by you in error, do not disclose its content to anyone and delete it immediately. This e-mail may contain information that is legally privileged, confidential or exempt from disclosure.
