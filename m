Return-Path: <cyrus@holtmann.org>
Subject: False negative checking for SSP support
From: Bastien Nocera <hadess@hadess.net>
To: BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain
Date: Sat, 13 Jun 2009 20:06:08 +0100
Message-Id: <1244919968.11069.4360.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Heya,

I'm slowly adding SSP 2.1 support to gnome-bluetooth. For that, I got a
laptop running Fedora 11, with a Bluetooth 2.1 dongle, in addition to
the one in the machine I'm trying to pair from.

Is there any reason why the other machine shows up as not supporting
SSP, when it actually does?

We already handle that case in the wizard, but it would be nicer if it
did detect it.

Cheers

