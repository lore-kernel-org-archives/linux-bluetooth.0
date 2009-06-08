Return-Path: <cyrus@holtmann.org>
Message-ID: <4A2CFD04.7020606@suse.de>
Date: Mon, 08 Jun 2009 13:59:00 +0200
From: Stefan Seyfried <seife@suse.de>
MIME-Version: 1.0
To: Petr Lautrbach <plautrba@redhat.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Add on demand functionality to bluetooth init script
References: <4A27DFBE.407@redhat.com> <20090605145144.GB7296@suse.de> <4A2CF696.8020702@redhat.com>
In-Reply-To: <4A2CF696.8020702@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Petr Lautrbach wrote:

> but there is running boot (changing runlevel) process, so sometime after starting dbus is started
> bluetooth again, this time successfully

Triggered by what? A init script that is always enabled? Is it checking if
there is an adapter present? If not, it's unconditionally always starting
bluetoothd (and thus the ondemand functionality is not strictly needed ;)

Best regards,

	Stefan

-- 
Stefan Seyfried
R&D Team Mobile Devices            |              "Any ideas, John?"
SUSE LINUX Products GmbH, Nürnberg | "Well, surrounding them's out."

This footer brought to you by insane German lawmakers:
SUSE Linux Products GmbH, GF: Markus Rex, HRB 16746 (AG Nürnberg)
