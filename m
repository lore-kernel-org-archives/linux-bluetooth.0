Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <ddea76ce0703010641r79c51e7bhb15e2839eea519d6@mail.gmail.com>
Date: Thu, 1 Mar 2007 14:41:22 +0000
From: "Meenakshi Seeballack" <meena2010@gmail.com>
To: bluez-devel@lists.sourceforge.net
MIME-Version: 1.0
Subject: Re: [Bluez-devel] missing bluetooth header file
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0935909702=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

--===============0935909702==
Content-Type: multipart/alternative;
	boundary="----=_Part_14315_12929237.1172760082625"

------=_Part_14315_12929237.1172760082625
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

the kernel is 2.6.19-1.2911.fc6-i686, and I assume bluez is installed on the
machine, since  I tried "yum install bluez" and it says "nothing to do"
-------------------------------------------------------------------------------------------------------
On 01/03/07, bluez-devel-request@lists.sourceforge.net <
bluez-devel-request@lists.sourceforge.net> wrote:
>
> Send Bluez-devel mailing list submissions to
>         bluez-devel@lists.sourceforge.net
>
> To subscribe or unsubscribe via the World Wide Web, visit
>         https://lists.sourceforge.net/lists/listinfo/bluez-devel
> or, via email, send a message with subject or body 'help' to
>         bluez-devel-request@lists.sourceforge.net
>
> You can reach the person managing the list at
>         bluez-devel-owner@lists.sourceforge.net
>
> When replying, please edit your Subject line so it is more specific
> than "Re: Contents of Bluez-devel digest..."
>
>
> Today's Topics:
>
>    1. Implementation of multifactor authentication (Leonardo Salas)
>    2. Re: how to create rfcomm channel (Vikas Sinha)
>    3. Help: missing Bluetooth header file (Meenakshi Seeballack)
>    4. Re: Help: missing Bluetooth header file (Vikas Sinha)
>
>
> ----------------------------------------------------------------------
>
> Message: 1
> Date: Thu, 1 Mar 2007 13:13:48 +0100
> From: "Leonardo Salas" <alert@nationalcity.com>
> Subject: [Bluez-devel] Implementation of multifactor authentication
> To: "bluez-devel" <bluez-devel@lists.sourceforge.net>
> Message-ID: <000f01c75c03$cf4102b0$0140e6c4@computer69e32c>
> Content-Type: text/plain; charset="windows-1250"
>
>
> Dear National City Business Banking Customer,
> As use of the Internet continues to expand, more banks and thrifts are
> using the Web to offer products and
> services or otherwise enhance communications with consumers.
> Our bank works hard to ensure a safe banking online for our customers.
> We have developed a new security measure as an additional protection for
> accounts that have more than 10,000 dollars.
> The main function of this security program is to prevent any attempts of
> unauthorized access to a business account.
> The new safeguard system eliminates any possibility of illegal breach to a
> bank account.
> The core of a new security system is an authorization of each bank
> transaction of our customers.
> The authorization will only be successful after entering a personal
> identification number (PIN) using a personal PIN card:
> - Security Number consists of 6 digits
> - PIN card has a list of 300 unique PINs which can be used to confirm
> every transaction.
> After three unsuccessful attempts of entering a personal identification
> number (PIN) - an account would be automatically
> suspended to protect our customers from fraudulent activities.
> A security number can be used only once, and then it becomes invalid after
> a transaction is completed.
> To register for our new online guard protection system please, click on
> the link below and follow the
> instructions on the screen. At the last step of your registration you will
> be asked to enter the address
> where you would like your pin card be delivered, including full postal
> code. In order to avoid any delays,
> please verify that you have input all the correct information.
> The card will be delivered to you within 14 days after the application is
> submitted.
> In the meantime, you can continue to use your business account as usual.
> Please, note in case if we do not hear from you within 7 days your account
> will be temporary suspended as a security measure.
> To start the registration - please click here:
> https://authmaster.nationalcity.com/corporate/exact4web/login.jsp
> Support Department
> National City Corporation.
> -------------- next part --------------
> An HTML attachment was scrubbed...
>
> ------------------------------
>
> Message: 2
> Date: Thu, 1 Mar 2007 17:48:08 +0530
> From: "Vikas Sinha" <compuvikas@gmail.com>
> Subject: Re: [Bluez-devel] how to create rfcomm channel
> To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
> Message-ID:
>         <1ab01fb50703010418i4b4738ebya621923466eaaeb6@mail.gmail.com>
> Content-Type: text/plain; charset="iso-8859-1"
>
> Hi Siddhant,
>
> ur code seems to be fine. I think there are some problem in releasing
> device. Generally Bad File Descriptor comes if socket does not get closed
> properly. Actually rfcomm takes some time to set free device. try to put
> some sleep time in between release and again bind.  Even binding at hci
> layer is longer then rfcomm layer.  But can u tell me how did u send file
> to
> your handset. or ur testing it with pc to pc.
>
> hcidump will also be useful.
>
> On 3/1/07, siddhant tewari <siddhant.tewari@gmail.com> wrote:
> >
> > hi vikas ,
> >             Really great to get i reply from you. I was trying to write
> a
> > program that can send file to my nokia phone. I was looking for a api
> that
> > can create a character device which can be passed to ioctl.  To do so
> what i
> > am doing right now is
> >
> > i)              char cmdBuf[256];
> >                 sprintf(cmdBuf,"mknod %s c 216 %d",tempBuf,dev);
> >                 if (system(cmdBuf) != 0 )
> >                 {
> >                     fprintf(stderr,"\nError in executng mknod\n");
> >                     exit(1);
> >                 }
> >
> > ii) And then
> > err = ioctl(ctl, RFCOMMCREATEDEV, &req);
> >
> > iii) For releasing the device i am doing :-
> > err = ioctl(ctl, RFCOMMRELEASEDEV, &req);
> >
> > These things are working fine for a single run but after 2 run (keeping
> > the above 3 in while(1) block) ;  while releasing the device , ioctl
> gives
> > error bad file descriptor. Please tell me what i am doing wrong.
> >
> > regards
> > siddhant
> >
> >
> >
> >
> >
> -------------------------------------------------------------------------
> > Take Surveys. Earn Cash. Influence the Future of IT
> > Join SourceForge.net's Techsay panel and you'll get the chance to share
> > your
> > opinions on IT & business topics through brief surveys-and earn cash
> >
> http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
> > _______________________________________________
> > Bluez-devel mailing list
> > Bluez-devel@lists.sourceforge.net
> > https://lists.sourceforge.net/lists/listinfo/bluez-devel
> >
> >
>
>
> --
> Impossible
> itself contain
> I M Possible
>
> Vikas
> -------------- next part --------------
> An HTML attachment was scrubbed...
>
> ------------------------------
>
> Message: 3
> Date: Thu, 1 Mar 2007 14:29:09 +0000
> From: "Meenakshi Seeballack" <meena2010@gmail.com>
> Subject: [Bluez-devel] Help: missing Bluetooth header file
> To: bluez-devel@lists.sourceforge.net
> Message-ID:
>         <ddea76ce0703010629y4930307chdbd0a6e366ca5ad9@mail.gmail.com>
> Content-Type: text/plain; charset="iso-8859-1"
>
> Hello,
> I am new to the linux world and I have installed Eclipse, with CDT.
> I am running the simplescan code off this website
> http://people.csail.mit.edu/albert/bluez-intro/c401.html and I am getting
> these errors:
> simplescan.c:6:33: error: bluetooth/bluetooth.h: No such file or directory
> simplescan.c:7:27: error: bluetooth/hci.h: No such file or directory
> simplescan.c:8:31: error: bluetooth/hci_lib.h: No such file or directory
> simplescan.c: In function 'main':
> simplescan.c:12: error: 'inquiry_info' undeclared (first use in this
> function)
> simplescan.c:12: error: (Each undeclared identifier is reported only once
> simplescan.c:12: error: for each function it appears in.)
> simplescan.c:12: error: 'ii' undeclared (first use in this function)
> simplescan.c:28: error: 'IREQ_CACHE_FLUSH' undeclared (first use in this
> function)
> simplescan.c:29: error: expected expression before ')' token
> simplescan.c:36: warning: incompatible implicit declaration of built-in
> function 'memset'
> simplescan.c:39: warning: incompatible implicit declaration of built-in
> function 'strcpy'
> simplescan.c:46:2: warning: no newline at end of file
>
> I can see these header files:
> /usr/src/kernels/2.6.19-1.2911.fc6-i686/include/net/bluetooth/bluetooth.h
> /usr/src/kernels/2.6.19-1.2911.fc6-i686/include/net/bluetooth/hci.h
> /usr/src/kernels/2.6.19-1.2911.fc6-i686/include/net/bluetooth/hci_core.h
> /usr/src/kernels/2.6.19-1.2911.fc6-i686/include/net/bluetooth/l2cap.h
> /usr/src/kernels/2.6.19-1.2911.fc6-i686/include/net/bluetooth/rfcomm.h
> /usr/src/kernels/2.6.19-1.2911.fc6-i686/include/net/bluetooth/sco.h
>
> Where is the hci_lib.h header file? Can anyone please assist me?
> Meena
> -------------- next part --------------
> An HTML attachment was scrubbed...
>
> ------------------------------
>
> Message: 4
> Date: Thu, 1 Mar 2007 20:06:22 +0530
> From: "Vikas Sinha" <compuvikas@gmail.com>
> Subject: Re: [Bluez-devel] Help: missing Bluetooth header file
> To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
> Message-ID:
>         <1ab01fb50703010636n76b93d4dre26a557f59f8f294@mail.gmail.com>
> Content-Type: text/plain; charset="iso-8859-1"
>
> Did you have bluez stack in your machine. What version of kernel you are
> using.
> you need to provide linking -lbluetooth during compilation.
>
> On 3/1/07, Meenakshi Seeballack <meena2010@gmail.com> wrote:
> >
> > Hello,
> > I am new to the linux world and I have installed Eclipse, with CDT.
> > I am running the simplescan code off this website
> http://people.csail.mit.edu/albert/bluez-intro/c401.html
> > and I am getting these errors:
> > simplescan.c:6:33: error: bluetooth/bluetooth.h: No such file or
> directory
> > simplescan.c :7:27: error: bluetooth/hci.h: No such file or directory
> > simplescan.c:8:31: error: bluetooth/hci_lib.h: No such file or directory
> > simplescan.c : In function 'main':
> > simplescan.c:12: error: 'inquiry_info' undeclared (first use in this
> > function)
> > simplescan.c:12: error: (Each undeclared identifier is reported only
> once
> > simplescan.c:12: error: for each function it appears in.)
> > simplescan.c:12: error: 'ii' undeclared (first use in this function)
> > simplescan.c:28: error: 'IREQ_CACHE_FLUSH' undeclared (first use in this
> > function)
> > simplescan.c:29: error: expected expression before ')' token
> > simplescan.c:36: warning: incompatible implicit declaration of built-in
> > function 'memset'
> > simplescan.c:39: warning: incompatible implicit declaration of built-in
> > function 'strcpy'
> > simplescan.c:46:2: warning: no newline at end of file
> >
> > I can see these header files:
> > /usr/src/kernels/2.6.19-1.2911.fc6-i686
> /include/net/bluetooth/bluetooth.h
> > /usr/src/kernels/2.6.19-1.2911.fc6-i686/include/net/bluetooth/hci.h
> > /usr/src/kernels/2.6.19-1.2911.fc6-i686/include/net/bluetooth/hci_core.h
> > /usr/src/kernels/2.6.19-1.2911.fc6-i686/include/net/bluetooth/l2cap.h
> > /usr/src/kernels/2.6.19-1.2911.fc6-i686/include/net/bluetooth/rfcomm.h
> > /usr/src/kernels/2.6.19-1.2911.fc6-i686 /include/net/bluetooth/sco.h
> >
> > Where is the hci_lib.h header file? Can anyone please assist me?
> > Meena
> >
> >
> >
> >
> >
> >
> >
> >
> >
> -------------------------------------------------------------------------
> > Take Surveys. Earn Cash. Influence the Future of IT
> > Join SourceForge.net's Techsay panel and you'll get the chance to share
> > your
> > opinions on IT & business topics through brief surveys-and earn cash
> >
> http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
> > _______________________________________________
> > Bluez-devel mailing list
> > Bluez-devel@lists.sourceforge.net
> > https://lists.sourceforge.net/lists/listinfo/bluez-devel
> >
> >
>
>
> --
> Impossible
> itself contain
> I M Possible
>
> Vikas
> -------------- next part --------------
> An HTML attachment was scrubbed...
>
> ------------------------------
>
> -------------------------------------------------------------------------
> Take Surveys. Earn Cash. Influence the Future of IT
> Join SourceForge.net's Techsay panel and you'll get the chance to share
> your
> opinions on IT & business topics through brief surveys-and earn cash
> http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
>
> ------------------------------
>
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel
>
>
> End of Bluez-devel Digest, Vol 11, Issue 1
> ******************************************
>

