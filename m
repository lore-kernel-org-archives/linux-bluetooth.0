Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <1ab01fb50703012120q62e91355rcad41055dd7d59a0@mail.gmail.com>
Date: Fri, 2 Mar 2007 10:50:37 +0530
From: "Vikas Sinha" <compuvikas@gmail.com>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
In-Reply-To: <ddea76ce0703010726j32cf3736kf8f5391c4c492183@mail.gmail.com>
MIME-Version: 1.0
References: <ddea76ce0703010726j32cf3736kf8f5391c4c492183@mail.gmail.com>
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
Content-Type: multipart/mixed; boundary="===============1721492708=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

--===============1721492708==
Content-Type: multipart/alternative;
	boundary="----=_Part_35944_5789993.1172812837848"

------=_Part_35944_5789993.1172812837848
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Meenakshi,

u need to compile bluez-devel. Download sorce then untar it into
/usr/local/src (you can put it to anywhere. I generally put it there). go
into that folder and do
./configure
make
make install


it will compile and put header files to its location. i.e.
/usr/include/bluetooth or /usr/local/include/bluetooth . if it create it in
second then simply copy it to first path. Then try to compile ur code. plz
check ur d-bus version also.


On 3/1/07, Meenakshi Seeballack <meena2010@gmail.com> wrote:
>
> In /usr/lib I have these files:
> /usr/lib/libbluetooth.so.2   rw- r - r
> /usr/lib/libbluetooth.so.2.4.1   rw- r - r
>
> And the header files are absent in /usr/include.
>
> The only header files I can see for bluetooth are here
> /usr/src/kernels/2.6.19-1.2911.fc6-i686/include/net/bluetooth/bluetooth.h
> /usr/src/kernels/2.6.19- 1.2911.fc6-i686/include/net/bluetooth/hci.h
> /usr/src/kernels/2.6.19-1.2911.fc6-i686/include/net/bluetooth/hci_core.h
> /usr/src/kernels/2.6.19-1.2911.fc6-i686/include/net/bluetooth/l2cap.h
> /usr/src/kernels/2.6.19- 1.2911.fc6-i686 /include/net/bluetooth/rfcomm.h
> /usr/src/kernels/2.6.19-1.2911.fc6-i686/include/net/bluetooth/sco.h
>
> >
> And the header files are absent in /usr/include. So how do I get the
> bluetooth folder with the header files in /usr/include?
> Where is the hci_lib.h header file?
>
> ----------------------------------------------------------------------------------
>
> On 01/03/07, bluez-devel-request@lists.sourceforge.net <bluez-devel-request@lists.sourceforge.net>
> wrote:
> >
> > Send Bluez-devel mailing list submissions to
> >         bluez-devel@lists.sourceforge.net
> >
> > To subscribe or unsubscribe via the World Wide Web, visit
> >          https://lists.sourceforge.net/lists/listinfo/bluez-devel
> > or, via email, send a message with subject or body 'help' to
> >          bluez-devel-request@lists.sourceforge.net
> >
> > You can reach the person managing the list at
> >         bluez-devel-owner@lists.sourceforge.net
> >
> > When replying, please edit your Subject line so it is more specific
> > than "Re: Contents of Bluez-devel digest..."
> >
> >
> > Today's Topics:
> >
> >    1. Re: missing bluetooth header file (Vikas Sinha)
> >
> >
> > ----------------------------------------------------------------------
> >
> > Message: 1
> > Date: Thu, 1 Mar 2007 20:36:08 +0530
> > From: "Vikas Sinha" <compuvikas@gmail.com >
> > Subject: Re: [Bluez-devel] missing bluetooth header file
> > To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
> > Message-ID:
> >         < 1ab01fb50703010706j27966cf8j598eae2d38c9b28c@mail.gmail.com>
> > Content-Type: text/plain; charset="iso-8859-1"
> >
> > ok plz check library path. did u have
> >
> > -rw-r--r--    1 root root    52530 Aug 17  2004 libbluetooth.a
> > lrwxrwxrwx    1 root root       22 Jun 21  2006 libbluetooth.so ->
> > libbluetooth.so.1.0.10
> > lrwxrwxrwx    1 root root       22 May  4  2006 libbluetooth.so.1 ->
> > libbluetooth.so.1.0.10
> > -rwxr-xr-x    1 root root    49780 Aug 17  2004 libbluetooth.so.1.0.10
> >
> > these files in ur /usr/lib or in /usr/local/lib. if these files are
> > places
> > other place then u need to
> > export LD_LIBRARY_PATH=// lib path for these file. These files need at
> > the
> > time of compilation of any code containing bluetooth.h file. include
> > these
> > and i think ur programm will work
> >
> > Also check ur header files are present at /usr/include or not.
> >
> >
> > On 3/1/07, Meenakshi Seeballack < meena2010@gmail.com> wrote:
> > >
> > > the kernel is 2.6.19-1.2911.fc6-i686, and I assume bluez is installed
> > on
> > > the machine, since  I tried "yum install bluez" and it says "nothing
> > to do"
> > >
> > -------------------------------------------------------------------------------------------------------
> > >
> > > On 01/03/07, bluez-devel-request@lists.sourceforge.net <
> > bluez-devel-request@lists.sourceforge.net>
> > > wrote:
> >
>


