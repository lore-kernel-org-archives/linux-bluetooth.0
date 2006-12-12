Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <457F08B4.6050603@free.fr>
Date: Tue, 12 Dec 2006 20:53:24 +0100
From: Fabien Chevalier <fabchevalier@free.fr>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
References: <457655A2.6030001@xmission.com>	<45772B71.5020505@vasmac.com>	<457734F2.30204@xmission.com>	<457C2D10.5040801@free.fr>
	<457EDCBB.8080207@xmission.com>
In-Reply-To: <457EDCBB.8080207@xmission.com>
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

Hi Brad,

>> Brad, i think the 'only on sco channel at a time argument' is not very
>> pertinent, for two reasons:
>>   * First, i'm not sure there is an added value to be able to mix sound
>> channels to a sco headset.
>>   * Second, if we think this is really needed, ALSA provides all
>> required facilities to mix multiple streams to one (think to the dmix
>> plugin). For your information, dmix is now on by default since alsa
>> 1.0.10 if i remember. Previously most cheap computers were only able to
>> play one PCM stream at a time. While annoying,  that didn't kill anybody
>> tought ;-)
> 
> maybe the documentation could use some improvement, but I'm in agreement
> with you. We should give the plugin its own file descriptor for the sco
> link.
> 
hmmm... i must have smoked the carpet again :-(
So it looks that we agree, everything's fine. ;-)

But what about A2DP ? Wouldn't it make sense to use ALSA mixing facility 
too ?

Cheers,

Fabien

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
