Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] IBM Thinkpad A31p and Bluetooth
From: Marcel Holtmann <marcel@holtmann.org>
To: Fredrik Noring <noring@nocrew.org>
Cc: jvp@lateapex.net, BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <1063473896.18942.35.camel@h9n1fls20o980.bredband.comhem.se>
References: <200309130612.h8D6CKs06276@localhost.lateapex.net>
	<1063441693.19165.31.camel@h9n1fls20o980.bredband.comhem.se>
	<1063449127.28890.407.camel@pegasus>
	<1063473896.18942.35.camel@h9n1fls20o980.bredband.comhem.se>
Content-Type: text/plain
Message-Id: <1063475808.28891.450.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: 13 Sep 2003 19:56:42 +0200

Hi Fredrik,

> > Please, can someone post the result of a SDP search with --tree option
> > for the OBEX push profile.
> 
> # sdptool search --tree OPUSH 00:07:E0:0C:1B:3F
> Inquiring ...
> Searching for OPUSH on 00:07:E0:0C:1B:3F ...
> Attribute Identifier : 0x0 - ServiceRecordHandle
>   Integer : 0x10001

seems that Palm uses default record handle number scheme. Please check
the records 0x10000 and onwards for values.

Regards

Marcel




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
