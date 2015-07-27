Return-Path: <cyrus@holtmann.org>
From: Tobias Preclik <linux-bluetooth@tobias.preclik.de>
Subject: Invalid file descriptor gatttool of bluez 5.32
To: linux-bluetooth@vger.kernel.org
Message-ID: <55B5DA6E.9060100@tobias.preclik.de>
Date: Mon, 27 Jul 2015 09:14:54 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello,

it seems the cleanup process when disconnecting from a bluetooth LE 
device changed in bluez 5.32 but gatttool 
(attrib/interactive.c:disconnect_io) wasn't updated.

$ ./gatttool -I
[                 ][LE]> connect FF:A7:8C:98:46:B6 random
Attempting to connect to FF:A7:8C:98:46:B6
Connection successful
[FF:A7:8C:98:46:B6][LE]> disconnect

(gatttool:20949): GLib-WARNING **: Invalid file descriptor.

[FF:A7:8C:98:46:B6][LE]> exit

What's the right way to do it in gatttool/bluez 5.32?

Best regards,
Tobias
