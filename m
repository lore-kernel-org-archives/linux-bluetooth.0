Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Attila Zsigmond <mail@backend-wizard.com>
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] Transfer link key from/to windows
References: <200504291858.19965@ByZsA> <200504292010.42625.bluez-user@schaettgen.de>
In-Reply-To: <200504292010.42625.bluez-user@schaettgen.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Message-Id: <200504292307.25245@ByZsA>
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Fri, 29 Apr 2005 23:07:24 +0200

>the link key is always 16 bytes / 128 bits long. Even Windows can"t
> change this.
> 
> Regards
> 
> Marcel

Hmmm... Thank you, Marcel. I know that this list is not about MS windows 
but maybe somebody can help. Here is the link key exported from XP 
registry:

Windows Registry Editor Version 5.00

[HKEY_LOCAL_MACHINE\SOFTWARE\Widcomm\BTConfig\Devices\08:00:1f:51:d1:e9]
"Name"=hex:57,69,6c,64,72,6f,73,65,00
"DevClass"=hex:50,02,04
"Features"=hex:ef,ff,0b,00,00,00,00,00
"TimeStamp"=dword:0000329d
"FTPAuthorizationExpires"=hex:00
"OPPAuthorizationExpires"=hex:00
"TrustedMask"=dword:00000000
"LinkKey"=hex:80,00,00,00,4c,00,00,00,01,02,00,00,02,66,00,00,00,a4,00,00,84,
\
  e1,7a,fe,7f,da,a6,51,87,b1,b7,1e,19,cc,cd,ea,fe,f7,b5,88,57,33,15,27,91,f8,
\
  c9,db,74,00,59,64,ff,9f,8b,3c,a0,fb,01,ba,52,7c,f3,28,94,b1,54,52,a4,30,42,
\
  6a,90,9f,55,40,a8,62,af,5c,60,7e,1f,92,28,00,00,00,15,86,a6,99,9b,53,e6,6c,
\
  a3,8e,06,77,c5,4d,3e,9a,17,70,8d,6b,06,40,19,88,fb,6b,d6,9f,8f,ef,77,3d,23,
\
  0f,99,cc,c7,d0,1d,cb

[HKEY_LOCAL_MACHINE\SOFTWARE\Widcomm\BTConfig\Devices\08:00:1f:51:d1:e9\0]
"ServiceNameUTF8"=hex:53,65,72,69,61,6c,20,50,6f,72,74,00
"ServiceNameNative"=hex:53,65,72,69,61,6c,20,50,6f,72,74,00
"UUID"=dword:00001101
"Security"=dword:00000000
"DefaultConnection"=dword:00000000

How can it be 16 bytes long? How can it be decoded or which part should 
I use?

Attila



-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.
Get your fingers limbered up and give it your best shot. 4 great events, 4
opportunities to win big! Highest score wins.NEC IT Guy Games. Play to
win an NEC 61 plasma display. Visit http://www.necitguy.com/?r=20
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
