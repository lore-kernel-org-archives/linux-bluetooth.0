Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: problem in bluez-4.30 & openobex-1.4 for OPP
Date: Fri, 13 Feb 2009 12:33:05 +0800
Message-ID: <9F2B2656C8747B498D56A7B30FF5EB9FF08352@CNMAIL13.cn.utstarcom.com>
From: "Yao Ye" <yeyao@utstar.com>
To: <linux-bluetooth@vger.kernel.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

hi, all :
my question is about file transfer between mobile phone and my pxa310
board.

1) pxa310 board: run bluez-4.30 & openobex-1.4
cmd tools: openobex-1.4.tar.gz\apps\obex_test

mobile phone : 00:1A:77:77:14:84
pxa310 board : 77:88:66:22:33:44

//add OPUSH service
[root@Linux /bttest]#sdptool add --channel 10 OPUSH
OBEX Object Push service registered

2) push file from pxa310 to mobile phone: ok !

[root@Linux /bttest]#obex_test -b 00:1A:77:77:14:84 3
Using Bluetooth RFCOMM transport
OBEX Interactive test client/server.
> c
bluetoothd[887]: adapter_get_device(00:1A:77:77:14:84)
Made some progress...
Server request finished!
server_done() Command (00) has now finished
Timeout waiting for data. Aborting
> x
PUSH filename> start5.wav

//push file ok ! and i can push file again by press cmd 'x'.
> x
PUSH filename> start1.wav

3) push file from mobile phone to pxa310: can run with some prolem

[root@Linux /bttest]#obex_test -b 77:88:66:22:33:44 10
Using Bluetooth RFCOMM transport
OBEX Interactive test client/server.
> s

// after press cmd 's', i send file from my mobile phone as fast as
possible.
//but it shows timeout error as following

bluetoothd[890]: adapter_get_device(00:1A:77:77:14:84)
Timeout while doing OBEX_HandleInput()
> s

//then i press cmd 's' again, it runs ok, and mobile phone receive the
file successfully.
 
connect_server()
Server request finished!
server_done() Command (00) has now finished
OBEX_HandleInput() returned 7
Unknown event 0b!
Made some progress...
OBEX_HandleInput() returned 40
OBEX_HandleInput() returned 667
put_server()
put_server() Skipped header c3
put_server() Found name
put_server() Skipped header 42
put_server() Found body
Filename = lesson.txt
Wrote lesson.txt (984 bytes)
Server request finished!
server_done() Command (02) has now finished
OBEX_HandleInput() returned 990
We got a disconnect-request
Server request finished!
Disconnect done!
OBEX_HandleInput() returned 3
> s

//press 's' again, it shows error, and can't run OPUSH again.

bluetoothd[890]: adapter_get_device(00:1A:77:77:14:84)
Server register error! (Bluetooth)
> s
Server register error! (Bluetooth)

//Anything i can do is just to press 'q' to quit obex_test.

4) question:
if somebody has also faced this type of problem, kindly reply me. thx !

btw: Is it the problem of my linux kernel version ? maybe it is too old.
But
I can run bluez4.30 on my pxa310 board, and headset & sink & control can
work very well.

Regards
ye yao
