Return-Path: <cyrus@holtmann.org>
Date: Fri, 5 Jun 2009 18:53:07 +0200
From: Stefan Seyfried <seife@suse.de>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Johan Hedberg <johan.hedberg@gmail.com>,
	Petr Lautrbach <plautrba@redhat.com>,
	BlueZ development <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH] Add on demand functionality to bluetooth init script
Message-ID: <20090605165307.GC13177@suse.de>
References: <4A27DFBE.407@redhat.com> <20090605153852.GA29262@jh-x301> <1244216906.23850.70.camel@localhost.localdomain> <20090605164200.GB13177@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <20090605164200.GB13177@suse.de>
List-ID: <linux-bluetooth.vger.kernel.org>

On Fri, Jun 05, 2009 at 06:42:00PM +0200, Stefan Seyfried wrote:
>   [ -x /dev/shm/bluetooth-adapter-present ] && \

"test -e" of course

> 	/etc/init.d/bluetooth start

Regards,

	Stefan
-- 
Stefan Seyfried
R&D Team Mobile Devices            |              "Any ideas, John?"
SUSE LINUX Products GmbH, Nürnberg | "Well, surrounding them's out." 

This footer brought to you by insane German lawmakers:
SUSE Linux Products GmbH, GF: Markus Rex, HRB 16746 (AG Nürnberg)
