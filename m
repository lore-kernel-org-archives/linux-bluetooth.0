Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <20050426122316.47651.qmail@web8310.mail.in.yahoo.com>
From: Mayank Batra <mayankbatra@yahoo.co.in>
Subject: Re: [Bluez-devel] A2DP sink code finally
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <426C62D4.80009@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
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
Date: Tue, 26 Apr 2005 13:23:16 +0100 (BST)

Brad,

> Thanks for the submission. I corrected some
> warnings, disabled unused 
> functions, and added it to Makefile.am.

Great!
 
> We definitely need to do a lot of cleanup (eg now
> that a2play and a2snk 
> have so much duplication), but first off we need to
> see why audio is 
> being distorted...

Exactly. Once the audio part is ok then we can take
care of the duplication part.


Mayank

> Mayank Batra wrote:
> > Hi Brad,
> > 
> > This is the code for the A2DP sink application.
> > 
> > Compilation:
> > 
> > gcc -o a2snk a2snk.c -lbluetooth
> > 
> > Running the application:
> > 
> > ./a2snk
> > 
> > Right now the following bugs exist:
> > 
> > 1)   Poor sound quality.
> > 
> > 2)   Unclean disconnection.
> > 
> > Help me improve the above areas.
> > 
> > Please add this code to the CVS.
> > 
> > Thanks and Regards,
> > 
> > Mayank
> > 
> >
>
________________________________________________________________________
> > Yahoo! India Matrimony: Find your life partner
> online
> > Go to: http://yahoo.shaadi.com/india-matrimony
> > 
> > 
> >
>
------------------------------------------------------------------------
> > 
> > /*
> >  * a2snk.c
> >  * This program functions as an A2DP sink
> >  * (Emulation of an A2DP headset)
> >  * Mayank Batra  <mayankbatra@yahoo.co.in>
> >  * Abhinav Mathur <abhinavpmathur@yahoo.com>
> >  * 
> >  *   This program is free software; you can
> redistribute it and/or modify
> >  *   it under the terms of the GNU General Public
> License as published by
> >  *   the Free Software Foundation; either version
> 2 of the License, or
> >  *   (at your option) any later version.
> >  *
> >  *   This program is distributed in the hope that
> it will be useful,
> >  *   but WITHOUT ANY WARRANTY; without even the
> implied warranty of
> >  *   MERCHANTABILITY or FITNESS FOR A PARTICULAR
> PURPOSE.  See the
> >  *   GNU General Public License for more details.
> >  *
> >  *   You should have received a copy of the GNU
> General Public License
> >  *   along with this program; if not, write to the
> Free Software
> >  *   Foundation, Inc., 59 Temple Place, Suite 330,
> Boston, MA  02111-1307 USA
> >  *
> >  */
> >  
> > #ifdef HAVE_CONFIG_H
> > #include <config.h>
> > #endif
> > 
> > #include <stdio.h>
> > #include <errno.h>
> > #include <fcntl.h>
> > #include <unistd.h>
> > #include <stdlib.h>
> > #include <getopt.h>
> > #include <signal.h>
> > #include <string.h>
> > #include <sys/socket.h>
> > #include <sys/stat.h>
> > #include <sys/soundcard.h>	//To play the sound on
> the sound card
> > 
> > #include "sbc/sbc.h"
> > 
> > #include <bluetooth/bluetooth.h>
> > #include <bluetooth/hci.h>
> > #include <bluetooth/hci_lib.h>
> > #include <bluetooth/l2cap.h>
> > #include <bluetooth/sdp.h>
> > #include <bluetooth/sdp_lib.h>
> > 
> > #include <netinet/in.h>
> > 
> > /* AVDTP structures */
> > 
> > /* packet components */
> > 
> > struct avdtp_header {
> > 	//uint8_t packet_type:2;
> > 	uint8_t message_type:2;
> > 	uint8_t packet_type:2;
> > 	uint8_t transaction_label:4;
> > 	uint8_t signal_id:6;
> > 	uint8_t rfa0:2;
> > } __attribute__ ((packed));
> > 
> > struct acp_seid_info {
> > 	uint8_t rfa0:1;
> > 	uint8_t inuse0:1;
> > 	uint8_t acp_seid:6;
> > 	uint8_t rfa2:3;
> > 	uint8_t tsep:1;
> > 	uint8_t media_type:4;
> > } __attribute__ ((packed));
> > 
> > struct sbc_codec_specific_elements {
> > 	// a2dp p. 20
> > 	uint8_t channel_mode:4;
> > 	uint8_t frequency:4;
> > 	uint8_t allocation_method:2;
> > 	uint8_t subbands:2;
> > 	uint8_t block_length:4;
> > 	uint8_t min_bitpool;
> > 	uint8_t max_bitpool;
> > } __attribute__ ((packed));
> > 
> > #define MAX_ADDITIONAL_CODEC 0	//Right now only
> SBC is supported
> > #define MAX_ADDITIONAL_CODEC_OCTETS
> (MAX_ADDITIONAL_CODEC*sizeof(struct acp_seid_info))
> > 
> > /* packets */
> > 
> > struct sepd_req {
> > 	struct avdtp_header header;
> > } __attribute__ ((packed));
> > 
> > struct sepd_resp {
> > 	struct avdtp_header header;
> > 	struct acp_seid_info infos[1 +
> MAX_ADDITIONAL_CODEC];
> > } __attribute__ ((packed));
> > 
> > struct getcap_req {
> > 	struct avdtp_header header;
> > 	uint8_t rfa1:2;
> > 	uint8_t acp_seid:6;
> > } __attribute__ ((packed));
> > 
> > struct getcap_resp {
> > 	struct avdtp_header header;
> > 
> > 	uint8_t serv_cap;
> > 	uint8_t serv_cap_len;
> > 
> > 	uint8_t cap_type;
> > 	uint8_t length;
> > 	uint8_t media_type;
> > 	uint8_t media_codec_type;
> > 
> > 	struct sbc_codec_specific_elements sbc_elements;
> > 
> > } __attribute__ ((packed));
> > 
> > struct set_config {
> > 	struct avdtp_header header;
> > 
> > 	uint8_t rfa0:2;
> > 	uint8_t acp_seid:6;
> > 	uint8_t rfa1:2;
> > 	uint8_t int_seid:6;
> > 
> > 	uint8_t serv_cap;
> > 	uint8_t serv_cap_len;
> > 
> > 	uint8_t cap_type;
> > 	uint8_t length;
> > 	uint8_t media_type;
> > 	uint8_t media_codec_type;
> > 
> > 	struct sbc_codec_specific_elements sbc_elements;
> > 
> > } __attribute__ ((packed));
> 
=== message truncated === 

________________________________________________________________________
Yahoo! India Matrimony: Find your life partner online
Go to: http://yahoo.shaadi.com/india-matrimony


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
