Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] code is ok, but still unknown field type
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <20050609131722.GF6606@pangeia.com.br>
References: <BAY20-F20A55F402EB690A199F6BD853E0@phx.gbl>
	 <d1f423d30504070519333f3148@mail.gmail.com>
	 <20050609131722.GF6606@pangeia.com.br>
Content-Type: text/plain
Message-Id: <1118365168.5609.2.camel@notepaq>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Fri, 10 Jun 2005 02:59:28 +0200

Hi Nelson,

> lk2a is a ascii dump for link_key database (default in /etc/bluetooth) 
> 
> Field1 = key
> Field2 = bdaddr remote
> Field3 = bdaddr local
> Field4 = type (???)
> Field5 = time
> 
> # ./lk2a 
> 88fc30d45810b6f32cfd626c969bfc49 00:10:60:AA:9B:5B 00:60:57:DF:1D:29 0 Fri May 27 10:58:47 2005

why don't you read the Bluetooth specification to understand what type
is. Look for HCI_Link_Key_Notification.

Starting with bluez-utils-2.16 it is no longer a binary file.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.  How far can you shotput
a projector? How fast can you ride your desk chair down the office luge track?
If you want to score the big prize, get to know the little guy.  
Play to win an NEC 61" plasma display: http://www.necitguy.com/?r=20
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
