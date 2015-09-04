Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Fri, 4 Sep 2015 16:34:11 -0300
Message-ID: <CADU7QaBWPCResEi5jpePjjxdoefteKD00MgAJ6=Q0FqZqoL=2Q@mail.gmail.com>
Subject: First time using gdbus
From: Agustin Gimeno <agustin.gimeno@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

I started recently to work with bluez. I have already compiled bluez
without any issues.
My long term objective is to make an embedded device in linux that
works as an CT in AVRCP with 1.4 capabilities.

I started to read the example of the client and in particular i
focused in how to register an agent.
Yes, i want to understand how all this work from its bare bones.

Its the first time i use glib for something like this and its the
first time i use dbus.
I made a simple-agent by myself copying some parts of the client i
state before. Yet i do not understand how the proxy call really works.
I understand how a proxy works, between process; but what i don't get
is how the instance of main loop is tied with the calls to dbus, so
then it finally calls the handler i passed to the proxy. Or if their
are not tied at all, then how is that i get my handler call, lets say
how does that proxy works. The api call i'm using is:
g_dbus_cllient_set_proxy_handlers.

Can someone please point me in the right direction, I'm sure there are
some things I'm not getting and that is probably why i don't
understand how gdbus is working.

I got the agent to register to dbus, but i want to understand how all
this works.

Best regards,

Agustin
