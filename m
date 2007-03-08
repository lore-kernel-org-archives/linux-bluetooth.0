Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <45F07155.7080201@killesreiter.de>
Date: Thu, 08 Mar 2007 21:25:57 +0100
From: Gerhard Killesreiter <gerhard@killesreiter.de>
MIME-Version: 1.0
To: BlueZ users <bluez-users@lists.sourceforge.net>
References: <45EFC3C7.2060802@redhat.com>
In-Reply-To: <45EFC3C7.2060802@redhat.com>
Subject: Re: [Bluez-users] Headsetd, skype and bluetooth headsets.
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

Alan Conway wrote:
> Trying to get a plantronics 510s headset working with skype (among other 
> things) and I'm tantalizingly close. Hopefully someone can help close 
> the gap.
> 
> I go the headset working for input and output with headsetd and headset 
> plug-in: aplay and arecord -D headset working A-OK - my .asoundrc 
> attached. Then I tried aoss skype - it *almost* worked. I could hear OK 
> thru the headset but my voice was weirdly distorted and unrecognizable. 
> I decided to recompile off the CVS head and now nothing works I get
>  ALSA lib pcm_sco.c:532:(_snd_pcm_sco_open) Unknown field max_periods
> 
> Probably I have some mish-mash of versions installed, it's too late at 
> night.
> 
> So what I'd like to know to speed my quest tomorrow:
> * In CVS there are multiple headsetd and alsa-plugins under plugz, btsco 
> and alsa-plugin-sco. Which is the right one?
> * Maybe the distortion indicates some transformation of sound formats is 
> needed - any hints as to what it might be?
> * Is there a better way than aoss for skype? It only shows alsa hardware 
> devices in it's menus, I haven't found a way to make it use a PCM.
> * Any other  tips on what might be going wrong, or better ways to 
> approach this?
> 
> I'll be happy to post my solution to the list if that's useful.

Yes, please. I had to get a cable headset in order to use skype. I could 
hear sound and record sound through the bt headset (logitech), but skype 
  would only get me a beep and nothing more.

aoss didn't work either, maybe I shoudl try it again...

Cheers,
	Gerhard

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
