Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <d89ddf300710171849p3cd9da02kb7488387e095b534@mail.gmail.com>
Date: Wed, 17 Oct 2007 19:49:57 -0600
From: "Brad Midgley" <bmidgley@gmail.com>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
In-Reply-To: <BAY117-W36EE4B29F3D4550A7C9847C09E0@phx.gbl>
MIME-Version: 1.0
References: <BAY117-W36EE4B29F3D4550A7C9847C09E0@phx.gbl>
Subject: Re: [Bluez-devel] SCO connection timed out issue
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

semiyd

> Later i found something.I checked out the website "
> http://wiki.bluez.org/wiki/Audio" and found that the
> /bluez-utils-3.20/audio/gateway.c implements the
> org.bluez.audio.gateway interface.But when i looked into the
> gateway.c, there's nothing in there.And /bluez-
> utils-3.20/audio-api.txt also says that the audio gateway service is
> not yet implemented in the current bluez. Is that true? If it is so
> ,does this means that there's no way we can enable the SCO/A2DP audio
> connection to the headset right now?

for now the files there are named backward. gateway.c would contain
code for talking to a gateway device, not for being a gateway. You can
experiment now with sco/a2dp to a headset just fine.

> I'm really confused cause i read about an
> article:http://bluetooth-alsa.sourceforge.net/build.html ,which
> teaches the reader how to enable bluez audio without mentioning
> anything about the org.bluez.audio.gateway implementation.

the bluetooth-alsa stuff is all old. that's why there's a banner
across the top of the page directing people to the new stuff.

brad

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
