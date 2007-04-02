Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Date: Tue, 03 Apr 2007 10:21:33 +1200
To: "bluez-devel@lists.sourceforge.net" <bluez-devel@lists.sourceforge.net>
From: "Jasper Mackenzie" <jasper@treshna.com>
MIME-Version: 1.0
Message-ID: <op.tp6gd7zomz9ilx@rayleigh>
Subject: Re: [Bluez-devel] Help getting Plugz going
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

Thanks Brad,

> fwiw, I made some improvements and put a line in the asound.conf that
should help you see where to put the address.

That did the trick.
  AsI was testing over ssh I cant hear if audio actually came out or not.
If tomorrow when I go and try it for real and no sound comes out the  
headset, asre there any other things I can try to get it to work?

mplayer spat out the following as it played, is this normal?:

DEBUG: _snd_pcm_sco_open: Starting pcm_sco plugin.
DEBUG: _snd_pcm_sco_open: Open mode is for Playback.
DEBUG: _snd_pcm_sco_open: opened as ioplug=0x8544588, pcm=0x85446c8,  
ioplug->callback = 0xb7f3e740
DEBUG: sco_prepare: Preparing with io->period_size = 24, io->buffer_size =  
48
AO: [alsa] 8000Hz 1ch s16le (2 bytes per sample)
Video: no video
Starting playback...
DEBUG: sco_pointer: returning bt_headset->hw_ptr=0
DEBUG: sco_pointer: returning bt_headset->hw_ptr=0
DEBUG: sco_write: areas->step=16, areas->first=0, offset=0, size=48,  
io->nonblock=0
DEBUG: sco_write: time: seconds=1175551211 nseconds=475464284
DEBUG: sco_write: returning 24
DEBUG: sco_start:
DEBUG: sco_pointer: returning bt_headset->hw_ptr=24
DEBUG: sco_write: areas->step=16, areas->first=0, offset=24, size=24,  
io->nonblock=0
DEBUG: sco_write: time: seconds=1175551211 nseconds=476009046
DEBUG: sco_write: returning 24
etc...

> most clients don't let you easily choose this device.

  Is there any workaround for Skype, the only application she wants this  
for? Like a virtual device or something?
I cant even find a .skype directory, sneaky skype

Jasper

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
