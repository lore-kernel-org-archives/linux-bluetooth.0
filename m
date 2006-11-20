Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <4561046E.50905@xmission.com>
Date: Sun, 19 Nov 2006 18:27:10 -0700
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
References: <455C01C4.7090801@xmission.com>	<1163672537.5169.16.camel@localhost>	<455CBBA6.8040401@free.fr>	<455CCBD8.3080001@xmission.com>
	<4560925E.3030901@free.fr>
In-Reply-To: <4560925E.3030901@free.fr>
Subject: Re: [Bluez-devel] audio & dbus
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

Fabien

>>>>> 		int32 GetIdleDisconnect(string identifier, string profile)
>>> Brad : How are we supposed to handle the case when an application 
>>> crashes while sending audio data ? Will he have to keep the audio 
>>> channel opened forever ?
>> if the disconnect timout is set then after the timeout passes the sco 
>> connection will be closed.
>>
>> I didn't want the timeout to default to be on since it's only useful in 
>> the case when audio goes over hci.
> 
> Looks like you lost me there :-(, i didn't understand your last sentence

we may have to modify this timeout plan. What I wanted was for the
daemon to see when audio transmission was idle and have it put the state
into "stopped" and close the sco or a2dp audio connection. The plugin
would be notified via dbus that this had happened.

We should work out a plan so the daemon knows when an app is actively
sending audio even if the daemon is not processing that audio directly.

> Brad, could you provide some details on that ?
> If i read your schematic correctly, there is a GUI that allows user to 
> choose  between PCM and headset routing.
> If this is what it is supposed to do, then it is possible to do it at 
> ALSA level without having to write any code :
> 
> Users would have to add that in their ~/.asoundrc for instance
> 
> pcm.!default {
>      type dmix
>      slave.pcm "a2dpd"
> }
> 
> And this would switch their default output to be the headset.
> Of course it is possible to write a program that automates that so that 
> people don't have to dig in their configuration files.

the advantage of using dbus communicating to an alsa plugin is the
change (for example) from built-in audio to sco bluetooth audio can take
effect in the middle of a voip call without the voip app needing to know
anything special happened.

Brad

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
