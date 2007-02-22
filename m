Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1172106351.3760.29.camel@cookie.hadess.net>
References: <1172106351.3760.29.camel@cookie.hadess.net>
Date: Thu, 22 Feb 2007 07:53:40 +0100
Message-Id: <1172127220.14885.5.camel@violet>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] Fax using Bluetooth, no FAX profile
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

Hi Bastien,

> I was looking at whether it was possible to use a Bluetooth mobile phone
> to send a fax. But I realised my phone doesn't have the FAX profile,
> only a Serial Port one. Is it possible at all to send Faxes using this
> (ie. would be dependent on the phone implementing +ATFCLASS properly),
> or I shouldn't even think about it?

there is actually no big difference between Fax Profile and Serial Port
Profile. The only big difference is a different SDP record and on some
GSM devices you might find an extra port for Fax. So in general using
the Serial Port Profile should work fine. However I never send a fax
using my mobile phone, so I have no clue if this actually works.

Regards

Marcel



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
