Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <33044.128.187.171.223.1091836937.squirrel@mail.cs.byu.edu>
From: wang@cs.byu.edu
To: bluez-devel@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Subject: [Bluez-devel] sdp_proto_desc_t problem
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
Date: Fri, 6 Aug 2004 18:02:17 -0600 (MDT)

I am a newbie to linux bluetooth programming.
My system is fedora2, kernel 2.6.5-1.358.
I was trying to compile a project developed by our lab, and got the
following error message:

error: type specifier omitted for parameter `sdp_proto_desc_t'

It seems that some header file was not included so the compiler could not
recognize sdp_proto_desc_t. However, bluetooth.h has been included. I
tried to find the definition of sdp_proto_desc_t in bluetooth.h, sdp.h and
sdp_lib.h, but all failed.

Can you tell me in which file sdp_proto_desc_t is defined? Or the possible
reason for this error.

Thanks


-------------------------------------------------------
This SF.Net email is sponsored by OSTG. Have you noticed the changes on
Linux.com, ITManagersJournal and NewsForge in the past few weeks? Now,
one more big change to announce. We are now OSTG- Open Source Technology
Group. Come see the changes on the new OSTG site. www.ostg.com
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
