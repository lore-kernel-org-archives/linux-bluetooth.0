Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <45A592D6.4050604@odi.ch>
Date: Thu, 11 Jan 2007 02:28:54 +0100
From: =?ISO-8859-1?Q?Ortwin_Gl=FCck?= <odi@odi.ch>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: [Bluez-devel] Mighty Mouse again
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

Okay, ignore my former emails. I figured out that the mouse data is 
parsed by net/bluetooth/hidp/core.c. A patch seems straight forward. I 
have verified that the code is executed. But I still don't see the 
events in xev. Any hints to a poor kernel newbie?

Cheers

Ortwin

--- core.c.orig 2007-01-11 01:31:29.000000000 +0100
+++ core.c      2007-01-11 02:16:05.000000000 +0100
@@ -212,6 +212,8 @@

                 if (size > 3)
                         input_report_rel(dev, REL_WHEEL, sdata[3]);
+               if (size > 4)
+                       input_report_rel(dev, REL_HWHEEL, sdata[4]);
                 break;
         }

@@ -563,7 +565,7 @@
                 input->keybit[LONG(BTN_MOUSE)] = BIT(BTN_LEFT) | 
BIT(BTN_RIGHT) | BIT(BTN_MIDDLE);
                 input->relbit[0] = BIT(REL_X) | BIT(REL_Y);
                 input->keybit[LONG(BTN_MOUSE)] |= BIT(BTN_SIDE) | 
BIT(BTN_EXTRA);
-               input->relbit[0] |= BIT(REL_WHEEL);
+               input->relbit[0] |= BIT(REL_WHEEL) | BIT(REL_HWHEEL);
         }

         input->event = hidp_input_event;


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
