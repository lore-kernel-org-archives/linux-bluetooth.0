Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <4563521A.1010707@free.fr>
Date: Tue, 21 Nov 2006 20:23:06 +0100
From: Fabien Chevalier <fabchevalier@free.fr>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
References: <455C01C4.7090801@xmission.com>	<1163672537.5169.16.camel@localhost>	<455CBBA6.8040401@free.fr>	<455CCBD8.3080001@xmission.com>	<4560925E.3030901@free.fr>
	<4561046E.50905@xmission.com>
In-Reply-To: <4561046E.50905@xmission.com>
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

Hi Brad,

>>> I didn't want the timeout to default to be on since it's only useful in 
>>> the case when audio goes over hci.
>> Looks like you lost me there :-(, i didn't understand your last sentence
> 

> we may have to modify this timeout plan. What I wanted was for the
> daemon to see when audio transmission was idle and have it put the state
> into "stopped" and close the sco or a2dp audio connection. The plugin
> would be notified via dbus that this had happened.

Ok, i understand this time :-)
However i'm surprised you thought of this can where an application would 
just stop sending data, as it's not possible to happen.
ALSA applications are expected to call snd_pcm_pause() if they want to 
stop sending data without closing the stream. In practive this is rarely 
used, as not all hardware support this feature.
If they don't call snd_pcm_pause(), an underrun will occur, which must 
be handle as an error later (i.e. hardware is then in an inconsistent 
state).

Could you provide details on why you think this was needed ?

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
