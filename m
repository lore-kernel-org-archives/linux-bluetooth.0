Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Date: Sun, 11 Mar 2007 13:55:48 -0700
From: Matt Zimmerman <mdz@ubuntu.com>
To: bluez-users@lists.sourceforge.net
Message-ID: <20070311205548.GQ8187@alcor.net>
References: <20070311203223.GP8187@alcor.net>
MIME-Version: 1.0
In-Reply-To: <20070311203223.GP8187@alcor.net>
Subject: Re: [Bluez-users] Plantronics 510 headset: playback partially works,
	but not recording
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

On Sun, Mar 11, 2007 at 01:32:23PM -0700, Matt Zimmerman wrote:
> Playback seems to be mostly working.  I can play short sounds to the headset
> using aplay.  I tried playing a song (resampled to 8kHz mono) as a test, but
> it cuts out periodically, approximately once per second.  I hear about 0.25
> seconds of audio followed by 0.75 seconds of silence, etc.  I'm not sure
> whether this is due to aplay or a problem with the bluetooth setup; is this
> expected to work?

I found an example which used aplay -B 1000000, and that fixes the
stuttering.  Still no luck yet on recording.

-- 
 - mdz

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
