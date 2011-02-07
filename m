Return-Path: <cyrus@holtmann.org>
From: Episteme PROMENEUR <epistemepromeneur@free.fr>
To: linux-bluetooth@vger.kernel.org
Subject: usb webcam, usb bluetooth dongle conflict
Date: Mon, 7 Feb 2011 12:34:48 +0100
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <201102071234.48133.epistemepromeneur@free.fr>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

my webcam
Bus 002 Device 004: ID 046d:0850 Logitech, Inc. QuickCam Web
module : STV06xx

my bluetooth dongle :
Bus 002 Device 006: ID 0a12:0001 Cambridge Silicon Radio, Ltd Bluetooth Dongle 
(HCI mode)

motherboard : Asus M2N, bios 803

Mandriva 2010.2 32 bit
kde 4.5.5
bluedevil 1.02
bluez 4.64

if i plug my bluetooth dongle
then
my webcam does not work

if i unplug my bluetooth dongle
then
my webcam works

if i activate my bluetooth dongle
then
my webcam does not work

if i unactivate my bluetooth dongle
then
my webcam works
