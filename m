Return-Path: <cyrus@holtmann.org>
Message-ID: <5b432a9b0804170634k5ab9ca56ka6a0a7895462b8fd@mail.gmail.com>
Date: Thu, 17 Apr 2008 21:34:16 +0800
From: hengxing <xhx321@gmail.com>
To: bluez-devel@lists.sourceforge.net
MIME-Version: 1.0
Subject: [Bluez-devel] What's wrong with the l2ping during the
	cross-compling!
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1258617960=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

--===============1258617960==
Content-Type: multipart/alternative;
	boundary="----=_Part_208_23411331.1208439256835"

------=_Part_208_23411331.1208439256835
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Dears:
I meet such question which delayed my schedule for several days.
The issue is that : I compiled the blueZ-2.20 in X86 platform, and execute
the command like "l2ping xx:xx:xx:xx", it can worked well.
but after compiled it with mipsel-compiler,and run the same command in
mipsel platform, the shell tips "Connection failed: invalid arguments". And
in the mipsel platform, the "hcitool scan" could work well already.but
'l2ping' & 'sdptool browse' can work which both tips "invalid argument". And
I have execute the hcidump in mipsel, which show only two lines. One is the
outgoing command data , the other is feedback events data. Compared it with
the result that hcidump in X86, the first outgoning command data is same.
But, the feedback data which has four bytes, the first byte is different
which seems like statue code, the other three bytes is same.
Almost forget that: In x86 the linux kernel version is 2.6.10, while in
mipsel kernel version is 2.4.21(I've done the newest patch).
If anybody met the same thing or knew what the reason, please give me some
help!

------=_Part_208_23411331.1208439256835
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<div>Dears:</div>
<div>I meet such question which delayed my schedule for several days.</div>
<div>The issue is that : I compiled the blueZ-2.20 in X86 platform, and execute the command like &quot;l2ping xx:xx:xx:xx&quot;, it can worked well.</div>
<div>but after compiled it with mipsel-compiler,and run the same command&nbsp;in mipsel platform, the shell tips &quot;Connection failed: invalid arguments&quot;. And in the mipsel platform, the &quot;hcitool scan&quot; could work well already.but &#39;l2ping&#39; &amp; &#39;sdptool browse&#39; can work which both tips &quot;invalid argument&quot;. And I have execute the hcidump in mipsel, which show only two lines. One is the outgoing command data , the other is feedback events data. Compared it with the result that hcidump in X86, the first outgoning command data is same. But, the feedback data which has four bytes, the first byte is different which seems like statue code, the other three bytes is same.</div>

<div>Almost forget that: In x86 the linux kernel version is 2.6.10, while in mipsel kernel version is 2.4.21(I&#39;ve done the newest patch).</div>
<div>If anybody met the same thing or knew what the reason, please give me some help!</div>

------=_Part_208_23411331.1208439256835--


--===============1258617960==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by the 2008 JavaOne(SM) Conference 
Don't miss this year's exciting event. There's still time to save $100. 
Use priority code J8TL2D2. 
http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/javaone
--===============1258617960==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============1258617960==--
