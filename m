Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <6297d67c0606290445h455ea56bjfdf3bc2b44f26ad1@mail.gmail.com>
Date: Thu, 29 Jun 2006 17:15:24 +0530
From: "Mayank Batra" <mayankbatra@gmail.com>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
In-Reply-To: <28c817710606290332o2e84020dl91d4a0bff11db73f@mail.gmail.com>
MIME-Version: 1.0
References: <28c817710606290332o2e84020dl91d4a0bff11db73f@mail.gmail.com>
Subject: Re: [Bluez-devel] how to create a ACL connection with an
	authentication?
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0207067608=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

--===============0207067608==
Content-Type: multipart/alternative;
	boundary="----=_Part_47396_23950244.1151581524669"

------=_Part_47396_23950244.1151581524669
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Jingtian,

On 6/29/06, ifq <ifqqfi@gmail.com> wrote:
>
> I want to create a ACL connection with an authentication and encryption
> use BlueZ. I searched the BlueZ lib and found nothing.is there anyone
> could give me some advice?thank you very much!
>

In /etc/bluetooth/hcid.conf file make sure that the following lines are
there (i.e. they should not be commented!)
auth enable
encrypt enable

You may have to restart hcid if it is already running.

Regards,
Mayank

------=_Part_47396_23950244.1151581524669
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Jingtian,<br><br>
<div><span class="gmail_quote">On 6/29/06, <b class="gmail_sendername">ifq</b> &lt;<a href="mailto:ifqqfi@gmail.com">ifqqfi@gmail.com</a>&gt; wrote:</span>
<blockquote class="gmail_quote" style="PADDING-LEFT: 1ex; MARGIN: 0px 0px 0px 0.8ex; BORDER-LEFT: #ccc 1px solid">
<div>I want to create a ACL connection with an authentication and encryption use BlueZ. I searched the BlueZ lib and found <a onclick="return top.js.OpenExtLink(window,event,this)" href="http://nothing.is/" target="_blank">
nothing.is</a> there anyone could give me some advice?thank you very much! </div></blockquote>
<div>&nbsp;</div>
<div>In /etc/bluetooth/hcid.conf file make sure that the following lines are there (i.e. they should not be commented!)</div>
<div>auth enable</div>
<div>encrypt enable</div>
<div>&nbsp;</div>
<div>You may have to restart hcid if it is already running.</div>
<div>&nbsp;</div>
<div>Regards,</div>
<div>Mayank</div><br>&nbsp;</div>

------=_Part_47396_23950244.1151581524669--


--===============0207067608==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--===============0207067608==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============0207067608==--
