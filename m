Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <6297d67c0606282023y52f26393i97ce102bde16776@mail.gmail.com>
Date: Thu, 29 Jun 2006 08:53:28 +0530
From: "Mayank Batra" <mayankbatra@gmail.com>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
In-Reply-To: <BAY116-DAV22C2B995073A52F8216D6C77F0@phx.gbl>
MIME-Version: 1.0
References: <BAY116-DAV738BD697D0EDB18FB509AC77F0@phx.gbl>
	<6297d67c0606272049g55cc14cby52254c90863e727f@mail.gmail.com>
	<BAY116-DAV22C2B995073A52F8216D6C77F0@phx.gbl>
Subject: Re: [Bluez-devel] A2DP a2play and a2recv
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1965429376=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

--===============1965429376==
Content-Type: multipart/alternative;
	boundary="----=_Part_37801_23590424.1151551408075"

------=_Part_37801_23590424.1151551408075
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Chane,

On 6/28/06, I-Chung Chane <ichane@hotmail.com> wrote:
>
>  Is CPU (ARM7 @80MHz) powerful enough  to run a2recv ?
>

On second thoughts, I think it is not fast enough. So please use fixed point
calculations in libsbc.a
In fact I tried the floating point library with a2play on my ARM9 platform
(~100MHz) yesterday. And it was probably too much for it. The CPU load was
too high.

Regards,
Mayank

------=_Part_37801_23590424.1151551408075
Content-Type: text/html; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Chane,<br><br>
<div><span class="gmail_quote">On 6/28/06, <b class="gmail_sendername">I-Chung Chane</b> &lt;<a href="mailto:ichane@hotmail.com">ichane@hotmail.com</a>&gt; wrote:</span>
<blockquote class="gmail_quote" style="PADDING-LEFT: 1ex; MARGIN: 0px 0px 0px 0.8ex; BORDER-LEFT: #ccc 1px solid">
<div>
<div bgcolor="#ffffff">
<div><font face="新細明體" size="2">Is&nbsp;CPU (ARM7 @80MHz) powerful enough &nbsp;to run a2recv ?</font></div></div></div></blockquote>
<div>&nbsp;</div>
<div>On second thoughts, I think it is not fast enough. So please use fixed point calculations in libsbc.a</div>
<div>In fact I tried the floating point library with a2play on my ARM9 platform (~100MHz)&nbsp;yesterday. And it was probably too much for it. The CPU load was too high.</div>
<div>&nbsp;</div>
<div>Regards,</div>
<div>Mayank</div></div>

------=_Part_37801_23590424.1151551408075--


--===============1965429376==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--===============1965429376==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============1965429376==--
