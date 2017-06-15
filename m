Return-Path: <linux-bluetooth-owner@vger.kernel.org>
To: <linux-bluetooth@vger.kernel.org>
From: ERAMOTO Masaya <eramoto.masaya@jp.fujitsu.com>
Subject: [PATCH BlueZ 0/3] client: Improve help command
Message-ID: <3520047b-7832-35e2-d1fa-fb7f5c0d058d@jp.fujitsu.com>
Date: Thu, 15 Jun 2017 20:35:52 +0900
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This adds alias-related help messages and makes more readable in whole.
The help command outputs the following messages before applying these
patches:

[bluetooth]# help
Available commands:
   list                       List available controllers
   show [ctrl]                Controller information
   select <ctrl>              Select default controller
   devices                    List available devices
   paired-devices             List paired devices
   power <on/off>             Set controller power
   pairable <on/off>          Set controller pairable mode
   discoverable <on/off>      Set controller discoverable mode
   agent <on/off/capability>  Enable/disable agent with given capability
   default-agent              Set agent as the default one
   advertise <on/off/type>    Enable/disable advertising with given type
   set-advertise-uuids [uuid1 uuid2 ...] Set advertise uuids
   set-advertise-service [uuid][data=[xx xx ...] Set advertise service data
   set-advertise-manufacturer [id][data=[xx xx ...] Set advertise manufacturer data


As below after applying this patches:

[bluetooth]# help
Available commands:
   list                       List available controllers
   show [ctrl]                Controller information
   select <ctrl>              Select default controller
   devices                    List available devices
   paired-devices             List paired devices
   system-alias <name>        Set controller alias
   reset-alias                Reset controller alias
   power <on/off>             Set controller power
   pairable <on/off>          Set controller pairable mode
   discoverable <on/off>      Set controller discoverable mode
   agent <on/off/capability>  Enable/disable agent with given capability
   default-agent              Set agent as the default one
   advertise <on/off/type>    Enable/disable advertising with given type
   set-advertise-uuids [uuid1 uuid2 ...]
                              Set advertise uuids
   set-advertise-service [uuid][data=[xx xx ...]
                              Set advertise service data
   set-advertise-manufacturer [id][data=[xx xx ...]
                              Set advertise manufacturer data


ERAMOTO Masaya (3):
   client: Compare a input string and each command only once
   client: Add a description to all commands
   client: Output a long message by two lines

  client/main.c | 37 +++++++++++++++++++++++++------------
  1 file changed, 25 insertions(+), 12 deletions(-)

-- 
2.7.4

