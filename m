Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Fri, 6 May 2011 11:27:16 +0200
Message-ID: <BANLkTi=xZk7+5RfZ40T6pKiYc06-sKJqhw@mail.gmail.com>
Subject: GSoC: Nintendo Wiimote Driver
From: David Herrmann <dh.herrmann@googlemail.com>
To: linux-bluetooth@vger.kernel.org, padovan@profusion.mobi
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi all

My name is David Herrmann and I am a student at Uni-Tuebingen in
Germany. I got accepted with my GSoC project at Bluez and will develop
a kernel-driver for the Nintendo Wiimote in the next few months with
the help of my tutor (Gustavo Padovan).

The Project:
The Nintendo Wiimote may be known to many of you. It is a bluetooth
device with several I/O ports: buttons, rumble (force feedback),
speaker, infrared-cam, accelerometer, leds and an extension port.
There are some known libraries which implement few features of the
wiimote. However, all these libraries suffer from several restrictions
like no asynchronous API, no auto-reconnection, limited functionality,
etc...
My intention is to write a kernel-driver which implements all these
features on kernel-side with a clean API using as much
kernel-infrastructure as possible. Integrating the driver into bluez
is the only way to support real auto-reconnection and fast
audio/infrared transfers.
You may watch my progress on: https://github.com/dvdhrm/xwiimote
If you have suggestions/questions, I am really glad to hear from you
via: #bluez (dvdhrm) or email.

About Me:
I am 20 years old and an undergraduate from Tübingen/Germany. I
develop IRC server-software since 3 years for the OnlineGamesNet
(http://wiki.onlinegamesnet.net) in cooperation with Undernet and
GameSurge. Currently, I try to get into kernel development and I
thought GSoC would be a great opportunity to do so. Besides, I love
working on 3D renderers and multimedia stuff.

I am really looking forward to the next four months and hope that it
will be a great and of course productive time.

Regards
David
