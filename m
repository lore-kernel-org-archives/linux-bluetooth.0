Return-Path: <bluez-devel-admin@lists.sourceforge.net>
To: bluez-devel@lists.sourceforge.net
From: Paul Ionescu <i_p_a_u_l@yahoo.com>
Message-ID: <pan.2005.01.19.22.10.39.649619@yahoo.com>
References: <20050118195131.CD122EACF@sc8-sf-spam2.sourceforge.net> <20050119161516.5ab84510@mirko_3>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Subject: [Bluez-devel] Re: Headset connected, respondig, but silent
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
Date: Thu, 20 Jan 2005 00:10:43 +0200

Hi,

When you assume you are connected (with btsco), can you check that you
have SCO packets in and out your BT adapter (with hcidump) ?
The direction is marked with > and < in hcidump.
Also you can try to connect with btsco2.
I also have a jabra but a bt110, and btsco2 gives better results.
Then try to connect to the handsfree profile, not the default headset
profile.
If your jabra is like mine, then you should append channel 2 on the btsco2
command-line.

Best regards,
Paul

On Wed, 19 Jan 2005 16:15:16 +0100, mirko_3 wrote:

> Hi everyone,
> I've been trying to get my headset to work lately, with partial success:
> using the latest btsco-cvs, I manage to connect to the headset (a
> Jabra-250, I think), and pressing the volume/answer buttons is correctly
> detected by the program. I've unmuted everything in alsamixer, and set 
> snd cards_limit=2 in modules.conf (although I don't use modules for
> alsa...). Everything is as it should be, except I can neither record nor
> playback anything. Here's my dmesg after pressing the play button three
> times on xmms (the progress bar doesn't move, the song doesn't start):
> 
> snd-bt-sco revision 1.4 $
> snd-bt-sco: snd-bt-scod thread starting snd-bt-sco: playback_open
> snd-bt-sco: prepare ok bps: 16000 size: 8000 count: 800 snd-bt-sco:
> prepare ok bps: 16000 size: 8000 count: 800 snd-bt-sco: playback_trigger 1
> snd-bt-sco: setting playback to bspcm snd-bt-sco: playback_trigger 0
> snd-bt-sco: setting playback to NULL
> snd-bt-sco: playback_open
> snd-bt-sco: prepare ok bps: 16000 size: 8000 count: 800 snd-bt-sco:
> prepare ok bps: 16000 size: 8000 count: 800 snd-bt-sco: playback_trigger 1
> snd-bt-sco: setting playback to bspcm snd-bt-sco: playback_trigger 0
> snd-bt-sco: setting playback to NULL
> snd-bt-sco: playback_open
> snd-bt-sco: prepare ok bps: 16000 size: 8000 count: 800 snd-bt-sco:
> prepare ok bps: 16000 size: 8000 count: 800 snd-bt-sco: playback_trigger 1
> snd-bt-sco: setting playback to bspcm snd-bt-sco: playback_trigger 0
> snd-bt-sco: setting playback to NULL
> 
> Program output is normal:
> Device is 1:0
> Voice setting: 0x0060
> RFCOMM channel 1 connected
> recieved AT+CKPD=200
> opened hwdep
> connected SCO channel
> Setting sco fd
> Done setting sco fd
> recieved AT+VGS=09
> Sending up speaker change 9
> recieved AT+VGS=08
> Sending up speaker change 8
> 
> 
> I really hope you can help me, as I've tried for days. Thank you all.




-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
