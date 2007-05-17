Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Robert Huitl <bluez-devel@huitl.de>
To: bluez-devel@lists.sourceforge.net
Date: Thu, 17 May 2007 02:07:52 +0200
MIME-Version: 1.0
Message-Id: <200705170207.52710.bluez-devel@huitl.de>
Subject: [Bluez-devel] headsetd has problems serving two applications at a
	time
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

Trying to get headsetd to work with the latest Skype version, I was able to 
find some pointers why Skype would freeze when I select the headset device 
both as an input and output device.

Try the following command:

$ arecord -D headset-sco -f s16_le -r 8000  | \
aplay -D headset-sco -f s16_le -r 8000

This should send all input captured right back to the headset, but it doesn't. 
The following is debug output from pcm_sco.c:

DEBUG(pid=7780): _snd_pcm_sco_open: Starting pcm_sco_headset plugin.
DEBUG(pid=7780): _snd_pcm_sco_open: Open mode is for Playback.
DEBUG(pid=7780): _snd_pcm_sco_open: do_cfg >>
DEBUG(pid=7780): do_cfg: send (PKT_TYPE_CFG_BDADDR) >>
DEBUG(pid=7780): do_cfg: <<send (PKT_TYPE_CFG_BDADDR)
DEBUG(pid=7780): do_cfg: recv (PKT_TYPE_CFG_BDADDR) >>
DEBUG(pid=7779): _snd_pcm_sco_open: Starting pcm_sco_headset plugin.
DEBUG(pid=7779): _snd_pcm_sco_open: Open mode is for Capture.
DEBUG(pid=7779): _snd_pcm_sco_open: do_cfg >>
DEBUG(pid=7779): do_cfg: send (PKT_TYPE_CFG_BDADDR) >>
DEBUG(pid=7779): do_cfg: <<send (PKT_TYPE_CFG_BDADDR)
DEBUG(pid=7779): do_cfg: recv (PKT_TYPE_CFG_BDADDR) >>
DEBUG(pid=7780): do_cfg: <<recv (PKT_TYPE_CFG_BDADDR)
DEBUG(pid=7780): do_cfg: send (PKT_TYPE_CFG_PAGINGTIMEOUT) >>
DEBUG(pid=7780): do_cfg: <<send (PKT_TYPE_CFG_PAGINGTIMEOUT)
DEBUG(pid=7780): do_cfg: recv (PKT_TYPE_CFG_PAGINGTIMEOUT) >>
DEBUG(pid=7780): do_cfg: <<recv (PKT_TYPE_CFG_PAGINGTIMEOUT)
DEBUG(pid=7780): _snd_pcm_sco_open: << do_cfg, get_sco_fd >>
DEBUG(pid=7780): _snd_pcm_sco_open: << get_sco_fd (OK)
DEBUG(pid=7780): _snd_pcm_sco_open: opened as ioplug=0x805ebd0, pcm=0x805ed08, 
ioplug->callback = 0xb7f48f40
Aborted by signal Interrupt...
DEBUG(pid=7780): sco_headset_close: closing ioplug=0x805ebd0
DEBUG(pid=7780): sco_headset_close: Closing Playback stream

(the << and >> messages are print before and after the corresponding function 
calls)

Suspicious here is:
1) "opened as ioplug=..." appears only once.
2) this is because do_cfg() only returns for process 7780, but not for 7779
3) which in turn is caused by the recv() call in do_cfg() which is blocking, 
waiting for an answer from headsetd about the PKT_TYPE_CFG_BDADDR it sends.

So why is headsetd not processing the config request of the 2nd process?
I'm not sure about the reason for this, but it doesn't get to dispatch the 
event that would send the answer pcm_sco.c is waiting for. It's somehow 
blocked by the first process. As soon as I kill the arecord/aplay combo, it 
gets to process the second CFG_BDADDR packet.


Another test:

$ arecord -D headset-sco -f s16_le -r 8000 > testfile
[testfile is recorded ok, keep arecord running]
$ aplay -D headset-sco -f s16_le -r 8000 < existing-testfile

In this scenario, aplay will be frozen until I kill arecord. Then it plays 
back the sound.

So why is headsetd blocking the second application while the first one is 
running?


I'd appreciate any hints,

Robert

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
