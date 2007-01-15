Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <45AB5679.8050606@palmsource.com>
Date: Mon, 15 Jan 2007 11:24:57 +0100
From: =?ISO-8859-1?Q?Fr=E9d=E9ric_DALLEAU?= <frederic.dalleau@palmsource.com>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
References: <200701150257.21542.bluez-devel@huitl.de>
In-Reply-To: <200701150257.21542.bluez-devel@huitl.de>
Subject: Re: [Bluez-devel] a2dpd: audio connection breaks every 300 seconds
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

Robert,

 > A2DPD[155.135]: a2dp_transfer_raw: Wrote -1 not 603 bytes.

The write call returned EAGAIN, so we should resend the data after a while.

 > I attached the complete logfile. It was created by a slightly =

modified version
 > of a2dpd that tries to resend the data several times (with 1/10/20 us
 > delay) - to no avail.

It should succeed if you wait long enough. Set the delay to 2000 and do =

more tries (like 1000). Unfortunately, waiting too much will lead to =

gaps in the sound when this happen.

I think the cause is elsewhere, could you send us the hcidump -V log?
Do you have another program using BlueZ? Another headset to try?
You could try a shorter bitpool (say 32) if your headset supports it to =

save some bandwith.

Fr=E9d=E9ric


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=3Djoin.php&p=3Dsourceforge&CID=3DDE=
VDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
