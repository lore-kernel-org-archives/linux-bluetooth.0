Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <ef9938ec0604130949q67168579m85a3eb9521cdae91@mail.gmail.com>
From: "Albert Huang" <albert@csail.mit.edu>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] How to process fragmentation synchronously when two l2cap connections over one acl connection?
In-Reply-To: <OF01649481.41C9F474-ON4825714F.003F0EC5-4825714F.004171CE@zte.com.cn>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_8958_4095664.1144946954028"
References: <9FBCE015AF479F46B3B410499F3AE05B011F0BCB@pdsmsx405>
	 <OF01649481.41C9F474-ON4825714F.003F0EC5-4825714F.004171CE@zte.com.cn>
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
Date: Thu, 13 Apr 2006 12:49:14 -0400

------=_Part_8958_4095664.1144946954028
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

l2cap packets are always identified by a channel ID, which is negotiated
when each l2cap connection (channel) is established.  Continuation fragments
always have the channel ID in the packet header, so there is no ambiguity
over which continuation fragment belongs to which connection.  You should
take another look at the L2CAP section in the core spec.

-albert

On 4/13/06, gao.yingbin@zte.com.cn <gao.yingbin@zte.com.cn> wrote:
>
>
> Marcel & all,
>   I'am puzzling over the following question. How to process fragmentation
> synchronously when two l2cap connections over one acl connection?
>  in bluetooth specification, the continuing fragments of l2cap only can be
> identified by acl connection handles. so if two l2cap connections build over
> one acl conncetion (such as two l2cap connections bulid  between two
> bluetooth devices), and the two l2cap connections received continuing
> fragments synchronously，how can i identify which fragments belong the first
> l2caps connections and which fragments  belong the other?
> thanks.
>
>
>
> --------------------------------------------------------
> ZTE Information Security Notice: The information contained in this mail is solely property of the sender's organization. This mail communication is confidential. Recipients named above are obligated to maintain secrecy and are not permitted to disclose the contents of this communication to others.
> This email and any files transmitted with it are confidential and intended solely for the use of the individual or entity to whom they are addressed. If you have received this email in error please notify the originator of the message. Any views expressed in this message are those of the individual sender.
> This message has been scanned for viruses and Spam by ZTE Anti-Spam system.
>
>

------=_Part_8958_4095664.1144946954028
Content-Type: text/html; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

l2cap packets are always identified by a channel ID, which is
negotiated when each l2cap connection (channel) is established.&nbsp;
Continuation fragments always have the channel ID in the packet header,
so there is no ambiguity over which continuation fragment belongs to
which connection.&nbsp; You should take another look at the L2CAP
section in the core spec.<br>
<br>
-albert<br><br><div><span class="gmail_quote">On 4/13/06, <b class="gmail_sendername"><a href="mailto:gao.yingbin@zte.com.cn">gao.yingbin@zte.com.cn</a></b> &lt;<a href="mailto:gao.yingbin@zte.com.cn">gao.yingbin@zte.com.cn
</a>&gt; wrote:</span><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;"><div style="direction: ltr;">
<br><font size="2"><tt>Marcel &amp; all,</tt></font>
<br><font size="2"><tt>&nbsp; I'am puzzling over the following question.
How to process fragmentation synchronously when two l2cap connections over
one acl connection?</tt></font>
<br><font size="2"><tt>&nbsp;in bluetooth specification, the continuing fragments
of l2cap only can be identified by acl connection handles. so if two l2cap
connections build over one acl conncetion (such as two l2cap connections
bulid &nbsp;between two bluetooth devices), and the two l2cap connections
received continuing fragments synchronously，how can i identify which
fragments belong the first l2caps connections and which fragments &nbsp;belong
the other?</tt></font>
<br><font size="2"><tt>thanks.</tt></font>
<br>
<br>
<br>
<br><pre>--------------------------------------------------------<br>ZTE&nbsp;Information&nbsp;Security&nbsp;Notice:&nbsp;The&nbsp;information&nbsp;contained&nbsp;in&nbsp;this&nbsp;mail&nbsp;is&nbsp;solely&nbsp;property&nbsp;of&nbsp;the&nbsp;sender's&nbsp;organization.&nbsp;This&nbsp;mail&nbsp;communication&nbsp;is&nbsp;confidential.&nbsp;Recipients&nbsp;named&nbsp;above&nbsp;are&nbsp;obligated&nbsp;to&nbsp;maintain&nbsp;secrecy&nbsp;and&nbsp;are&nbsp;not&nbsp;permitted&nbsp;to&nbsp;disclose&nbsp;the&nbsp;contents&nbsp;of&nbsp;this&nbsp;communication&nbsp;to&nbsp;others.
<br>This&nbsp;email&nbsp;and&nbsp;any&nbsp;files&nbsp;transmitted&nbsp;with&nbsp;it&nbsp;are&nbsp;confidential&nbsp;and&nbsp;intended&nbsp;solely&nbsp;for&nbsp;the&nbsp;use&nbsp;of&nbsp;the&nbsp;individual&nbsp;or&nbsp;entity&nbsp;to&nbsp;whom&nbsp;they&nbsp;are&nbsp;addressed.&nbsp;If&nbsp;you&nbsp;have&nbsp;received&nbsp;this&nbsp;email&nbsp;in&nbsp;error&nbsp;please&nbsp;notify&nbsp;the&nbsp;originator&nbsp;of&nbsp;the&nbsp;message.&nbsp;Any&nbsp;views&nbsp;expressed&nbsp;in&nbsp;this&nbsp;message&nbsp;are&nbsp;those&nbsp;of&nbsp;the&nbsp;individual&nbsp;sender.
<br>This&nbsp;message&nbsp;has&nbsp;been&nbsp;scanned&nbsp;for&nbsp;viruses&nbsp;and&nbsp;Spam&nbsp;by&nbsp;ZTE&nbsp;Anti-Spam&nbsp;system.<br></pre></div></blockquote></div><br>

------=_Part_8958_4095664.1144946954028--


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
