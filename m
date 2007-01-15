Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Robert Huitl <bluez-devel@huitl.de>
To: bluez-devel@lists.sourceforge.net
MIME-Version: 1.0
Date: Mon, 15 Jan 2007 20:10:54 +0100
Message-Id: <200701152010.54996.bluez-devel@huitl.de>
Subject: [Bluez-devel] a2dpd and mplayer - any chance to get it working?
	[resent]
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

Hi,

I was wondering whether it is possible to make the a2dp alsa plugin supply 
correct audio timing to applications like MPlayer. Right now, MPlayer does 
not work with a2dpd because it relies on the audio driver to report accurate 
audio timing information (or something like that).

If a2dpd could measure the delay introduced on the wireless transport, it 
might be possible to supply timing information to media players. The player 
could then sync the video to the audio data, so there should be no delay at 
all between audio and video playback.

Is there something I am missing?
What changes to the alsa plugin would be necessary?

Even if the delay can't be determined exactly, we could just fake that 
information MPlayer is missing, so that a2dpd at least worked together with 
MPlayer (with a small delay, maybe)?

Regards,
  Robert

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
