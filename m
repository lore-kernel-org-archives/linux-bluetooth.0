Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: RE: [Bluez-devel] BC Flag in HCI ACL Data PACket.
From: Marcel Holtmann <marcel@holtmann.org>
To: Aarti Kumar <akmr2000@yahoo.com>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <20040529144553.59027.qmail@web52304.mail.yahoo.com>
References: <20040529144553.59027.qmail@web52304.mail.yahoo.com>
Content-Type: text/plain
Message-Id: <1085900936.12117.111.camel@pegasus>
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
Date: Sun, 30 May 2004 09:08:56 +0200

Hi Aarti,

> Right now I am trying to differentiate between the
> packets I am sending to the master. Packets are coming
> from the same source, but one of the packet has got
> some information I need to process, differently. Now
> since between two bluetooth devices there can be just
> one acl link. I have to differentitate between the
> incoming packets. And that can be done by setting some
> header value of some field. The only field which i
> could identify is the BC flag field which is not being
> used right now. I want to set these field values and
> then check at them at receiver hci layer and process
> the packet seperatly.

who said that the BC flag will be there at the other end after your
packet is sent over the air? I don't think that you can misuse HCI flags
to achieve your goal. The HCI is a hardware interface and not a protocol
layer.

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
