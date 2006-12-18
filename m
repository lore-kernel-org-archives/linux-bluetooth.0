Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <4586FF69.6010202@xmission.com>
Date: Mon, 18 Dec 2006 13:51:53 -0700
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
References: <24a5055d0612180213j56a6a7d1s832c981bb93d4a26@mail.gmail.com>
In-Reply-To: <24a5055d0612180213j56a6a7d1s832c981bb93d4a26@mail.gmail.com>
Subject: Re: [Bluez-devel] Setting of bluetooth address in asoundrc
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

Rahul

>    i would like to know whether is it possible to automatically set
> bluetooth address in .asoundrc. Is there a way to set bluetooth address
> in .asoundrc from outside. (eg. exporting a global variable). The reason
> for this is that i have two bluetooth headsets. On switching the headset
> i have to again edit the .asoundrc file. Instead if i can update the
> .asoundrc from outside, i guess i could just write a script which finds
> bluetooth address and sets it. but is this possible ??

I feel your pain. Yes, I think it would be scriptable. If it's a2dp
you're using, the daemon can re-read the config on the fly but sco stuff
will require a client restart.

The plan of course is to have a proper gui (the "audio routing gui" in
http://bluetooth-alsa.sourceforge.net/future.html fwiw). I've been
tinkering with pulseaudio to see how things might fit together.

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
