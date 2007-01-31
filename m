Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <20070123154203.GA30435@salmon.maths.tcd.ie>
References: <20070123154203.GA30435@salmon.maths.tcd.ie>
Date: Wed, 31 Jan 2007 12:25:47 +0100
Message-Id: <1170242747.6121.24.camel@violet>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] marshalling SDP_URL_STR
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

Hi Steve,

> It looks as if these types aren't being marshalled properly in the SDP
> library. (They should be treated identically to SDP_TEXT_STR.)
> 
> The current code causes 1 byte too many to be allocated to them in the
> marshalled form which results in garbage when it is read out of the
> buffer.
> 
> The attached patch treats them the same as SDP_TEXT_STR, aside from the
> DTD of course.

are you sure that this doesn't break anything?

Regards

Marcel



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
