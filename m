Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <57c68ddc0702122257r230f45eeo75b4bca9b81796e7@mail.gmail.com>
Date: Tue, 13 Feb 2007 12:27:04 +0530
From: "siddhant tewari" <siddhant.tewari@gmail.com>
To: "BlueZ users" <bluez-users@lists.sourceforge.net>
In-Reply-To: <1169301946.30356.7.camel@violet>
MIME-Version: 1.0
References: <b5dccebe0701190517t50869e29y4fcacda8475db035@mail.gmail.com>
	<1169219863.29458.10.camel@violet>
	<b5dccebe0701200259i156f623ci1fc12159affbd2f4@mail.gmail.com>
	<1169301946.30356.7.camel@violet>
Subject: Re: [Bluez-users] BlueZ on other platforms
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0080194816=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============0080194816==
Content-Type: multipart/alternative;
	boundary="----=_Part_62598_23294327.1171349824947"

------=_Part_62598_23294327.1171349824947
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Marcel,
    i would like to port bluez on windows .... Marcel can you guide me how
to do that or at least outline the steps and give threads abt how to
proceed.

regards
siddhant

On 1/20/07, Marcel Holtmann <marcel@holtmann.org> wrote:
>
> Hi Mikel,
>
> > > > Is it possible to get bluez to work on other platforms than Linux?
> I'm
> > > > asking because it's a real good bluetooth stack and that's a rare
> > > > thing... So technically it's not bluez, but bluez-libs. So what
> about
> > > >
> > > > Bluez on Mac?
> > > > Bluez on Windows?
> > > > Bluez on Cygwin on Windows?
> > >
> > > non of that will work. The Bluetooth library depends on kernel
> > > structures and one of the big advantages of BlueZ is the native
> > > integration with the socket API.
> >
> > So not even for Cygwin? How difficult would this be to add? I.e. how
> > big parts of bluez would have to be rewritten and how much could be
> > reused to make it work on cygwin (I suppose this would be layered on
> > top of the Microsoft bluetooth stack)?
>
> this all depends on what's your goal and how your applications look
> like. The best emulation would be of course our D-Bus based API, but
> even that is a lot of work. A native emulation of BlueZ is not realistic
> from my point of view. Feel free to prove me wrong.
>
> Regards
>
> Marcel
>
>
>
> -------------------------------------------------------------------------
> Take Surveys. Earn Cash. Influence the Future of IT
> Join SourceForge.net's Techsay panel and you'll get the chance to share
> your
> opinions on IT & business topics through brief surveys - and earn cash
> http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users
>

------=_Part_62598_23294327.1171349824947
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<div>Hi Marcel,</div>
<div>&nbsp;&nbsp;&nbsp; i would like to port bluez on windows .... Marcel can you guide me how to do that or at least outline the steps and give threads abt how to proceed. </div>
<div>&nbsp;</div>
<div>regards</div>
<div>siddhant<br>&nbsp;</div>
<div><span class="gmail_quote">On 1/20/07, <b class="gmail_sendername">Marcel Holtmann</b> &lt;<a href="mailto:marcel@holtmann.org">marcel@holtmann.org</a>&gt; wrote:</span>
<blockquote class="gmail_quote" style="PADDING-LEFT: 1ex; MARGIN: 0px 0px 0px 0.8ex; BORDER-LEFT: #ccc 1px solid">Hi Mikel,<br><br>&gt; &gt; &gt; Is it possible to get bluez to work on other platforms than Linux? I&#39;m
<br>&gt; &gt; &gt; asking because it&#39;s a real good bluetooth stack and that&#39;s a rare<br>&gt; &gt; &gt; thing... So technically it&#39;s not bluez, but bluez-libs. So what about<br>&gt; &gt; &gt;<br>&gt; &gt; &gt; Bluez on Mac?
<br>&gt; &gt; &gt; Bluez on Windows?<br>&gt; &gt; &gt; Bluez on Cygwin on Windows?<br>&gt; &gt;<br>&gt; &gt; non of that will work. The Bluetooth library depends on kernel<br>&gt; &gt; structures and one of the big advantages of BlueZ is the native
<br>&gt; &gt; integration with the socket API.<br>&gt;<br>&gt; So not even for Cygwin? How difficult would this be to add? I.e. how<br>&gt; big parts of bluez would have to be rewritten and how much could be<br>&gt; reused to make it work on cygwin (I suppose this would be layered on
<br>&gt; top of the Microsoft bluetooth stack)?<br><br>this all depends on what&#39;s your goal and how your applications look<br>like. The best emulation would be of course our D-Bus based API, but<br>even that is a lot of work. A native emulation of BlueZ is not realistic
<br>from my point of view. Feel free to prove me wrong.<br><br>Regards<br><br>Marcel<br><br><br><br>-------------------------------------------------------------------------<br>Take Surveys. Earn Cash. Influence the Future of IT
<br>Join SourceForge.net&#39;s Techsay panel and you&#39;ll get the chance to share your<br>opinions on IT &amp; business topics through brief surveys - and earn cash<br><a href="http://www.techsay.com/default.php?page=join.php&amp;p=sourceforge&amp;CID=DEVDEV">
http://www.techsay.com/default.php?page=join.php&amp;p=sourceforge&amp;CID=DEVDEV</a><br>_______________________________________________<br>Bluez-users mailing list<br><a href="mailto:Bluez-users@lists.sourceforge.net">Bluez-users@lists.sourceforge.net
</a><br><a href="https://lists.sourceforge.net/lists/listinfo/bluez-users">https://lists.sourceforge.net/lists/listinfo/bluez-users</a><br></blockquote></div><br>

------=_Part_62598_23294327.1171349824947--


--===============0080194816==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier.
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--===============0080194816==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============0080194816==--
