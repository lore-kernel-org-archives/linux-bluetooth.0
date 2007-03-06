Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <9da483cb0703052034o1b638df3mde7dab20730d539@mail.gmail.com>
Date: Mon, 5 Mar 2007 21:34:44 -0700
From: "Mike Hodson" <mystica@gmail.com>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
In-Reply-To: <45D2C8B3.8050102@xmission.com>
MIME-Version: 1.0
References: <9da483cb0702121756l3541cc58u690e518940035b11@mail.gmail.com>
	<45D138AF.3040708@xmission.com>
	<9da483cb0702130106s3c76315g2c57fd4f1017ad23@mail.gmail.com>
	<45D2C8B3.8050102@xmission.com>
Subject: Re: [Bluez-devel] Successes and failures with btsco/bluez
	respectively
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

On 2/14/07, Brad Midgley <bmidgley@xmission.com> wrote:
> Mike
>
> fwiw, it may be that something somewhere has regressed. I can't get
> totally smooth audio through btsco-0.5 or cvs plugz (a2dpd or a2dpd2).
> It doesn't have to be in our driver, especially since my previously
> working btsco-0.5 plugin doesn't work right. It could be in the kernel
> or bluez or my config. I haven't held things constant with a control
> configuration unfortunately :(
>
> My best result is in using my spider set, plugz from cvs, a2dpd plugin,
> totem and a .asoundrc with
>
> pcm.!default {
> type a2dpd
> }
>
> but I'm still getting occasional pauses in the stream. totem using
> a2dpd2 resulted in audio playing too fast with gaps of silence.
>
> Brad


Well, I finally had time/money to get a better bluetooth dongle, a
bluespoon (CSR) 2.0/EDR.  My old one's lack of adaptive frequency
hopping limited my range quite a lot compared to what i was able to
get with my BT 1.2 phone. The new dongle improves that immensely.
Also: current plugz cvs works perfectly well, no skipping/weird audio
pitch/dropouts when using mplayer to play back mp3 files. I am still
getting no sound when using a2dpd as a plugin for xmms.

One thing of note, I am no longer able to run a2dpd as a user, and im
wondering what I need to change... i know i got it working once, but
now i get:

A2DPD[21:23:25.748]: a2dp_make_listen_socket: (errno=13:Permission
denied)Cannot bind socket 6 for psm 25

Other than these problems, it works fine when i run a2dpd as root.

Mike

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
