Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <20060719085107.34521.qmail@web15806.mail.cnb.yahoo.com>
References: <20060719085107.34521.qmail@web15806.mail.cnb.yahoo.com>
Date: Thu, 20 Jul 2006 02:51:37 +0200
Message-Id: <1153356697.4094.12.camel@aeonflux.holtmann.net>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] About the transfering speed of bluez RFCOMM	socket
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hi,

> Env:
> Machine A and machine B are the same.
> But
> suse10.1 for A   ---bluez
> windowsXP(SP2) for B ---bluesoleil
> We use the same bluetooth dongle and mobile device(symbian) in the
> test.
> When I use OpenObex(based on bluez Rfcomm socket) to send a file from
> machieA to the mobile device the transfering speed is about 10K
> BytePerSec.
> When I use Bluesoleil to send the same file from machine B to the
> mobile device the transfering speed is about 40K-50K BytePerSec.
>  
> Why is  B much better than A?
> is it not efficient of Bluez Rfcomm socket? or other reason.

the BlueZ RFCOMM can go full speed. Maybe the OBEX part is a little bit
screwed up. However I can't say anything without comparing the setups of
both connections. For the BlueSoleil connection you would need to make
an air trace. For the BlueZ connection it is enough if you create a
trace with "hcidump -X -V".

Regards

Marcel



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
