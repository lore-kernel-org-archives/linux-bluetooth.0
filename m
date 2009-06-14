Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH] Remove hid2hci from bluez
From: Bastien Nocera <hadess@hadess.net>
To: Mario_Limonciello@Dell.com
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <6BE8CE7840AC9F459EF5A0693CA2744D5DB52E@ausx3mpc138.aus.amer.dell.com>
References: <6BE8CE7840AC9F459EF5A0693CA2744D5DB52E@ausx3mpc138.aus.amer.dell.com>
Content-Type: text/plain
Date: Mon, 15 Jun 2009 00:33:20 +0100
Message-Id: <1245022400.11069.6101.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Sun, 2009-06-14 at 17:54 -0500, Mario_Limonciello@Dell.com wrote:
> Hi:
> 
> Since hid2hci has been accepted into udev-extras, I'd like to remove it
> from bluez source.  Attached is a patch.

I really wonder how good an idea that is, given that, ultimately, we'd
want to remove hid2hci from everything, and handle the switching from
within bluetoothd.

If we had specs for the devices (or at least rev-eng'ed specs), we'd
need to do link keys management, and switching the devices to hci mode
from within the same codebase.

So I'd rather hid2hci didn't go into udev-extras, and stayed in bluez
until a better solution comes along.

(Still no luck on getting specs from Broadcom about the Dell adapters at
least?)

Cheers

