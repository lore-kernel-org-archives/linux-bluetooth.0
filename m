Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
From: Hieu Le <hieu.le@veriksystems.com>
Date: Wed, 5 Oct 2016 22:37:35 +0700
Message-ID: <CADEmUHPqOU4SpUuN2gWHNGFUTZ+fpXszjwJSNu=Wfq1kjtOzSA@mail.gmail.com>
Subject: BlueZ: How to change supervision timeout
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello,

I am using BlueZ-5.39 to develop my application which creates a GATT
server and uses BlueZ D-Bus method call "RegisterProfile" to hook
itself to Bluetooth daemon.

The application is working fine. However, I want to change the default
supervision timeout because Central and Peripheral sometimes got
disconnected when moving away.

I searched all the document. Unfortunately, I cannot find any D-Bus
API to accomplish it.

Could you please suggest me any solution for this?

Many thanks for your valuable input.
Hieu
