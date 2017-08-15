Return-Path: <richard@sigma-star.at>
From: Richard Weinberger <richard@sigma-star.at>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Greg Kroah-Hartman <greg@kroah.com>, kernel list <linux-kernel@vger.kernel.org>, "Gustavo F. Padovan" <gustavo@padovan.org>, Johan Hedberg <johan.hedberg@gmail.com>, linux-bluetooth@vger.kernel.org
Subject: Re: WARNING: CPU: 3 PID: 2952 at drivers/base/firmware_class.c:1225 _request_firmware+0x329/0x890
Date: Tue, 15 Aug 2017 13:41:51 +0200
Message-ID: <25498655.5hsXaGAV9U@blindfold>
In-Reply-To: <C551B3EE-FC6F-4FDA-8B32-270AAC18D958@holtmann.org>
References: <2237498.dXpkGoRScD@blindfold> <C551B3EE-FC6F-4FDA-8B32-270AAC18D958@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-ID: <linux-bluetooth.vger.kernel.org>

Marcel,

Am Dienstag, 15. August 2017, 12:22:27 CEST schrieb Marcel Holtmann:
> > Is this known?
> 
> It is not known, but it is also unclear why this happens. Basically the card
> looses power and thus ends up in bootloader mode.
> 

Hm, maybe a BIOS issue?

Thanks,
//richard

-- 
sigma star gmbh - Eduard-Bodem-Gasse 6 - 6020 Innsbruck - Austria
ATU66964118 - FN 374287y
