Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Bluetooth, Mobile IPv6 and PAN profile
From: Marcel Holtmann <marcel@holtmann.org>
To: Wang Haiguang <wanghg@i2r.a-star.edu.sg>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <LMEOKMJFKNFFHEAEDGDEGEDNCHAA.wanghg@i2r.a-star.edu.sg>
References: <LMEOKMJFKNFFHEAEDGDEGEDNCHAA.wanghg@i2r.a-star.edu.sg>
Content-Type: text/plain
Message-Id: <1085407211.9779.22.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Mon, 24 May 2004 16:00:11 +0200

Hi Haiguang,

> Has anybody tried to test the Mobile IPv6 over bluetooth with PAN profile?
> 
> For example, two node work as NAP with bluetooth and one node as PANU.
> 
> If you did, please give me some hint?
> 
> Now I am trying on the stuffs. 

I've never done this nor have I tested IPv6 together with PAN, but the
BNEP is only an ethernet emulation and so everything that's working over
ethernet should work over BNEP, too.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
