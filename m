Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] RFCOMM connecting problem
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <20050430151036.04f20b12.zhixiang_deng@yahoo.com.cn>
References: <200501261244.47898.jschindele@arcor.de>
	 <20050430151036.04f20b12.zhixiang_deng@yahoo.com.cn>
Content-Type: text/plain
Message-Id: <1114856606.8836.126.camel@pegasus>
Mime-Version: 1.0
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
Date: Sat, 30 Apr 2005 12:23:26 +0200

Hi,

> when I tried to establish an RFCOMM connection between two bluetooth devices by typing the commands : rfcomm bind 0 <btaddr> 0 ,rfcomm listen 0 0 on one side , it gave the following message : Waiting for connection on channel 0 .However ,on the other side ,when I type the commands : rfcomm bind 0 <btaddr> 0 ,rfcomm connect 0 <remote btaddr> 0 , it gave the message : Can't create RFCOMM socket : invalid argument . What should I do to create the rfcomm connection correctly? Thanks very much .

the RFCOMM channel 0 is not a valid channel.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.
Get your fingers limbered up and give it your best shot. 4 great events, 4
opportunities to win big! Highest score wins.NEC IT Guy Games. Play to
win an NEC 61 plasma display. Visit http://www.necitguy.com/?r=20
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
