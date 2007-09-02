Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <9346e8090709020805j53dbcc8blba0f42eeecb2c6c6@mail.gmail.com>
Date: Sun, 2 Sep 2007 20:35:46 +0530
From: "Richeek Arya" <richeek.arya@gmail.com>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <9346e8090709020731k60893fe5xaf27e01a8c292761@mail.gmail.com>
MIME-Version: 1.0
References: <9346e8090709020731k60893fe5xaf27e01a8c292761@mail.gmail.com>
Subject: [Bluez-devel] bluez-utils-3.17 installation problem
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0911101526=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

--===============0911101526==
Content-Type: multipart/alternative;
	boundary="----=_Part_11860_33233757.1188745546126"

------=_Part_11860_33233757.1188745546126
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

hi
i have downloaded the bluetooth module from www.bluez.org site(5 modules all
are latest as of now).
When i am installing bluez-utils-3.17 i am getting this error :-

[root@localhost bluez-utils-3.17]# make
make  all-recursive
make[1]: Entering directory `/home/richeek/Desktop/bluez-utils-3.17'
Making all in sbc
make[2]: Entering directory `/home/richeek/Desktop/bluez-utils-3.17 /sbc'
make[2]: Nothing to be done for `all'.
make[2]: Leaving directory `/home/richeek/Desktop/bluez-utils-3.17/sbc'
Making all in eglib
make[2]: Entering directory `/home/richeek/Desktop/bluez-utils-3.17 /eglib'
make[2]: Nothing to be done for `all'.
make[2]: Leaving directory `/home/richeek/Desktop/bluez-utils-3.17/eglib'
Making all in common
make[2]: Entering directory `/home/richeek/Desktop/bluez- utils-3.17/common'
make[2]: Nothing to be done for `all'.
make[2]: Leaving directory `/home/richeek/Desktop/bluez-utils-3.17/common'
Making all in sdpd
make[2]: Entering directory `/home/richeek/Desktop/bluez- utils-3.17/sdpd'
gcc -DHAVE_CONFIG_H -I. -I.. -I../common   -I../eglib -Wall -O2
-D_FORTIFY_SOURCE=2 -MT service.o -MD -MP -MF .deps/service.Tpo -c -o
service.o service.c
service.c: In function 'update_svclass_list':
service.c:83: error: 'sdp_record_t' has no member named 'svclass'
service.c:86: error: 'sdp_record_t' has no member named 'svclass'
service.c: In function 'create_ext_inquiry_response':
service.c:170: error: 'sdp_record_t' has no member named 'svclass'
service.c:173: error: 'sdp_record_t' has no member named 'svclass'
service.c:182: error: 'sdp_record_t' has no member named 'svclass'
service.c:188: error: 'sdp_record_t' has no member named 'svclass'
make[2]: *** [ service.o] Error 1
make[2]: Leaving directory `/home/richeek/Desktop/bluez-utils-3.17/sdpd'
make[1]: *** [all-recursive] Error 1
make[1]: Leaving directory `/home/richeek/Desktop/bluez-utils-3.17'
make: *** [all] Error 2

My gcc version is 4.1.1. How to solve this problem??
With due regards..
-- 
richeek arya
GHEB-143
iiit hyderabad

-- 
richeek arya
GHEB-148
iiit hyderabad

------=_Part_11860_33233757.1188745546126
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<span class="gmail_quote"></span>hi<br>i have downloaded the bluetooth module from <a href="http://www.bluez.org" target="_blank" onclick="return top.js.OpenExtLink(window,event,this)">www.bluez.org</a> site(5 modules all are latest as of now).
<br>When i am installing bluez-utils-3.17 i am getting this error :-<br><br clear="all">
[root@localhost bluez-utils-3.17]# make<br>make&nbsp; all-recursive<br>make[1]: Entering directory `/home/richeek/Desktop/bluez-utils-3.17&#39;<br>Making all in sbc<br>make[2]: Entering directory `/home/richeek/Desktop/bluez-
utils-3.17
/sbc&#39;<br>make[2]: Nothing to be done for `all&#39;.<br>make[2]: Leaving directory `/home/richeek/Desktop/bluez-utils-3.17/sbc&#39;<br>Making all in eglib<br>make[2]: Entering directory `/home/richeek/Desktop/bluez-utils-3.17

/eglib&#39;<br>make[2]: Nothing to be done for `all&#39;.<br>make[2]: Leaving directory `/home/richeek/Desktop/bluez-utils-3.17/eglib&#39;<br>Making all in common<br>make[2]: Entering directory `/home/richeek/Desktop/bluez-
utils-3.17/common&#39;<br>make[2]: Nothing to be done for `all&#39;.<br>make[2]: Leaving directory `/home/richeek/Desktop/bluez-utils-3.17/common&#39;<br>Making all in sdpd<br>make[2]: Entering directory `/home/richeek/Desktop/bluez-
utils-3.17/sdpd&#39;<br>gcc -DHAVE_CONFIG_H -I. -I.. -I../common&nbsp;&nbsp; -I../eglib -Wall -O2 -D_FORTIFY_SOURCE=2 -MT service.o -MD -MP -MF .deps/service.Tpo -c -o service.o service.c<br>service.c: In function &#39;update_svclass_list&#39;:
<br>service.c:83: error: &#39;sdp_record_t&#39; has no member named &#39;svclass&#39;<br>service.c:86: error: &#39;sdp_record_t&#39; has no member named &#39;svclass&#39;<br>service.c: In function &#39;create_ext_inquiry_response&#39;:
<br>service.c:170: error: &#39;sdp_record_t&#39; has no member named &#39;svclass&#39;
<br>service.c:173: error: &#39;sdp_record_t&#39; has no member named &#39;svclass&#39;<br>service.c:182: error: &#39;sdp_record_t&#39; has no member named &#39;svclass&#39;<br>service.c:188: error: &#39;sdp_record_t&#39; has no member named &#39;svclass&#39;
<br>make[2]: *** [
service.o] Error 1<br>make[2]: Leaving directory `/home/richeek/Desktop/bluez-utils-3.17/sdpd&#39;<br>make[1]: *** [all-recursive] Error 1<br>make[1]: Leaving directory `/home/richeek/Desktop/bluez-utils-3.17&#39;<br>make: *** [all] Error 2
<br><br>My gcc version is 4.1.1. How to solve this problem??<br>With due regards..<br><span class="sg">-- <br>richeek arya<br>GHEB-143<br>iiit hyderabad
</span><br clear="all"><br>-- <br>richeek arya<br>GHEB-148<br>iiit hyderabad

------=_Part_11860_33233757.1188745546126--


--===============0911101526==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
--===============0911101526==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============0911101526==--
