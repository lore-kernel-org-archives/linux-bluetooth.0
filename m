Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
Content-Type: text/plain
Message-Id: <1101592165.27074.31.camel@pegasus>
Mime-Version: 1.0
Subject: [Bluez-devel] SBC code cleanup
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Sat, 27 Nov 2004 22:49:25 +0100

Hi Henryk,

I started with some cleaning up of the SBC code to better fit into
current coding conventions. My focus was on the sbc_synthesize_audio()
and sbc_analyze_audio() functions. While checking them and looking at
the code I think we also need this patch:

--- sbc/sbc.c   27 Nov 2004 21:39:38 -0000      1.23
+++ sbc/sbc.c   27 Nov 2004 21:46:01 -0000
@@ -523,7 +523,7 @@
        int i, j, k;
 
        /* Input 8 New Subband Samples */
-       for (i = 0; i < 7; i++)
+       for (i = 0; i < 8; i++)
                state->S[ch][i] = frame->sb_sample[blk][ch][i];
 
        /* Shifting */

Am I right, or do I miss something?

Regards

Marcel




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
