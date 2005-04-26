Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <20050426122127.57962.qmail@web8302.mail.in.yahoo.com>
From: Mayank Batra <mayankbatra@yahoo.co.in>
To: BLUEZ DEVELOPERS LIST <bluez-devel@lists.sourceforge.net>
In-Reply-To: <426C05D9.6090100@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Subject: [Bluez-devel] Re: a2play code that is working
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
Date: Tue, 26 Apr 2005 13:21:27 +0100 (BST)

Brad,

> There is sometimes a delay before cvs gets updated
> by sourceforge. I had 
> made those changes to sbc.h

Are you sure it will be ok if we change the sbc.h and
sbc.c files ?
Because then the other applications making use of the
sbc encoder will also have to change accordingly...??

I mean it is ok for a2dp applications, but what about
others...??


Mayank


 
> Mayank Batra wrote:
> > Brad,
> > 
> > I tried the code from the CVS.
> > 
> > It was not compiling.
> > 
> > Reason is that you have changed the no. of
> parameters
> > being passed through sbc_encode(). But in sbc.h
> the
> > declaration is different.
> > 
> > So I have made a new file called sbc_a2dp.h which
> now
> > contains the new declaration.
> > 
> > Also we will have to include the file sbc_a2dp.c
> > because the sbc.c file contains the old definition
> of
> > sbc_encode(). Now since the definintion has
> changed I
> > have made a new file called sbc_a2dp.c which we
> will
> > have to include in the a2play.c file. I know that
> it
> > is not good to include .c files in the code... but
> > can't help it.
> > 
> > If you have a better way out, please tell me.
> > 
> > Put the sbc_a2play.h and sbc_a2play.c files in the
> > sbc/ folder.
> > 
> > After making the above files and including
> sbc_a2dp.h
> > and sbc_a2dp.c files in the a2play.c file, then
> the
> > compilation is taking place fine.
> > 
> > Please note that after including the sbc_a2dp.h
> and
> > sbc_a2dp.c files in the a2play.c file you should
> not
> > give -lsbc during compilation.
> > 
> > I am not sending the patch once again. Please bear
> > with me.
> > 
> > Thanks.
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
> >  * a2play.c
> >  * experimenting with sending a2dp audio to a
> headset
> >  * Brad Midgley
> >  *
>
*************************************************************************************
> >  * Mayank Batra <mayankbatra@yahoo.co.in> (Added
> real time SBC encoding while streaming)
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
> > /* This is because we have changed the declaration
> of sbc_encode */
> > #include "sbc/sbc_a2dp.h"	
> > /* This is because we have changed the definition
> of sbc_encode */
> > #include "sbc/sbc_a2dp.c"	//Even though it is not
> good to do so
> > /* So, we do not want to use the sbc.h and sbc.c
> files as they contain the old definition and
> declaration */
> > 
> > /* AVDTP structures */
> > 
> > /* packet components */
> > 
> > struct avdtp_header {
> > 	uint8_t packet_type:2;
> > 	uint8_t message_type:2;
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
> > #define MAX_ADDITIONAL_CODEC 4
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
