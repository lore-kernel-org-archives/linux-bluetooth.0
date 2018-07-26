Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Message-ID: <43a125d60469ce919959790a88bce71707b05306.camel@hadess.net>
Subject: Re: [PATCH BlueZ 3/4] adapter: Track pending settings
From: Bastien Nocera <hadess@hadess.net>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-bluetooth@vger.kernel.org
Date: Thu, 26 Jul 2018 14:43:29 +0200
In-Reply-To: <20180725102035.19439-3-luiz.dentz@gmail.com>
References: <20180725102035.19439-1-luiz.dentz@gmail.com>
         <20180725102035.19439-3-luiz.dentz@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Wed, 2018-07-25 at 13:20 +0300, Luiz Augusto von Dentz wrote:
> -                               property_set_mode_complete, data, g_free) > 0)
> +                       property_set_mode_complete, data, g_free) > 0)

White space change is probably not needed here.

This patch and 4/4 don't work as expected though. I use this set of 2
commands to replicate what gnome-bluetooth did:

dbus-send  --system --dest=org.bluez /org/bluez/hci0
org.freedesktop.DBus.Properties.Set string:org.bluez.Adapter1
string:Discoverable variant:boolean:false ; dbus-send  --system --
dest=org.bluez /org/bluez/hci0 org.freedesktop.DBus.Properties.Set
string:org.bluez.Adapter1 string:DiscoverableTimeout variant:uint32:0

You can add a "print-reply" which will wait for the caller to return.
In my case, without the --print-reply, property_set_mode will never be
called.
