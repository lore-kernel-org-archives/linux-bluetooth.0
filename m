Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <457C2D10.5040801@free.fr>
Date: Sun, 10 Dec 2006 16:51:44 +0100
From: Fabien Chevalier <fabchevalier@free.fr>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
References: <457655A2.6030001@xmission.com> <45772B71.5020505@vasmac.com>
	<457734F2.30204@xmission.com>
In-Reply-To: <457734F2.30204@xmission.com>
Subject: Re: [Bluez-devel] org.bluez.Audio
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

Hi Brad&Jose,

> 
>> I think that bt.audiod should only handle the audio control portion.
>> The audio plugins should do direct bluetooth I/O.
> 
> I'll update the page then. I won't rule out having bt.audiod manage a 
> file descriptor for the sco channel and pass it around like Fabien did 
> in his daemon. Only one app could use the sco channel at a time.

Brad, i think the 'only on sco channel at a time argument' is not very
pertinent, for two reasons:
  * First, i'm not sure there is an added value to be able to mix sound
channels to a sco headset.
  * Second, if we think this is really needed, ALSA provides all
required facilities to mix multiple streams to one (think to the dmix
plugin). For your information, dmix is now on by default since alsa
1.0.10 if i remember. Previously most cheap computers were only able to
play one PCM stream at a time. While annoying,  that didn't kill anybody
tought ;-)

> 
> In the case of a2dp where we're already dealing with long latencies, I 
> would like to have bt.audiod mix, encode, and deliver the audio. The 
> challenge there is to keep the latency consistent so a video player 
> could accommodate it.
> 
> Brad
> 




-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
