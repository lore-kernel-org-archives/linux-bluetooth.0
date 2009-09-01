Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH] Make discovery mode of bluetooth CUPS backend work
 with CUPS 1.4.0
From: Bastien Nocera <hadess@hadess.net>
To: Till Kamppeter <till.kamppeter@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, Marcel Holtmann <marcel@holtmann.org>,  Mario Limonciello <superm1@ubuntu.com>
In-Reply-To: <4A9652D4.10807@gmail.com>
References: <4A957819.7040808@gmail.com>
	 <1251310460.2950.98.camel@localhost.localdomain> <4A95891A.20402@gmail.com>
	 <1251340537.2950.105.camel@localhost.localdomain>
	 <4A9652D4.10807@gmail.com>
Content-Type: text/plain
Date: Tue, 01 Sep 2009 17:13:14 +0100
Message-Id: <1251821594.3326.91.camel@localhost.localdomain>
Mime-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>

On Thu, 2009-08-27 at 11:33 +0200, Till Kamppeter wrote:
> The new CUPS 1.4.x does device discovery only for a given time frame
> requested by the client (printer setup tool, "lpinfo" command). CUPS's
> default for CUPS-1.3.x-ish requests without timeout specification
> seems to be 10 seconds. CUPS starts all backends at once in the
> beginning (in parallel) and kills every backend which remains running
> at the end of the timeout. It accepts output from the backends
> whenever it occurs not only when the backend finishes, so a backend
> can search for printers infinitely long if it outputs every found
> device immediately. Then all printers found during CUPS' timeout are
> taken into account.
> 
> The bluetooth backend of 4.48 asks the Bluetooth daemon for printers
> and collects results for 10 seconds and after that it outputs
> them. This takes a total of 10.5 sec and so CUPS kills the backend
> right before it answers (at least with the 10-second default timeout),
> resulting in Bluetooth printers never being discovered by CUPS.
> 
> This change fixes it by making each new printer added to the list
> being output immediately. Note that the list structure cannot be
> removed from cups/main.c as otherwise we would get duplicate
> listings. Also important is the addition of unbuffered output on
> stdout.

Looks fine to me, although I'd have the stdout unbuffered change in a
separate patch instead.

Cheers
