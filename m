Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <8de6c3e20708231340j439ca230i487e816693149441@mail.gmail.com>
Date: Thu, 23 Aug 2007 13:40:07 -0700
From: "Jeffrey Cuenco" <jcuenco@gmail.com>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
In-Reply-To: <2EB6297382462046A9427D7324788A480217D35A@MCLNEXVS06.resource.ds.bah.com>
MIME-Version: 1.0
References: <2EB6297382462046A9427D7324788A480217D35A@MCLNEXVS06.resource.ds.bah.com>
Subject: Re: [Bluez-devel] Multiple Bluetooth Dongles
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1728093999=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

--===============1728093999==
Content-Type: multipart/alternative;
	boundary="----=_Part_74883_13380764.1187901607357"

------=_Part_74883_13380764.1187901607357
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,

We are doing something similar in that we are using multiple dongles as
well, and are also interested in doing something similar to what your
customer wants to do by increasing the # of dongles.

Out of curiosity, how are you using these dongles?

On 8/23/07, Williams, Richard <williams_richard_b@bah.com> wrote:
>
>  Hello,
>
> I have a system that uses multiple Bluetooth dongles and works just fine.
> I've had my system running with several USB hubs and up to the 16 maximum
> devices that Bluez supports. Now I have a changing requirement from my
> customer to handle more than 16 Bluetooth devices. They want support for up
> to 30 Bluetooth devices.
>
> I changed the HCI_MAX_DEV in bluez_libs/include/hci.h from 16 to
> 30, recompiled and installed bluez_libs and bluez_utils. No problem.
>
> My program works fine with up to 16 Bluetooth devices, but the 17th device
> is not recognized and sometimes the entire USB will no longer work.
>
> Suggestions??
>
> Thank you. Best Regards.
>
> *Rich *
>
> -------------------------------------------------------------------------
> This SF.net email is sponsored by: Splunk Inc.
> Still grepping through log files to find problems?  Stop.
> Now Search log events and configuration files using AJAX and a browser.
> Download your FREE copy of Splunk now >>  http://get.splunk.com/
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel
>
>


-- 
-Jeff

------=_Part_74883_13380764.1187901607357
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,<br><br>We are doing something similar in that we are using multiple dongles as well, and are also interested in doing something similar to what your customer wants to do by increasing the # of dongles.<br><br>Out of curiosity, how are you using these dongles?&nbsp; 
<br><br><div><span class="gmail_quote">On 8/23/07, <b class="gmail_sendername">Williams, Richard</b> &lt;<a href="mailto:williams_richard_b@bah.com">williams_richard_b@bah.com</a>&gt; wrote:</span><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">




<div>
<div><font face="Arial" size="2"><span>Hello,</span></font></div>
<div><font face="Arial" size="2"><span></span></font>&nbsp;</div>
<div><font face="Arial" size="2"><span>I have a system that 
uses multiple Bluetooth dongles and works just fine. I&#39;ve had my system running 
with several USB hubs and up to the 16 maximum devices that Bluez supports. Now 
I have a changing requirement from my customer to handle more than 16 Bluetooth 
devices. They want support for up to 30 Bluetooth devices.</span></font></div>
<div><font face="Arial" size="2"><span></span></font>&nbsp;</div>
<div><font face="Arial" size="2"><span>I changed the 
HCI_MAX_DEV in bluez_libs/include/hci.h from 16 to 30,&nbsp;recompiled and 
installed&nbsp;bluez_libs and bluez_utils. No problem.</span></font></div>
<div><font face="Arial" size="2"><span></span></font>&nbsp;</div>
<div><font face="Arial" size="2"><span>My program works 
fine with up to 16 Bluetooth devices, but the 17th device is not recognized and 
sometimes&nbsp;the entire USB&nbsp;will no&nbsp;longer work.</span></font></div>
<div><font face="Arial" size="2"><span></span></font>&nbsp;</div>
<div><font face="Arial" size="2"><span>Suggestions??</span></font></div>
<div><font face="Arial" size="2"><span></span></font>&nbsp;</div>
<div><font face="Arial" size="2"><span>Thank you. Best 
Regards.</span></font></div>
<div>&nbsp;</div>
<div align="left"><font face="Arial" size="2"><strong>Rich </strong></font><font face="Arial" size="2"></font></div></div>
<br>-------------------------------------------------------------------------<br>This SF.net email is sponsored by: Splunk Inc.<br>Still grepping through log files to find problems? &nbsp;Stop.<br>Now Search log events and configuration files using AJAX and a browser.
<br>Download your FREE copy of Splunk now &gt;&gt; &nbsp;<a onclick="return top.js.OpenExtLink(window,event,this)" href="http://get.splunk.com/" target="_blank">http://get.splunk.com/</a><br>_______________________________________________
<br>Bluez-devel mailing list<br><a onclick="return top.js.OpenExtLink(window,event,this)" href="mailto:Bluez-devel@lists.sourceforge.net">Bluez-devel@lists.sourceforge.net</a><br><a onclick="return top.js.OpenExtLink(window,event,this)" href="https://lists.sourceforge.net/lists/listinfo/bluez-devel" target="_blank">
https://lists.sourceforge.net/lists/listinfo/bluez-devel</a><br><br></blockquote></div><br><br clear="all"><br>-- <br>-Jeff

------=_Part_74883_13380764.1187901607357--


--===============1728093999==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
--===============1728093999==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============1728093999==--
