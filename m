Return-Path: <cyrus@holtmann.org>
Date: Fri, 21 Sep 2012 13:55:59 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 00/17] RFC: Simplify DBusConnection object handling
Message-ID: <20120921105559.GA5561@x220>
References: <1348050139-27883-1-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1348050139-27883-1-git-send-email-andrzej.kaczmarek@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrzej,

On Wed, Sep 19, 2012, Andrzej Kaczmarek wrote:
> Here's series of patches which makes handling of DBusConnection object
> across code simpler and more consistent.
> 
> Problem with current implementation is that different modules handles
> reference to D-Bus in a different way, e.g. some use dbus_bus_get() and
> just store it in static variable, others pass this around via multiple
> calls to finally store it in per-{adapter,device,request} structure or
> some just use get_dbus_connection() call to have it immediately.
> 
> This creates a lot of redundant code which only (un)refs DBusConnection
> and pass it around for no particular reason, because you can use global
> reference which is exactly the same object.
> 
> What following patches do is:
> (1) prefix get_dbus_connection() with btd_ so it can be used by external
>     plugins
> (2) make sure D-Bus is disconnected after all modules (agent, mamanger,
>     plugins etc.) are shutdown
> (3) remove any redundant internal references and function parameters that
>     pass/store DBusConnection and just use btd_get_dbus_connection() where
>     need to pass valid DBusConnection object (no need to ref it, there's
>     one global ref and it's always valid as per #2)
> 
> This makes things with D-Bus really simple: you need to pass DBusConnection
> object somewhere - call btd_get_dbus_connection() and you have it. No need
> to store it, no need to ref it. Perhaps some downside of this approach is
> that few files (hdp.c, telephony-maemo{5,6}.c) have quite a lot of such calls
> but if this is something to avoid we can still add global static variable
> and call btd_get_dbus_connection() once in *_init(), just like dbusoob plugin
> does now.
> 
> Comments are welcome.

I didn't see any major issues with this set so all patches have now been
applied. Thanks.

Johan
