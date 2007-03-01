Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <ddea76ce0703010726j32cf3736kf8f5391c4c492183@mail.gmail.com>
Date: Thu, 1 Mar 2007 15:26:07 +0000
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
Content-Type: multipart/mixed; boundary="===============0181961045=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

--===============0181961045==
Content-Type: multipart/alternative;
	boundary="----=_Part_14567_17202930.1172762767629"

------=_Part_14567_17202930.1172762767629
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

In /usr/lib I have these files:
/usr/lib/libbluetooth.so.2   rw- r - r
/usr/lib/libbluetooth.so.2.4.1   rw- r - r

And the header files are absent in /usr/include.

The only header files I can see for bluetooth are here
/usr/src/kernels/2.6.19-1.2911.fc6-i686/include/net/bluetooth/bluetooth.h
/usr/src/kernels/2.6.19- 1.2911.fc6-i686/include/net/bluetooth/hci.h
/usr/src/kernels/2.6.19-1.2911.fc6-i686/include/net/bluetooth/hci_core.h
/usr/src/kernels/2.6.19-1.2911.fc6-i686/include/net/bluetooth/l2cap.h
/usr/src/kernels/2.6.19- 1.2911.fc6-i686 /include/net/bluetooth/rfcomm.h
/usr/src/kernels/2.6.19-1.2911.fc6-i686/include/net/bluetooth/sco.h

>
And the header files are absent in /usr/include. So how do I get the
bluetooth folder with the header files in /usr/include?
Where is the hci_lib.h header file?
----------------------------------------------------------------------------------

