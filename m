Return-Path: <cyrus@holtmann.org>
From: Gilbert Gao <Gilbert.Gao@Qisda.com>
To: Marcel Holtmann <marcel@holtmann.org>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: RE: BlueZ question about HID profile
Date: Fri, 23 Jan 2015 10:10:57 +0000
Message-ID: <7FF7EC0D6ACE2E4297FA998A42F07AD6195B2106@QS-MBX02.benq.corp.com>
References: <m3oaqfl79f.fsf@carbon.jhcloos.org>
 <D043D131-E9F8-43C1-8671-0EACAE810420@holtmann.org>
 <m361cklxwo.fsf@carbon.jhcloos.org>
 <C5CDA647-8415-44F3-9F89-0D596D76498F@holtmann.org>
 <m3zj9wkfsw.fsf@carbon.jhcloos.org>
 <7FF7EC0D6ACE2E4297FA998A42F07AD6195AF357@QS-MBX02.benq.corp.com>
 <E1E9C166-A11C-4A76-8B60-BF168C918F2B@holtmann.org>  
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


Hi,

I add KEYB to sdp:
#sdptool add KEYB

And HID service can be found and connected by a remote dongle on PC,
>From log, connect_event_cb() is called, but this function calls input_device_set_channel(), in which find_device() returns NULL, because the global variable "devices" is NULL, so the connection can not be established.
I want to know how to modify here for successful connection as a keyboard.

And I'm not very clear which interfaces should be called for HID device role to send data(such as a key press).

Sicerely expect your advice! Thank you!

Best Regards,
Gilbert


-----Original Message-----
From: Gilbert Gao
Sent: Tuesday, January 06, 2015 10:26 AM
To: 'Marcel Holtmann'
Cc: linux-bluetooth@vger.kernel.org
Subject: RE: BlueZ question about HID profile

Dear Marcel,

Thank you very much!
But now I'm not very clear about BlueZ HID implementation.
Could you help to point out how to modify for a HID device role or any sample code?

Best Regards,
Gilbert

-----Original Message-----
From: Marcel Holtmann [mailto:marcel@holtmann.org]
Sent: Tuesday, January 06, 2015 9:38 AM
To: Gilbert Gao
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: BlueZ question about HID profile

Hi Gilbert,

> Here is an emergent question about BlueZ feature:
> I read the doc "supported-features.txt", which says BlueZ supports HID host.
> And my question is whether HID device is supported?
> Or can I use BlueZ HID profile to implement the Bluetooth HID device such as a Bluetooth mouse or keyboard?

it should be pretty simple to implement a HID device role. There have been external projects in the past that did this. The reason why this is not in BlueZ is mainly due to the fact that we would need to get the input events from some kind of source. So if you have that figured out, then it should be simple to provided HID device role.

Regards

Marcel


**********************Confidentiality Notice************************
The opinions and views expressed in this e-mail are solely those of the author and do not necessarily represent our company and its affiliates. If this e-mail is not originally intended for you, or received by you in error, do not disclose its content to anyone and delete it immediately. This e-mail may contain information that is legally privileged, confidential or exempt from disclosure.
