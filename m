Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Reply-To: jay@systech.com
To: linux-bluetooth@vger.kernel.org
From: Jay Foster <jay@systech.com>
Subject: Bluez 5.49 Segmentation Fault
Message-ID: <e4a2aaba-6888-6c44-b48d-e954514263b4@systech.com>
Date: Thu, 22 Mar 2018 12:31:23 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

I am experiencing problems with the latest 5.49 version of the bluez 
bluetooth daemon.  Attempting to configure the Discoverable property of 
an adapter causes the bluetoothd to segmentation fault.  This works 
correctly for version 5.48 and earlier.

The following command demonstrates the bug.

dbus-send --system --dest=org.bluez --print-reply /org/bluez/hci0 
org.freedesktop.DBus.Properties.Set string:org.bluez.Adapter1 
string:Discoverable variant:boolean:true

Jay


