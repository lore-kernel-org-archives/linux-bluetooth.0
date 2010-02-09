Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <4fb5db51002091056x54f0f81td3417afbcee29db@mail.gmail.com>
References: <4fb5db51002091056x54f0f81td3417afbcee29db@mail.gmail.com>
Date: Wed, 10 Feb 2010 00:49:34 +0530
Message-ID: <4fb5db51002091119r71ea2c5l813f2f7e6f05478d@mail.gmail.com>
Subject: Fwd: Regd Obexfs support in Linux
From: Janakiram Sistla <janakiram.sistla@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Marcel Holtmann <marcel@holtmann.org>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Hi all,

I am trying to use obexfs in Linux on a poky filesystem.I compiled the
package for ARM cross compiler.when i try to mount using obexfs i see
the following messages and i dont see any remote device filesystem
getting mounted.Can i get any inputs regarding the this.Am i missing
any packages.

Regards,
Ram.




root@beagle:~/sony# obexfs -b 00:1A:75:A9:FD:B6 -B 6 -- -d -f  ~/sony &
root@beagle:~/sony# ls
root@beagle:~/sony# PM: Adding info for No Bus:hci0:2
cd PM: Adding info for No Bus:0:18
unique: 1, opcode: INIT (26), nodeid: 0, insize: 56
INIT: 7.13
flags=0x0000007b
max_readahead=0x00020000
  INIT: 7.8
  flags=0x00000000
  max_readahead=0x00020000
  max_write=0x00020000
  unique: 1, error: 0 (Success), outsize: 40
** (pcmanfm:1349): DEBUG: inotify (1073741856) :home
** (pcmanfm:1349): DEBUG: inotify (1073741856) :/home
** (pcmanfm:1349): DEBUG: inotify (1073741840) :home
** (pcmanfm:1349): DEBUG: inotify (1073741840) :/home
unique: 2, opcode: GETATTR (3), nodeid: 1, insize: 56
  unique: 2, error: 0 (Success), outsize: 112
** (pcmanfm:1349): DEBUG: inotify (1073741856) :root
** (pcmanfm:1349): DEBUG: inotify (1073741856) :/home/root
** (pcmanfm:1349): DEBUG: inotify (32) :.gtk-bookmarks
** (pcmanfm:1349): DEBUG: inotify (16) :.gtk-bookmarks
** (pcmanfm:1349): DEBUG: inotify (32) :.ash_history
** (pcmanfm:1349): DEBUG: inotify (1) :.ash_history
** (pcmanfm:1349): DEBUG: inotify (16) :.ash_history
** (pcmanfm:1349): DEBUG: inotify (1073741840) :root
** (pcmanfm:1349): DEBUG: inotify (1073741840) :/home/root
unique: 3, opcode: ACCESS (34), nodeid: 1, insize: 48
ACCESS / 05
  unique: 3, error: -38 (Function not implemented), outsize: 16
unique: 4, opcode: OPENDIR (27), nodeid: 1, insize: 48
  unique: 4, error: 0 (Success), outsize: 32
unique: 5, opcode: READDIR (28), nodeid: 1, insize: 80
ofs_connect() >>>blocking<<<
** (pcmanfm:1349): DEBUG: inotify (1073741856) :/home/root/sony
ofs_disconnect() <<<unblocking>>>
  unique: 5, error: -2 (No such file or directory), outsize: 16
** (pcmanfm:1349): DEBUG: inotify (1073741840) :/home/root/sony
unique: 6, opcode: RELEASEDIR (29), nodeid: 1, insize: 64
  unique: 6, error: 0 (Success), outsize: 16
unique: 7, opcode: STATFS (17), nodeid: 1, insize: 40
  unique: 7, error: 0 (Success), outsize: 96
unique: 8, opcode: GETATTR (3), nodeid: 1, insize: 56
  unique: 8, error: 0 (Success), outsize: 112
unique: 9, opcode: STATFS (17), nodeid: 1, insize: 40
  unique: 9, error: 0 (Success), outsize: 96
unique: 10, opcode: STATFS (17), nodeid: 1, insize: 40
  unique: 10, error: 0 (Success), outsize: 96
