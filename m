Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] pan on zaurus
From: Philip Blundell <pb@nexus.co.uk>
To: Kutschenreuter Matthias <Matthias.Kutschenreuter@siemens.com>
Cc: "'Bluez-devel@lists.sourceforge.net'" <Bluez-devel@lists.sourceforge.net>
In-Reply-To: <AFE91B59A185A5439840B43AB7919047093912@mchp997a.mch.sbs.de>
References: <AFE91B59A185A5439840B43AB7919047093912@mchp997a.mch.sbs.de>
Content-Type: text/plain
Message-Id: <1079570413.9385.21.camel@dixie.nexus.co.uk>
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
Date: Thu, 18 Mar 2004 00:40:13 +0000

On Wed, 2004-03-17 at 19:28, Kutschenreuter Matthias wrote:
> Now I cannot understand, why my software fails on Zaurus, 
> using the same commands as the official PAN, that doesnt fail.

I suggest you run both programs under strace and look for difference in
the syscalls that they make.  There should be nothing special about the
ARM other than the structure-packing issue that you mentioned.

p.



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
