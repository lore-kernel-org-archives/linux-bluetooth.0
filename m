Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <4489AF5B.7060303@xmission.com>
Date: Fri, 09 Jun 2006 11:26:51 -0600
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
References: <4489AB13.3020501@dgreaves.com> <4489AC19.3030200@free.fr>
In-Reply-To: <4489AC19.3030200@free.fr>
Subject: Re: [Bluez-devel] 2 instances of btsco on one dongle...
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

> I don't know if btsco can handle more than one headset, however what is 
> sure is that the hci USB driver cannot (as SCO support is not complete...)
> Having what you want to work might require quite a lot of work actually :-(

starting with the plugin-alsa-sco would be less work than modifying
btsco and its kernel mod. then we only have to deal with the sco part.
but then maybe that's what you were thinking of when you say it's a lot
of work.

brad


_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
