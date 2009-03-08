Return-Path: <cyrus@holtmann.org>
Date: Sun, 8 Mar 2009 23:22:15 +0000
From: James Le Cuirot <chewi@aura-online.co.uk>
To: linux-bluetooth@vger.kernel.org
Subject: PANU currently broken?
Message-ID: <20090308232215.727f38fa@symphony>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

I've managed to serve my phone with NAP successfully but using PANU in
the other direction has not worked at all. No one I've spoken to has
any answers so I've done some digging. I've been using Blueman a little
but I worked out how to start the connection manually with dbus-send.
The first error I encountered was this. It appears after a short delay.

Error org.freedesktop.DBus.Error.NoReply: Did not receive a reply.
Possible causes include: the remote application did not send a reply,
the message bus security policy blocked the reply, the reply timeout
expired, or the network connection was broken.

This seemed a little vague but after adding some debug messages to the
source, I figured out what the problem was. The D-Bus method signature
for org.bluez.Network.Connect says it's supposed to return a string. So
do the API docs. So why does it return NULL? I don't know much about
D-Bus but this doesn't seem right.

According to the docs, it's supposed to return the name of the newly
created interface such as bnep0. I outputted nc->dev to the log to
check that's what it actually was. Close. It gave me bnep%d.

In any case, I wasn't sure how to return a string to D-Bus so I got it
to return null with g_dbus_create_reply(msg, DBUS_TYPE_INVALID). This
fixed the error and the delay. Still no sign of bnep0 though.

Looking through the rest of the source, it seemed to me that nc->dev is
supposed to get changed from bnep%d to bnep0 at some point but this
isn't happening and I can't even see any code that resembles this
operation. If it's trying to do operations on an interface called
bnep%d then no wonder it's not working.

Having said that, I changed the setting in network.conf from bnep%d to
bnep0 and while it definitely did pick this up, it still wouldn't work.
I've seen "Connection refused (111)" a couple of times but I'm not sure
where that's coming from exactly.

Are my observations correct or am I missing something here? If I'm
right, why is it in such a broken state? I wouldn't expect a release to
have these kind of problems.

Regards,
James
