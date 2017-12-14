Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CADU0Vqxge=ESPPT3YWPt9VCRZCCX=VM5AHBYVnVQsKP3_mveiA@mail.gmail.com>
References: <CADU0Vqxge=ESPPT3YWPt9VCRZCCX=VM5AHBYVnVQsKP3_mveiA@mail.gmail.com>
From: John Klug <ski.brimson@gmail.com>
Date: Thu, 14 Dec 2017 09:21:32 -0600
Message-ID: <CADU0VqxBm3dv3oMsvMLqQ_h0EqwQpekJsVT6RkZZ_buiK_db_w@mail.gmail.com>
Subject: Re: Profile1 close question
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

What is holding the connection open is bluetoothd.

After closing the file descriptor for RFCOMM, there are two file
descriptors in the Bluetooth daemon that are left:

bluetooth 1406 root   18u     sock        0,7      0t0 26587 protocol: RFCOMM
bluetooth 1406 root   19u     sock        0,7      0t0 26602 protocol: RFCOMM

By terminating the application these go away, but what if I wish to
keep the daemon running?  How do I tell the Bluetooth daemon to close
the RFCOMM sockets?

On Wed, Dec 13, 2017 at 6:13 PM, John Klug <ski.brimson@gmail.com> wrote:
> The file descriptor that is placed as a parameter to the NewConnection
> callback does not close the connection when it is called with the OS's
> close.  This is using Bluez 5.47 on Linux.
>
> Bluetoothctl still shows the connection as being up, as does the remote.
>
> What method should one use to close the connection?
>
> I am using Python and GObject Introspection.
>
> Before connection:
> rw.py   3983 root    0u      CHR      136,3      0t0     6 /dev/pts/3
> rw.py   3983 root    1u      CHR      136,3      0t0     6 /dev/pts/3
> rw.py   3983 root    2u      CHR      136,3      0t0     6 /dev/pts/3
> rw.py   3983 root    3u     unix 0xceaf54a0      0t0 22976 type=STREAM
> rw.py   3983 root    4u  a_inode        0,9        0     7 [eventfd]
> rw.py   3983 root    5u  a_inode        0,9        0     7 [eventfd]
>
> After Connection:
> NewConnection(/org/bluez/hci0/dev_BC_44_86_56_6B_95, 8)
>
> rw.py   3983 root    0u      CHR      136,3      0t0     6 /dev/pts/3
> rw.py   3983 root    1u      CHR      136,3      0t0     6 /dev/pts/3
> rw.py   3983 root    2u      CHR      136,3      0t0     6 /dev/pts/3
> rw.py   3983 root    3u     unix 0xceaf54a0      0t0 22976 type=STREAM
> rw.py   3983 root    4u  a_inode        0,9        0     7 [eventfd]
> rw.py   3983 root    5u  a_inode        0,9        0     7 [eventfd]
> rw.py   3983 root    8u     sock        0,7      0t0 23050 protocol: RFCOMM
>
> After Close:
> rw.py   3983 root    0u      CHR      136,3      0t0     6 /dev/pts/3
> rw.py   3983 root    1u      CHR      136,3      0t0     6 /dev/pts/3
> rw.py   3983 root    2u      CHR      136,3      0t0     6 /dev/pts/3
> rw.py   3983 root    3u     unix 0xceaf54a0      0t0 22976 type=STREAM
> rw.py   3983 root    4u  a_inode        0,9        0     7 [eventfd]
> rw.py   3983 root    5u  a_inode        0,9        0     7 [eventfd]
>
>
> Device BC:44:86:56:6B:95
> ...
> Connected: yes
