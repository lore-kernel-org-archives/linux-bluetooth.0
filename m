Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] RFCOMM problemms
From: Marcel Holtmann <marcel@holtmann.org>
To: zubiwat@poczta.onet.pl
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <20040410173436Z154500-21126+67709@kps2.test.onet.pl>
References: <20040410173436Z154500-21126+67709@kps2.test.onet.pl>
Content-Type: text/plain
Message-Id: <1081703869.5398.82.camel@pegasus>
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
Date: Sun, 11 Apr 2004 19:17:50 +0200

Hi Maciej,

> I have problems with a connection through RFCOMM. I have ACL and L2CAP
> channels but when I'm trying to make connection using RFCOMM it doesn't want
> to answer - I mean remote BT device.
> I'm sending SABM packet to start multiplexer working. According to
> specification I should wait for UA packet but I can't get this packet.
> Remote device is silent until it sends me disconnection request and is
> closing ACL channel.
> What can be the cause of this, why the remote device doesn't want to answer
> with UA.
> If any one knows why it's happening like this then please tell me because I
> looked almost every where and I couldn't find a solution.
> It's very important to me !!!

please stop posting non BlueZ related question like this to our mailing
lists. I already told you that I am not going to answer them and as you
have seen nobody else do. Everything you need to know is written in the
Bluetooth specification and with hcidump you can see how BlueZ treats
RFCOMM connections.

Regards

Marcel





-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
