Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-Id: <45AE1BFE.5301.0014.0@novell.com>
Date: Wed, 17 Jan 2007 12:55:18 -0700
From: "Olin Atkinson" <oatkinson@novell.com>
To: <bluez-devel@lists.sourceforge.net>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] I got plugz to compile but now there is no sound
	on the	headset after connecting
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

Wait, I lied.  The command line is giving the following output:


DEBUG(pid=7544): _snd_pcm_sco_open: Starting pcm_sco_headset plugin.
DEBUG(pid=7544): _snd_pcm_sco_open: Open mode is for Playback.
ALSA lib pcm_sco.c:533:(_snd_pcm_sco_open) Unknown field max_periods
aplay: main:550: audio open error: Invalid argument
oatkinson@oatkinson1:/windows/D/projects/gspcav1-20060925> aplay -v
Aborted by signal Interrupt...


Any ideas how best to debug the problem?

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
