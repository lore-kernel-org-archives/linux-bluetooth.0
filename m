Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Wed, 1 Apr 2009 16:05:54 +0200
Message-ID: <bb7250380904010705k2bd15e55t750b1ae34e480f35@mail.gmail.com>
Subject: DeviceFound-Signal without name?
From: Marcel <wittemar@googlemail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

why does the DeviceFound-Signal from the D-Bus-API does not contain a
name of the device until I have connected to the device one time oder
until "hcitool scan" found the device? Is there a possibility to
configure bluetoothd to put the name every time in this signal? Or is
there a simple way to ask for the name through the D-Bus-API if it is
missing? I'm using bluez 4.33

Greets
