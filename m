Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <1ab01fb50702012101s13f28626s1fc39ccc8f88c02e@mail.gmail.com>
Date: Fri, 2 Feb 2007 10:31:39 +0530
From: "Vikas Sinha" <compuvikas@gmail.com>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
In-Reply-To: <200702011159.21531.fernando@bluexare.org>
MIME-Version: 1.0
References: <200702011159.21531.fernando@bluexare.org>
Subject: Re: [Bluez-devel] About hci_inquiry (Num_Responses)
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0334011434=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

--===============0334011434==
Content-Type: multipart/alternative;
	boundary="----=_Part_17856_9247421.1170392499384"

------=_Part_17856_9247421.1170392499384
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Fernando,
you can get code at
http://www-md.e-technik.uni-rostock.de/ma/hm27/uebung_hnp_2004/documentation/bluez-2.10-html/
line no 555.
Here you will fine all documentation about blueZ

It intresting to know about it. Well i find the same and I develop an
application in which i put its value to 255[i.e. Max] so tat I will get
information about all its devices.

On 2/1/07, Fernando Unzu <fernando@bluexare.org> wrote:
>
> Hello,
> I'm playing with hci_inquiry function and I have realizedthat
> Num_Responses,
> who is passed like an argument to the function, does not do wath I want.
>
> I thought that this value told how many devices are scanned until the
> scanning
> stopped.
> But this value tells how many devices "respond" the scan message (so one
> same
> device can "respond" several times).
>
> With the hcidump I have realized on that.
>
> I have realized this issue because I put this value to 7, for example, and
> 7
> seconds to the len, but, without find the 7 devices, and without spend all
> the time, the inquiry returns and saying only 3 devices found (for
> example).
>
> There is any way to solve this? Or is the implementation of this function
> to
> do so...
>
> There is any solution? Can I, in any way, say the hci_inquiry to stop the
> scan
> only when 7 (f.e) different devices respond, or only the unique solution
> is
> to scan for over 40 or more devices, and find all devices, although others
> respond several times...
>
> Can anybody tell me where is the hci_inquiry code to take a study?
>
> Thank you.
>
> -------------------------------------------------------------------------
> Using Tomcat but need to do more? Need to support web services, security?
> Get stuff done quickly with pre-integrated technology to make your job
> easier.
> Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
> http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel
>



-- 
Impossible
itself contain
I M Possible

Vikas

------=_Part_17856_9247421.1170392499384
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Fernando,<br>

you can get code at <br>

<a href="http://www-md.e-technik.uni-rostock.de/ma/hm27/uebung_hnp_2004/documentation/bluez-2.10-html/">http://www-md.e-technik.uni-rostock.de/ma/hm27/uebung_hnp_2004/documentation/bluez-2.10-html/</a><br>
line no 555. <br>

Here you will fine all documentation about blueZ<br>

<br>

It intresting to know about it. Well i find the same and I develop an
application in which i put its value to 255[i.e. Max] so tat I will get
information about all its devices.<br><br><div><span class="gmail_quote">On 2/1/07, <b class="gmail_sendername">Fernando Unzu</b> &lt;<a href="mailto:fernando@bluexare.org">fernando@bluexare.org</a>&gt; wrote:</span><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
Hello,<br>I&#39;m playing with hci_inquiry function and I have realizedthat Num_Responses,<br>who is passed like an argument to the function, does not do wath I want.<br><br>I thought that this value told how many devices are scanned until the scanning
<br>stopped.<br>But this value tells how many devices &quot;respond&quot; the scan message (so one same<br>device can &quot;respond&quot; several times).<br><br>With the hcidump I have realized on that.<br><br>I have realized this issue because I put this value to 7, for example, and 7
<br>seconds to the len, but, without find the 7 devices, and without spend all<br>the time, the inquiry returns and saying only 3 devices found (for example).<br><br>There is any way to solve this? Or is the implementation of this function to
<br>do so...<br><br>There is any solution? Can I, in any way, say the hci_inquiry to stop the scan<br>only when 7 (f.e) different devices respond, or only the unique solution is<br>to scan for over 40 or more devices, and find all devices, although others
<br>respond several times...<br><br>Can anybody tell me where is the hci_inquiry code to take a study?<br><br>Thank you.<br><br>-------------------------------------------------------------------------<br>Using Tomcat but need to do more? Need to support web services, security?
<br>Get stuff done quickly with pre-integrated technology to make your job easier.<br>Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo<br><a href="http://sel.as-us.falkag.net/sel?cmd=lnk&amp;kid=120709&amp;bid=263057&amp;dat=121642">
http://sel.as-us.falkag.net/sel?cmd=lnk&amp;kid=120709&amp;bid=263057&amp;dat=121642</a><br>_______________________________________________<br>Bluez-devel mailing list<br><a href="mailto:Bluez-devel@lists.sourceforge.net">
Bluez-devel@lists.sourceforge.net</a><br><a href="https://lists.sourceforge.net/lists/listinfo/bluez-devel">https://lists.sourceforge.net/lists/listinfo/bluez-devel</a><br></blockquote></div><br><br clear="all"><br>-- <br>
Impossible <br>itself contain <br>I M Possible<br><br>Vikas

------=_Part_17856_9247421.1170392499384--


--===============0334011434==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier.
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--===============0334011434==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============0334011434==--
