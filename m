Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <57c68ddc0701220133y791c725ekdad31a6818f3c22f@mail.gmail.com>
Date: Mon, 22 Jan 2007 15:03:09 +0530
From: "siddhant tewari" <siddhant.tewari@gmail.com>
To: "BlueZ users" <bluez-users@lists.sourceforge.net>
In-Reply-To: <loom.20070120T002212-956@post.gmane.org>
MIME-Version: 1.0
References: <loom.20070119T000915-349@post.gmane.org>
	<57c68ddc0701182021h7b9ed313t5cdf667250aa66da@mail.gmail.com>
	<loom.20070120T002212-956@post.gmane.org>
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
Content-Type: multipart/mixed; boundary="===============0423070918=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============0423070918==
Content-Type: multipart/alternative;
	boundary="----=_Part_24919_3793137.1169458389730"

------=_Part_24919_3793137.1169458389730
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

sdp.h file should be there if bluez libs were installed .... check for
sdp.hin /usr/local/include/bluetooth or /usr/include/bluetooh and
verify wether
right path is passed to the compiler at the time of doing the build ...

On 1/20/07, Andres <ortiz_a@telefonica.net> wrote:
>
> Thank you for reply.
>
>
> sdp-xml.c:36:27: bluetooth/sdp.h: No such file or directory
> sdp-xml.c:37:31: bluetooth/sdp_lib.h: No such file or directory
> In file included from sdp-xml.c:41:
> sdp-xml.h:28:27: bluetooth/sdp.h: No such file or directory
> In file included from sdp-xml.c:41:
> sdp-xml.h:33: error: parse error before '*' token
> sdp-xml.h:34: error: parse error before ')' token
> sdp-xml.h:36: warning: type defaults to `int'
> in declaration of `sdp_xml_parse_nil'
> sdp-xml.h:36: warning: data definition has no
> type or storage class
> sdp-xml.h:37: error: parse error before '*' token
> sdp-xml.h:37: warning: type defaults to `int' in
> declaration of `sdp_xml_parse_text'
> sdp-xml.h:37: warning: data definition has no
> type or storage class
> sdp-xml.h:38: error: parse error before '*' token
> sdp-xml.h:38: warning: type defaults to `int'
> in declaration of `sdp_xml_parse_url'
> sdp-xml.h:38: warning: data definition has no
> type or storage class
> sdp-xml.h:39: error: parse error before '*' token
> sdp-xml.h:39: error: parse error before "uint8_t"
> sdp-xml.h:39: warning: type defaults to `int' in
> declaration of `sdp_xml_parse_int'
> sdp-xml.h:39: warning: data definition has no
> type or storage class
> sdp-xml.h:40: error: parse error before '*' token
> sdp-xml.h:40: warning: type defaults to `int'
> in declaration of `sdp_xml_parse_uuid'
> sdp-xml.h:40: warning: data definition has no
> type or storage class
> sdp-xml.h:42: error: parse error before '*' token
> sdp-xml.h:42: warning: type defaults to `int' in
> declaration of
> `sdp_xml_parse_record'
> sdp-xml.h:42: warning: data definition has no
> type or storage class
> sdp-xml.c:46: error: parse error before '*' token
> sdp-xml.c:47: error: parse error before ')' token
> sdp-xml.c:54: error: parse error before "if"
> sdp-xml.c:62: error: `i' undeclared here
> (not in a function)
> sdp-xml.c:62: warning: type defaults to `int'
> in declaration of `next_indent'
> sdp-xml.c:62: error: conflicting types
> for `next_indent'
> sdp-xml.c:52: error: previous declaration
> of `next_indent'
> sdp-xml.c:62: warning: data definition has
> no type or storage class
> sdp-xml.c:63: error: parse error before '}' token
> make[2]: *** [sdp-xml.o] Interrupt
> make[1]: *** [all-recursive] Interrupt
> make: *** [all] Interrupt
>
>
>
>
> Thank you.
>
>
>
> -------------------------------------------------------------------------
> Take Surveys. Earn Cash. Influence the Future of IT
> Join SourceForge.net's Techsay panel and you'll get the chance to share
> your
> opinions on IT & business topics through brief surveys - and earn cash
> http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users
>

------=_Part_24919_3793137.1169458389730
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

sdp.h file should be there if bluez libs were installed .... check for sdp.h in /usr/local/include/bluetooth or /usr/include/bluetooh and verify wether right path is passed to the compiler at the time of doing the build ... 
<br><br><div><span class="gmail_quote">On 1/20/07, <b class="gmail_sendername">Andres</b> &lt;<a href="mailto:ortiz_a@telefonica.net">ortiz_a@telefonica.net</a>&gt; wrote:</span><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
Thank you for reply.<br><br><br>sdp-xml.c:36:27: bluetooth/sdp.h: No such file or directory<br>sdp-xml.c:37:31: bluetooth/sdp_lib.h: No such file or directory<br>In file included from sdp-xml.c:41:<br>sdp-xml.h:28:27: bluetooth/sdp.h: No such file or directory
<br>In file included from sdp-xml.c:41:<br>sdp-xml.h:33: error: parse error before &#39;*&#39; token<br>sdp-xml.h:34: error: parse error before &#39;)&#39; token<br>sdp-xml.h:36: warning: type defaults to `int&#39;<br>in declaration of `sdp_xml_parse_nil&#39;
<br>sdp-xml.h:36: warning: data definition has no<br>type or storage class<br>sdp-xml.h:37: error: parse error before &#39;*&#39; token<br>sdp-xml.h:37: warning: type defaults to `int&#39; in<br>declaration of `sdp_xml_parse_text&#39;
<br>sdp-xml.h:37: warning: data definition has no<br>type or storage class<br>sdp-xml.h:38: error: parse error before &#39;*&#39; token<br>sdp-xml.h:38: warning: type defaults to `int&#39;<br>in declaration of `sdp_xml_parse_url&#39;
<br>sdp-xml.h:38: warning: data definition has no<br>type or storage class<br>sdp-xml.h:39: error: parse error before &#39;*&#39; token<br>sdp-xml.h:39: error: parse error before &quot;uint8_t&quot;<br>sdp-xml.h:39: warning: type defaults to `int&#39; in
<br>declaration of `sdp_xml_parse_int&#39;<br>sdp-xml.h:39: warning: data definition has no<br>type or storage class<br>sdp-xml.h:40: error: parse error before &#39;*&#39; token<br>sdp-xml.h:40: warning: type defaults to `int&#39;
<br>in declaration of `sdp_xml_parse_uuid&#39;<br>sdp-xml.h:40: warning: data definition has no<br>type or storage class<br>sdp-xml.h:42: error: parse error before &#39;*&#39; token<br>sdp-xml.h:42: warning: type defaults to `int&#39; in
<br>declaration of<br>`sdp_xml_parse_record&#39;<br>sdp-xml.h:42: warning: data definition has no<br>type or storage class<br>sdp-xml.c:46: error: parse error before &#39;*&#39; token<br>sdp-xml.c:47: error: parse error before &#39;)&#39; token
<br>sdp-xml.c:54: error: parse error before &quot;if&quot;<br>sdp-xml.c:62: error: `i&#39; undeclared here<br>(not in a function)<br>sdp-xml.c:62: warning: type defaults to `int&#39;<br>in declaration of `next_indent&#39;
<br>sdp-xml.c:62: error: conflicting types<br>for `next_indent&#39;<br>sdp-xml.c:52: error: previous declaration<br>of `next_indent&#39;<br>sdp-xml.c:62: warning: data definition has<br>no type or storage class<br>sdp-xml.c
:63: error: parse error before &#39;}&#39; token<br>make[2]: *** [sdp-xml.o] Interrupt<br>make[1]: *** [all-recursive] Interrupt<br>make: *** [all] Interrupt<br><br><br><br><br>Thank you.<br><br><br><br>-------------------------------------------------------------------------
<br>Take Surveys. Earn Cash. Influence the Future of IT<br>Join SourceForge.net&#39;s Techsay panel and you&#39;ll get the chance to share your<br>opinions on IT &amp; business topics through brief surveys - and earn cash
<br><a href="http://www.techsay.com/default.php?page=join.php&amp;p=sourceforge&amp;CID=DEVDEV">http://www.techsay.com/default.php?page=join.php&amp;p=sourceforge&amp;CID=DEVDEV</a><br>_______________________________________________
<br>Bluez-users mailing list<br><a href="mailto:Bluez-users@lists.sourceforge.net">Bluez-users@lists.sourceforge.net</a><br><a href="https://lists.sourceforge.net/lists/listinfo/bluez-users">https://lists.sourceforge.net/lists/listinfo/bluez-users
</a><br></blockquote></div><br>

------=_Part_24919_3793137.1169458389730--


--===============0423070918==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============0423070918==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============0423070918==--
