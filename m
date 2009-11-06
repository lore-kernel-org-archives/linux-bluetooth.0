Return-Path: <cyrus@holtmann.org>
Date: Fri, 6 Nov 2009 13:11:33 +0000 (GMT)
To: nirav rabara <niravrabara@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: headset service search problem
In-Reply-To: <912bb79a0911060310t71211862q3c39fe3e08486d2a@mail.gmail.com>
References: <912bb79a0911060310t71211862q3c39fe3e08486d2a@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Message-Id: <1257513094.024986.889.nullmailer@galant.ukfsn.org>
From: Iain Hibbert <plunky@rya-online.net>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Fri, 6 Nov 2009, nirav rabara wrote:

> I have been trying to search only headset devices among other
> bluetooth devices using SDP.
>
> Problem - 1)
>
> -> when I search for UUID 0x1108 (for headset). It shows me mobile
> devices also because it support headset service
>    Is there any other way to search  particularly for headset only??

Well, you could do a device inquiry first and filter the responses using
the "Class of Device" value. A headset will claim to be an AV device
(major #4) rather than a Phone (major #2). See section 5.5.1 in the
Headset Profile specification..

Then, you can probe the devices you find and check for "Headset" in the
service class attributes but that might only apply to version 1.0 of the
HSP specification because the newer profile (v1.2) seems to provide
different UUIDs for "Headset HS" (0x1131), "Headset AG" (0x1112) and
"Headset Profile" (0x1108)

> Problem - 2)
>
> -> when I search for the search for the service(headset). Bluetoothd
> is going to get PIN no. because sometimes link key gets fail (in case
> of new headset device whose is getting connected first time ).
> -> Why bluetoothd need PIN when I am try to search for the service.
> (not connecting)
>
> Is there any way to search for the services without entering PIN ??

If the remote device requires authentication, then no.

iain


