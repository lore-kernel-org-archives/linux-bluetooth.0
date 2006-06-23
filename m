Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <6297d67c0606222152l241a22d7ifdb96032bbc52458@mail.gmail.com>
Date: Fri, 23 Jun 2006 10:22:43 +0530
From: "Mayank Batra" <mayankbatra@gmail.com>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
In-Reply-To: <6297d67c0606202248t48d5e85fi4888304c70f12139@mail.gmail.com>
MIME-Version: 1.0
References: <mailman.1467.1150830573.9417.bluez-devel@lists.sourceforge.net>
	<44986D90.2090505@fh-wolfenbuettel.de>
	<6297d67c0606202248t48d5e85fi4888304c70f12139@mail.gmail.com>
Subject: Re: [Bluez-devel] blueZ and SAP
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0138620932=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

--===============0138620932==
Content-Type: multipart/alternative;
	boundary="----=_Part_64090_17249364.1151038363604"

------=_Part_64090_17249364.1151038363604
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Goetz,


On 6/21/06, Mayank Batra <mayankbatra@gmail.com> wrote:
>
>
>  *But tell me one thing: After you receive a connect_resp from the phone,
> do you receive a status_ind as well?*
> *This is important, because if you do not receive this, the connection is
> not really up. See page 22 of the spec.*
>

So, I mean that after you've read the connect_resp, you should perform
another read for the status_ind which will be something like:

0x11 0x01 0x00 0x00 0x08 0x00 0x00 0x01 0x04 0x00 0x00 0x00

0x11 is msg_id for status_ind.
0x08 is parameter_id for StatusChange
0x04 is the value of StatusChange which says "Card Inserted"


Please let me know in case you want any further information.

Regards,
Mayank

------=_Part_64090_17249364.1151038363604
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<div>Hi Goetz,</div><br><br>
<div><span class="gmail_quote">On 6/21/06, <b class="gmail_sendername">Mayank Batra</b> &lt;<a href="mailto:mayankbatra@gmail.com">mayankbatra@gmail.com</a>&gt; wrote:</span>
<blockquote class="gmail_quote" style="PADDING-LEFT: 1ex; MARGIN: 0px 0px 0px 0.8ex; BORDER-LEFT: #ccc 1px solid">
<div>
<div>&nbsp;</div>
<div>
<div><strong>But tell me one thing: After you receive a connect_resp from the phone, do you receive a status_ind as well?</strong></div>
<div><strong>This is important, because if you do not receive this, the connection is not really up. See page 22 of the spec.</strong></div></div></div></blockquote>
<div>&nbsp;</div>
<div>So, I mean that after you've read the connect_resp, you should perform another read for the status_ind which will be something like:</div>
<div>&nbsp;</div>
<div>0x11 0x01 0x00 0x00 0x08 0x00 0x00 0x01 0x04 0x00 0x00 0x00</div>
<div>&nbsp;</div>
<div>0x11 is msg_id for status_ind.</div>
<div>0x08 is parameter_id for StatusChange</div>
<div>0x04 is the value of StatusChange which says &quot;Card Inserted&quot;</div>
<div>&nbsp;</div>
<div>&nbsp;</div>
<div>Please let me know in case you want any further information.</div>
<div>&nbsp;</div>
<div>Regards,</div>
<div>Mayank</div></div>

------=_Part_64090_17249364.1151038363604--


--===============0138620932==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--===============0138620932==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============0138620932==--
