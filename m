Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Suggestion for ANSI compliance for sdp.h
From: Marcel Holtmann <marcel@holtmann.org>
To: "Georg v. Zezschwitz" <gvz@work.de>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <20040329230518.GD25439@smile.2scale.net>
References: <20040329230518.GD25439@smile.2scale.net>
Content-Type: text/plain
Message-Id: <1080625864.4094.0.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Tue, 30 Mar 2004 07:51:05 +0200

Hi Georg,

> I just discovered why I was not able to compile OBEX
> support for kdebluetooth sucessfully.
> 
> The reason is that the configure-checks are done
> with the compile-option "-ansi".
> 
> This fails for "sdp.h" at line 395, as the
> C++-notation "// comment" is used here.
> 
> There is just one occurrence of this comment-style
> in sdp.h (and 9 others in other include libraries).
> 
> Would you mind to change these to ANSI style?

why don't you send a patch?

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
