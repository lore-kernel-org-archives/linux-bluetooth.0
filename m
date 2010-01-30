Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <f97b2b971001292024u7ddf84b6gd063280efa6c1a4e@mail.gmail.com>
References: <f97b2b971001292013i3edd6bdajde0d9e39ed021fbd@mail.gmail.com>
	 <f97b2b971001292024u7ddf84b6gd063280efa6c1a4e@mail.gmail.com>
Date: Sat, 30 Jan 2010 06:40:58 +0200
Message-ID: <f97b2b971001292040hf7537d2yeef91fecf4189c50@mail.gmail.com>
Subject: Kernel panic when dongle is disconnected during sco connection
From: Ahmed Ragab <elmasri.ahmed@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

I Forgot to mention kernel version 2.6.26 however i have the latest
bluez package

Please confirm this bug, Linux kernel hangs when usb bluetooth dongle
is disconnected
During SCO connection stream (read, write).
I don't think it's a problem of the dongle however i am using dongle
trust bluetooth 2 USB Adapter 100m BT-2305p
which has a Cambridge silicon radio chip set 2.1
