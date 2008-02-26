Return-Path: <cyrus@holtmann.org>
Message-ID: <20080226181808.5vmymkfjgsgogcks@wmlab.csie.ncu.edu.tw>
Date: Tue, 26 Feb 2008 18:18:08 +0800
From: Ming-I Hsieh <mihs@wmlab.csie.ncu.edu.tw>
To: bluez-devel <bluez-devel@lists.sourceforge.net>
References: <307246.71328.qm@web8401.mail.in.yahoo.com>
In-Reply-To: <307246.71328.qm@web8401.mail.in.yahoo.com>
MIME-Version: 1.0
Subject: Re: [Bluez-devel] error whjile cross compiling Bluez-utils
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

> sdp-xml.c:36:27: bluetooth/sdp.h: No such file or directory
> sdp-xml.c:37:31: bluetooth/sdp_lib.h: No such file or directory
check your include directories. gcc could not find

bluetooth/sdp.h and
bluetooth/sdp_lib.h

in your include directories.

> In file included from sdp-xml.c:41:
> sdp-xml.h:33: error: parse error before '*' token
> sdp-xml.h:34: error: parse error before ')' token
> sdp-xml.h:36: warning: type defaults to `int' in declaration of   
> `sdp_xml_parse_nil'
> sdp-xml.h:36: warning: data definition has no type or storage class
>


----------------------------------------------------------------
This message was sent using IMP, the Internet Messaging Program.



-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
