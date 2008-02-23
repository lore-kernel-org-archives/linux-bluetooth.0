Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: Andrew Morton <akpm@linux-foundation.org>
In-Reply-To: <20080223133603.e85b7bc2.akpm@linux-foundation.org>
References: <20080223212620.GA8227@distanz.ch>
	<20080223133603.e85b7bc2.akpm@linux-foundation.org>
Date: Sun, 24 Feb 2008 00:05:27 +0100
Message-Id: <1203807927.28528.4.camel@californication>
Mime-Version: 1.0
Cc: Tobias Klauser <tklauser@distanz.ch>,
	bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] [PATCH] bluetooth: Make bnep_sock_cleanup()
	return void
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

Hi Andrew,

> > bnep_sock_cleanup() always returns 0 and its return value isn't used
> > anywhere in the code.
> 
> Please cc netdev@vger.kernel.org on bluetooth patches.
> 
> Apparently bluez-devel is a complete spamfest, and davem has set up
> linux-bluetooth@vger.kernel.org, but we haven't done anything with it yet.
> 
> I guess we should put out an announcement and modify ./MAINTAINERS, etc. 
> ANy volunteers?

I do that.

Regards

Marcel



-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
