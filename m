Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Announce : BlueZ-based implemantation of JSR82
From: Marcel Holtmann <marcel@holtmann.org>
To: Stephen Crane <steve.crane@rococosoft.com>
Cc: Julien Campana <juliencampana@yahoo.fr>,
   BlueZ-devel List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1085654720.17536.405.camel@baroque.rococosoft.com>
References: <1085393268.892.40.camel@fischer>
	 <1085487245.9779.89.camel@pegasus>  <1085489942.900.89.camel@fischer>
	 <1085492205.9779.119.camel@pegasus>  <1085496174.900.127.camel@fischer>
	 <1085497660.9779.139.camel@pegasus>  <1085653295.914.36.camel@fischer>
	 <1085654720.17536.405.camel@baroque.rococosoft.com>
Content-Type: text/plain
Message-Id: <1085661209.2797.16.camel@merlin>
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
Date: Thu, 27 May 2004 14:33:30 +0200

Hi Stephen,

> Yeah, having built a JSR82 solution with callbacks to Java from the
> native layer for SDP, I can whole-heartedly recommend passing the
> bytearray returned from the search back to Java and parsing it there.
> 
> I'd been thinking of splitting the SDP code along these lines: one base
> layer which encapsulates the protocol and some user-space helper
> functions which (de-)construct the byte-arrays passed to this base
> layer. What do you think Marcel?

I think this is a nice idea, because this makes it also very easy to
store the SDP record on a filesystem for caching or anything else. I
have done something similar in the SDP code for libs2.

Lets talk about the API and then start coding this extension.

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
