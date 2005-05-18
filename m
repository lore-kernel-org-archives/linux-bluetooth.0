Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <428BD03E.9000307@xmission.com>
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
Content-Type: multipart/mixed;
 boundary="------------090406060206000709030907"
Subject: [Bluez-devel] libsbc optimizing
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
Date: Wed, 18 May 2005 17:31:10 -0600

This is a multi-part message in MIME format.
--------------090406060206000709030907
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

I have been looking at the problem of libsbc performance on arm. My 
first pass is on the decoder. I'm trying to cut down deeply nested fp 
multiply/divide ops.

I originally planned regression tests in the build process for 
performance/correctness but decided against them:

  - performance may actually go down on x86 where I build when we reduce 
  fp usage
  - the character of roundoff errors will change and the lossy stream 
will probably look different even when it is still "correct"

Anyway, I will need to know the range of certain values in order to make 
much progress. I tried hunting down how they are calculated but it gets 
difficult very quickly.

Can I get help with the ranges for bits[ch][sb] in sbc_unpack_frame and 
the state.* vectors if they're bounded?

How about this first little patch?

Brad

--------------090406060206000709030907
Content-Type: text/plain;
 name="opt1.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="opt1.patch"

Index: sbc/sbc.c
===================================================================
RCS file: /cvsroot/bluetooth-alsa/btsco/sbc/sbc.c,v
retrieving revision 1.33
diff -u -b -B -w -p -r1.33 sbc.c
--- sbc/sbc.c	17 May 2005 06:48:02 -0000	1.33
+++ sbc/sbc.c	18 May 2005 22:32:13 -0000
@@ -391,7 +391,6 @@ static int sbc_unpack_frame(const u_int8
 	int bits[2][8];		/* bits distribution */
 	int levels[2][8];	/* levels derived from that */
 
-	double scalefactor[2][8];	/* derived from frame->scale_factors */
 
 	if (len < 4)
 		return -1;
@@ -525,7 +524,6 @@ static int sbc_unpack_frame(const u_int8
 	for (ch = 0; ch < frame->channels; ch++) {
 		for (sb = 0; sb < frame->subbands; sb++) {
 			levels[ch][sb] = (1 << bits[ch][sb]) - 1;
-			scalefactor[ch][sb] = 2 << frame->scale_factor[ch][sb];
 		}
 	}
 
@@ -534,8 +532,8 @@ static int sbc_unpack_frame(const u_int8
 			for (sb = 0; sb < frame->subbands; sb++) {
 				if (levels[ch][sb] > 0) {
 					frame->sb_sample[blk][ch][sb] =
-					    scalefactor[ch][sb] * ((frame->audio_sample[blk][ch][sb] * 2.0 + 1.0) /
-								   levels[ch][sb] - 1.0);
+						(((frame->audio_sample[blk][ch][sb] << 1) | 1) << frame->scale_factor[ch][sb])/(float)levels[ch][sb]
+						- (1 << frame->scale_factor[ch][sb]);
 				} else {
 					frame->sb_sample[blk][ch][sb] = 0;
 				}
@@ -547,10 +545,11 @@ static int sbc_unpack_frame(const u_int8
 		for (blk = 0; blk < frame->blocks; blk++) {
 			for (sb = 0; sb < frame->subbands; sb++) {
 				if (frame->join & (0x01 << sb)) {
-					frame->sb_sample[blk][0][sb] =
+					double temp =
 					    frame->sb_sample[blk][0][sb] + frame->sb_sample[blk][1][sb];
 					frame->sb_sample[blk][1][sb] =
-					    frame->sb_sample[blk][0][sb] - 2 * frame->sb_sample[blk][1][sb];
+					    frame->sb_sample[blk][0][sb] - frame->sb_sample[blk][1][sb];
+					frame->sb_sample[blk][0][sb] = temp;
 				}
 			}
 		}

--------------090406060206000709030907--


-------------------------------------------------------
This SF.Net email is sponsored by Oracle Space Sweepstakes
Want to be the first software developer in space?
Enter now for the Oracle Space Sweepstakes!
http://ads.osdn.com/?ad_id=7412&alloc_id=16344&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
