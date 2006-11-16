Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <455CBE1E.8000800@free.fr>
Date: Thu, 16 Nov 2006 20:38:06 +0100
From: Fabien Chevalier <fabchevalier@free.fr>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
References: <455C01C4.7090801@xmission.com>	<1163672537.5169.16.camel@localhost>
	<455C8857.9050008@xmission.com>
In-Reply-To: <455C8857.9050008@xmission.com>
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


> 
> hmm... this is actually for interacting with the builtin speaker. Johan 
> mentioned the scenario of custom ringing both the headset and the 
> speaker simultaneously and there are other scenarios we would need to 
> interact with builtin audio (for example, to get a mic input with 
> today's a2dp headsets you would use the built-in mic)

Guys, i wouldn't like to be a pain in the ass, but i have an annoying 
question to ask ;-)

Why not keep it simple and keep a2dp for what it is designed for :
listening to high quality music ?
a2dp has never been designed for low latency, the codecs used will add 
way too much delay to be of any use for real time audioconferencing or 
videoconferencing.

It's what i've learned while talking with some phone guys : it looks 
like a2dp will never ever be used for audio calls, due to the latency 
introduced by sbc or mp3. :-(

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
