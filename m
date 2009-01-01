Return-Path: <cyrus@holtmann.org>
Message-ID: <60526.209.216.239.242.1230835250.squirrel@webmail.ipns.com>
In-Reply-To: <20090101172628.5aea09d7@hermes>
References: <20081230211526.5136a798@hermes>
    <1230668540.30789.1.camel@californication>
    <20081231104354.1bf8f381@hermes>
    <1230800341.4530.4.camel@californication>
    <20090101172628.5aea09d7@hermes>
Date: Thu, 1 Jan 2009 11:40:50 -0700 (MST)
Subject: How do I get headset button events without .btscorc?
From: "Dave Schile" <dave@schile.com>
To: linux-bluetooth@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello.
I figured this one out all  on my own!  Here is a script in python that
uses dbus to get the bluetooth headset button press.  I think it might be
helpful to add this to the wiki.

<pre>

def handler(sender=None):
	os.system ('/usr/bin/twinkle --cmd answerbye') # <- that's the part
specific to twinkle
import dbus, os,  gobject
from dbus.mainloop.glib import DBusGMainLoop
DBusGMainLoop(set_as_default=True)
bus = dbus.SystemBus()
bus.add_signal_receiver(handler, signal_name="AnswerRequested")
loop = gobject.MainLoop()
loop.run()

</pre>

Dave


