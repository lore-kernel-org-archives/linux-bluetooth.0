Return-Path: <cyrus@holtmann.org>
Date: Tue, 29 Jan 2008 11:59:39 -0500
From: Aristeu Rozanski <aris@ruivo.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
Message-ID: <20080129165939.GT5671@cathedrallabs.org>
References: <20080129051220.GC14674@jake.ruivo.org>
	<1201624205.6218.9.camel@violet>
MIME-Version: 1.0
In-Reply-To: <1201624205.6218.9.camel@violet>
Subject: Re: [Bluez-devel] [PATCH 2/4] add connect,
	disconnect and	is_connected methods to fake_input
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

> Hi Aristeu,
> 
> > This patch adds three methods to fake_input structure, in order to
> > prepare fake_hid support addition.
> 
> looks good to me with the exception of is_connected. Why do we need
> that. Can't we track that status based on connect and disconnect method?
OK, will do it

-- 
Aristeu


-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
