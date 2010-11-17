Return-Path: <cyrus@holtmann.org>
Date: Thu, 18 Nov 2010 00:27:51 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Andre Kuehne <andre.kuehne@gmx.net>
Cc: "Gustavo F. Padovan" <padovan@profusion.mobi>,
	linux-bluetooth@vger.kernel.org
Subject: Re: Apple Wireless Keyboard connection issue
Message-ID: <20101117222751.GA20735@jh-x301>
References: <20101116212701.50060@gmx.net>
 <20101117013009.GA15855@vigoh>
 <20101117090534.GA11494@jh-x301>
 <4CE45F63.7030902@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <4CE45F63.7030902@gmx.net>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Thu, Nov 18, 2010, Andre Kuehne wrote:
> On 11/17/2010 10:05 AM, Johan Hedberg wrote:
> >On Tue, Nov 16, 2010, Gustavo F. Padovan wrote:
> >>* "André Kühne"<andre.kuehne@gmx.net>  [2010-11-16 22:27:01 +0100]:
> >>>I noticed the following on my system: After upgrading to bluez-4.79
> >>>connecting my Apple Wireless Keyboard does not work anymore. With
> >>>bluez-4.77 the connection works just fine.
> >>
> >>My Microsoft keyboard is not working too. That is probably due to commit
> >>abe7cd44124a from Johan. It should be fixed soon.
> >
> >The only real difference that patch makes is the reuse of the HCI socket
> >inside hciops.c. Maybe that screws up the event filters somehow or
> >something similar. I don't have a keyboard to verify a fix, but could
> >you try the attached patch and see if it helps?
> >
> I installed
> 
>   http://www.kernel.org/pub/linux/bluetooth/bluez-4.79.tar.gz + hciops_encrypt.patch
> 
> but the patch does not work for me. For verification I downloaded
> 
>   http://www.kernel.org/pub/linux/bluetooth/bluez-4.77.tar.gz
> 
> and compiled/installed it the same way (without the patch) and the connection works.
> 
> I did the same using bluez-4.78 with the result that both my keyboard and mouse failed to connect.

Ok, so then it seems like abe7cd44124a might not be to blame. Could you
do a proper git bisect so we can figure out exactly at which point this
broke. abe7cd44124a is really the only commit touching HID code since
4.77 so this is starting to get a bit strange.

Johan
