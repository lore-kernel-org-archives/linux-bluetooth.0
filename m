Return-Path: <cyrus@holtmann.org>
Message-ID: <492E7D86.8030007@powercraft.nl>
Date: Thu, 27 Nov 2008 11:59:18 +0100
From: Jelle de Jong <jelledejong@powercraft.nl>
MIME-Version: 1.0
To: Simon Kenyon <simon@koala.ie>
CC: linux-bluetooth@vger.kernel.org
Subject: Re: Sony BD Remote (help requested)
References: <492E6E6A.80509@koala.ie>
In-Reply-To: <492E6E6A.80509@koala.ie>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Simon Kenyon wrote:
> i'm trying to get y BD Remote to work.
> 
> this is what i have done so far:
> 
> installed bluez from git (as of yesterday)
> configured it (i think)
> when i:
> 
> hidd --search
> 
> i see the remote
> 
> by using udev rules i create /dev/bdremote (which links to 
> /dev/input/event<x>, for the correct <x>)
> i can see the key presses on the remote being transmitted (using hcidump)
> 
> what i cannot do see is ny events occuring (by loading evbug)
> i'm trying to get the events into lirc
> 
> i promise to write up the steps if i get it working
> 
> i'm running a pretty standard gentoo setup with kde (not gnome)
> 
> any help would be appreciated
> --
> simon

I talked to Marcel about the Sony BD Remote on the CELINUX event in the
Netherlands. I took my Sony BD Remote with me to show some issues.
Marcel did some on the fly coding to get the device connected, but there
is missing an hid driver that maps the keys to an input event xorg can use.

So the device is not working yet, until somebody creates a proper hid
driver for the device to map the keys.

I don't know if Marcel commited the code to make the device connect.

I spent far to much time trying to get this device working, there are a
few bug reports and some post on the archive from me about this subject...

Hope this information helps you understand.

Best regards,

Jelle
