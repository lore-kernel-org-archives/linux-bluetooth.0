Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <455CB9D9.4050002@xmission.com>
Date: Thu, 16 Nov 2006 12:19:53 -0700
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
References: <455C01C4.7090801@xmission.com>	<1163672537.5169.16.camel@localhost>
	<455C8857.9050008@xmission.com>
	<1163692996.5169.67.camel@localhost>
In-Reply-To: <1163692996.5169.67.camel@localhost>
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

Marcel

>>hmm... this is actually for interacting with the builtin speaker. Johan 
>>mentioned the scenario of custom ringing both the headset and the 
>>speaker simultaneously and there are other scenarios we would need to 
>>interact with builtin audio (for example, to get a mic input with 
>>today's a2dp headsets you would use the built-in mic)
> 
> This will be up to ALSA or GStreamer. It is not the job of the audio
> daemon to handle non-Bluetooth stuff.

I'm in agreement that bt.audiod does not do any built-in audio i/o, but
can it just keep track of when builtin audio is needed? I figure the
alsa or gst plugin will use dbus to get this state from bt.audiod and
act on it.

I tried to think of a way to not involve bt.audiod at all and I'm not
coming up with another approach.

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