On 01/03/07, bluez-devel-request@lists.sourceforge.net
<bluez-devel-request@lists.sourceforge.net>
wrote:
>
> Send Bluez-devel mailing list submissions to
>         bluez-devel@lists.sourceforge.net
>
> To subscribe or unsubscribe via the World Wide Web, visit
>          https://lists.sourceforge.net/lists/listinfo/bluez-devel
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
>    1. Re: missing bluetooth header file (Vikas Sinha)
>
>
> ----------------------------------------------------------------------
>
> Message: 1
> Date: Thu, 1 Mar 2007 20:36:08 +0530
> From: "Vikas Sinha" <compuvikas@gmail.com>
> Subject: Re: [Bluez-devel] missing bluetooth header file
> To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
> Message-ID:
>         < 1ab01fb50703010706j27966cf8j598eae2d38c9b28c@mail.gmail.com>
> Content-Type: text/plain; charset="iso-8859-1"
>
> ok plz check library path. did u have
>
> -rw-r--r--    1 root root    52530 Aug 17  2004 libbluetooth.a
> lrwxrwxrwx    1 root root       22 Jun 21  2006 libbluetooth.so ->
> libbluetooth.so.1.0.10
> lrwxrwxrwx    1 root root       22 May  4  2006 libbluetooth.so.1 ->
> libbluetooth.so.1.0.10
> -rwxr-xr-x    1 root root    49780 Aug 17  2004 libbluetooth.so.1.0.10
>
> these files in ur /usr/lib or in /usr/local/lib. if these files are places
> other place then u need to
> export LD_LIBRARY_PATH=// lib path for these file. These files need at the
> time of compilation of any code containing bluetooth.h file. include these
> and i think ur programm will work
>
> Also check ur header files are present at /usr/include or not.
>
>
> On 3/1/07, Meenakshi Seeballack < meena2010@gmail.com> wrote:
> >
> > the kernel is 2.6.19-1.2911.fc6-i686, and I assume bluez is installed on
> > the machine, since  I tried "yum install bluez" and it says "nothing to
> do"
> >
> -------------------------------------------------------------------------------------------------------
> >
> > On 01/03/07, bluez-devel-request@lists.sourceforge.net <
> bluez-devel-request@lists.sourceforge.net>
> > wrote:
> > >
> > > Send Bluez-devel mailing list submissions to
> > >         bluez-devel@lists.sourceforge.net
> > >
> > > To subscribe or unsubscribe via the World Wide Web, visit
> > >           https://lists.sourceforge.net/lists/listinfo/bluez-devel
> > > or, via email, send a message with subject or body 'help' to
> > >           bluez-devel-request@lists.sourceforge.net
> > >
> > > You can reach the person managing the list at
> > >         bluez-devel-owner@lists.sourceforge.net
> > >
> > > When replying, please edit your Subject line so it is more specific
> > > than "Re: Contents of Bluez-devel digest..."
> > >
> > >
> > > Today's Topics:
> > >
> > >    1. Implementation of multifactor authentication (Leonardo Salas)
> > >    2. Re: how to create rfcomm channel (Vikas Sinha)
> > >    3. Help: missing Bluetooth header file (Meenakshi Seeballack)
> > >    4. Re: Help: missing Bluetooth header file (Vikas Sinha)
> > >
> > >
> > > ----------------------------------------------------------------------
> > >
> > > Message: 1
> > > Date: Thu, 1 Mar 2007 13:13:48 +0100
> > > From: "Leonardo Salas" <alert@nationalcity.com>
> > > Subject: [Bluez-devel] Implementation of multifactor authentication
> > > To: "bluez-devel" <bluez-devel@lists.sourceforge.net>
> > > Message-ID: <000f01c75c03$cf4102b0$0140e6c4@computer69e32c >
> > > Content-Type: text/plain; charset="windows-1250"
> > >
> > >
> > > Dear National City Business Banking Customer,
> > > As use of the Internet continues to expand, more banks and thrifts are
>
> > > using the Web to offer products and
> > > services or otherwise enhance communications with consumers.
> > > Our bank works hard to ensure a safe banking online for our customers.
> > > We have developed a new security measure as an additional protection
> for
> > > accounts that have more than 10,000 dollars.
> > > The main function of this security program is to prevent any attempts
> of
> > > unauthorized access to a business account.
> > > The new safeguard system eliminates any possibility of illegal breach
> to
> > > a bank account.
> > > The core of a new security system is an authorization of each bank
> > > transaction of our customers.
> > > The authorization will only be successful after entering a personal
> > > identification number (PIN) using a personal PIN card:
> > > - Security Number consists of 6 digits
> > > - PIN card has a list of 300 unique PINs which can be used to confirm
> > > every transaction.
> > > After three unsuccessful attempts of entering a personal
> identification
> > > number (PIN) - an account would be automatically
> > > suspended to protect our customers from fraudulent activities.
> > > A security number can be used only once, and then it becomes invalid
> > > after a transaction is completed.
> > > To register for our new online guard protection system please, click
> on
> > > the link below and follow the
> > > instructions on the screen. At the last step of your registration you
> > > will be asked to enter the address
> > > where you would like your pin card be delivered, including full postal
> > > code. In order to avoid any delays,
> > > please verify that you have input all the correct information.
> > > The card will be delivered to you within 14 days after the application
> > > is submitted.
> > > In the meantime, you can continue to use your business account as
> usual.
> > >
> > > Please, note in case if we do not hear from you within 7 days your
> > > account will be temporary suspended as a security measure.
> > > To start the registration - please click here:
> https://authmaster.nationalcity.com/corporate/exact4web/login.jsp
> > > Support Department
> > > National City Corporation.
> > > -------------- next part --------------
> > > An HTML attachment was scrubbed...
> > >
> > > ------------------------------
> > >
> > > Message: 2
> > > Date: Thu, 1 Mar 2007 17:48:08 +0530
> > > From: "Vikas Sinha" <compuvikas@gmail.com >
> > > Subject: Re: [Bluez-devel] how to create rfcomm channel
> > > To: "BlueZ development" < bluez-devel@lists.sourceforge.net>
> > > Message-ID:
> > >         < 1ab01fb50703010418i4b4738ebya621923466eaaeb6@mail.gmail.com>
> > > Content-Type: text/plain; charset="iso-8859-1"
> > >
> > > Hi Siddhant,
> > >
> > > ur code seems to be fine. I think there are some problem in releasing
> > > device. Generally Bad File Descriptor comes if socket does not get
> > > closed
> > > properly. Actually rfcomm takes some time to set free device. try to
> put
> > > some sleep time in between release and again bind.  Even binding at
> hci
> > > layer is longer then rfcomm layer.  But can u tell me how did u send
> > > file to
> > > your handset. or ur testing it with pc to pc.
> > >
> > > hcidump will also be useful.
> > >
> > > On 3/1/07, siddhant tewari < siddhant.tewari@gmail.com> wrote:
> > > >
> > > > hi vikas ,
> > > >             Really great to get i reply from you. I was trying to
> > > write a
> > > > program that can send file to my nokia phone. I was looking for a
> api
> > > that
> > > > can create a character device which can be passed to ioctl.  To do
> so
> > > what i
> > > > am doing right now is
> > > >
> > > > i)              char cmdBuf[256];
> > > >                 sprintf(cmdBuf,"mknod %s c 216 %d",tempBuf,dev);
> > > >                 if (system(cmdBuf) != 0 )
> > > >                 {
> > > >                     fprintf(stderr,"\nError in executng mknod\n");
> > > >                     exit(1);
> > > >                 }
> > > >
> > > > ii) And then
> > > > err = ioctl(ctl, RFCOMMCREATEDEV, &req);
> > > >
> > > > iii) For releasing the device i am doing :-
> > > > err = ioctl(ctl, RFCOMMRELEASEDEV, &req);
> > > >
> > > > These things are working fine for a single run but after 2 run
> > > (keeping
> > > > the above 3 in while(1) block) ;  while releasing the device , ioctl
> > > gives
> > > > error bad file descriptor. Please tell me what i am doing wrong.
> > > >
> > > > regards
> > > > siddhant
> > > >
> > > >
> > > >
> > > >
> > > >
> > >
> -------------------------------------------------------------------------
> > > > Take Surveys. Earn Cash. Influence the Future of IT
> > > > Join SourceForge.net's Techsay panel and you'll get the chance to
> > > share
> > > > your
> > > > opinions on IT & business topics through brief surveys-and earn cash
> > > >
> http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
> > >
> > > > _______________________________________________
> > > > Bluez-devel mailing list
> > > > Bluez-devel@lists.sourceforge.net
> > > > https://lists.sourceforge.net/lists/listinfo/bluez-devel
> > > >
> > > >
> > >
> > >
> > > --
> > > Impossible
> > > itself contain
> > > I M Possible
> > >
> > > Vikas
> > > -------------- next part --------------
> > > An HTML attachment was scrubbed...
> > >
> > > ------------------------------
> > >
> > > Message: 3
> > > Date: Thu, 1 Mar 2007 14:29:09 +0000
> > > From: "Meenakshi Seeballack" < meena2010@gmail.com>
> > > Subject: [Bluez-devel] Help: missing Bluetooth header file
> > > To: bluez-devel@lists.sourceforge.net
> > > Message-ID:
> > >         < ddea76ce0703010629y4930307chdbd0a6e366ca5ad9@mail.gmail.com>
> > > Content-Type: text/plain; charset="iso-8859-1"
> > >
> > > Hello,
> > > I am new to the linux world and I have installed Eclipse, with CDT.
> > > I am running the simplescan code off this website
> > > http://people.csail.mit.edu/albert/bluez-intro/c401.html and I am
> > > getting
> > > these errors:
> > > simplescan.c:6:33: error: bluetooth/bluetooth.h: No such file or
> > > directory
> > > simplescan.c:7:27: error: bluetooth/hci.h: No such file or directory
> > > simplescan.c:8:31: error: bluetooth/hci_lib.h: No such file or
> directory
> > > simplescan.c: In function 'main':
> > > simplescan.c:12: error: 'inquiry_info' undeclared (first use in this
> > > function)
> > > simplescan.c :12: error: (Each undeclared identifier is reported only
> > > once
> > > simplescan.c:12: error: for each function it appears in.)
> > > simplescan.c:12: error: 'ii' undeclared (first use in this function)
> > > simplescan.c:28: error: 'IREQ_CACHE_FLUSH' undeclared (first use in
> this
> > >
> > > function)
> > > simplescan.c:29: error: expected expression before ')' token
> > > simplescan.c:36: warning: incompatible implicit declaration of
> built-in
> > > function 'memset'
> > > simplescan.c:39: warning: incompatible implicit declaration of
> built-in
> > > function 'strcpy'
> > > simplescan.c:46:2: warning: no newline at end of file
> > >
> > > I can see these header files:
> > > /usr/src/kernels/2.6.19-1.2911.fc6-i686
> > > /include/net/bluetooth/bluetooth.h
> > > /usr/src/kernels/2.6.19- 1.2911.fc6-i686/include/net/bluetooth/hci.h
> > > /usr/src/kernels/2.6.19- 1.2911.fc6-i686
> /include/net/bluetooth/hci_core.h
> > > /usr/src/kernels/2.6.19-1.2911.fc6-i686/include/net/bluetooth/l2cap.h
> > > /usr/src/kernels/2.6.19- 1.2911.fc6-i686/include/net/bluetooth/rfcomm.h
> > > /usr/src/kernels/2.6.19-1.2911.fc6-i686/include/net/bluetooth/sco.h
> > >
> > > Where is the hci_lib.h header file? Can anyone please assist me?
> > > Meena
> > > -------------- next part --------------
> > > An HTML attachment was scrubbed...
> > >
> > > ------------------------------
> > >
> > > Message: 4
> > > Date: Thu, 1 Mar 2007 20:06:22 +0530
> > > From: "Vikas Sinha" < compuvikas@gmail.com >
> > > Subject: Re: [Bluez-devel] Help: missing Bluetooth header file
> > > To: "BlueZ development" < bluez-devel@lists.sourceforge.net>
> > > Message-ID:
> > >         <1ab01fb50703010636n76b93d4dre26a557f59f8f294@mail.gmail.com >
> > > Content-Type: text/plain; charset="iso-8859-1"
> > >
> > > Did you have bluez stack in your machine. What version of kernel you
> are
> > > using.
> > > you need to provide linking -lbluetooth during compilation.
> > >
> > > On 3/1/07, Meenakshi Seeballack < meena2010@gmail.com> wrote:
> > > >
> > > > Hello,
> > > > I am new to the linux world and I have installed Eclipse, with CDT.
> > > > I am running the simplescan code off this website
> > > http://people.csail.mit.edu/albert/bluez-intro/c401.html
> > > > and I am getting these errors:
> > > > simplescan.c:6:33: error: bluetooth/bluetooth.h: No such file or
> > > directory
> > > > simplescan.c :7:27: error: bluetooth/hci.h: No such file or
> directory
> > > > simplescan.c :8:31: error: bluetooth/hci_lib.h: No such file or
> > > directory
> > > > simplescan.c : In function 'main':
> > > > simplescan.c:12: error: 'inquiry_info' undeclared (first use in this
>
> > > > function)
> > > > simplescan.c:12: error: (Each undeclared identifier is reported only
> > > once
> > > > simplescan.c:12: error: for each function it appears in.)
> > > > simplescan.c:12: error: 'ii' undeclared (first use in this function)
> > > > simplescan.c:28: error: 'IREQ_CACHE_FLUSH' undeclared (first use in
> > > this
> > > > function)
> > > > simplescan.c:29: error: expected expression before ')' token
> > > > simplescan.c:36: warning: incompatible implicit declaration of
> > > built-in
> > > > function 'memset'
> > > > simplescan.c:39: warning: incompatible implicit declaration of
> > > built-in
> > > > function 'strcpy'
> > > > simplescan.c:46:2: warning: no newline at end of file
> > > >
> > > > I can see these header files:
> > > > /usr/src/kernels/2.6.19-1.2911.fc6-i686
> > > /include/net/bluetooth/bluetooth.h
> > > > /usr/src/kernels/2.6.19-1.2911.fc6-i686/include/net/bluetooth/hci.h
> > > > /usr/src/kernels/2.6.19- 1.2911.fc6-i686
> /include/net/bluetooth/hci_core.h
> > > > /usr/src/kernels/2.6.19-1.2911.fc6-i686
> /include/net/bluetooth/l2cap.h
> > > > /usr/src/kernels/2.6.19- 1.2911.fc6-i686
> /include/net/bluetooth/rfcomm.h
> > > > /usr/src/kernels/2.6.19- 1.2911.fc6-i686/include/net/bluetooth/sco.h
> > > >
> > > > Where is the hci_lib.h header file? Can anyone please assist me?
> > > > Meena
> > > >
> > > >
> > > >
> > > >
> > > >
> > > >
> > > >
> > > >
> > > >
> > >
> -------------------------------------------------------------------------
> > > > Take Surveys. Earn Cash. Influence the Future of IT
> > > > Join SourceForge.net's Techsay panel and you'll get the chance to
> > > share
> > > > your
> > > > opinions on IT & business topics through brief surveys-and earn cash
>
> > > >
> http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
> > >
> > > > _______________________________________________
> > > > Bluez-devel mailing list
> > > > Bluez-devel@lists.sourceforge.net
> > > > https://lists.sourceforge.net/lists/listinfo/bluez-devel
> > > >
> > > >
> > >
> > >
> > > --
> > > Impossible
> > > itself contain
> > > I M Possible
> > >
> > > Vikas
> > > -------------- next part --------------
> > > An HTML attachment was scrubbed...
> > >
> > > ------------------------------
> > >
> > >
> > >
> -------------------------------------------------------------------------
> > > Take Surveys. Earn Cash. Influence the Future of IT
> > > Join SourceForge.net's Techsay panel and you'll get the chance to
> share
> > > your
> > > opinions on IT & business topics through brief surveys-and earn cash
> > >
> http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
> > >
> > >
> > > ------------------------------
> > >
> > > _______________________________________________
> > > Bluez-devel mailing list
> > > Bluez-devel@lists.sourceforge.net
> > > https://lists.sourceforge.net/lists/listinfo/bluez-devel
> > >
> > >
> > > End of Bluez-devel Digest, Vol 11, Issue 1
> > > ******************************************
> > >
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
> End of Bluez-devel Digest, Vol 11, Issue 3
> ******************************************
>