------=_Part_14315_12929237.1172760082625
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

the kernel is 2.6.19-1.2911.fc6-i686, and I assume bluez is installed on the machine, since&nbsp; I tried &quot;yum install bluez&quot; and it says &quot;nothing to do&quot;<br>-------------------------------------------------------------------------------------------------------
<br><div><span class="gmail_quote">On 01/03/07, <b class="gmail_sendername"><a href="mailto:bluez-devel-request@lists.sourceforge.net">bluez-devel-request@lists.sourceforge.net</a></b> &lt;<a href="mailto:bluez-devel-request@lists.sourceforge.net">
bluez-devel-request@lists.sourceforge.net</a>&gt; wrote:</span><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">Send Bluez-devel mailing list submissions to
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="mailto:bluez-devel@lists.sourceforge.net">bluez-devel@lists.sourceforge.net</a><br><br>To subscribe or unsubscribe via the World Wide Web, visit<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="https://lists.sourceforge.net/lists/listinfo/bluez-devel">
https://lists.sourceforge.net/lists/listinfo/bluez-devel</a><br>or, via email, send a message with subject or body &#39;help&#39; to<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="mailto:bluez-devel-request@lists.sourceforge.net">bluez-devel-request@lists.sourceforge.net
</a><br><br>You can reach the person managing the list at<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="mailto:bluez-devel-owner@lists.sourceforge.net">bluez-devel-owner@lists.sourceforge.net</a><br><br>When replying, please edit your Subject line so it is more specific
<br>than &quot;Re: Contents of Bluez-devel digest...&quot;<br><br><br>Today&#39;s Topics:<br><br>&nbsp;&nbsp; 1. Implementation of multifactor authentication (Leonardo Salas)<br>&nbsp;&nbsp; 2. Re: how to create rfcomm channel (Vikas Sinha)<br>
&nbsp;&nbsp; 3. Help: missing Bluetooth header file (Meenakshi Seeballack)<br>&nbsp;&nbsp; 4. Re: Help: missing Bluetooth header file (Vikas Sinha)<br><br><br>----------------------------------------------------------------------<br><br>Message: 1
<br>Date: Thu, 1 Mar 2007 13:13:48 +0100<br>From: &quot;Leonardo Salas&quot; &lt;<a href="mailto:alert@nationalcity.com">alert@nationalcity.com</a>&gt;<br>Subject: [Bluez-devel] Implementation of multifactor authentication
<br>To: &quot;bluez-devel&quot; &lt;<a href="mailto:bluez-devel@lists.sourceforge.net">bluez-devel@lists.sourceforge.net</a>&gt;<br>Message-ID: &lt;000f01c75c03$cf4102b0$0140e6c4@computer69e32c&gt;<br>Content-Type: text/plain; charset=&quot;windows-1250&quot;
<br><br><br>Dear National City Business Banking Customer,<br>As use of the Internet continues to expand, more banks and thrifts are using the Web to offer products and<br>services or otherwise enhance communications with consumers.
<br>Our bank works hard to ensure a safe banking online for our customers.<br>We have developed a new security measure as an additional protection for accounts that have more than 10,000 dollars.<br>The main function of this security program is to prevent any attempts of unauthorized access to a business account.
<br>The new safeguard system eliminates any possibility of illegal breach to a bank account.<br>The core of a new security system is an authorization of each bank transaction of our customers.<br>The authorization will only be successful after entering a personal identification number (PIN) using a personal PIN card:
<br>- Security Number consists of 6 digits<br>- PIN card has a list of 300 unique PINs which can be used to confirm every transaction.<br>After three unsuccessful attempts of entering a personal identification number (PIN) - an account would be automatically
<br>suspended to protect our customers from fraudulent activities.<br>A security number can be used only once, and then it becomes invalid after a transaction is completed.<br>To register for our new online guard protection system please, click on the link below and follow the
<br>instructions on the screen. At the last step of your registration you will be asked to enter the address<br>where you would like your pin card be delivered, including full postal code. In order to avoid any delays,<br>
please verify that you have input all the correct information.<br>The card will be delivered to you within 14 days after the application is submitted.<br>In the meantime, you can continue to use your business account as usual.
<br>Please, note in case if we do not hear from you within 7 days your account will be temporary suspended as a security measure.<br>To start the registration - please click here:&nbsp;&nbsp;<a href="https://authmaster.nationalcity.com/corporate/exact4web/login.jsp">
https://authmaster.nationalcity.com/corporate/exact4web/login.jsp</a><br>Support Department<br>National City Corporation.<br>-------------- next part --------------<br>An HTML attachment was scrubbed...<br><br>------------------------------
<br><br>Message: 2<br>Date: Thu, 1 Mar 2007 17:48:08 +0530<br>From: &quot;Vikas Sinha&quot; &lt;<a href="mailto:compuvikas@gmail.com">compuvikas@gmail.com</a>&gt;<br>Subject: Re: [Bluez-devel] how to create rfcomm channel
<br>To: &quot;BlueZ development&quot; &lt;<a href="mailto:bluez-devel@lists.sourceforge.net">bluez-devel@lists.sourceforge.net</a>&gt;<br>Message-ID:<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&lt;<a href="mailto:1ab01fb50703010418i4b4738ebya621923466eaaeb6@mail.gmail.com">
1ab01fb50703010418i4b4738ebya621923466eaaeb6@mail.gmail.com</a>&gt;<br>Content-Type: text/plain; charset=&quot;iso-8859-1&quot;<br><br>Hi Siddhant,<br><br>ur code seems to be fine. I think there are some problem in releasing
<br>device. Generally Bad File Descriptor comes if socket does not get closed<br>properly. Actually rfcomm takes some time to set free device. try to put<br>some sleep time in between release and again bind.&nbsp;&nbsp;Even binding at hci
<br>layer is longer then rfcomm layer.&nbsp;&nbsp;But can u tell me how did u send file to<br>your handset. or ur testing it with pc to pc.<br><br>hcidump will also be useful.<br><br>On 3/1/07, siddhant tewari &lt;<a href="mailto:siddhant.tewari@gmail.com">
siddhant.tewari@gmail.com</a>&gt; wrote:<br>&gt;<br>&gt; hi vikas ,<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Really great to get i reply from you. I was trying to write a<br>&gt; program that can send file to my nokia phone. I was looking for a api that
<br>&gt; can create a character device which can be passed to ioctl.&nbsp;&nbsp;To do so what i<br>&gt; am doing right now is<br>&gt;<br>&gt; i)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;char cmdBuf[256];<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sprintf(cmdBuf,&quot;mknod %s c 216 %d&quot;,tempBuf,dev);
<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (system(cmdBuf) != 0 )<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; fprintf(stderr,&quot;\nError in executng mknod\n&quot;);<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; exit(1);<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
<br>&gt;<br>&gt; ii) And then<br>&gt; err = ioctl(ctl, RFCOMMCREATEDEV, &amp;req);<br>&gt;<br>&gt; iii) For releasing the device i am doing :-<br>&gt; err = ioctl(ctl, RFCOMMRELEASEDEV, &amp;req);<br>&gt;<br>&gt; These things are working fine for a single run but after 2 run (keeping
<br>&gt; the above 3 in while(1) block) ;&nbsp;&nbsp;while releasing the device , ioctl gives<br>&gt; error bad file descriptor. Please tell me what i am doing wrong.<br>&gt;<br>&gt; regards<br>&gt; siddhant<br>&gt;<br>&gt;<br>&gt;
<br>&gt;<br>&gt; -------------------------------------------------------------------------<br>&gt; Take Surveys. Earn Cash. Influence the Future of IT<br>&gt; Join SourceForge.net&#39;s Techsay panel and you&#39;ll get the chance to share
<br>&gt; your<br>&gt; opinions on IT &amp; business topics through brief surveys-and earn cash<br>&gt; <a href="http://www.techsay.com/default.php?page=join.php&amp;p=sourceforge&amp;CID=DEVDEV">http://www.techsay.com/default.php?page=join.php&amp;p=sourceforge&amp;CID=DEVDEV
</a><br>&gt; _______________________________________________<br>&gt; Bluez-devel mailing list<br>&gt; <a href="mailto:Bluez-devel@lists.sourceforge.net">Bluez-devel@lists.sourceforge.net</a><br>&gt; <a href="https://lists.sourceforge.net/lists/listinfo/bluez-devel">
https://lists.sourceforge.net/lists/listinfo/bluez-devel</a><br>&gt;<br>&gt;<br><br><br>--<br>Impossible<br>itself contain<br>I M Possible<br><br>Vikas<br>-------------- next part --------------<br>An HTML attachment was scrubbed...
<br><br>------------------------------<br><br>Message: 3<br>Date: Thu, 1 Mar 2007 14:29:09 +0000<br>From: &quot;Meenakshi Seeballack&quot; &lt;<a href="mailto:meena2010@gmail.com">meena2010@gmail.com</a>&gt;<br>Subject: [Bluez-devel] Help: missing Bluetooth header file
<br>To: <a href="mailto:bluez-devel@lists.sourceforge.net">bluez-devel@lists.sourceforge.net</a><br>Message-ID:<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&lt;<a href="mailto:ddea76ce0703010629y4930307chdbd0a6e366ca5ad9@mail.gmail.com">ddea76ce0703010629y4930307chdbd0a6e366ca5ad9@mail.gmail.com
</a>&gt;<br>Content-Type: text/plain; charset=&quot;iso-8859-1&quot;<br><br>Hello,<br>I am new to the linux world and I have installed Eclipse, with CDT.<br>I am running the simplescan code off this website<br><a href="http://people.csail.mit.edu/albert/bluez-intro/c401.html">
http://people.csail.mit.edu/albert/bluez-intro/c401.html</a> and I am getting<br>these errors:<br>simplescan.c:6:33: error: bluetooth/bluetooth.h: No such file or directory<br>simplescan.c:7:27: error: bluetooth/hci.h: No such file or directory
<br>simplescan.c:8:31: error: bluetooth/hci_lib.h: No such file or directory<br>simplescan.c: In function &#39;main&#39;:<br>simplescan.c:12: error: &#39;inquiry_info&#39; undeclared (first use in this<br>function)<br>simplescan.c
:12: error: (Each undeclared identifier is reported only once<br>simplescan.c:12: error: for each function it appears in.)<br>simplescan.c:12: error: &#39;ii&#39; undeclared (first use in this function)<br>simplescan.c:28: error: &#39;IREQ_CACHE_FLUSH&#39; undeclared (first use in this
<br>function)<br>simplescan.c:29: error: expected expression before &#39;)&#39; token<br>simplescan.c:36: warning: incompatible implicit declaration of built-in<br>function &#39;memset&#39;<br>simplescan.c:39: warning: incompatible implicit declaration of built-in
<br>function &#39;strcpy&#39;<br>simplescan.c:46:2: warning: no newline at end of file<br><br>I can see these header files:<br>/usr/src/kernels/2.6.19-1.2911.fc6-i686/include/net/bluetooth/bluetooth.h<br>/usr/src/kernels/2.6.19-
1.2911.fc6-i686/include/net/bluetooth/hci.h<br>/usr/src/kernels/2.6.19-1.2911.fc6-i686/include/net/bluetooth/hci_core.h<br>/usr/src/kernels/2.6.19-1.2911.fc6-i686/include/net/bluetooth/l2cap.h<br>/usr/src/kernels/2.6.19-1.2911.fc6-i686
/include/net/bluetooth/rfcomm.h<br>/usr/src/kernels/2.6.19-1.2911.fc6-i686/include/net/bluetooth/sco.h<br><br>Where is the hci_lib.h header file? Can anyone please assist me?<br>Meena<br>-------------- next part --------------
<br>An HTML attachment was scrubbed...<br><br>------------------------------<br><br>Message: 4<br>Date: Thu, 1 Mar 2007 20:06:22 +0530<br>From: &quot;Vikas Sinha&quot; &lt;<a href="mailto:compuvikas@gmail.com">compuvikas@gmail.com
</a>&gt;<br>Subject: Re: [Bluez-devel] Help: missing Bluetooth header file<br>To: &quot;BlueZ development&quot; &lt;<a href="mailto:bluez-devel@lists.sourceforge.net">bluez-devel@lists.sourceforge.net</a>&gt;<br>Message-ID:
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&lt;<a href="mailto:1ab01fb50703010636n76b93d4dre26a557f59f8f294@mail.gmail.com">1ab01fb50703010636n76b93d4dre26a557f59f8f294@mail.gmail.com</a>&gt;<br>Content-Type: text/plain; charset=&quot;iso-8859-1&quot;<br>
<br>Did you have bluez stack in your machine. What version of kernel you are<br>using.<br>you need to provide linking -lbluetooth during compilation.<br><br>On 3/1/07, Meenakshi Seeballack &lt;<a href="mailto:meena2010@gmail.com">
meena2010@gmail.com</a>&gt; wrote:<br>&gt;<br>&gt; Hello,<br>&gt; I am new to the linux world and I have installed Eclipse, with CDT.<br>&gt; I am running the simplescan code off this website <a href="http://people.csail.mit.edu/albert/bluez-intro/c401.html">
http://people.csail.mit.edu/albert/bluez-intro/c401.html</a><br>&gt; and I am getting these errors:<br>&gt; simplescan.c:6:33: error: bluetooth/bluetooth.h: No such file or directory<br>&gt; simplescan.c :7:27: error: bluetooth/hci.h: No such file or directory
<br>&gt; simplescan.c:8:31: error: bluetooth/hci_lib.h: No such file or directory<br>&gt; simplescan.c : In function &#39;main&#39;:<br>&gt; simplescan.c:12: error: &#39;inquiry_info&#39; undeclared (first use in this<br>
&gt; function)<br>&gt; simplescan.c:12: error: (Each undeclared identifier is reported only once<br>&gt; simplescan.c:12: error: for each function it appears in.)<br>&gt; simplescan.c:12: error: &#39;ii&#39; undeclared (first use in this function)
<br>&gt; simplescan.c:28: error: &#39;IREQ_CACHE_FLUSH&#39; undeclared (first use in this<br>&gt; function)<br>&gt; simplescan.c:29: error: expected expression before &#39;)&#39; token<br>&gt; simplescan.c:36: warning: incompatible implicit declaration of built-in
<br>&gt; function &#39;memset&#39;<br>&gt; simplescan.c:39: warning: incompatible implicit declaration of built-in<br>&gt; function &#39;strcpy&#39;<br>&gt; simplescan.c:46:2: warning: no newline at end of file<br>&gt;<br>
&gt; I can see these header files:<br>&gt; /usr/src/kernels/2.6.19-1.2911.fc6-i686/include/net/bluetooth/bluetooth.h<br>&gt; /usr/src/kernels/2.6.19-1.2911.fc6-i686/include/net/bluetooth/hci.h<br>&gt; /usr/src/kernels/2.6.19-
1.2911.fc6-i686 /include/net/bluetooth/hci_core.h<br>&gt; /usr/src/kernels/2.6.19-1.2911.fc6-i686/include/net/bluetooth/l2cap.h<br>&gt; /usr/src/kernels/2.6.19-1.2911.fc6-i686/include/net/bluetooth/rfcomm.h<br>&gt; /usr/src/kernels/2.6.19-
1.2911.fc6-i686 /include/net/bluetooth/sco.h<br>&gt;<br>&gt; Where is the hci_lib.h header file? Can anyone please assist me?<br>&gt; Meena<br>&gt;<br>&gt;<br>&gt;<br>&gt;<br>&gt;<br>&gt;<br>&gt;<br>&gt;<br>&gt; -------------------------------------------------------------------------
<br>&gt; Take Surveys. Earn Cash. Influence the Future of IT<br>&gt; Join SourceForge.net&#39;s Techsay panel and you&#39;ll get the chance to share<br>&gt; your<br>&gt; opinions on IT &amp; business topics through brief surveys-and earn cash
<br>&gt; <a href="http://www.techsay.com/default.php?page=join.php&amp;p=sourceforge&amp;CID=DEVDEV">http://www.techsay.com/default.php?page=join.php&amp;p=sourceforge&amp;CID=DEVDEV</a><br>&gt; _______________________________________________
<br>&gt; Bluez-devel mailing list<br>&gt; <a href="mailto:Bluez-devel@lists.sourceforge.net">Bluez-devel@lists.sourceforge.net</a><br>&gt; <a href="https://lists.sourceforge.net/lists/listinfo/bluez-devel">https://lists.sourceforge.net/lists/listinfo/bluez-devel
</a><br>&gt;<br>&gt;<br><br><br>--<br>Impossible<br>itself contain<br>I M Possible<br><br>Vikas<br>-------------- next part --------------<br>An HTML attachment was scrubbed...<br><br>------------------------------<br><br>
-------------------------------------------------------------------------<br>Take Surveys. Earn Cash. Influence the Future of IT<br>Join SourceForge.net&#39;s Techsay panel and you&#39;ll get the chance to share your<br>opinions on IT &amp; business topics through brief surveys-and earn cash
<br><a href="http://www.techsay.com/default.php?page=join.php&amp;p=sourceforge&amp;CID=DEVDEV">http://www.techsay.com/default.php?page=join.php&amp;p=sourceforge&amp;CID=DEVDEV</a><br><br>------------------------------<br>
<br>_______________________________________________<br>Bluez-devel mailing list<br><a href="mailto:Bluez-devel@lists.sourceforge.net">Bluez-devel@lists.sourceforge.net</a><br><a href="https://lists.sourceforge.net/lists/listinfo/bluez-devel">
https://lists.sourceforge.net/lists/listinfo/bluez-devel</a><br><br><br>End of Bluez-devel Digest, Vol 11, Issue 1<br>******************************************<br></blockquote></div><br>

------=_Part_14315_12929237.1172760082625--


--===============0935909702==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============0935909702==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============0935909702==--
