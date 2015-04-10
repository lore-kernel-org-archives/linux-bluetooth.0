Return-Path: <cyrus@holtmann.org>
Message-ID: <55280988.7090400@gmail.com>
Date: Fri, 10 Apr 2015 13:34:00 -0400
From: Gabriel Smith <ga29smith@gmail.com>
MIME-Version: 1.0
To: Bluez List <linux-bluetooth@vger.kernel.org>
Subject: Cached Device UUIDs not Visable on DBus
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

When searching for devices, I ckeck the service UUIDs to find the 
correct device to connect to. On the first run of the program the device 
is discovered, the service UUID is matched, and everything goes 
smoothly. On every other run after the first the device is found, but no 
service UUIDs are set. I check for a PropertiesChanged signal when this 
occurs, but the signal is only ever sent when the RSSI value changes. 
When the system is rebooted, the program can run again once.
I am using Bluez 5.30 and the high level GIO DBus API. I see that the 
GIO DBus API, specifically GDBusProxy, caches properties, but promises 
that they are updated on PropertiesChanged signals. As the program works 
once I do not think that it is the fault of the GIO DBus API. Is there 
something I am missing with Bluez's operation that would cause this 
error to happen?

-- 
Thank you,
Gabriel Smith

