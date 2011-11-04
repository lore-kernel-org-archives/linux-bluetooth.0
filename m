Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 0/2] Initial Time Profile implementation
Date: Fri,  4 Nov 2011 11:59:26 -0400
Message-Id: <1320422368-23820-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

This initial implementation for Time Profile contains the mandatory Current
Time Service (CTS), including the mandatory Current Time Characteristic and the
optional Local Time Information Characteristic.

The only limitation is that notifications for the Current Time Characteristic
value are not being sent yet. The mechanism to detect changes on the system
time is platform specific, therefore we need more infrastructure to support
this and allow multiple platform support.

Future patches will address this (and also make sure the notifications enabled
by clients are persistent across reboots), and we will also introduce Reference
Time Update Service (which also depends on platform specific mechanisms.)

This series depend on the "High level GATT API for service registration" series
sent a while ago. Note that, despite the limitation explained above, we
consider this code ready for upstream inclusion (it is mandatory for server to
implement it, but not mandatory for the client to enable the notification, it
can just read the current time on each connection.)

Best Regards,
--
Anderson Lizardo
Instituto Nokia de Tecnologia (INdT)
Manaus - Brazil
