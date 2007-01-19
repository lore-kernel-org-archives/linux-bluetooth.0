Return-Path: <bluez-users-bounces@lists.sourceforge.net>
To: bluez-users@lists.sourceforge.net
From: Andres <ortiz_a@telefonica.net>
Date: Fri, 19 Jan 2007 23:26:12 +0000 (UTC)
Message-ID: <loom.20070120T002212-956@post.gmane.org>
References: <loom.20070119T000915-349@post.gmane.org>
	<57c68ddc0701182021h7b9ed313t5cdf667250aa66da@mail.gmail.com>
Mime-Version: 1.0
Subject: Re: [Bluez-users] problems installing bluez-utils
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Thank you for reply.


sdp-xml.c:36:27: bluetooth/sdp.h: No such file or directory
sdp-xml.c:37:31: bluetooth/sdp_lib.h: No such file or directory
In file included from sdp-xml.c:41:
sdp-xml.h:28:27: bluetooth/sdp.h: No such file or directory
In file included from sdp-xml.c:41:
sdp-xml.h:33: error: parse error before '*' token
sdp-xml.h:34: error: parse error before ')' token
sdp-xml.h:36: warning: type defaults to `int' 
in declaration of `sdp_xml_parse_nil'
sdp-xml.h:36: warning: data definition has no 
type or storage class
sdp-xml.h:37: error: parse error before '*' token
sdp-xml.h:37: warning: type defaults to `int' in 
declaration of `sdp_xml_parse_text'
sdp-xml.h:37: warning: data definition has no 
type or storage class
sdp-xml.h:38: error: parse error before '*' token
sdp-xml.h:38: warning: type defaults to `int' 
in declaration of `sdp_xml_parse_url'
sdp-xml.h:38: warning: data definition has no 
type or storage class
sdp-xml.h:39: error: parse error before '*' token
sdp-xml.h:39: error: parse error before "uint8_t"
sdp-xml.h:39: warning: type defaults to `int' in 
declaration of `sdp_xml_parse_int'
sdp-xml.h:39: warning: data definition has no 
type or storage class
sdp-xml.h:40: error: parse error before '*' token
sdp-xml.h:40: warning: type defaults to `int' 
in declaration of `sdp_xml_parse_uuid'
sdp-xml.h:40: warning: data definition has no 
type or storage class
sdp-xml.h:42: error: parse error before '*' token
sdp-xml.h:42: warning: type defaults to `int' in 
declaration of
`sdp_xml_parse_record'
sdp-xml.h:42: warning: data definition has no 
type or storage class
sdp-xml.c:46: error: parse error before '*' token
sdp-xml.c:47: error: parse error before ')' token
sdp-xml.c:54: error: parse error before "if"
sdp-xml.c:62: error: `i' undeclared here 
(not in a function)
sdp-xml.c:62: warning: type defaults to `int' 
in declaration of `next_indent'
sdp-xml.c:62: error: conflicting types 
for `next_indent'
sdp-xml.c:52: error: previous declaration 
of `next_indent'
sdp-xml.c:62: warning: data definition has 
no type or storage class
sdp-xml.c:63: error: parse error before '}' token
make[2]: *** [sdp-xml.o] Interrupt
make[1]: *** [all-recursive] Interrupt
make: *** [all] Interrupt




Thank you.



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
