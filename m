Return-Path: <cyrus@holtmann.org>
Message-ID: <54CB81F5.3000401@mozilla.com>
Date: Fri, 30 Jan 2015 14:07:01 +0100
From: Thomas Zimmermann <tzimmermann@mozilla.com>
MIME-Version: 1.0
To: linux-bluetooth@vger.kernel.org
CC: Shawn Huang <shuang@mozilla.com>
Subject: Extending BlueZ's HAL protocol
Content-Type: text/plain; charset=utf-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello,

On Mozilla's Firefox OS, we use a daemon for running Bluedroid drivers
in their own address space, and communicate with the daemon via BlueZ's
HAL protocol. [1]

We'd like to use the HAL protocol as-is, but several commands are not
defined in the spec. We especially ran into this problem with
Bluedroid's |bt_interface_t::config_hci_snoop_log|. BlueZ has a
completely different mechanism for handling the command and probably
won't ever require an opcode for it. Just adding an opcode for
|config_hci_snoop_log| to our code base will probably collide with BlueZ
official spec in the long run.

Our proposal is to reserve two opcodes per service for extensions to
commands and notifications. This would allow us to add the missing
pieces without opcode collisions.

Best regards
Thomas

[1]
https://git.kernel.org/cgit/bluetooth/bluez.git/tree/android/hal-ipc-api.txt
