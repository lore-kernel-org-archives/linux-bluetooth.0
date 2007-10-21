Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <6656b6540710210008v5cc459dv6692a5e8ff888187@mail.gmail.com>
Date: Sun, 21 Oct 2007 12:38:27 +0530
From: "Robin Gujjar" <robin.gujjar@gmail.com>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
In-Reply-To: <47189691.2000504@cilnu.com>
MIME-Version: 1.0
References: <6656b6540710182155m29cd7441l6dcb9a7d722d5417@mail.gmail.com>
	<47189691.2000504@cilnu.com>
Subject: Re: [Bluez-devel] BlueZ integration to LINUX kernel (ARM)
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============2045942222=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

--===============2045942222==
Content-Type: multipart/alternative;
	boundary="----=_Part_5529_30208407.1192950507611"

------=_Part_5529_30208407.1192950507611
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

hi jon
thanks for the reply .Jon i saw the source code i got it . now i want to
write a bluetooth UART device driver for my board
can you just give me some basic step how to go ahead because i am new to
linux device driver .please help any on

thanks and regrds
Robin Singh

On 10/19/07, Jon Maber <jon@cilnu.com> wrote:
>
> Robin,
> the job is already done for you.  Download kernel 2.6.22 and take a look
> in net/bluetooth - you will see that the source code is there already.
> Run menuconfig and you will see bluetooth configuration options under
> the networking heading.  The fact that you are building for ARM
> shouldn't present any additional problems.
> Jon
>
> Robin Gujjar wrote:
> > hi every body
> >
> > i am newbie to bluetooth .i want to integrate blueZ to my linux kernel
> > 2.6.22 can any body plz give me some basic step to do that .
> >
> > thanks in advance
> >
> > Robin Singh
> >
> >
> > ------------------------------------------------------------------------
> >
> >
> -------------------------------------------------------------------------
> > This SF.net email is sponsored by: Splunk Inc.
> > Still grepping through log files to find problems?  Stop.
> > Now Search log events and configuration files using AJAX and a browser.
> > Download your FREE copy of Splunk now >> http://get.splunk.com/
> > ------------------------------------------------------------------------
> >
> > _______________________________________________
> > Bluez-devel mailing list
> > Bluez-devel@lists.sourceforge.net
> > https://lists.sourceforge.net/lists/listinfo/bluez-devel
> >
>
>
> -------------------------------------------------------------------------
> This SF.net email is sponsored by: Splunk Inc.
> Still grepping through log files to find problems?  Stop.
> Now Search log events and configuration files using AJAX and a browser.
> Download your FREE copy of Splunk now >> http://get.splunk.com/
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel
>

------=_Part_5529_30208407.1192950507611
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

hi jon <br>thanks for the reply .Jon i saw the source code i got it . now i want to write a bluetooth UART device driver for my board <br>can you just give me some basic step how to go ahead because i am new to linux device driver .please help any on 
<br><br>thanks and regrds<br>Robin Singh<br><br><div><span class="gmail_quote">On 10/19/07, <b class="gmail_sendername">Jon Maber</b> &lt;<a href="mailto:jon@cilnu.com">jon@cilnu.com</a>&gt; wrote:</span><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
Robin,<br>the job is already done for you.&nbsp;&nbsp;Download kernel 2.6.22 and take a look<br>in net/bluetooth - you will see that the source code is there already.<br>Run menuconfig and you will see bluetooth configuration options under
<br>the networking heading.&nbsp;&nbsp;The fact that you are building for ARM<br>shouldn&#39;t present any additional problems.<br>Jon<br><br>Robin Gujjar wrote:<br>&gt; hi every body<br>&gt;<br>&gt; i am newbie to bluetooth .i want to integrate blueZ to my linux kernel
<br>&gt; 2.6.22 can any body plz give me some basic step to do that .<br>&gt;<br>&gt; thanks in advance<br>&gt;<br>&gt; Robin Singh<br>&gt;<br>&gt;<br>&gt; ------------------------------------------------------------------------
<br>&gt;<br>&gt; -------------------------------------------------------------------------<br>&gt; This SF.net email is sponsored by: Splunk Inc.<br>&gt; Still grepping through log files to find problems?&nbsp;&nbsp;Stop.<br>&gt; Now Search log events and configuration files using AJAX and a browser.
<br>&gt; Download your FREE copy of Splunk now &gt;&gt; <a href="http://get.splunk.com/">http://get.splunk.com/</a><br>&gt; ------------------------------------------------------------------------<br>&gt;<br>&gt; _______________________________________________
<br>&gt; Bluez-devel mailing list<br>&gt; <a href="mailto:Bluez-devel@lists.sourceforge.net">Bluez-devel@lists.sourceforge.net</a><br>&gt; <a href="https://lists.sourceforge.net/lists/listinfo/bluez-devel">https://lists.sourceforge.net/lists/listinfo/bluez-devel
</a><br>&gt;<br><br><br>-------------------------------------------------------------------------<br>This SF.net email is sponsored by: Splunk Inc.<br>Still grepping through log files to find problems?&nbsp;&nbsp;Stop.<br>Now Search log events and configuration files using AJAX and a browser.
<br>Download your FREE copy of Splunk now &gt;&gt; <a href="http://get.splunk.com/">http://get.splunk.com/</a><br>_______________________________________________<br>Bluez-devel mailing list<br><a href="mailto:Bluez-devel@lists.sourceforge.net">
Bluez-devel@lists.sourceforge.net</a><br><a href="https://lists.sourceforge.net/lists/listinfo/bluez-devel">https://lists.sourceforge.net/lists/listinfo/bluez-devel</a><br></blockquote></div><br>

------=_Part_5529_30208407.1192950507611--


--===============2045942222==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
--===============2045942222==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============2045942222==--