-- 
Impossible
itself contain
I M Possible

Vikas

------=_Part_35944_5789993.1172812837848
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Meenakshi,<br>
<br>
u need to compile bluez-devel. Download sorce then untar it into
/usr/local/src (you can put it to anywhere. I generally put it there).
go into that folder and do <br>
./configure<br>
make<br>
make install<br>
<br>
<br>
it will compile and put header files to its location. i.e.
/usr/include/bluetooth or /usr/local/include/bluetooth . if it create
it in second then simply copy it to first path. Then try to compile ur
code. plz check ur d-bus version also. <br>
<br><br><div><span class="gmail_quote">On 3/1/07, <b class="gmail_sendername">Meenakshi Seeballack</b> &lt;<a href="mailto:meena2010@gmail.com">meena2010@gmail.com</a>&gt; wrote:</span><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
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
libbluetooth.a<br>lrwxrwxrwx&nbsp;&nbsp;&nbsp;&nbsp;1
root root&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 22 Jun 21&nbsp;&nbsp;2006
libbluetooth.so -&gt;<br>libbluetooth.so.1.0.10<br>lrwxrwxrwx&nbsp;&nbsp;&nbsp;&nbsp;1
root root&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 22
May&nbsp;&nbsp;4&nbsp;&nbsp;2006 libbluetooth.so.1 -&gt;<br>libbluetooth.so.1.0.10<br>-rwxr-xr-x&nbsp;&nbsp;&nbsp;&nbsp;1 root root&nbsp;&nbsp;&nbsp;&nbsp;49780 Aug 17&nbsp;&nbsp;2004 
libbluetooth.so.1.0.10<br><br>these files in ur /usr/lib or in /usr/local/lib. if these files are places<br>other place then u need to<br>export LD_LIBRARY_PATH=// lib path for these file. These files need at the<br>time of compilation of any code containing 
bluetooth.h file. include these<br>and i think ur programm will work<br><br>Also check ur header files are present at /usr/include or not.<br><br><br>On 3/1/07, Meenakshi Seeballack &lt;<a href="mailto:meena2010@gmail.com" target="_blank" onclick="return top.js.OpenExtLink(window,event,this)">


meena2010@gmail.com</a>&gt; wrote:<br>&gt;<br>&gt; the kernel is 2.6.19-1.2911.fc6-i686, and I assume bluez is installed on<br>&gt; the machine, since&nbsp;&nbsp;I tried &quot;yum install bluez&quot; and it says &quot;nothing to do&quot;
<br>&gt; -------------------------------------------------------------------------------------------------------<br>&gt;<br>&gt; On 01/03/07, <a href="mailto:bluez-devel-request@lists.sourceforge.net" target="_blank" onclick="return top.js.OpenExtLink(window,event,this)">

bluez-devel-request@lists.sourceforge.net
</a> &lt;<a href="mailto:bluez-devel-request@lists.sourceforge.net" target="_blank" onclick="return top.js.OpenExtLink(window,event,this)">bluez-devel-request@lists.sourceforge.net</a>&gt;<br>&gt; wrote:<br></blockquote>
</div></blockquote></div><br>
<br clear="all"><br>-- <br>Impossible <br>itself contain <br>I M Possible<br><br>Vikas

------=_Part_35944_5789993.1172812837848--


--===============1721492708==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============1721492708==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============1721492708==--
