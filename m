Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: "Franck Arnaud" <franck@nenie.org>
To: bluez-devel@lists.sourceforge.net
Message-Id: <45540213.2004.5.20.14.0.11.47584@mem.nenie.org>
Subject: Re: [Bluez-devel] LIBS vs LD_FLAGS in bluez-utils makefiles
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
Date: 20 May 2004 14:00:11 GMT

I wrote:

> $LIBS = @BLUEZ_LIBS@

Sorry, typo, this is without $:

LIBS = @BLUEZ_LIBS@



-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
