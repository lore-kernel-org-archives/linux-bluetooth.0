Return-Path: <michael.albinus@gmx.de>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
Subject: Re: [Bluez-users] Printer adapter w/o SDP
References: <87acxxxly1.fsf@gmx.de> <1090178500.4400.25.camel@pegasus>
From: Michael Albinus <michael.albinus@gmx.de>
Date: Sun, 18 Jul 2004 21:39:32 +0200
In-Reply-To: <1090178500.4400.25.camel@pegasus> (Marcel Holtmann's message of
	"Sun, 18 Jul 2004 21:21:40 +0200")
Message-ID: <87wu11w1e3.fsf@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-ID: <bluez-users.lists.sourceforge.net>

Marcel Holtmann <marcel@holtmann.org> writes:

> Hi Michael,

Hi,

> this is not broken SDP. They use UUID32 which is fine, but actually not
> quite the normal way.
>
> What libs and utils versions are you using?

magdalene:~> uname -a
Linux magdalene 2.6.7-mh1 #1 Sun Jul 4 11:32:11 CEST 2004 i686 GNU/Linux

magdalene:~> apt-cache policy bluez-cups bluez-utils libbluetooth1
bluez-cups:
  Installed: 2.8-1
bluez-utils:
  Installed: 2.8-1
libbluetooth1:
  Installed: 2.8-1

>> magdalene:~# rfcomm
>> rfcomm0: 00:0C:55:00:B2:B4 channel 1 clean 
>
> Who said that this needed?

Nobody. I simply tried this.

> Regards
>
> Marcel

Best regards, Michael.
