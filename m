Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.1 \(1993\))
Subject: Re: bluetooth: Add hci_h4p driver
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20141213235131.GA23566@amd>
Date: Sun, 14 Dec 2014 01:07:42 +0100
Cc: =?utf-8?Q?Pali_Roh=C3=A1r?= <pali.rohar@gmail.com>,
	Sebastian Reichel <sre@debian.org>,
	Sebastian Reichel <sre@ring0.de>,
	kernel list <linux-kernel@vger.kernel.org>,
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
	linux-omap <linux-omap@vger.kernel.org>,
	Tony Lindgren <tony@atomide.com>, khilman@kernel.org,
	Aaro Koskinen <aaro.koskinen@iki.fi>,
	Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>,
	linux-bluetooth@vger.kernel.org
Message-Id: <ED6FB9B5-7BD5-4398-ACA4-C5D1547B91A4@holtmann.org>
References: <20141213223727.GA13894@amd> <570BAC61-3137-42E5-B4F8-A61AEED380DE@holtmann.org> <20141213235131.GA23566@amd>
To: Pavel Machek <pavel@ucw.cz>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Pavel,

>>> My notes say that Marcel wanted different filenames, but I'd need
>>> advice exactly what filenames. I guess platform data supprort should
>>> be removed altogether, rather than renamed.
>> 
>> Yes, the platform support should go away. This should be purely based on DT.
>> 
>> Can you also start using git format-patch so that patches get a diffstat.
> 
> So the rest of filenames look ok?

I have not looked at the patch or the filenames at all.

Regards

Marcel


