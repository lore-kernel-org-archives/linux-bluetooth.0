Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: mirko_3 <mirko_3@gmx.net>
To: bluez-devel@lists.sourceforge.net
Message-ID: <20050119161516.5ab84510@mirko_3>
In-Reply-To: <20050118195131.CD122EACF@sc8-sf-spam2.sourceforge.net>
References: <20050118195131.CD122EACF@sc8-sf-spam2.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: [Bluez-devel] Headset connected, respondig, but silent
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
Date: Wed, 19 Jan 2005 16:15:16 +0100

Hi everyone,
I've been trying to get my headset to work lately, with partial success: using the latest btsco-cvs, I manage to connect to the headset (a Jabra-250, I think), and pressing the volume/answer buttons is correctly detected by the program. I've unmuted everything in alsamixer, and set  snd cards_limit=2 in modules.conf (although I don't use modules for alsa...). Everything is as it should be, except I can neither record nor playback anything. Here's my dmesg after pressing the play button three times on xmms (the progress bar doesn't move, the song doesn't start):

snd-bt-sco revision 1.4 $
snd-bt-sco: snd-bt-scod thread starting
snd-bt-sco: playback_open
snd-bt-sco: prepare ok bps: 16000 size: 8000 count: 800
snd-bt-sco: prepare ok bps: 16000 size: 8000 count: 800
snd-bt-sco: playback_trigger 1
snd-bt-sco: setting playback to bspcm
snd-bt-sco: playback_trigger 0
snd-bt-sco: setting playback to NULL
snd-bt-sco: playback_open
snd-bt-sco: prepare ok bps: 16000 size: 8000 count: 800
snd-bt-sco: prepare ok bps: 16000 size: 8000 count: 800
snd-bt-sco: playback_trigger 1
snd-bt-sco: setting playback to bspcm
snd-bt-sco: playback_trigger 0
snd-bt-sco: setting playback to NULL
snd-bt-sco: playback_open
snd-bt-sco: prepare ok bps: 16000 size: 8000 count: 800
snd-bt-sco: prepare ok bps: 16000 size: 8000 count: 800
snd-bt-sco: playback_trigger 1
snd-bt-sco: setting playback to bspcm
snd-bt-sco: playback_trigger 0
snd-bt-sco: setting playback to NULL

Program output is normal: 
Device is 1:0
Voice setting: 0x0060
RFCOMM channel 1 connected
recieved AT+CKPD=200
opened hwdep
connected SCO channel
Setting sco fd
Done setting sco fd
recieved AT+VGS=09
Sending up speaker change 9
recieved AT+VGS=08
Sending up speaker change 8


I really hope you can help me, as I've tried for days. Thank you all.

-- 
Dammit Jim, I'm an actor, not a doctor.


-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
