Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <455CCAF4.8020007@silicom.fr>
Date: Thu, 16 Nov 2006 21:32:52 +0100
From: Fabien Chevalier <fchevalier@silicom.fr>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="------------050409040509070603080106"
Subject: [Bluez-devel] SCO on bluez : some architectural tips
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

This is a multi-part message in MIME format.
--------------050409040509070603080106
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


Marcel & Brad,

I send you this e-mail to share some of the experience acquired while 
writing bluez-headset.
There is much to share but i'll do it bits at a time, it will be more 
easy to digest than a 300 lines e-mail :-).

So let's talk about SCO today. :-)

SCO is designed for low quality (poor Hz rate). It's only application is 
telephony.
However it requires *really* low latency.

At first hand i tried the same approach as you did, which means route 
audio trough a daemon that could do all kind a of funny and interesting 
stuff in it. This would have been a very interesting approach.
However result was really bad, for two reasons:
 * The unix socket between application and the daemon would queue some 
data, which would add unwanted delay.
 * And moreover, the fact to send the data trough a 3rd party unix 
process (the daemon), resulted in jitter due to scheduling behaviour. Do 
avoid hearing audio cuts in the headset, i had to add run daemon as root 
and decrease its nice value to unsane levels.

Due to this, i had to fall back on having the SCO file descriptor 
available in application process space.

However, due to the fact a2dp is not supposed to be used for delay sensitive
 streams, it is possible to use this architecture for a2dp. :-)

Cheers,

Fabien

--------------050409040509070603080106
Content-Type: text/x-vcard; charset=utf-8;
 name="fchevalier.vcf"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="fchevalier.vcf"

begin:vcard
fn:Fabien CHEVALIER
n:CHEVALIER;Fabien
org:SILICOM
adr:;;4 rue de Jouanet;RENNES ATALANTE;;35700;FRANCE
email;internet:fchevalier@silicom.fr
title:Software & Studies Engineer
tel;work:+33 (0) 2 99 84 17 17
version:2.1
end:vcard


--------------050409040509070603080106
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--------------050409040509070603080106
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--------------050409040509070603080106--
