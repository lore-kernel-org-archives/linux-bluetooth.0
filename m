Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <45ADA7D3.3030404@xmission.com>
Date: Tue, 16 Jan 2007 21:36:35 -0700
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
References: <D8CE9CFA707C894180BAC8CDD154F8460AE3EC0D@msiexch01.marvell.com>
In-Reply-To: <D8CE9CFA707C894180BAC8CDD154F8460AE3EC0D@msiexch01.marvell.com>
Subject: Re: [Bluez-devel] a2play
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="windows-1252"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Quinton

> I am trying out the a2play in head version btsco package, basically it
> works great except that seems it=92s very sensitive to system event, if I
> leave the my notebook there playing without doing anything, I can listen
> hours music without any problem, however, if I try to something on the
> same pc, like edit some file or browse the internet, audio will be
> stopped,  message like
> =

>             Read 3321c0 1080 times / sec

fwiw, I found a2play timing is very sensitive to the use of X using the
closed-source nvidia driver. They must be doing something wacky like
masking interrupts for long periods.

the "real" driver using a2dpd is better at timing. I just applied Steve
Romanow's suggestion for the d-bus compile problem in case that helps.

Brad

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
