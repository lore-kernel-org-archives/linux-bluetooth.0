Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] bthid,ppc,sdp
From: Marcel Holtmann <marcel@holtmann.org>
To: Ben Wilson <bwilson@yooser.org>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <20040519214238.GK15386@stag.mark-and-erika.com>
References: <878yfp4bmz.fsf@handgranat.org>
	 <20040519212124.GI15386@stag.mark-and-erika.com>
	 <1085002651.4327.82.camel@pegasus>
	 <20040519214238.GK15386@stag.mark-and-erika.com>
Content-Type: text/plain
Message-Id: <1085007918.4327.127.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Thu, 20 May 2004 01:05:18 +0200

Hi Ben,

> > build the hidp support as module, because it looks like that some
> > function will collide with the usbhid driver.
> 
> Bingo! Thanks.

I fixed this problem and with the next patch it should be possible to
compile hidp and usbhid built-in.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