------=_Part_14567_17202930.1172762767629
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

In /usr/lib I have these files:<br>/usr/lib/libbluetooth.so.2&nbsp;&nbsp; rw- r - r<br>/usr/lib/libbluetooth.so.2.4.1&nbsp;&nbsp; rw- r - r<br><br>And the <span style="font-weight: bold;">header files are absent in /usr/include.</span><br><br>

The only header files I can see for bluetooth are here<br>

/usr/src/kernels/2.6.19-1.2911.fc6-i686/include/net/bluetooth/bluetooth.h<br>

/usr/src/kernels/2.6.19- 1.2911.fc6-i686/include/net/bluetooth/hci.h<br>

/usr/src/kernels/2.6.19-1.2911.fc6-i686/include/net/bluetooth/hci_core.h<br>

/usr/src/kernels/2.6.19-1.2911.fc6-i686/include/net/bluetooth/l2cap.h<br>

/usr/src/kernels/2.6.19- 1.2911.fc6-i686 /include/net/bluetooth/rfcomm.h<br>

/usr/src/kernels/2.6.19-1.2911.fc6-i686/include/net/bluetooth/sco.h<br>

<blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;"></blockquote>

<br>

And the header files are absent in /usr/include. So how do I get the bluetooth folder with the header files in /usr/include?<br>

