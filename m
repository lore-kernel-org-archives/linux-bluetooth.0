Return-Path: <bluez-devel-admin@lists.sourceforge.net>
To: bluez-devel@lists.sourceforge.net
From: Julien Campana <juliencampana@yahoo.fr>
Message-ID: <loom.20040324T174933-510@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Subject: [Bluez-devel] Direct use of the function =?utf-8?b?c2RwX3NlbmRfcmVxX3c0X3JzcA==?=
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
Date: Wed, 24 Mar 2004 17:02:26 +0000 (UTC)

Hi everybody,

I've already sent this message
to bluez-devel@lists.sourceforge.net but I do not
know if the lists are the same. So, sorry if it commes twice:)

I'm trying to extend JBlueZ, which links BlueZ and java, 
in order to
make it JSR82 compatible (Java Bluetooth Spetification). 

BlueZ uses sdp_record_t structures to store the 
list of all service attributes 
and I'm trying to modify it in order 
to get some Java Objects (with JNI) instead. 

To do this, I want to re-implement 
the "sdp_service_search_attr_req" function. 

But the project do not compile because some 
sdp fucntions cannot not be linked. 

I'm getting the following error message:
/tmp/ccvRmUPO.o(.text+0x158e): In
function`my_sdp_service_search_attr_req(sdp_session_t*, _sdp_list
const*, sdp_attrreq_type_t, _sdp_list const*, _sdp_list**): 
undefined reference
to `sdp_send_req_w4_rsp(sdp_session_t*, char*,char*, int, int*)

The function my_sdp_service_search_attr_req has EXACTLY 
the same implementation
as the official function 
sdp_service_search_attr_req. (I aim to change it but I
first want to understand how it works).

I use the following gcc command (java headers for JNI
+/home/julien/bluez/include 
to get the "sdp_internal.h" header):

gcc -I /home/java/include -I /home/java/include/linux
-I/home/julien/bluez/include 
BlueZ.cpp -o ../bin/jbluez -lsdp-lbluetooth -lstdc++ 

The undefined function can be found into 
the installed bluetooth library:
nm --dynamic /usr/lib/libsdp.so.2 | grep sdp_send
00002080 T sdp_send_req
000021c0 T sdp_send_req_w4_rsp

I use debian (Knoppix 3.1 with kernel 2.4.20: I know its an old one),
libsdp
1-5-2, libbluetooth 2-5-1, gcc 3.3 (Debian).

I've tried to compile the project on three different 
machines (2 Knoppix with
different kernels and a Suse) and the problem remains.

The same problem occurs with following sdp functions:
sdp_extract_seqtype,
sdp_extract_pdu, 
sdp_gen_pdu.

Does anybody have an idea?

Thank you for your help.

Julien Campana



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
