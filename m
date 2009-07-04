Return-Path: <cyrus@holtmann.org>
Date: Sat, 4 Jul 2009 13:57:47 +0200
From: Stefan Seyfried <seife@suse.de>
To: BlueZ devel list <linux-bluetooth@vger.kernel.org>
Subject: Re: Feature request:  boolean properties to auto reconnect list of
 MAC's at daemon start up
Message-ID: <20090704135747.05efc95c@stoetzler>
In-Reply-To: <4A4F39E8.4020908@powercraft.nl>
References: <4A4F39E8.4020908@powercraft.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Sat, 04 Jul 2009 13:15:52 +0200
Jelle de Jong <jelledejong@powercraft.nl> wrote:

> Use-case: I have a lot of systems with successful connected bluetooth
> keyboards. The boot-up of these systems are around 5 seconds with full
> GUI. But the devices is not usable yet, because when you press a key
> it first start connection... this takes almost the same time as the
> complete boot-up and it forces an extra key press of the user every
> time they start the system. Maybe some org.bluez.Input interface
> thing?

IIUC that's just how bluetooth input devices work: they do connect to
the host - not the other way round. So it is really a problem that
cannot be solved on bluez' side.

-- 
Stefan Seyfried
R&D Preload Department             |              "Any ideas, John?"
SUSE LINUX Products GmbH, Nürnberg | "Well, surrounding them's out."

This footer brought to you by insane German lawmakers:
SUSE Linux Products GmbH, GF: Markus Rex, HRB 16746 (AG Nürnberg)