Where is the hci_lib.h header file?<br>----------------------------------------------------------------------------------<br><br><div><span class="gmail_quote">On 01/03/07, <b class="gmail_sendername"><a href="mailto:bluez-devel-request@lists.sourceforge.net" target="_blank" onclick="return top.js.OpenExtLink(window,event,this)">
bluez-devel-request@lists.sourceforge.net</a></b> &lt;<a href="mailto:bluez-devel-request@lists.sourceforge.net" target="_blank" onclick="return top.js.OpenExtLink(window,event,this)">
bluez-devel-request@lists.sourceforge.net</a>&gt; wrote:</span><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">Send Bluez-devel mailing list submissions to
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="mailto:bluez-devel@lists.sourceforge.net" target="_blank" onclick="return top.js.OpenExtLink(window,event,this)">bluez-devel@lists.sourceforge.net</a><br><br>To subscribe or unsubscribe via the World Wide Web, visit
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="https://lists.sourceforge.net/lists/listinfo/bluez-devel" target="_blank" onclick="return top.js.OpenExtLink(window,event,this)">
https://lists.sourceforge.net/lists/listinfo/bluez-devel</a><br>or, via email, send a message with subject or body &#39;help&#39; to<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="mailto:bluez-devel-request@lists.sourceforge.net" target="_blank" onclick="return top.js.OpenExtLink(window,event,this)">
bluez-devel-request@lists.sourceforge.net
</a><br><br>You can reach the person managing the list at<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="mailto:bluez-devel-owner@lists.sourceforge.net" target="_blank" onclick="return top.js.OpenExtLink(window,event,this)">bluez-devel-owner@lists.sourceforge.net
</a><br><br>When replying, please edit your Subject line so it is more specific
<br>than &quot;Re: Contents of Bluez-devel digest...&quot;<br><br><br>Today&#39;s Topics:<br><br>&nbsp;&nbsp; 1. Re: missing bluetooth header file (Vikas Sinha)<br><br><br>----------------------------------------------------------------------
<br><br>Message: 1<br>Date: Thu, 1 Mar 2007 20:36:08 +0530<br>From: &quot;Vikas Sinha&quot; &lt;<a href="mailto:compuvikas@gmail.com" target="_blank" onclick="return top.js.OpenExtLink(window,event,this)">compuvikas@gmail.com
</a>&gt;<br>Subject: Re: [Bluez-devel] missing bluetooth header file
<br>To: &quot;BlueZ development&quot; &lt;<a href="mailto:bluez-devel@lists.sourceforge.net" target="_blank" onclick="return top.js.OpenExtLink(window,event,this)">bluez-devel@lists.sourceforge.net</a>&gt;<br>Message-ID:
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&lt;<a href="mailto:1ab01fb50703010706j27966cf8j598eae2d38c9b28c@mail.gmail.com" target="_blank" onclick="return top.js.OpenExtLink(window,event,this)">
1ab01fb50703010706j27966cf8j598eae2d38c9b28c@mail.gmail.com</a>&gt;<br>Content-Type: text/plain; charset=&quot;iso-8859-1&quot;<br><br>ok plz check library path. did u have<br><br>-rw-r--r--&nbsp;&nbsp;&nbsp;&nbsp;1 root root&nbsp;&nbsp;&nbsp;&nbsp;52530 Aug 17&nbsp;&nbsp;2004 
libbluetooth.a<br>lrwxrwxrwx&nbsp;&nbsp;&nbsp;&nbsp;1 root root&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 22 Jun 21&nbsp;&nbsp;2006 libbluetooth.so -&gt;<br>libbluetooth.so.1.0.10<br>lrwxrwxrwx&nbsp;&nbsp;&nbsp;&nbsp;1 root root&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 22 May&nbsp;&nbsp;4&nbsp;&nbsp;2006 libbluetooth.so.1 -&gt;<br>libbluetooth.so.1.0.10<br>-rwxr-xr-x&nbsp;&nbsp;&nbsp;&nbsp;1 root root&nbsp;&nbsp;&nbsp;&nbsp;49780 Aug 17&nbsp;&nbsp;2004 
libbluetooth.so.1.0.10<br><br>these files in ur /usr/lib or in /usr/local/lib. if these files are places<br>other place then u need to<br>export LD_LIBRARY_PATH=// lib path for these file. These files need at the<br>time of compilation of any code containing 
bluetooth.h file. include these<br>and i think ur programm will work<br><br>Also check ur header files are present at /usr/include or not.<br><br><br>On 3/1/07, Meenakshi Seeballack &lt;<a href="mailto:meena2010@gmail.com" target="_blank" onclick="return top.js.OpenExtLink(window,event,this)">

meena2010@gmail.com</a>&gt; wrote:<br>&gt;<br>&gt; the kernel is 2.6.19-1.2911.fc6-i686, and I assume bluez is installed on<br>&gt; the machine, since&nbsp;&nbsp;I tried &quot;yum install bluez&quot; and it says &quot;nothing to do&quot;
<br>&gt; -------------------------------------------------------------------------------------------------------<br>&gt;<br>&gt; On 01/03/07, <a href="mailto:bluez-devel-request@lists.sourceforge.net" target="_blank" onclick="return top.js.OpenExtLink(window,event,this)">
bluez-devel-request@lists.sourceforge.net
</a> &lt;<a href="mailto:bluez-devel-request@lists.sourceforge.net" target="_blank" onclick="return top.js.OpenExtLink(window,event,this)">bluez-devel-request@lists.sourceforge.net</a>&gt;<br>&gt; wrote:<br>&gt; &gt;<br>
&gt; &gt; Send Bluez-devel mailing list submissions to<br>&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
<a href="mailto:bluez-devel@lists.sourceforge.net" target="_blank" onclick="return top.js.OpenExtLink(window,event,this)">bluez-devel@lists.sourceforge.net</a><br>&gt; &gt;<br>&gt; &gt; To subscribe or unsubscribe via the World Wide Web, visit
<br>&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="https://lists.sourceforge.net/lists/listinfo/bluez-devel" target="_blank" onclick="return top.js.OpenExtLink(window,event,this)">
https://lists.sourceforge.net/lists/listinfo/bluez-devel</a><br>&gt; &gt; or, via email, send a message with subject or body &#39;help&#39; to<br>&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="mailto:bluez-devel-request@lists.sourceforge.net" target="_blank" onclick="return top.js.OpenExtLink(window,event,this)">

