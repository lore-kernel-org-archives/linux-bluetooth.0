Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <AFE91B59A185A5439840B43AB7919047093912@mchp997a.mch.sbs.de>
From: Kutschenreuter Matthias <Matthias.Kutschenreuter@siemens.com>
To: "'Bluez-devel@lists.sourceforge.net'"
	 <Bluez-devel@lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Bluez-devel] pan on zaurus
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
Date: Wed, 17 Mar 2004 20:28:50 +0100

Hi,

I installed "bluez-zaurus_2.3b_arm.ipk" on zaurus and
can perfetly pan between zaurus and non-arm laptops: pand -s, pand -c <MAC>.

Now I wrote a software, that  does the same as in the
source file <pand.c>  (connect / accept, bnep_create_connectio ...).
this software works perfectly among non-arm devices, but
the zaurus can only be a slave with it (the "pand -s" part).

if the zaurus tries to create the connection (would
be equivalent to pand -c MAC), it fails on l2cap before 
bnep commands are involved.

sk=socket(AF_BLUETOOTH, SOCK_SEQPACKET, BTPROTO_L2CAP)
getsockopt(sk, ...)
...
connect(sk, (struct sockaddr *) &l2a, sizeof(l2a))  
<---- this connect fails

gives back: "No route to host."

using hcidump, I see that no "CreateConnection" is sent.
I found out that sizeof(l2a) equals 12, although it should only
be 10. this is due to padding:  on zaurus struct-sizes are padded
to a multiple of 4 bytes, i.e. 12 instead of 10. But I think
this cant be the problem, as it also will pad when executing "pand -c"
(which works). 


Now I cannot understand, why my software fails on Zaurus, 
using the same commands as the official PAN, that doesnt fail.
Which are the sources of  bluez-zaurus_2.3b_arm.ipk? 
	(I only found those of bluez-zaurus_2.3_arm.ipk)
Are they different to the one for non-arm devices?
Is there a trick, when cross compiling bluez for zaurus ?

Kind regards, Matthias


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
