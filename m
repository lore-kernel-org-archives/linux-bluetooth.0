Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <427A305D.40808@xmission.com>
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] Regarding a2recv
References: <20050505124512.53335.qmail@web8306.mail.in.yahoo.com>
In-Reply-To: <20050505124512.53335.qmail@web8306.mail.in.yahoo.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
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
Date: Thu, 05 May 2005 08:40:29 -0600

Mayank,

Good job finding that error.

Sorry I was slow to figure out what you were saying and didn't get it. I 
made the fix.

If you show us the output of 'cvs diff' you'll be able to make these 
things clear with less effort on your part:

$ cvs diff a2dp.h
Index: a2dp.h
===================================================================
RCS file: /cvsroot/bluetooth-alsa/btsco/a2dp.h,v
retrieving revision 1.3
diff -u -b -B -w -p -r1.3 a2dp.h
--- a2dp.h      2 May 2005 16:01:19 -0000       1.3
+++ a2dp.h      5 May 2005 14:34:20 -0000
@@ -38,8 +38,8 @@ struct sbc_frame_header {
  /* packet components */

  struct avdtp_header {
-       uint8_t packet_type:2;
         uint8_t message_type:2;
+       uint8_t packet_type:2;
         uint8_t transaction_label:4;
         uint8_t signal_id:6;
         uint8_t rfa0:2;

Brad

Mayank Batra wrote:
> Henryk,
> 
> Did you try what I suggested you in my mail titled 'A
> small Query' ?
> 
> That is, swap the message_type and packet_type fields
> of the structure
> 
> struct avdtp_header {
> 	uint8_t packet_type:2;
> 	uint8_t message_type:2;
> 	uint8_t transaction_label:4;
> 	uint8_t signal_id:6;
> 	uint8_t rfa0:2;
> } __attribute__ ((packed));
> 
> in the file a2dp.h
> 
> i.e. make it look like the following:
> struct avdtp_header {
> 	uint8_t message_type:2;
> 	uint8_t packet_type:2;
> 	uint8_t transaction_label:4;
> 	uint8_t signal_id:6;
> 	uint8_t rfa0:2;
> } __attribute__ ((packed));
> 
> 
> Once you swap them, I feel that a2recv will work for
> you.
> If it doesn't work, send me a copy of the dump.
> 
> Regards,
> 
> Mayank
> 
> ________________________________________________________________________
> Yahoo! India Matrimony: Find your life partner online
> Go to: http://yahoo.shaadi.com/india-matrimony
> 
> 
> -------------------------------------------------------
> This SF.Net email is sponsored by: NEC IT Guy Games.
> Get your fingers limbered up and give it your best shot. 4 great events, 4
> opportunities to win big! Highest score wins.NEC IT Guy Games. Play to
> win an NEC 61 plasma display. Visit http://www.necitguy.com/?r=20
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel


-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.
Get your fingers limbered up and give it your best shot. 4 great events, 4
opportunities to win big! Highest score wins.NEC IT Guy Games. Play to
win an NEC 61 plasma display. Visit http://www.necitguy.com/?r=20
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