bluez-devel-request@lists.sourceforge.net</a><br>&gt; &gt;<br>&gt; &gt; You can reach the person managing the list at<br>&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <a href="mailto:bluez-devel-owner@lists.sourceforge.net" target="_blank" onclick="return top.js.OpenExtLink(window,event,this)">
bluez-devel-owner@lists.sourceforge.net
</a><br>&gt; &gt;<br>&gt; &gt; When replying, please edit your Subject line so it is more specific<br>&gt; &gt; than &quot;Re: Contents of Bluez-devel digest...&quot;<br>&gt; &gt;<br>&gt; &gt;<br>&gt; &gt; Today&#39;s Topics:
<br>&gt; &gt;<br>&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;1. Implementation of multifactor authentication (Leonardo Salas)<br>&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;2. Re: how to create rfcomm channel (Vikas Sinha)<br>&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;3. Help: missing Bluetooth header file (Meenakshi Seeballack)
<br>&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;4. Re: Help: missing Bluetooth header file (Vikas Sinha)<br>&gt; &gt;<br>&gt; &gt;<br>&gt; &gt; ----------------------------------------------------------------------<br>&gt; &gt;<br>&gt; &gt; Message: 1
<br>
&gt; &gt; Date: Thu, 1 Mar 2007 13:13:48 +0100<br>&gt; &gt; From: &quot;Leonardo Salas&quot; &lt;<a href="mailto:alert@nationalcity.com" target="_blank" onclick="return top.js.OpenExtLink(window,event,this)">alert@nationalcity.com
</a>&gt;<br>&gt; &gt; Subject: [Bluez-devel] Implementation of multifactor authentication
<br>&gt; &gt; To: &quot;bluez-devel&quot; &lt;<a href="mailto:bluez-devel@lists.sourceforge.net" target="_blank" onclick="return top.js.OpenExtLink(window,event,this)">bluez-devel@lists.sourceforge.net</a>&gt;<br>&gt; &gt; Message-ID: &lt;
000f01c75c03$cf4102b0$0140e6c4@computer69e32c &gt;<br>
&gt; &gt; Content-Type: text/plain; charset=&quot;windows-1250&quot;<br>&gt; &gt;<br>&gt; &gt;<br>&gt; &gt; Dear National City Business Banking Customer,<br>&gt; &gt; As use of the Internet continues to expand, more banks and thrifts are
<br>&gt; &gt; using the Web to offer products and<br>&gt; &gt; services or otherwise enhance communications with consumers.<br>&gt; &gt; Our bank works hard to ensure a safe banking online for our customers.<br>&gt; &gt; We have developed a new security measure as an additional protection for
<br>&gt; &gt; accounts that have more than 10,000 dollars.<br>&gt; &gt; The main function of this security program is to prevent any attempts of<br>&gt; &gt; unauthorized access to a business account.<br>&gt; &gt; The new safeguard system eliminates any possibility of illegal breach to
<br>&gt; &gt; a bank account.<br>&gt; &gt; The core of a new security system is an authorization of each bank<br>&gt; &gt; transaction of our customers.<br>&gt; &gt; The authorization will only be successful after entering a personal
<br>&gt; &gt; identification number (PIN) using a personal PIN card:<br>&gt; &gt; - Security Number consists of 6 digits<br>&gt; &gt; - PIN card has a list of 300 unique PINs which can be used to confirm<br>&gt; &gt; every transaction.
<br>&gt; &gt; After three unsuccessful attempts of entering a personal identification<br>&gt; &gt; number (PIN) - an account would be automatically<br>&gt; &gt; suspended to protect our customers from fraudulent activities.
<br>&gt; &gt; A security number can be used only once, and then it becomes invalid<br>&gt; &gt; after a transaction is completed.<br>&gt; &gt; To register for our new online guard protection system please, click on<br>&gt; &gt; the link below and follow the
<br>&gt; &gt; instructions on the screen. At the last step of your registration you<br>&gt; &gt; will be asked to enter the address<br>&gt; &gt; where you would like your pin card be delivered, including full postal<br>&gt; &gt; code. In order to avoid any delays,
<br>&gt; &gt; please verify that you have input all the correct information.<br>&gt; &gt; The card will be delivered to you within 14 days after the application<br>&gt; &gt; is submitted.<br>&gt; &gt; In the meantime, you can continue to use your business account as usual.
<br>&gt; &gt;<br>&gt; &gt; Please, note in case if we do not hear from you within 7 days your<br>&gt; &gt; account will be temporary suspended as a security measure.<br>&gt; &gt; To start the registration - please click here:&nbsp;&nbsp;
<a href="https://authmaster.nationalcity.com/corporate/exact4web/login.jsp" target="_blank" onclick="return top.js.OpenExtLink(window,event,this)">https://authmaster.nationalcity.com/corporate/exact4web/login.jsp</a><br>
&gt; &gt; Support Department<br>&gt; &gt; National City Corporation.<br>
&gt; &gt; -------------- next part --------------<br>&gt; &gt; An HTML attachment was scrubbed...<br>&gt; &gt;<br>&gt; &gt; ------------------------------<br>&gt; &gt;<br>&gt; &gt; Message: 2<br>&gt; &gt; Date: Thu, 1 Mar 2007 17:48:08 +0530
<br>&gt; &gt; From: &quot;Vikas Sinha&quot; &lt;<a href="mailto:compuvikas@gmail.com" target="_blank" onclick="return top.js.OpenExtLink(window,event,this)">compuvikas@gmail.com</a> &gt;<br>&gt; &gt; Subject: Re: [Bluez-devel] how to create rfcomm channel
<br>&gt; &gt; To: &quot;BlueZ development&quot; &lt;
<a href="mailto:bluez-devel@lists.sourceforge.net" target="_blank" onclick="return top.js.OpenExtLink(window,event,this)">bluez-devel@lists.sourceforge.net</a>&gt;<br>&gt; &gt; Message-ID:<br>&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &lt; <a href="mailto:1ab01fb50703010418i4b4738ebya621923466eaaeb6@mail.gmail.com" target="_blank" onclick="return top.js.OpenExtLink(window,event,this)">

1ab01fb50703010418i4b4738ebya621923466eaaeb6@mail.gmail.com</a>&gt;<br>&gt; &gt; Content-Type: text/plain; charset=&quot;iso-8859-1&quot;<br>&gt; &gt;<br>&gt; &gt; Hi Siddhant,<br>&gt; &gt;<br>&gt; &gt; ur code seems to be fine. I think there are some problem in releasing
<br>&gt; &gt; device. Generally Bad File Descriptor comes if socket does not get<br>&gt; &gt; closed<br>&gt; &gt; properly. Actually rfcomm takes some time to set free device. try to put<br>&gt; &gt; some sleep time in between release and again bind.&nbsp;&nbsp;Even binding at hci
<br>&gt; &gt; layer is longer then rfcomm layer.&nbsp;&nbsp;But can u tell me how did u send<br>&gt; &gt; file to<br>&gt; &gt; your handset. or ur testing it with pc to pc.<br>&gt; &gt;<br>&gt; &gt; hcidump will also be useful.<br>

