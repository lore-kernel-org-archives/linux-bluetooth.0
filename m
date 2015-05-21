Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=windows-1252
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2098\))
Subject: Re: DBus API for LTK OOB keys
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <555DD643.5000703@ubnt.com>
Date: Thu, 21 May 2015 15:10:19 +0200
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Message-Id: <706634F7-0B6D-4D4B-BBD8-088F7D81D7AB@holtmann.org>
References: <54F8584D.6020301@ubnt.com> <20150305134024.GA20862@t440s> <54F862A3.80400@ubnt.com> <8EB5FD2F-4C46-41F8-95BA-4ACBEF0BCDE4@holtmann.org> <54F8B881.4050506@ubnt.com> <280B8CCC-6E98-477A-B805-D91966220207@holtmann.org> <555D8B8C.4090007@ubnt.com> <21E176FE-31DA-4AC0-87FD-8CDB532644D1@holtmann.org> <555DD643.5000703@ubnt.com>
To: Andrejs Hanins <andrejs.hanins@ubnt.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrejs,

>>>> So LE Legacy Pairing needs the Security Manager TK value and LE Secure Connections needs the Confirmation and Random values. However right now, we can not get these ones from the kernel.
>>>> 
>>>> As a side note, I added tools/oobtest utility where you can test this between two controllers attached to the same host.
>>> Based on oobtest/kernel code/mgmt-api comments, the OOB LE legacy pairing is still not supported: "Currently there is no support for providing the Security Manager TK Value for LE legacy pairing".
>>> 
>>> Is there any plan to support it? Maybe some patches exist? Are there any serious technical difficulties behind the absence of this functionality?
>> 
>> making OOB LE legacy pairing work is pretty tricky since it is the wrong kind of OOB. Essentially it is just a shared secret between two device and only if that shared secret is truly random and communicated out-of-band you get proper strong keys. But nothing in the process guarantees that or can verify it.
>> 
>> It also does not fit into the SSP, BR/EDR SC or LE SC model with the public key exchange. So we actually gave up on supporting OOB LE legacy pairing.
>> 
>>> I know that BT 4.2 SC provides better alternatives for secure pairing, but the 4.2 is not so widely adopted as 4.0 and our BT chip also don't support 4.2…
>> 
>> You can run LE SC on Bluetooth 4.0 chips. We do that and also Apple’s iOS does that. No need for new hardware.
> Our device (peripheral) chip runs proprietary SW which doesn't support 4.2 yet, it is not related to BlueZ/Linux at all, unfortunately.

I would try to get your chip software updated to support LE SC as quickly as possible. It is the one update that is really worth the effort since it makes a huge difference from a security point of view.

The advantage with OOB from LE SC is that the OOB material only needs to be transported in one direction. It is truly random since it is based on your public/private key pair.

Regards

Marcel

