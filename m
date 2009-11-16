Return-Path: <cyrus@holtmann.org>
From: Oliver Neukum <oliver@neukum.org>
To: Pavel Machek <pavel@ucw.cz>,
 Alan Stern <stern@rowland.harvard.edu>,
 USB list <linux-usb@vger.kernel.org>
Subject: Re: -rc6: something (probably active usb bluetooth) blocks suspend
Date: Mon, 16 Nov 2009 14:43:20 +0100
Cc: kernel list <linux-kernel@vger.kernel.org>,
 marcel@holtmann.org,
 linux-bluetooth@vger.kernel.org,
 "Rafael J. Wysocki" <rjw@sisk.pl>
References: <20091116112254.GB12315@elf.ucw.cz>
In-Reply-To: <20091116112254.GB12315@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <200911161443.20704.oliver@neukum.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Am Montag, 16. November 2009 12:22:54 schrieb Pavel Machek:
> Linux amd 2.6.32-rc6-00498-g05b553a-dirty #89 SMP Fri Nov 13 10:43:31
> CET 2009 i686 GNU/Linux
> 
> ...and yes, it is a regression. Hw is thinkpad x60.
> 
> Tried to suspend, machine came right back, used radio kill switch, and
> it suspended ok. Relevant messages seem to be:

I forgot to ask. Is this repeatable? The code is build on the assumption
that workqueues are frozen as the system calls suspend for system
sleep. If that assumption is wrong, a race can lead to this failure.
Is it wrong?

	Regards
		Oliver
