Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <45ABCBF4.3030003@xmission.com>
Date: Mon, 15 Jan 2007 11:46:12 -0700
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
References: <45ABC674.6000402@xmission.com> <1168886146.31200.12.camel@violet>
In-Reply-To: <1168886146.31200.12.camel@violet>
Subject: Re: [Bluez-devel] no-install clients in sbc project
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

Marcel

> that is totally wrong. Tell me what you are trying to achieve and I tell
> you the autoconf/automake trick.

I thought so.

I want to put sbcenc and sbcdec into the sbc module (I don't care where)
so 'make' will rebuild them against libsbc.a whenever I've changed a
part of the codec. I use these two over and over when working on the codec.

The idea is sbcenc/dec will never be installed anywhere.

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
