Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] [Bluez-devel]Help on sdp_list_append
From: Stephen Crane <steve.crane@rococosoft.com>
To: Patrick Soboljew <PatrickSoboljew@web.de>
Cc: bluez-devel@lists.sourceforge.net
In-Reply-To: <1216589481@web.de>
References: <1216589481@web.de>
Content-Type: text/plain
Message-Id: <1083142156.29569.319.camel@baroque.rococosoft.com>
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
Date: Wed, 28 Apr 2004 09:49:17 +0100

AFAICR it returns the head of the list. If you supply 0 for the list
parameter it will allocate a new head.

On Tue, 2004-04-27 at 14:16, Patrick Soboljew wrote:
> Hi there,
> 
> I'm new in programming applications using Bluez. Now I'm wondering about the parameters
> in the function sdp_list_append. As return value you get a list and the the first parameter is also a list. When to I fill in a "0" there and when do I put a list in?
> 
> Thanks for your help
> ____________________________________________________________________
> Der WEB.DE Virenschutz schuetzt Ihr Postfach vor dem Wurm Sober.A-F!
> Kostenfrei fuer FreeMail Nutzer. http://f.web.de/?mc=021158
> 
> 
> 
> -------------------------------------------------------
> This SF.net email is sponsored by: The Robotic Monkeys at ThinkGeek
> For a limited time only, get FREE Ground shipping on all orders of $35
> or more. Hurry up and shop folks, this offer expires April 30th!
> http://www.thinkgeek.com/freeshipping/?cpg=12297
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel
-- 
Stephen Crane, Rococo Software Ltd. http://www.rococosoft.com
steve.crane@rococosoft.com +353-1-6601315 (ext 209)



-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
