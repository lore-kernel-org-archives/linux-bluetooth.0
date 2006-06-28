Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <6297d67c0606272049g55cc14cby52254c90863e727f@mail.gmail.com>
Date: Wed, 28 Jun 2006 09:19:22 +0530
From: "Mayank Batra" <mayankbatra@gmail.com>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
In-Reply-To: <BAY116-DAV738BD697D0EDB18FB509AC77F0@phx.gbl>
MIME-Version: 1.0
References: <BAY116-DAV738BD697D0EDB18FB509AC77F0@phx.gbl>
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
Content-Type: multipart/mixed; boundary="===============0956361522=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

--===============0956361522==
Content-Type: multipart/alternative;
	boundary="----=_Part_4722_20718774.1151466562152"

------=_Part_4722_20718774.1151466562152
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Chane,

On 6/28/06, I-Chung Chane <ichane@hotmail.com> wrote:

>  I'm trying Bluetooth-ALSA Project (A2DP part). I wonder does a2play and
> a2recv need
> ALSA to make it work? Can they work with sound card using OSS driver?
>

a2recv will work with OSS driver. It will accept an incoming A2DP connection
and then bind to your /dev/dsp.

Regards,
Mayank

------=_Part_4722_20718774.1151466562152
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Chane,<br><br>
<div><span class="gmail_quote">On 6/28/06, <b class="gmail_sendername">I-Chung Chane</b> &lt;<a href="mailto:ichane@hotmail.com">ichane@hotmail.com</a>&gt; wrote:</span><br>
<blockquote class="gmail_quote" style="PADDING-LEFT: 1ex; MARGIN: 0px 0px 0px 0.8ex; BORDER-LEFT: #ccc 1px solid">
<div>
<div bgcolor="#ffffff">
<div><font size="2">I'm trying Bluetooth-ALSA Project (A2DP part). I wonder does a2play and a2recv need</font></div>
<div><font size="2">ALSA&nbsp;to make it work? Can they work with sound card using OSS driver?</font></div></div></div></blockquote>
<div>&nbsp;</div>
<div>a2recv will work with OSS driver. It will accept an incoming A2DP connection and then bind to your /dev/dsp.</div>
<div>&nbsp;</div>
<div>Regards,</div>
<div>Mayank</div><br>
<div>&nbsp;</div>
<div>&nbsp;</div><br>&nbsp;</div>

------=_Part_4722_20718774.1151466562152--


--===============0956361522==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--===============0956361522==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============0956361522==--