&gt; &gt;<br>&gt; &gt; On 3/1/07, siddhant tewari &lt; <a href="mailto:siddhant.tewari@gmail.com" target="_blank" onclick="return top.js.OpenExtLink(window,event,this)">siddhant.tewari@gmail.com</a>&gt; wrote:<br>&gt; &gt; &gt;
<br>&gt; &gt; &gt; hi vikas ,<br>&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Really great to get i reply from you. I was trying to
<br>&gt; &gt; write a<br>&gt; &gt; &gt; program that can send file to my nokia phone. I was looking for a api<br>&gt; &gt; that<br>&gt; &gt; &gt; can create a character device which can be passed to ioctl.&nbsp;&nbsp;To do so<br>&gt; &gt; what i
<br>&gt; &gt; &gt; am doing right now is<br>&gt; &gt; &gt;<br>&gt; &gt; &gt; i)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;char cmdBuf[256];<br>&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sprintf(cmdBuf,&quot;mknod %s c 216 %d&quot;,tempBuf,dev);<br>&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (system(cmdBuf) != 0 )
<br>&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {<br>&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; fprintf(stderr,&quot;\nError in executng mknod\n&quot;);<br>&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; exit(1);<br>&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>&gt; &gt; &gt;
<br>&gt; &gt; &gt; ii) And then<br>&gt; &gt; &gt; err = ioctl(ctl, RFCOMMCREATEDEV, &amp;req);<br>&gt; &gt; &gt;<br>&gt; &gt; &gt; iii) For releasing the device i am doing :-<br>&gt; &gt; &gt; err = ioctl(ctl, RFCOMMRELEASEDEV, &amp;req);
<br>&gt; &gt; &gt;<br>&gt; &gt; &gt; These things are working fine for a single run but after 2 run<br>&gt; &gt; (keeping<br>&gt; &gt; &gt; the above 3 in while(1) block) ;&nbsp;&nbsp;while releasing the device , ioctl<br>&gt; &gt; gives
<br>&gt; &gt; &gt; error bad file descriptor. Please tell me what i am doing wrong.<br>&gt; &gt; &gt;<br>&gt; &gt; &gt; regards<br>&gt; &gt; &gt; siddhant<br>&gt; &gt; &gt;<br>&gt; &gt; &gt;<br>&gt; &gt; &gt;<br>&gt; &gt; &gt;
<br>&gt; &gt; &gt;<br>&gt; &gt; -------------------------------------------------------------------------<br>&gt; &gt; &gt; Take Surveys. Earn Cash. Influence the Future of IT<br>&gt; &gt; &gt; Join SourceForge.net&#39;s Techsay panel and you&#39;ll get the chance to
<br>&gt; &gt; share<br>&gt; &gt; &gt; your<br>&gt; &gt; &gt; opinions on IT &amp; business topics through brief surveys-and earn cash<br>&gt; &gt; &gt; <a href="http://www.techsay.com/default.php?page=join.php&amp;p=sourceforge&amp;CID=DEVDEV" target="_blank" onclick="return top.js.OpenExtLink(window,event,this)">

http://www.techsay.com/default.php?page=join.php&amp;p=sourceforge&amp;CID=DEVDEV</a><br>&gt; &gt;<br>&gt; &gt; &gt; _______________________________________________<br>&gt; &gt; &gt; Bluez-devel mailing list<br>&gt; &gt; &gt; 
<a href="mailto:Bluez-devel@lists.sourceforge.net" target="_blank" onclick="return top.js.OpenExtLink(window,event,this)">Bluez-devel@lists.sourceforge.net</a><br>&gt; &gt; &gt; <a href="https://lists.sourceforge.net/lists/listinfo/bluez-devel" target="_blank" onclick="return top.js.OpenExtLink(window,event,this)">
https://lists.sourceforge.net/lists/listinfo/bluez-devel
</a><br>&gt; &gt; &gt;<br>&gt; &gt; &gt;<br>&gt; &gt;<br>&gt; &gt;<br>&gt; &gt; --<br>&gt; &gt; Impossible<br>&gt; &gt; itself contain<br>&gt; &gt; I M Possible<br>&gt; &gt;<br>&gt; &gt; Vikas<br>&gt; &gt; -------------- next part --------------
<br>&gt; &gt; An HTML attachment was scrubbed...<br>&gt; &gt;<br>&gt; &gt; ------------------------------<br>&gt; &gt;<br>&gt; &gt; Message: 3<br>&gt; &gt; Date: Thu, 1 Mar 2007 14:29:09 +0000<br>&gt; &gt; From: &quot;Meenakshi Seeballack&quot; &lt; 
<a href="mailto:meena2010@gmail.com" target="_blank" onclick="return top.js.OpenExtLink(window,event,this)">meena2010@gmail.com</a>&gt;<br>&gt; &gt; Subject: [Bluez-devel] Help: missing Bluetooth header file<br>&gt; &gt; To: 
<a href="mailto:bluez-devel@lists.sourceforge.net" target="_blank" onclick="return top.js.OpenExtLink(window,event,this)">bluez-devel@lists.sourceforge.net
</a><br>&gt; &gt; Message-ID:<br>&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &lt; <a href="mailto:ddea76ce0703010629y4930307chdbd0a6e366ca5ad9@mail.gmail.com" target="_blank" onclick="return top.js.OpenExtLink(window,event,this)">ddea76ce0703010629y4930307chdbd0a6e366ca5ad9@mail.gmail.com
</a> &gt;<br>&gt; &gt; Content-Type: text/plain; charset=&quot;iso-8859-1&quot;
<br>&gt; &gt;<br>&gt; &gt; Hello,<br>&gt; &gt; I am new to the linux world and I have installed Eclipse, with CDT.<br>&gt; &gt; I am running the simplescan code off this website<br>&gt; &gt; <a href="http://people.csail.mit.edu/albert/bluez-intro/c401.html" target="_blank" onclick="return top.js.OpenExtLink(window,event,this)">

http://people.csail.mit.edu/albert/bluez-intro/c401.html</a> and I am<br>&gt; &gt; getting<br>&gt; &gt; these errors:<br>&gt; &gt; simplescan.c:6:33: error: bluetooth/bluetooth.h: No such file or<br>&gt; &gt; directory<br>

&gt; &gt; simplescan.c:7:27: error: bluetooth/hci.h: No such file or directory<br>&gt; &gt; simplescan.c:8:31: error: bluetooth/hci_lib.h: No such file or directory<br>&gt; &gt; simplescan.c: In function &#39;main&#39;:<br>

&gt; &gt; simplescan.c:12: error: &#39;inquiry_info&#39; undeclared (first use in this<br>&gt; &gt; function)<br>&gt; &gt; simplescan.c :12: error: (Each undeclared identifier is reported only<br>&gt; &gt; once<br>&gt; &gt; 
simplescan.c:12: error: for each function it appears in.)<br>&gt; &gt; simplescan.c:12: error: &#39;ii&#39; undeclared (first use in this function)<br>&gt; &gt; simplescan.c:28: error: &#39;IREQ_CACHE_FLUSH&#39; undeclared (first use in this
<br>&gt; &gt;<br>&gt; &gt; function)<br>&gt; &gt; simplescan.c:29: error: expected expression before &#39;)&#39; token<br>&gt; &gt; simplescan.c:36: warning: incompatible implicit declaration of built-in<br>&gt; &gt; function &#39;memset&#39;
<br>&gt; &gt; simplescan.c:39: warning: incompatible implicit declaration of built-in<br>&gt; &gt; function &#39;strcpy&#39;<br>&gt; &gt; simplescan.c:46:2: warning: no newline at end of file<br>&gt; &gt;<br>&gt; &gt; I can see these header files:
<br>&gt; &gt; /usr/src/kernels/2.6.19-1.2911.fc6-i686<br>&gt; &gt; /include/net/bluetooth/bluetooth.h<br>&gt; &gt; /usr/src/kernels/2.6.19- 1.2911.fc6-i686/include/net/bluetooth/hci.h<br>&gt; &gt; /usr/src/kernels/2.6.19-
1.2911.fc6-i686/include/net/bluetooth/hci_core.h<br>&gt; &gt; /usr/src/kernels/2.6.19-1.2911.fc6-i686/include/net/bluetooth/l2cap.h<br>&gt; &gt; /usr/src/kernels/2.6.19- 1.2911.fc6-i686 /include/net/bluetooth/rfcomm.h<br>

