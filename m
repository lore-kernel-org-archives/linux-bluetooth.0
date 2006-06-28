Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <6297d67c0606280257y1cda0a8bj5ebdec42e3b1079@mail.gmail.com>
Date: Wed, 28 Jun 2006 15:27:58 +0530
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
Content-Type: multipart/mixed; boundary="===============1697656272=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

--===============1697656272==
Content-Type: multipart/alternative;
	boundary="----=_Part_11500_27764554.1151488678176"

------=_Part_11500_27764554.1151488678176
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Chane,

On 6/28/06, I-Chung Chane <ichane@hotmail.com> wrote:
>
>       Thanks for reply. can a2play run on OSS too?
>

I am not very sure of a2play's design now.


>      I ported BlueZ on an embeded ARM7 running at 80 MHz.
> I also try a2recv on embeded board with sound chip using OSS
> driver. Printout looks ok, but can't hear anything:
>
> ---------------------------------------------------------------------
> > ./a2recv
>
> Connected [imtu 672, omtu 672, flush_to 65535]
> Connected
> Sent Stream End Point Discovery Response
>
> Sent the get capabilities responseChannels=2, speed=44100channel_mode = 2
> alloca tion_method = 2 subbands = 1 block_length = 1 min_bitpool = 2
> max_bitpool = 250
>
> Sent a Set configurations response
>
> Received an open stream command
>
> Sent open stream confirm
>
> Connected [imtu 672, omtu 672, flush_to 65535]
> ConnectedGot stream fd
>
> Sent start stream confirm
>
> ------------------------------------------------------------------------------
>
>

The above logs are OK. It means that the A2DP source is streaming to your
target device.
The only reason that you do not hear anything can be an endian problem.
Maybe the endian type in which the SBC is decoded is different from the one
that your device supports.
Don't you even hear any noise?
By the way are you using the latest version of a2recv?


  Is CPU (ARM7 @80MHz) powerful enough  to run a2recv ?
>

I think it should be powerful enough.

Regards,
Mayank

------=_Part_11500_27764554.1151488678176
Content-Type: text/html; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Chane,<br><br>
<div><span class="gmail_quote">On 6/28/06, <b class="gmail_sendername">I-Chung Chane</b> &lt;<a href="mailto:ichane@hotmail.com">ichane@hotmail.com</a>&gt; wrote:</span>
<blockquote class="gmail_quote" style="PADDING-LEFT: 1ex; MARGIN: 0px 0px 0px 0.8ex; BORDER-LEFT: #ccc 1px solid">
<div>
<div bgcolor="#ffffff">
<div><font face="新細明體" size="2">&nbsp;&nbsp;&nbsp;&nbsp; Thanks for reply. can a2play run on OSS too?</font></div></div></div></blockquote>
<div>&nbsp;</div>
<div>I am not very sure of a2play's design now.</div><br>
<blockquote class="gmail_quote" style="PADDING-LEFT: 1ex; MARGIN: 0px 0px 0px 0.8ex; BORDER-LEFT: #ccc 1px solid">
<div>
<div bgcolor="#ffffff">
<div>&nbsp;</div>
<div><font face="新細明體" size="2">&nbsp;&nbsp;&nbsp;&nbsp; I ported BlueZ on an embeded ARM7 running at 80 MHz. </font></div>
<div><font face="新細明體" size="2">I also try a2recv on embeded board with sound chip using OSS</font></div>
<div><font face="新細明體" size="2">driver. Printout looks ok, but can't hear anything:</font></div>
<div><font face="新細明體" size="2"></font>&nbsp;</div>
<div><font face="新細明體" size="2">---------------------------------------------------------------------</font></div>
<div><font size="2">&gt;&nbsp;./a2recv<br><br>Connected [imtu 672, omtu 672, flush_to 65535]<br>Connected<br>Sent Stream End Point Discovery Response<br><br>Sent the get capabilities responseChannels=2, speed=44100channel_mode = 2 alloca tion_method = 2 subbands = 1 block_length = 1 min_bitpool = 2 max_bitpool = 250
<br><br>Sent a Set configurations response<br><br>Received an open stream command<br><br>Sent open stream confirm<br><br>Connected [imtu 672, omtu 672, flush_to 65535]<br>ConnectedGot stream fd<br><br>Sent start stream confirm
</font><br><font face="新細明體" size="2">------------------------------------------------------------------------------</font></div>
<div><font face="新細明體" size="2"></font>&nbsp;</div></div></div></blockquote>
<div>&nbsp;</div>
<div>The above logs are OK. It means that the A2DP source is streaming to your target device. </div>
<div>The only reason that you do not hear anything can be an endian problem. Maybe the endian type in which the SBC is decoded is different from the one that your device supports.</div>
<div>Don't you even hear any noise?</div>
<div>By the way are you using the latest version of a2recv?</div>
<div>&nbsp;</div><br>
<blockquote class="gmail_quote" style="PADDING-LEFT: 1ex; MARGIN: 0px 0px 0px 0.8ex; BORDER-LEFT: #ccc 1px solid">
<div>
<div bgcolor="#ffffff">
<div><font face="新細明體" size="2">Is&nbsp;CPU (ARM7 @80MHz) powerful enough &nbsp;to run a2recv ?</font></div></div></div></blockquote>
<div>&nbsp;</div>
<div>I think it should be powerful enough.</div>
<div>&nbsp;</div>
<div>Regards,</div>
<div>Mayank</div></div>

------=_Part_11500_27764554.1151488678176--


--===============1697656272==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--===============1697656272==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============1697656272==--
