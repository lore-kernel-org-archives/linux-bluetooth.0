Return-Path: <cyrus@holtmann.org>
Subject: Re: PATCHES: Device discovery of the "bluetooth" CUPS backend does
 not work
From: Marcel Holtmann <marcel@holtmann.org>
To: Till Kamppeter <till.kamppeter@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	Mario Limonciello <superm1@ubuntu.com>
In-Reply-To: <4A957819.7040808@gmail.com>
References: <4A957819.7040808@gmail.com>
Content-Type: text/plain
Date: Wed, 26 Aug 2009 11:14:20 -0700
Message-Id: <1251310460.2950.98.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Till,

> I am using Bluez 4.48 in Ubuntu Karmic. First thank you for applying my 
> patches. The bluetooth backend works perfectly now with CUPS 1.3.x and 
> older. On the new CUPS 1.4.x a new problem appeared: The new CUPS does 
> device discovery only for a given time frame requested by the client 
> (printer setup tool, "lpinfo" command). CUPS's default for 
> CUPS-1.3.x-ish requests without timeout specification seems to be 10 
> seconds. CUPS startys all backends at once in the beginning (in 
> parallel) and kills every backend which remains running at the end of 
> the timeout. It accepts output from the backends whenever it occurs not 
> only when the backend finishes, so a backend can search for printers 
> infinitely long if it outputs every found device immediately. Then all 
> printers found during CUPS' timeout are taken into account.
> 
> The bluetooth backend o 4.48 asks the Bluetooth daemon for printers and 
> collects results for 10 seconds and after that it output them. This 
> takes a total of 10.5 sec and so CUPS kills the backend right before it 
> answers (at least with the 10-second default timeout), resulting in 
> Bluetooth printers never being discovered by CUPS.
> 
> I have fixed this now with the attached patch, by making each new 
> printer added to the list being output immediately. Note that the list 
> structure cannot be removed from cups/main.c as otherwise we would get 
> duplicate listings.
> 
> Can you please apply this patch to Bluez so that Bluez gets ready for 
> the new CUPS 1.4.x generation? Thanks.

send a patch created with git format-patch so we can apply them properly
without me having to modify the commit message manually.

Regards

Marcel


