Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Robert Huitl <bluez-devel@huitl.de>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
Date: Thu, 17 May 2007 15:21:38 +0200
References: <200705170207.52710.bluez-devel@huitl.de>
	<d89ddf300705162042j1850b997wd069bae29e813d29@mail.gmail.com>
In-Reply-To: <d89ddf300705162042j1850b997wd069bae29e813d29@mail.gmail.com>
MIME-Version: 1.0
Message-Id: <200705171521.38889.bluez-devel@huitl.de>
Subject: Re: [Bluez-devel] headsetd has problems serving two applications at
	a time
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

Hi Brad,

On Donnerstag, 17. Mai 2007, Brad Midgley wrote:
> headsetd is written to allow a single application to use the headset at one
> time. it doesn't multiplex the mic or mix to the speaker. one of the two
> apps will fail to get exclusive access. it's basically a latency
> optimization but there's room for something like dmix or a sound server
> like pulse to make it more flexible.

Thanks for pointing that out, not exactly what I wanted to hear, but it's an 
explanation ;-)

I played a bit with dmix, dsnoop, dshare etc., but I cannot get any of the d* 
plugins to work. The error message is always the same:

-----
$ arecord -D headset-test -f s16_le -r 8000  | aplay -D headset-test -f 
s16_le -r 8000
ALSA lib pcm_direct.c:1464:(_snd_pcm_direct_get_slave_ipc_offset) Invalid 
type 'sco' for slave PCM

aplay: main:545: audio open error: Invalid argument
ALSA lib pcm_direct.c:1464:(_snd_pcm_direct_get_slave_ipc_offset) Invalid 
type 'sco' for slave PCM

arecord: main:545: audio open error: Invalid argument
-----

this is with the following sections in .asoundrc (they might not be exactly 
what's needed here, but the same error messages appear as soon as I throw one 
of the dmix/dsnoop/... plugins into the chain):

pcm.dmixed {
       ipc_key 1025
       type dmix
       slave.pcm "headset-sco"
}

pcm.dsnooped {
       ipc_key 1027
       type dsnoop
       slave.pcm "headset-sco"
}

pcm.headset-test {
       type asym
       playback.pcm "dmixed"
       capture.pcm "dsnooped"
}


Could it be that some of the ALSA plugins only work with hardware devices?!

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
