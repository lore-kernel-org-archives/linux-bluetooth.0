Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20090704135747.05efc95c@stoetzler>
References: <4A4F39E8.4020908@powercraft.nl>
	 <20090704135747.05efc95c@stoetzler>
Date: Sat, 4 Jul 2009 10:37:39 -0300
Message-ID: <2d5a2c100907040637s73791batd85327f31cb4f1ee@mail.gmail.com>
Subject: Re: Feature request: boolean properties to auto reconnect list of
	MAC's at daemon start up
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Stefan Seyfried <seife@suse.de>
Cc: BlueZ devel list <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Sat, Jul 4, 2009 at 8:57 AM, Stefan Seyfried<seife@suse.de> wrote:
> On Sat, 04 Jul 2009 13:15:52 +0200
> Jelle de Jong <jelledejong@powercraft.nl> wrote:
>
>> Use-case: I have a lot of systems with successful connected bluetooth
>> keyboards. The boot-up of these systems are around 5 seconds with full
>> GUI. But the devices is not usable yet, because when you press a key
>> it first start connection... this takes almost the same time as the
>> complete boot-up and it forces an extra key press of the user every
>> time they start the system. Maybe some org.bluez.Input interface
>> thing?
>
> IIUC that's just how bluetooth input devices work: they do connect to
> the host - not the other way round. So it is really a problem that
> cannot be solved on bluez' side.

Yep, most hid devices will just refuse the connection if the 'virtual
cable plug' was already stabilised, in general this is also a bad idea
for any connection attempt during the startup as we have no guarantee
that the connection will complete.

-- 
Luiz Augusto von Dentz
Engenheiro de Computação
