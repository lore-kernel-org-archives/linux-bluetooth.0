Return-Path: <bluez-devel-admin@lists.sourceforge.net>
In-Reply-To: <1134389864.1468.36.camel@blade>
To: bluez-devel@lists.sourceforge.net
Cc: bluez-devel@lists.sourceforge.net, bluez-devel-admin@lists.sourceforge.net
MIME-Version: 1.0
Message-ID: <OFFBC33E94.09420113-ON482570D5.0044635F-482570D5.00450674@zte.com.cn>
From: gao.yingbin@zte.com.cn
Content-Type: multipart/alternative; boundary="=_alternative 00450665482570D5_="
Subject: [Bluez-devel] =?GB2312?B?tPC4tDogUmU6IFtCbHVlei1kZXZlbF0gQWZ0ZXIgdHdvIFNDTyBsaW5rcw==?=
 =?GB2312?B?IGJlZW4gY3JlYXRlZCwgQ2FuIG5vdAl0cmFuc2ZlciBBQ0wgZGF0YQ==?=
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Mon, 12 Dec 2005 20:33:28 +0800

This is a multipart message in MIME format.
--=_alternative 00450665482570D5_=
Content-Type: text/plain; charset="US-ASCII"

Hi,

> After I creat two SCO links from two different Teminal devices to one
> Gateway device, I can not transfer any ACL data between the gateway
> and teminal. 
> the note is: 
> # hcitool con 
> Connections: 
>         < SCO 00:00:11:22:33:44 handle 2 state 1 lm SLAVE 
>         < SCO 00:00:55:66:77:88 handle 1 state 1 lm SLAVE 
>         > ACL 00:00:11:22:33:44 handle 7 state 1 lm MASTER 
>         > ACL 00:00:55:66:77:88 handle 6 state 1 lm MASTER 
> 
> Software: Using bluez stacks; 
> hareware: using broardcom bluetooth chip or CSR bluetooth chip. 
> I watch the uart port of the bluetooth chip and find that some ACL
> data have been sent to bluetooth chip of gateway, but no any acl data
> have been received from bluetooth chip of teminal. 

the example above is not a CSR chip. Use the CSR chip as reference and
provide output of "hciconfig hci0 revision".
>>the example above is a broardcom chip.but using CSR chip have the same 
problems.
>>the csr chip revision is: HCIStack1.2v18.2, BlueCore3-ROM

> Is bugs of the bluetooth chips , or the bluez stacks is wrongly used?

With this little information it is totally unclear. However since you
mentioned UART, it might be an UART limitation.


***********************************************
信息安全声明：本邮件包含信息归ZTE所有，
ZTE对该邮件拥有所有权利。请接收者注意
保密，未经发件人书面许可，不得向任何第
三方组织和个人透露本邮件所含信息的全部
或部分。以上声明仅适用于工作邮件。
Information Security  Notice：
The information contained in this mail is
solely property of  ZTE Corporation. 
This mail communication is confidential.
Recipients named above are obligated to
maintain secrecy and are not permitted to
disclose the contents of this communication
to others.
***********************************************

--=_alternative 00450665482570D5_=
Content-Type: text/html; charset="US-ASCII"


<br><font size=2><tt>Hi,<br>
<br>
&gt; After I creat two SCO links from two different Teminal devices to
one<br>
&gt; Gateway device, I can not transfer any ACL data between the gateway<br>
&gt; and teminal. <br>
&gt; the note is: <br>
&gt; # hcitool con <br>
&gt; Connections: <br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &lt; SCO 00:00:11:22:33:44 handle 2 state
1 lm SLAVE &nbsp; <br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &lt; SCO 00:00:55:66:77:88 handle 1 state
1 lm SLAVE <br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &gt; ACL 00:00:11:22:33:44 handle 7 state
1 lm MASTER <br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &gt; ACL 00:00:55:66:77:88 handle 6 state
1 lm MASTER <br>
&gt; <br>
&gt; Software: Using bluez stacks; <br>
&gt; hareware: using broardcom bluetooth chip or CSR bluetooth chip. <br>
&gt; I watch the uart port of the bluetooth chip and find that some ACL<br>
&gt; data have been sent to bluetooth chip of gateway, but no any acl data<br>
&gt; have been received from bluetooth chip of teminal. <br>
<br>
the example above is not a CSR chip. Use the CSR chip as reference and<br>
provide output of &quot;hciconfig hci0 revision&quot;.</tt></font>
<br><font size=2><tt>&gt;&gt;the example above is a broardcom chip.but
using CSR chip have the same problems.</tt></font>
<br><font size=2><tt>&gt;&gt;the csr chip revision is: HCIStack1.2v18.2,
BlueCore3-ROM<br>
<br>
&gt; Is bugs of the bluetooth chips , or the bluez stacks is wrongly used?<br>
<br>
With this little information it is totally unclear. However since you<br>
mentioned UART, it might be an UART limitation.</tt></font><br><br><br>
***********************************************<br>
信息安全声明：本邮件包含信息归ZTE所有，<br>
ZTE对该邮件拥有所有权利。请接收者注意<br>
保密，未经发件人书面许可，不得向任何第<br>
三方组织和个人透露本邮件所含信息的全部<br>
或部分。以上声明仅适用于工作邮件。<br>
Information&nbsp;Security&nbsp;&nbsp;Notice：<br>
The&nbsp;information&nbsp;contained&nbsp;in&nbsp;this&nbsp;mail&nbsp;is<br>
solely&nbsp;property&nbsp;of&nbsp;&nbsp;ZTE&nbsp;Corporation.&nbsp;<br>
This&nbsp;mail&nbsp;communication&nbsp;is&nbsp;confidential.<br>
Recipients&nbsp;named&nbsp;above&nbsp;are&nbsp;obligated&nbsp;to<br>
maintain&nbsp;secrecy&nbsp;and&nbsp;are&nbsp;not&nbsp;permitted&nbsp;to<br>
disclose&nbsp;the&nbsp;contents&nbsp;of&nbsp;this&nbsp;communication<br>
to&nbsp;others.<br>
***********************************************<br>

--=_alternative 00450665482570D5_=--


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
