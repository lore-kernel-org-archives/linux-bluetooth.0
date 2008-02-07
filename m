Return-Path: <cyrus@holtmann.org>
From: Bastien Nocera <hadess@hadess.net>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <cc1649d10802071025s38dbe8dbuaeff21f05e45b49f@mail.gmail.com>
References: <cc1649d10802051215j7f1d9406u6c4cda1b161c77de@mail.gmail.com>
	<1202251232.15090.147.camel@violet>
	<cc1649d10802071025s38dbe8dbuaeff21f05e45b49f@mail.gmail.com>
Date: Thu, 07 Feb 2008 18:32:22 +0000
Message-Id: <1202409142.3491.60.camel@cookie.hadess.net>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] sdp_extract_pdu *** stack smashing detected ***
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


On Thu, 2008-02-07 at 13:25 -0500, Vlad Skarzhevskyy wrote:
> Hi Marcel
>  I create a small test in C  bluez-sdp-tests.c
>  Source code there: http://snapshot.bluecove.org/bluecove-gpl/bluez/test/
> 
>  If the SDP binary size is 258  bytes still works OK.
>  But when I make it bigger call to sdp_gen_record_pdu will crash.

Works fine here, no errors from valgrind either. You might want to
upgrade your bluez-libs...

Cheers


-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