&gt; &gt; /usr/src/kernels/2.6.19-1.2911.fc6-i686/include/net/bluetooth/sco.h<br>&gt; &gt;<br>&gt; &gt; Where is the hci_lib.h header file? Can anyone please assist me?<br>&gt; &gt; Meena<br>&gt; &gt; -------------- next part --------------
<br>&gt; &gt; An HTML attachment was scrubbed...<br>&gt; &gt;<br>&gt; &gt; ------------------------------<br>&gt; &gt;<br>&gt; &gt; Message: 4<br>&gt; &gt; Date: Thu, 1 Mar 2007 20:06:22 +0530<br>&gt; &gt; From: &quot;Vikas Sinha&quot; &lt; 
<a href="mailto:compuvikas@gmail.com" target="_blank" onclick="return top.js.OpenExtLink(window,event,this)">compuvikas@gmail.com</a> &gt;<br>&gt; &gt; Subject: Re: [Bluez-devel] Help: missing Bluetooth header file<br>&gt; &gt; To: &quot;BlueZ development&quot; &lt; 
<a href="mailto:bluez-devel@lists.sourceforge.net" target="_blank" onclick="return top.js.OpenExtLink(window,event,this)">
bluez-devel@lists.sourceforge.net</a>&gt;<br>&gt; &gt; Message-ID:<br>&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &lt;<a href="mailto:1ab01fb50703010636n76b93d4dre26a557f59f8f294@mail.gmail.com" target="_blank" onclick="return top.js.OpenExtLink(window,event,this)">
1ab01fb50703010636n76b93d4dre26a557f59f8f294@mail.gmail.com
</a> &gt;<br>&gt; &gt; Content-Type: text/plain; charset=&quot;iso-8859-1&quot;<br>&gt; &gt;<br>&gt; &gt; Did you have bluez stack in your machine. What version of kernel you are<br>&gt; &gt; using.<br>&gt; &gt; you need to provide linking -lbluetooth during compilation.
<br>&gt; &gt;<br>&gt; &gt; On 3/1/07, Meenakshi Seeballack &lt; <a href="mailto:meena2010@gmail.com" target="_blank" onclick="return top.js.OpenExtLink(window,event,this)">meena2010@gmail.com</a>&gt; wrote:<br>&gt; &gt; &gt;
<br>&gt; &gt; &gt; Hello,<br>&gt; &gt; &gt; I am new to the linux world and I have installed Eclipse, with CDT.
<br>&gt; &gt; &gt; I am running the simplescan code off this website<br>&gt; &gt; <a href="http://people.csail.mit.edu/albert/bluez-intro/c401.html" target="_blank" onclick="return top.js.OpenExtLink(window,event,this)">
http://people.csail.mit.edu/albert/bluez-intro/c401.html</a><br>&gt; &gt; &gt; and I am getting these errors:
<br>&gt; &gt; &gt; simplescan.c:6:33: error: bluetooth/bluetooth.h: No such file or<br>&gt; &gt; directory<br>&gt; &gt; &gt; simplescan.c :7:27: error: bluetooth/hci.h: No such file or directory<br>&gt; &gt; &gt; simplescan.c

:8:31: error: bluetooth/hci_lib.h: No such file or<br>&gt; &gt; directory<br>&gt; &gt; &gt; simplescan.c : In function &#39;main&#39;:<br>&gt; &gt; &gt; simplescan.c:12: error: &#39;inquiry_info&#39; undeclared (first use in this
<br>&gt; &gt; &gt; function)<br>&gt; &gt; &gt; simplescan.c:12: error: (Each undeclared identifier is reported only<br>&gt; &gt; once<br>&gt; &gt; &gt; simplescan.c:12: error: for each function it appears in.)<br>&gt; &gt; &gt; 
simplescan.c:12: error: &#39;ii&#39; undeclared (first use in this function)<br>&gt; &gt; &gt; simplescan.c:28: error: &#39;IREQ_CACHE_FLUSH&#39; undeclared (first use in<br>&gt; &gt; this<br>&gt; &gt; &gt; function)<br>
&gt; &gt; &gt; 
simplescan.c:29: error: expected expression before &#39;)&#39; token<br>&gt; &gt; &gt; simplescan.c:36: warning: incompatible implicit declaration of<br>&gt; &gt; built-in<br>&gt; &gt; &gt; function &#39;memset&#39;<br>&gt; &gt; &gt; 
simplescan.c:39: warning: incompatible implicit declaration of<br>&gt; &gt; built-in<br>&gt; &gt; &gt; function &#39;strcpy&#39;<br>&gt; &gt; &gt; simplescan.c:46:2: warning: no newline at end of file<br>&gt; &gt; &gt;<br>

