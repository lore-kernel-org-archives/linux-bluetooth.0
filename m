Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <45D873BC.2050305@yahoo.com.au>
Date: Sun, 18 Feb 2007 16:41:48 +0100
From: bluez.mexon@spamgourmet.com
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
References: <45D7173C.6090108@yahoo.com.au>
	<CE5216C10C83944D9FD37B65CD33F3970CF472@mplex01.mpl.access-company.com>
In-Reply-To: <CE5216C10C83944D9FD37B65CD33F3970CF472@mplex01.mpl.access-company.com>
Subject: Re: [Bluez-devel] bluetooth-alsa: ALSA doesn't recognise a2dpd?
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Frederic Dalleau - Frederic.Dalleau@access-company.com wrote:
>> But in XMMS I don't get an "a2dpd" option for ALSA output.
> =

> Hi, just type it manually a2dpd.
> Maybe the doc could be less ambigous!
> Fr=E9d=E9ric

This doesn't work for me either.  I typed "a2dpd" and selected software
mixer.  When I press play, the frequency band thing shows a solid
horizontal black line, so it looks like it's just unable to write any
data out.

So I tried running XMMS off the command line, and it prints this at startup:

Message: device: a2dpd

** WARNING **: alsa_setup_mixer(): Failed to find mixer element: PCM

When I press play, it doesn't print anything more.

I would have expected that if a2dpd had properly registered itself with
ALSA, it would be available as an auto-detected audio device, wouldn't it?

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=3Djoin.php&p=3Dsourceforge&CID=3DDE=
VDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
