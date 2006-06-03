Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <549053140606031339i43cee0a7h8622f83d76370504@mail.gmail.com>
References: <549053140606021732w4263c5c2g93efa4cdf9a7614d@mail.gmail.com>
	<1149362263.1977.4.camel@localhost>
	<549053140606031339i43cee0a7h8622f83d76370504@mail.gmail.com>
Date: Sat, 03 Jun 2006 23:50:47 +0200
Message-Id: <1149371447.1977.13.camel@localhost>
Mime-Version: 1.0
Subject: Re: [Bluez-users] PM325 by LG cell phone
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Hi Carl,

>         > Service Name: Dialup Networking
>         > Service RecHandle: 0x10003
>         > Service Class ID List:
>         >   "Dialup Networking" (0x1103)
>         > Protocol Descriptor List:
>         >   "L2CAP" (0x0100) 
>         >   "RFCOMM" (0x0003)
>         >     Channel: 4
>         > Profile Descriptor List:
>         >   "Dialup Networking" (0x1103)
>         >     Version: 0x0100
>         >
>         > I am not sure what to do next.  looks like audio and dun are
>         the only 
>         > profiles the phone supports, so DUN seems like a good place
>         to start.
>         
>         with DUN you can use your mobile phone to dialup to the
>         Internet. It
>         makes you phone look like a modem. The audio profiles allow
>         you to 
>         connect a headset to your phone.
> 
> 
> I am assuming I can connect minicom to it and issue AT commands.  I
> couln't find any instructions on how.

call "rfcomm connect 0 <bdaddr> 4" and you will get a /dev/rfcomm0
terminal device you can use with minicom or whatever program supporting
Linux TTY devices.

Regards

Marcel




_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
