Return-Path: <cyrus@holtmann.org>
From: Guillaume Bedot <littletux@zarb.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <47A438C6.90700@gmx.de>
References: <47A274DB.9020808@gmx.de>  <47A438C6.90700@gmx.de>
Content-Type: multipart/mixed; boundary="=-ILy3U4uW8xWLZdSjG3bg"
Date: Sat, 02 Feb 2008 11:40:07 +0100
Message-Id: <1201948807.11895.10.camel@littletux>
Mime-Version: 1.0
Subject: Re: [Bluez-users] BT Headset connected but no sound
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net


--=-ILy3U4uW8xWLZdSjG3bg
Content-Type: text/plain
Content-Transfer-Encoding: 7bit


On sam, 2008-02-02 at 10:32 +0100, Daniel Stumpner wrote:
> Daniel Stumpner wrote:
> > Hi,
> > 
> > can connect to my BT Headset but if I try to play a sound, it does only
> > beep at the start and at the end of the connection but there is no sound.
> > 
> > mplayer -ao alsa:device=bluetooth test.wav
> > - beep -
> > (pressing 'q')
> > - beep -
> > 
> > I am running Gentoo with linux 2.6.23 (x86)
> > bluez-libs-3.24
> > blues-utils-3.24
> > 
There is a bug in bluez-utils 3.24 that prevents headset/SCO connections
to work.
Try with current bluez cvs or with the attached patch.

> But the errors don't change...
> What do I have to do to get my key-agent working?
> 
You can check your configuration in /etc/bluetooth/hcid.conf too.

Regards,

Guillaume B.


--=-ILy3U4uW8xWLZdSjG3bg
Content-Disposition: attachment; filename=bluez-utils-3.24-fixheadset.patch
Content-Type: text/x-patch; name=bluez-utils-3.24-fixheadset.patch;
	charset=utf-8
Content-Transfer-Encoding: 7bit

--- bluez-utils/audio/pcm_bluetooth.c	2008/01/05 14:51:47	1.91
+++ bluez-utils/audio/pcm_bluetooth.c	2008/01/09 03:03:32	1.92
@@ -786,11 +786,11 @@
 	DBG("areas->step=%u areas->first=%u offset=%lu size=%lu io->nonblock=%u",
 			areas->step, areas->first, offset, size, io->nonblock);
 
+	frame_size = areas->step / 8;
+
 	if (data->count > 0)
 		goto proceed;
 
-	frame_size = areas->step / 8;
-
 	nrecv = recv(data->stream.fd, data->buffer, data->link_mtu,
 			MSG_WAITALL | (io->nonblock ? MSG_DONTWAIT : 0));
 

--=-ILy3U4uW8xWLZdSjG3bg
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
--=-ILy3U4uW8xWLZdSjG3bg
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--=-ILy3U4uW8xWLZdSjG3bg--
