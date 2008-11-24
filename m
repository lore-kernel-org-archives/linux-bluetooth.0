Return-Path: <cyrus@holtmann.org>
Date: Mon, 24 Nov 2008 12:00:37 +0100
From: Stefan Seyfried <seife@suse.de>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Subject: Re: compat/Makefile.am manpages fix / pand/dund question
Message-ID: <20081124110037.GC28799@suse.de>
References: <20081110092009.GD11057@suse.de> <226D5095-C45F-49D8-8001-9D62F17D8122@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <226D5095-C45F-49D8-8001-9D62F17D8122@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Mon, Nov 24, 2008 at 03:58:11AM +0100, Marcel Holtmann wrote:
>> package? I guess that I should not package hidd, no matter how much
>> users would like it, though ;-)
>
> You can put hidd in bluez-compat if you like. It is useful for debugging 
> since it can show the actual kernel state of the hidp.ko module.

Fortunately nobody has requested it for quite some time.
Would it be helpful to remove the "--server" code from hidd, since I guess
that this will not be useful anymore (and I fear that once I package up
hidd, people _will_ use "hidd --server", because they read that in some
outdated README). I can come op with a patch for that, if wanted.

Thanks,

	seife
-- 
Stefan Seyfried
R&D Team Mobile Devices            |              "Any ideas, John?"
SUSE LINUX Products GmbH, Nürnberg | "Well, surrounding them's out." 

This footer brought to you by insane German lawmakers:
SUSE Linux Products GmbH, GF: Markus Rex, HRB 16746 (AG Nürnberg)
