Return-Path: <cyrus@holtmann.org>
Date: Wed, 9 Jan 2008 01:28:28 +0100
From: Pavel Semerad <semerad@sisal.mff.cuni.cz>
To: bluez-devel@lists.sourceforge.net
Message-ID: <20080109002828.GB5883@ps.ms.mff.cuni.cz>
MIME-Version: 1.0
Subject: [Bluez-devel] error in headset capture, patch included
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net


Helo,

I have found error in function bluetooth_hsp_read. frame_size is
correctly set only when data->count is zero. When data->count is
nonzero, frame_size is 0 and condition
'if ((data->count + size * frame_size) <= data->link_mtu)'
is always true and frames_to_write is set incorrectly (1000 instead
max 24 in my case). This results in capture not working for headset,
cycling in endless loop.

Following patch sets frame_size before check to data->count and
'arecord -D bluetooth -f S16_LE' now works.

Pavel Semerad



--- ./audio/pcm_bluetooth.c.capture     2007-12-08 20:04:40.000000000
+0100
+++ ./audio/pcm_bluetooth.c     2008-01-09 01:12:02.000000000 +0100
@ -786,11 +786,11 @@ static snd_pcm_sframes_t bluetooth_hsp_r
        DBG("areas->step=%u areas->first=%u offset=%lu size=%lu
io->nonblock=%u",
                        areas->step, areas->first, offset, size,
io->nonblock);
 
+       frame_size = areas->step / 8;
+
        if (data->count > 0)
                goto proceed;
 
-       frame_size = areas->step / 8;
-
        nrecv = recv(data->stream.fd, data->buffer, data->link_mtu,
                        MSG_WAITALL | (io->nonblock ? MSG_DONTWAIT :
0));
 

-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://ad.doubleclick.net/clk;164216239;13503038;w?http://sf.net/marketplace
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
