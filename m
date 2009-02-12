Return-Path: <cyrus@holtmann.org>
Message-Id: <49944CE2.11B9.0054.1@speno.ch>
Date: Thu, 12 Feb 2009 16:23:01 +0100
From: "Pierre Wenger" <PW@speno.ch>
To: <linux-bluetooth@vger.kernel.org>
Subject: Problem with kbluetooth on a EeePC 901 on Xandros
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello

I installed kdebluetooth and openobex-apps and every thing work in the console : after starting bluetooth, dbus and th hci interface (hciconfig hci0 up), I can use hcitool to scan or inq and it find all my BT peripherals (4 differents GSM and a Palm in a test).

The problem is in kbluetooth : it start but stay gray saying "No Bluetooth Adapter".

Seems to me that the program is searching the adapter in the wonrg place, but after a lot of Google search, I didn't find the key of this problem.

The key is a Trust BT-2210Tp (Class 2) and the netbook is an Asus EeePC 901

Thank you very much for your help

Pierre Wenger

