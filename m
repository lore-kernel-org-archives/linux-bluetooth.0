Return-Path: <cyrus@holtmann.org>
Message-ID: <555D8B8C.4090007@ubnt.com>
Date: Thu, 21 May 2015 10:38:52 +0300
From: Andrejs Hanins <andrejs.hanins@ubnt.com>
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: DBus API for LTK OOB keys
References: <54F8584D.6020301@ubnt.com> <20150305134024.GA20862@t440s> <54F862A3.80400@ubnt.com> <8EB5FD2F-4C46-41F8-95BA-4ACBEF0BCDE4@holtmann.org> <54F8B881.4050506@ubnt.com> <280B8CCC-6E98-477A-B805-D91966220207@holtmann.org>
In-Reply-To: <280B8CCC-6E98-477A-B805-D91966220207@holtmann.org>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On 03/06/2015 12:08 AM, Marcel Holtmann wrote:
> 
> So LE Legacy Pairing needs the Security Manager TK value and LE Secure Connections needs the Confirmation and Random values. However right now, we can not get these ones from the kernel.
> 
> As a side note, I added tools/oobtest utility where you can test this between two controllers attached to the same host.
Based on oobtest/kernel code/mgmt-api comments, the OOB LE legacy pairing is still not supported: "Currently there is no support for providing the Security Manager TK Value for LE legacy pairing".

Is there any plan to support it? Maybe some patches exist? Are there any serious technical difficulties behind the absence of this functionality?
I know that BT 4.2 SC provides better alternatives for secure pairing, but the 4.2 is not so widely adopted as 4.0 and our BT chip also don't support 4.2...

> 
> Regards
> 
> Marcel
> 