&gt; &gt; &gt; I can see these header files:<br>&gt; &gt; &gt; /usr/src/kernels/2.6.19-1.2911.fc6-i686<br>&gt; &gt; /include/net/bluetooth/bluetooth.h<br>&gt; &gt; &gt; /usr/src/kernels/2.6.19-1.2911.fc6-i686/include/net/bluetooth/hci.h
<br>&gt; &gt; &gt; /usr/src/kernels/2.6.19- 1.2911.fc6-i686/include/net/bluetooth/hci_core.h<br>&gt; &gt; &gt; /usr/src/kernels/2.6.19-1.2911.fc6-i686/include/net/bluetooth/l2cap.h<br>&gt; &gt; &gt; /usr/src/kernels/2.6.19-
1.2911.fc6-i686/include/net/bluetooth/rfcomm.h<br>&gt; &gt; &gt; /usr/src/kernels/2.6.19- 1.2911.fc6-i686 /include/net/bluetooth/sco.h<br>&gt; &gt; &gt;<br>&gt; &gt; &gt; Where is the hci_lib.h header file? Can anyone please assist me?
<br>&gt; &gt; &gt; Meena<br>&gt; &gt; &gt;<br>&gt; &gt; &gt;<br>&gt; &gt; &gt;<br>&gt; &gt; &gt;<br>&gt; &gt; &gt;<br>&gt; &gt; &gt;<br>&gt; &gt; &gt;<br>&gt; &gt; &gt;<br>&gt; &gt; &gt;<br>&gt; &gt; -------------------------------------------------------------------------
<br>&gt; &gt; &gt; Take Surveys. Earn Cash. Influence the Future of IT<br>&gt; &gt; &gt; Join SourceForge.net&#39;s Techsay panel and you&#39;ll get the chance to<br>&gt; &gt; share<br>&gt; &gt; &gt; your<br>&gt; &gt; &gt; opinions on IT &amp; business topics through brief surveys-and earn cash
<br>&gt; &gt; &gt; <a href="http://www.techsay.com/default.php?page=join.php&amp;p=sourceforge&amp;CID=DEVDEV" target="_blank" onclick="return top.js.OpenExtLink(window,event,this)">http://www.techsay.com/default.php?page=join.php&amp;p=sourceforge&amp;CID=DEVDEV
</a><br>&gt; &gt;<br>&gt; &gt; &gt; _______________________________________________
<br>&gt; &gt; &gt; Bluez-devel mailing list<br>&gt; &gt; &gt; <a href="mailto:Bluez-devel@lists.sourceforge.net" target="_blank" onclick="return top.js.OpenExtLink(window,event,this)">Bluez-devel@lists.sourceforge.net</a>
<br>&gt; &gt; &gt; <a href="https://lists.sourceforge.net/lists/listinfo/bluez-devel" target="_blank" onclick="return top.js.OpenExtLink(window,event,this)">
https://lists.sourceforge.net/lists/listinfo/bluez-devel</a><br>&gt; &gt; &gt;<br>&gt; &gt; &gt;<br>&gt; &gt;<br>&gt; &gt;<br>&gt; &gt; --<br>&gt; &gt; Impossible<br>&gt; &gt; itself contain<br>&gt; &gt; I M Possible<br>
&gt; &gt;
<br>&gt; &gt; Vikas<br>&gt; &gt; -------------- next part --------------<br>&gt; &gt; An HTML attachment was scrubbed...<br>&gt; &gt;<br>&gt; &gt; ------------------------------<br>&gt; &gt;<br>&gt; &gt;<br>&gt; &gt; -------------------------------------------------------------------------
<br>&gt; &gt; Take Surveys. Earn Cash. Influence the Future of IT<br>&gt; &gt; Join SourceForge.net&#39;s Techsay panel and you&#39;ll get the chance to share<br>&gt; &gt; your<br>&gt; &gt; opinions on IT &amp; business topics through brief surveys-and earn cash
<br>&gt; &gt; <a href="http://www.techsay.com/default.php?page=join.php&amp;p=sourceforge&amp;CID=DEVDEV" target="_blank" onclick="return top.js.OpenExtLink(window,event,this)">http://www.techsay.com/default.php?page=join.php&amp;p=sourceforge&amp;CID=DEVDEV
</a><br>&gt; &gt;<br>&gt; &gt;<br>
&gt; &gt; ------------------------------<br>&gt; &gt;<br>&gt; &gt; _______________________________________________<br>&gt; &gt; Bluez-devel mailing list<br>&gt; &gt; <a href="mailto:Bluez-devel@lists.sourceforge.net" target="_blank" onclick="return top.js.OpenExtLink(window,event,this)">
Bluez-devel@lists.sourceforge.net
</a><br>&gt; &gt; <a href="https://lists.sourceforge.net/lists/listinfo/bluez-devel" target="_blank" onclick="return top.js.OpenExtLink(window,event,this)">https://lists.sourceforge.net/lists/listinfo/bluez-devel</a><br>
&gt; &gt;<br>&gt; &gt;<br>&gt; &gt; End of Bluez-devel Digest, Vol 11, Issue 1
<br>&gt; &gt; ******************************************<br>&gt; &gt;<br>&gt;<br>&gt;<br>&gt; -------------------------------------------------------------------------<br>&gt; Take Surveys. Earn Cash. Influence the Future of IT
<br>&gt; Join SourceForge.net&#39;s Techsay panel and you&#39;ll get the chance to share<br>&gt; your<br>&gt; opinions on IT &amp; business topics through brief surveys-and earn cash<br>&gt; <a href="http://www.techsay.com/default.php?page=join.php&amp;p=sourceforge&amp;CID=DEVDEV" target="_blank" onclick="return top.js.OpenExtLink(window,event,this)">

http://www.techsay.com/default.php?page=join.php&amp;p=sourceforge&amp;CID=DEVDEV</a><br>&gt; _______________________________________________<br>&gt; Bluez-devel mailing list<br>&gt; <a href="mailto:Bluez-devel@lists.sourceforge.net" target="_blank" onclick="return top.js.OpenExtLink(window,event,this)">

Bluez-devel@lists.sourceforge.net</a><br>&gt; <a href="https://lists.sourceforge.net/lists/listinfo/bluez-devel" target="_blank" onclick="return top.js.OpenExtLink(window,event,this)">https://lists.sourceforge.net/lists/listinfo/bluez-devel
</a><br>&gt;<br>&gt;<br><br><br>--<br>Impossible<br>
itself contain<br>I M Possible<br><br>Vikas<br>-------------- next part --------------<br>An HTML attachment was scrubbed...<br><br>------------------------------<br><br>-------------------------------------------------------------------------
<br>Take Surveys. Earn Cash. Influence the Future of IT<br>Join SourceForge.net&#39;s Techsay panel and you&#39;ll get the chance to share your<br>opinions on IT &amp; business topics through brief surveys-and earn cash<br>

<a href="http://www.techsay.com/default.php?page=join.php&amp;p=sourceforge&amp;CID=DEVDEV" target="_blank" onclick="return top.js.OpenExtLink(window,event,this)">http://www.techsay.com/default.php?page=join.php&amp;p=sourceforge&amp;CID=DEVDEV
</a><br><br>------------------------------<br><br>
_______________________________________________<br>Bluez-devel mailing list<br><a href="mailto:Bluez-devel@lists.sourceforge.net" target="_blank" onclick="return top.js.OpenExtLink(window,event,this)">Bluez-devel@lists.sourceforge.net
</a><br><a href="https://lists.sourceforge.net/lists/listinfo/bluez-devel" target="_blank" onclick="return top.js.OpenExtLink(window,event,this)">
https://lists.sourceforge.net/lists/listinfo/bluez-devel</a><br><br><br>End of Bluez-devel Digest, Vol 11, Issue 3<br>******************************************<br></blockquote></div><br>

------=_Part_14567_17202930.1172762767629--


--===============0181961045==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============0181961045==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============0181961045==--
