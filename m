Return-Path: <cyrus@holtmann.org>
Date: Tue, 28 Jul 2015 17:16:47 +0200
From: Arthur LAMBERT <lambertarthur22@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: compile gatt server outside bluez source
Message-ID: <20150728151647.GA17994@arthur-dreem>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi all,

I am currently implementing a gatt server with custom profile, charac, ....
I am inspired from bluez sources (last stable version source package 5.32). My
model is : bluez-5.32/tools/btgatt-server.c

Problem is that I am not able to build my own gatt server out of bluez tree.
Indeed I am not able to find gatt api in headers and library installed by 'make
install' from bluez package.

Do I am using the wrong API ? Do I have miss something ?

Thanks,
Arthur.
