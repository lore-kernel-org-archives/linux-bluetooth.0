Return-Path: <cyrus@holtmann.org>
Date: Fri, 5 Jun 2009 16:51:44 +0200
From: Stefan Seyfried <seife@suse.de>
To: Petr Lautrbach <plautrba@redhat.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Add on demand functionality to bluetooth init script
Message-ID: <20090605145144.GB7296@suse.de>
References: <4A27DFBE.407@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <4A27DFBE.407@redhat.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Thu, Jun 04, 2009 at 04:52:46PM +0200, Petr Lautrbach wrote:
> Hi.
>
> This patch adds on demand functionality for bluetooth service based on udev events.
> It's adapted from Fedora [1].

JFTR: I'd appreciate if this (or something similar) was added. I have a similar hack in
the openSUSE package (though not as elaborate as this one), and for consistency across
distributions, having a solution upstream is preferred.

> Idea is that bluetoothd doesn't need to be running unless the user actually has a bluetooth device.

Just out of interest: how did you solve the "udev event for bluetooth adapter
fires before dbus is started" probem?

Best regards,

	Stefan
-- 
Stefan Seyfried
R&D Team Mobile Devices            |              "Any ideas, John?"
SUSE LINUX Products GmbH, Nürnberg | "Well, surrounding them's out." 

This footer brought to you by insane German lawmakers:
SUSE Linux Products GmbH, GF: Markus Rex, HRB 16746 (AG Nürnberg)
