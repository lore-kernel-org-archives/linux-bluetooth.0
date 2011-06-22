Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <BANLkTimaJSHEx0GoR1659tOWnYRBWV9Z0Q@mail.gmail.com>
References: <BANLkTimaJSHEx0GoR1659tOWnYRBWV9Z0Q@mail.gmail.com>
Date: Wed, 22 Jun 2011 14:17:15 -0500
Message-ID: <BANLkTik9GX_KOubOiStpjpYMBXQzEFOh+g@mail.gmail.com>
Subject: Re: audio/manager.c:hf_io_cb() Refusing new connection since one
 already exists
From: Mike <puffy.taco@gmail.com>
To: linux-bluetooth <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Mon, May 23, 2011 at 4:45 PM, Mike <puffy.taco@gmail.com> wrote:
> I am having a problem where I can not connect my phone using HFP after
> it has been once disconnected from bluetoothd.
>

I'm still having this problem (just tested on bluez 4.94).  I can
disconnect my phone and execute the GetProperties method on
org.bluez.HandsfreeGateway and the return State is connected.  If I
execute the Disconnect method over DBus (org.bluez.HandsfreeGateway),
the state of the connection is set properly to disconnected.  After
doing this, I can reconnect my phone without error (of course it will
fail again if I disconnect/reconnect).

The one thing that has me curious is the lack of a call to
"g_io_add_watch" for the hands free rfcomm.  It looks like most other
io connections use this to detect the channel closing (e.g. the sco
channel or the ag_confirm code).  Is this an oversight?

Mike
