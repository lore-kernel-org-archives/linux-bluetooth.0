Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Unable to get hciattach to work...
From: Marcel Holtmann <marcel@holtmann.org>
To: Michael Frey <mfrey@pepper.com>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <C65C90C8-93AA-11D8-88A9-00039390D626@pepper.com>
References: <E09DAEFD-93A2-11D8-88A9-00039390D626@pepper.com>
	 <1082559461.23959.37.camel@pegasus>
	 <80000A27-93A5-11D8-88A9-00039390D626@pepper.com>
	 <1082560168.23959.40.camel@pegasus>
	 <C65C90C8-93AA-11D8-88A9-00039390D626@pepper.com>
Content-Type: text/plain
Message-Id: <1082562647.23959.43.camel@pegasus>
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
Date: Wed, 21 Apr 2004 17:50:47 +0200

Hi Michael,

> Ok -- I was able to patch my kernel -- fixing up by hand any rejects 
> but I get the following when trying to build the bluez modules.
> core.c: In function `bnep_session':
> core.c:463: error: structure has no member named `nice'
> core.c: In function `bnep_add_connection':

then your kernel includes another backport, because this is a 2.6
feature only. Replace the line with

	set_user_nice(current, -15);

and see if that helps.

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
