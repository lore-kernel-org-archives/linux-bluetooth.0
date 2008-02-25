Return-Path: <cyrus@holtmann.org>
Message-ID: <d89ddf300802242243t9503c11ye3d5d2bc7ae1cebb@mail.gmail.com>
Date: Sun, 24 Feb 2008 23:43:22 -0700
From: "Brad Midgley" <bmidgley@gmail.com>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
In-Reply-To: <47666E1F.2000902@mizi.com>
MIME-Version: 1.0
References: <47666E1F.2000902@mizi.com>
Subject: Re: [Bluez-devel] forcing SCO connection patch
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

Louis

>  When I tried to connect SCO channel with
>  HCI_OP_SETUP_SYNC_CONN(LINK_TYPE_ESCO), some bluetooth headsets responds
>  with LINK_TYPE_SCO because it did not support ESCO. But bluez couldn't
>  handle this situation, and patch_hci_event.c is for this.

Marcel looked at this patch and came back with the comments below. Can
you revisit it? I think some other people are seeing the same issues.
The patch won't go upstream until Marcel likes it.

the patch you sent me is fully broken. First of all the coding style
is wrong. Does nobody have learned this by now? I always look for that
first before even reading the patch. Second the case where an
ESCO_LINK returns NULL is broken and will fall over and crash.

-- 
Brad

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
