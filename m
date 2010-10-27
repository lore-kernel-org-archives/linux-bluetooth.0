Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Wed, 27 Oct 2010 22:03:37 +0200
Message-ID: <AANLkTikQqPqJdFgLpUrKiqyAC0HNUFnj+8NtbPxazY18@mail.gmail.com>
Subject: HFP Pulseaudio Source destroyed "too quickly" at the end of a call
From: =?ISO-8859-1?Q?Thomas_W=E4lti?= <twaelti@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello all

I'm developing an application that records all kinds of audio using GStreamer.
Target platform is the Nokia N900, the app is called Recaller
(http://maemo.org/downloads/product/Maemo5/recaller/)

All works well except when ending the recording of Bluetooth
Conversations: Once a party hangs up the call, the PulseAudio source
and sink disappear before I can stop GStreamer recording (I'm
listening to D-Bus events). Unfortunately, this causes my GStreamer
pipeline to crash.

Is there a way to either delay the destruction of the sink/source by
Bluez or a D-Bus message I could intercept/attach to? How can I "win
the race"?

Thank you for your support and hints (and for the outstanding work you
all do on Bluez - a fascinating part of the Linux ecosystem!)
-Tom
