Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <AANLkTinZS1EbbW7XGYVHMdA0M5tMss8RuYwtiNoM5m_M@mail.gmail.com>
References: <AANLkTinZS1EbbW7XGYVHMdA0M5tMss8RuYwtiNoM5m_M@mail.gmail.com>
Date: Wed, 29 Sep 2010 18:27:08 +0200
Message-ID: <AANLkTinBcH0smvZ_Yd7d+TqwufSLBjmM+TROUN6iTzAq@mail.gmail.com>
Subject: SCO Socket input connection.
From: Pepe Aracil <pepe.aracil.gomez@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello.

I'm developing embedded alarm system with hands free bluetooth profile.

Some months ago this code in python was working OK. (i don't remember
bluez version)

self.sco = socket.socket(socket.AF_BLUETOOTH, socket.SOCK_SEQPACKET,
socket.BTPROTO_SCO)
print "socket SCO opened."
self.sco.bind("00:00:00:00:00:00")
self.sco.listen(1)
sck, mac = self.sco.accept()

When receiving a call on my cell phone and took down (via rfcomm HF
connecton) , SCO connection was produced from the phone to pc.

Now this connection fails.

I added to audio.conf   Disable=Headset,Control,Gateway    to disable
SCO Listening from bluetoothd but with no result :(

The only thing that works is to launch this python code before bluetoothd.
Some thing is touched by bluetoothd  that blocks SCO incoming
connections for other apps. ¿What?

I try  compile with --disable-audio with no results.

Thanks. and sorry for may horrible English.
