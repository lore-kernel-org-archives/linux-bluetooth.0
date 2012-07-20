Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Fri, 20 Jul 2012 10:29:59 -0600
Message-ID: <CAAbnaHb+Za_13Wvp0v4ea0JhXShbgsimC_FeLSkoHOUXHg+JjQ@mail.gmail.com>
Subject: [RFC generichid 0/5]
From: Nathaniel Haggard <natester@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Patch to add generichid so bluez can emulate a bluetooth keyboard.
Pairs with ubuntu, osx leopard and tiger.  The following commands set
it up for testing:

#!/bin/bash

./src/bluetoothd -P input -n &> log &
/usr/local/sbin/hciconfig hci0 class 0x02540
/usr/local/sbin/hciconfig hci0 piscan
python test/simple-agent

 Makefile.am         |   10 +
 Makefile.tools      |    1 +
 acinclude.m4        |    6 +
 bootstrap-configure |    1 +
 input/generichid.c  | 1220 +++++++++++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 1238 insertions(+), 0 deletions(-)
