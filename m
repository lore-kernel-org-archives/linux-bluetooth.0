Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <455CCBD8.3080001@xmission.com>
Date: Thu, 16 Nov 2006 13:36:40 -0700
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
References: <455C01C4.7090801@xmission.com>	<1163672537.5169.16.camel@localhost>
	<455CBBA6.8040401@free.fr>
In-Reply-To: <455CBBA6.8040401@free.fr>
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

>>> 		int32 GetIdleDisconnect(string identifier, string profile)
> 
> Brad : How are we supposed to handle the case when an application 
> crashes while sending audio data ? Will he have to keep the audio 
> channel opened forever ?

if the disconnect timout is set then after the timeout passes the sco 
connection will be closed.

I didn't want the timeout to default to be on since it's only useful in 
the case when audio goes over hci.

> Marcel, could you provide details on all this PCM routing stuff ?
> ALSA already has support for routing aufio through the use of audio plugins.
> Maybe it's a bit redundant ?

I was the one who brought up routing. I want the daemon to store enough 
state so the alsa plugin can figure out where audio goes.

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
