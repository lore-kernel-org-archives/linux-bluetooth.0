Return-Path: <tetsu@s-direct.com>
Message-Id: <4.3.2-J.20040710152845.0669b538@emi.s-direct.com>
Date: Sat, 10 Jul 2004 23:11:07 +0900
To: Marcel Holtmann <marcel@holtmann.org>
From: Tetsuo Shiraishi <tetsu@s-direct.com>
Subject: Re: [Bluez-devel] rfcomm bind : Address already in use
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1089396790.22528.6.camel@pegasus>
References: <4.3.2-J.20040709223728.06828b80@emi.s-direct.com>
 <4.3.2-J.20040709223728.06828b80@emi.s-direct.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-ID: <bluez-devel.lists.sourceforge.net>

Hi Marcel,

At 04/07/09 20:13 +0200, Marcel Holtmann wrote:
>
>what kind of peer is this? Why don't you try to fix the problem in the
>peer device? The BlueZ RFCOMM part is working correct.
>

The peer is a device for data gathering using DUN + PPP.

I think so, but that device is not our product.
I cannot fix it.
(It takes long time to fix the problem...)

>The left over socket you see in /proc is from your application and it is
>in the closed state. Do you really terminate your application? Try to
>repdroduce this with rctest.
>

My application can terminate using HUP signal and clean up sockets.
Then I made sure using ps utility.

And I terminated the application, lines of /proc/bluetooth/rfcomm
decrease to 1 line.

The followings is more detailed testing operations.

1 - I start the application.
    - DUN listen
    
2 - "cat /proc/bluetooth/rfcomm" says the following.
    This socket is for listening, isn't it ?

	~ # cat /proc/bluetooth/rfcomm
	sk  E6:D7:1E:96:A0:00 00:00:00:00:00:00 4 1

2 - The peer(00:07:CF:51:78:F3) try to connect.
    No RFCOMM connections are established.

	send RFCOMM_SABM
	send RFCOMM_PN
	send RFCOMM_DISC
	send RFCOMM_DISC
	send RFCOMM_DISC
	         :
	       repeat
	         :

3 - hcitool dc 00:07:CF:51:78:F3

4 - "cat /proc/bluetooth/rfcomm" says the following.
    When received RFCOMM_PN, the socket of upper line seems to be allocated.
    (Probably for accepted socket, but no RFCOMM connections are established.)

	~ # cat /proc/bluetooth/rfcomm
	sk  E6:D7:1E:96:A0:00 F3:78:51:CF:07:00 9 1
	sk  E6:D7:1E:96:A0:00 00:00:00:00:00:00 4 1

5 - I terminate the application sending HUP signal.

6 - "cat /proc/bluetooth/rfcomm" says the following.
    The socket for listening deleted...

	~ # cat /proc/bluetooth/rfcomm
	sk  E6:D7:1E:96:A0:00 F3:78:51:CF:07:00 9 1

7 - I start the application again.
    But bind() fails saying "Address already in use".

I really want to use standard utilities(like rctest).
But the peer device behaves strange occasionally, 
while continuous tests.
And the continuous tests needs the peer device to 
establish DUN + PPP and do the application process normally.

Thanks,

Tetsuo

//
//   Tetsuo Shiraishi tetsu@s-direct.com
//                    tshiro@arion.ocn.ne.jp
//
