Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <55280988.7090400@gmail.com>
References: <55280988.7090400@gmail.com>
Date: Mon, 13 Apr 2015 12:19:41 +0300
Message-ID: <CABBYNZL0teRFgy_SH5mwCe8Rc+DcdWG70T6N1LApQgE6bez6yw@mail.gmail.com>
Subject: Re: Cached Device UUIDs not Visable on DBus
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Gabriel Smith <ga29smith@gmail.com>
Cc: Bluez List <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gabriel,

On Fri, Apr 10, 2015 at 8:34 PM, Gabriel Smith <ga29smith@gmail.com> wrote:
> When searching for devices, I ckeck the service UUIDs to find the correct
> device to connect to. On the first run of the program the device is
> discovered, the service UUID is matched, and everything goes smoothly. On
> every other run after the first the device is found, but no service UUIDs
> are set. I check for a PropertiesChanged signal when this occurs, but the
> signal is only ever sent when the RSSI value changes. When the system is
> rebooted, the program can run again once.
> I am using Bluez 5.30 and the high level GIO DBus API. I see that the GIO
> DBus API, specifically GDBusProxy, caches properties, but promises that they
> are updated on PropertiesChanged signals. As the program works once I do not
> think that it is the fault of the GIO DBus API. Is there something I am
> missing with Bluez's operation that would cause this error to happen?

But is there any changes to the UUIDs? It should only emit
PropertiesChanged if the UUIDs changes.

-- 
Luiz Augusto von Dentz
