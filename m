Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Date: Fri, 1 Jun 2007 21:26:06 +0200
From: Stefan Seyfried <seife@suse.de>
To: BlueZ users <bluez-users@lists.sourceforge.net>
Message-ID: <20070601192606.GC21247@suse.de>
References: <4660704B.7050703@pagestation.com>
MIME-Version: 1.0
In-Reply-To: <4660704B.7050703@pagestation.com>
Subject: Re: [Bluez-users] centos 5 hci dump
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

On Fri, Jun 01, 2007 at 03:15:23PM -0400, Jerry Geis wrote:
> I am getting the following dump on centos 5. Gigabyte AM2 motherboard.
> System boots and works for a time, then after this dump my USB mouse stop=
s working.
> =

> hcid --version reports 3.7
> =

> Should I update bluez packages? Will that help? This same computer had no
> issues under centos 4.4, mouse worked fine.

To me (not being an expert, though), this does not look bluetooth related.
 =

>  <IRQ>  [<ffffffff800b389d>] __report_bad_irq+0x30/0x7d
>  [<ffffffff800b3ad0>] note_interrupt+0x1e6/0x227
>  [<ffffffff800b3005>] __do_IRQ+0xc7/0x105
>  [<ffffffff80011c19>] __do_softirq+0x5e/0xd5
>  [<ffffffff8006a195>] do_IRQ+0xe7/0xf5
>  [<ffffffff8005b649>] ret_from_intr+0x0/0xa
>  <EOI>
> handlers:
> [<ffffffff801d213f>] (usb_hcd_irq+0x0/0x55)
-- =

Stefan Seyfried
QA / R&D Team Mobile Devices        |              "Any ideas, John?"
SUSE LINUX Products GmbH, N=FCrnberg  | "Well, surrounding them's out." =


This footer brought to you by insane German lawmakers:
SUSE Linux Products GmbH, GF: Markus Rex, HRB 16746 (AG N=FCrnberg)

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
