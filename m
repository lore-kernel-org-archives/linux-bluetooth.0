Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <9da2dbd10702090428h28269bbfrb01e0939d2d979e3@mail.gmail.com>
Date: Fri, 9 Feb 2007 17:58:19 +0530
From: "Vishal Gaurav" <vishalgaurav01@gmail.com>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <9da2dbd10702090424u165f798em3cedc1218403152a@mail.gmail.com>
MIME-Version: 1.0
References: <mailman.8758.1171021888.20110.bluez-users@lists.sourceforge.net>
	<9da2dbd10702090424u165f798em3cedc1218403152a@mail.gmail.com>
Subject: Re: [Bluez-users] Bluez-users Digest, Vol 10, Issue 11
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0930989844=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============0930989844==
Content-Type: multipart/alternative;
	boundary="----=_Part_28849_32460039.1171024099374"

------=_Part_28849_32460039.1171024099374
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,
Some information about my bluetooth device and phone:/
I have a NOKIA 6600 phone.And i have a bluetooth device,Before installed
linux i am able to connect internet via bluetooth in win 98, So my bluetooth
and gprs services are running,But i am not know how can i setup bluetooth in
Linux Please help me.
Thnaks


On 2/9/07, Vishal Gaurav <vishalgaurav01@gmail.com> wrote:
>
> Hi,
> Thnaks for your valuable comments,But i am not get any support.Please tell
> me about connecting bluetooth internet connecting, Please help me.I am
> just got latest kernel and bluez softwares from bluez.org website.I am not
> know how can i run this drivers and how can i run kernel update.
> Please help me,
> Thanks
> Vishal
> vishalgaurav01@gmail.com
>
>
>
> On 2/9/07, bluez-users-request@lists.sourceforge.net <bluez-users-request@lists.sourceforge.net>
> wrote:
> >
> > Send Bluez-users mailing list submissions to
> >        bluez-users@lists.sourceforge.net
> >
> > To subscribe or unsubscribe via the World Wide Web, visit
> >        https://lists.sourceforge.net/lists/listinfo/bluez-users
> > or, via email, send a message with subject or body 'help' to
> >        bluez-users-request@lists.sourceforge.net
> >
> > You can reach the person managing the list at
> >        bluez-users-owner@lists.sourceforge.net
> >
> > When replying, please edit your Subject line so it is more specific
> > than "Re: Contents of Bluez-users digest..."
> >
> >
> > Today's Topics:
> >
> >   1. Logitech MediaPad HOWTO send info to display (CIJOML)
> >   2. Re: headset /SCO / plugz (Gerhard Killesreiter)
> >   3. Bluetooth setup (Vishal Gaurav)
> >   4. Re: Is this list dead? Here is my problem... (John H.)
> >   5. Re: Is this list dead? Here is my problem... (Anssi Saari)
> >   6. phone model and link manager version (Mikael Lindqvist)
> >   7. Re: phone model and link manager version (Peter Stephenson)
> >   8. meditation devil's advocate (Gwendoline J. Tapia)
> >
> >
> > ----------------------------------------------------------------------
> >
> > Message: 1
> > Date: Thu, 8 Feb 2007 15:00:07 +0100
> > From: CIJOML <cijoml@volny.cz>
> > Subject: [Bluez-users] Logitech MediaPad HOWTO send info to display
> > To: bluez-users@lists.sourceforge.net
> > Message-ID: < 200702081500.07792.cijoml@volny.cz>
> > Content-Type: text/plain;  charset="iso-8859-2"
> >
> > Hi all,
> >
> > I would like to know how to send some text (sensors stats the best and
> > system
> > load) to the display on this MediaPad. I think Marcel made some work a
> > year
> > ago in this direction, but I see no sources...
> >
> > Any help?
> >
> > Thanks a lot
> >
> > Michal
> >
> >
> >
> > ------------------------------
> >
> > Message: 2
> > Date: Thu, 08 Feb 2007 18:02:31 +0100
> > From: Gerhard Killesreiter < gerhard@killesreiter.de>
> > Subject: Re: [Bluez-users] headset /SCO / plugz
> > To: BlueZ users <bluez-users@lists.sourceforge.net >
> > Message-ID: <45CB57A7.1050505@killesreiter.de>
> > Content-Type: text/plain; charset=ISO-8859-1; format=flowed
> >
> > Gerhard Killesreiter wrote:
> > > Gerhard Killesreiter wrote:
> > >> Brad Midgley wrote:
> > >>> Gerhard
> > >>>
> > >>>> 6) now what? a2dpd doesn't show up in my output choices in xmms,
> > >>>> "headset" shows up as a choice for the mixer device, but not the
> > >>>> general output device.
> > >>> I have to type
> > >>>  a2dpd
> > >>>   or
> > >>>  headset
> > >>> freehand in the device choice in xmms. It's true it doesn't find it
> > >>> automatically and we've tried to document that.
> > >>>
> > >>
> > >> Ok, tried that, but it still doesn't work.
> > >>
> > >> Set to a2dpd and ran a2dpd:
> >
> > Ok, I've given up on a2dpd and tried headsetd for SCO (what I wanted to
> > do anyway): It works!
> >
> > My problem apparently was that hibernating the laptop didn't allow
> > usb/alsa/bluetooth to work properly after waking up the machine.
> > Switching the headset on/off also seems to help. I've now added all usb
> > modules to the hibernate blacklist and will see if it still works after
> > the next hibernation.
> >
> > I have booted and headsetd will now work, I can direct sound output to
> > my headset as given on the "build" page and I can also record sound from
> >
> > the microphone doing:
> >
> > arecord -D headset --format=S16_LE blah.wav
> >
> > My problem is now that most apps don't allow for specific sound options
> > on the command line. I am thinking of skype and krut
> > ( http://sourceforge.net/projects/krut/). Is there a way to make the
> > headset the default alsa device?
> >
> > (later)
> >
> > Apparently, the answer is yes and I need to modify my .asoundrc file.
> > Does anybody have a copy that works in such a way that when the headset
> > is available it is the default and in other cases the normal
> > speaker/micro?
> >
> >
> > Cheers,
> >        Gerhard
> >
> >
> >
> > ------------------------------
> >
> > Message: 3
> > Date: Fri, 9 Feb 2007 00:08:21 +0530
> > From: "Vishal Gaurav" <vishalgaurav01@gmail.com>
> > Subject: [Bluez-users] Bluetooth setup
> > To: bluez-users@lists.sourceforge.net
> > Message-ID:
> >        <9da2dbd10702081038w2116ea35k4af9e54a167c83a2@mail.gmail.com>
> > Content-Type: text/plain; charset="iso-8859-1"
> >
> > I am just instaled Kubuntu on my desktop.I am new linux user.Can some
> > one
> > know how can i setup bluetooth device with my phone to connect
> > internet.Please help me.
> >
> > --
> > Vishal Gaurav
> > -------------- next part --------------
> > An HTML attachment was scrubbed...
> >
> > ------------------------------
> >
> > Message: 4
> > Date: Thu, 8 Feb 2007 13:09:16 -0600
> > From: "John H." <mistamaila@gmail.com >
> > Subject: Re: [Bluez-users] Is this list dead? Here is my problem...
> > To: "BlueZ users" <bluez-users@lists.sourceforge.net>
> > Message-ID:
> >        <5b9417770702081109r22d806fci366f0b01a678be73@mail.gmail.com>
> > Content-Type: text/plain; charset=ISO-8859-1; format=flowed
> >
> > It does, but that's not the point.  I want to see if bluetooth is
> > working at all between your pc and the phone.
> >
> > On 2/8/07, Xamindar <junkxamindar@gmail.com > wrote:
> > > John H. wrote:
> > > > Try unplugging the usb cable and turning off phone then back on...
> > it
> > > > might also be worth your while to remove, in bluetooth settings, a
> > > > reference on your phone to your computer.
> > > >
> > > > Then, just to be safe, put it in discovery mode and if there's a
> > > > setting for "allow other computers to connect," do that.
> > > >
> > > > But really, before all of this, please let us know if konqueror
> > > > bluetooth:/// can access your phone.
> > > >
> > > Only kde programs I use are k3b and amarok.  I really hope I don't
> > have
> > > to go through the trouble of installing kde to get bluetooth
> > working.  I
> > > may have to do that though, it seems kde has far superior bluetooth
> > > support.  I'll consider it.
> > >
> > >
> > >
> > -------------------------------------------------------------------------
> > > Using Tomcat but need to do more? Need to support web services,
> > security?
> > > Get stuff done quickly with pre-integrated technology to make your job
> > easier.
> > > Download IBM WebSphere Application Server v.1.0.1 based on Apache
> > Geronimo
> > >
> > http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
> > > _______________________________________________
> > > Bluez-users mailing list
> > > Bluez-users@lists.sourceforge.net
> > > https://lists.sourceforge.net/lists/listinfo/bluez-users
> > >
> >
> >
> >
> > ------------------------------
> >
> > Message: 5
> > Date: Thu, 8 Feb 2007 22:03:39 +0200
> > From: Anssi Saari <anssi.saari@modeemi.fi>
> > Subject: Re: [Bluez-users] Is this list dead? Here is my problem...
> > To: bluez-users@lists.sourceforge.net
> > Message-ID: <20070208200339.GA15750@jolt.modeemi.cs.tut.fi >
> > Content-Type: text/plain; charset=us-ascii
> >
> > On Wed, Feb 07, 2007 at 01:42:00PM -0800, Xamindar wrote:
> > > John H. wrote:
> > > > Yes, it looks as though you do.  Can you do a regular rfcomm
> > connect?
> > > > What if you use rfcomm1?
> > > >
> > > What is a regular rfcomm connect?  On the console it just gives me
> > errors.
> >
> > That would be rfcomm connect hci0 00:12:56:5A:92:59 8
> >
> > Maybe you need to remove that weird stuff from rfcomm.conf first too.
> > And what
> > about pairing, you haven't said anything about it?
> >
> >
> >
> > ------------------------------
> >
> > Message: 6
> > Date: Fri, 9 Feb 2007 11:41:04 +0100
> > From: "Mikael Lindqvist" < li.mikael.spam@gmail.com>
> > Subject: [Bluez-users] phone model and link manager version
> > To: bluez-users@lists.sourceforge.net
> > Message-ID:
> >        <b5dccebe0702090241w797ff03fk8dc41eb2e8881015@mail.gmail.com>
> > Content-Type: text/plain; charset=ISO-8859-1; format=flowed
> >
> > Hello,
> >
> > I wonder if there is any correlation between the Link Manager Protocol
> > (LMP) Subversion and the model of a bluetooth phone. I mean, if I find
> > out the LMP subversion of a remote device with for example hcitool,
> > like this:
> >
> > sudo hcitool info <bdaddr>
> >
> > Requesting information ...
> > ...
> > LMP Version: 1.2 (0x2) LMP Subversion: 0x41c
> >
> > Can this subversion be used to identify the model of the phone?
> >
> > If not, can it be used to suggest that the phone is any of a small set
> > of models?
> >
> > If firmware updates are being made on the phone, will that affect the
> > LMP subversion?
> >
> > What process inside a phone manufacturer company decide that a
> > Bluetooth chip with a certain LMP subversion ends up in a specific
> > model? Is it just related to when the phone happened to be produced or
> > is it somehow related to the model?
> >
> > Thanks in advance!
> >
> > -- Mikael
> >
> >
> >
> > ------------------------------
> >
> > Message: 7
> > Date: Fri, 09 Feb 2007 11:02:17 +0000
> > From: Peter Stephenson <pws@csr.com>
> > Subject: Re: [Bluez-users] phone model and link manager version
> > To: BlueZ users <bluez-users@lists.sourceforge.net>
> > Message-ID: <200702091102.l19B2H0L012760@news01.csr.com >
> > Content-Type: text/plain
> >
> > "Mikael Lindqvist" wrote:
> > > I wonder if there is any correlation between the Link Manager Protocol
> > > (LMP) Subversion and the model of a bluetooth phone.
> >
> > Yes and no, but mostly no.  The LMP subversion is that of the link
> > manager on the Bluetooth chip, not (for example) the phone's GSM
> > baseband chip---unless Bluetooth is built into the latter, which is
> > possible but not very common.  In either case it's probably not telling
> > you the sorts of things you want to know about the phone, simply about
> > the phone manufacturer's procurement policy.
> >
> > Note that because they're telling you about the Bluetooth chip, the LMP
> > and HCI subversion numbers are useless without the Bluetooth
> > manufacturer ID (which is also reported).  You can decode these
> > from http://www.bluetooth.org/assigned-numbers/company_identifiers.php
> >
> > There will be *some* correlation: an older version is likely to appear
> > in an older phone, obviously.  But even the same model of phone might
> > have a different version of the firmware, and in some cases even a
> > completely different Bluetooth chip.  There's not even a requirement
> > that the LMP subversion is monotonically increasing with time.
> >
> > pws
> >
> >
> > To access the latest news from CSR copy this link into a web browser:
> > http://www.csr.com/email_sig.php
> >
> > To get further information regarding CSR, please visit our Investor
> > Relations page at http://ir.csr.com/csr/about/overview
> >
> >
> >
> > ------------------------------
> >
> > Message: 8
> > Date: Fri, 9 Feb 2007 12:50:59 +0100
> > From: Gwendoline J. Tapia <lmenht@devereux.homechoice.co.uk >
> > Subject: [Bluez-users] meditation devil's advocate
> > To: bluez-users@lists.sourceforge.net
> > Message-ID: < 45CC6023.2020407@devereux.homechoice.co.uk>
> > Content-Type: text/plain; charset="us-ascii"
> >
> > An HTML attachment was scrubbed...
> > -------------- next part --------------
> > A non-text attachment was scrubbed...
> > Name: dud.gif
> > Type: image/gif
> > Size: 14365 bytes
> > Desc: not available
> >
> > ------------------------------
> >
> >
> > -------------------------------------------------------------------------
> > Using Tomcat but need to do more? Need to support web services,
> > security?
> > Get stuff done quickly with pre-integrated technology to make your job
> > easier.
> > Download IBM WebSphere Application Server v.1.0.1 based on Apache
> > Geronimo
> > http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
> >
> > ------------------------------
> >
> > _______________________________________________
> > Bluez-users mailing list
> > Bluez-users@lists.sourceforge.net
> > https://lists.sourceforge.net/lists/listinfo/bluez-users
> >
> >
> > End of Bluez-users Digest, Vol 10, Issue 11
> > *******************************************
> >
>
>
>
> --
> Vishal Gaurav




-- 
Vishal Gaurav

------=_Part_28849_32460039.1171024099374
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<div>Hi,</div>
<div>Some information about my bluetooth device and phone:/</div>
<div>I have a NOKIA 6600 phone.And i have a bluetooth device,Before installed linux i am able to connect internet via bluetooth in win 98, So my bluetooth and gprs services are running,But i am not know how can i setup bluetooth in Linux Please help me.
</div>
<div>Thnaks<br><br>&nbsp;</div>
<div><span class="gmail_quote">On 2/9/07, <b class="gmail_sendername">Vishal Gaurav</b> &lt;<a href="mailto:vishalgaurav01@gmail.com">vishalgaurav01@gmail.com</a>&gt; wrote:</span>
<blockquote class="gmail_quote" style="PADDING-LEFT: 1ex; MARGIN: 0px 0px 0px 0.8ex; BORDER-LEFT: #ccc 1px solid">
<div><font color="#3366ff">Hi,</font></div>
<div><font color="#3366ff">Thnaks for your valuable comments,But i am not get any support.Please tell me about connecting bluetooth internet connecting, Please help me.I am just got latest kernel and bluez softwares from 
<a onclick="return top.js.OpenExtLink(window,event,this)" href="http://bluez.org/" target="_blank">bluez.org</a> website.I am not know how can i run this drivers and how can i run kernel update.</font></div>
<div><font color="#3366ff">Please help me,</font></div>
<div><font color="#3366ff">Thanks</font></div>
<div><font color="#3366ff">Vishal</font></div>
<div><font color="#3366ff"><a onclick="return top.js.OpenExtLink(window,event,this)" href="mailto:vishalgaurav01@gmail.com" target="_blank">vishalgaurav01@gmail.com</a></font></div>
<div><span class="e" id="q_110a6763e8f86ff1_1">
<div><font color="#3366ff"><br></font><br>&nbsp;</div>
<div><span class="gmail_quote">On 2/9/07, <b class="gmail_sendername"><a onclick="return top.js.OpenExtLink(window,event,this)" href="mailto:bluez-users-request@lists.sourceforge.net" target="_blank">bluez-users-request@lists.sourceforge.net
</a></b> &lt;<a onclick="return top.js.OpenExtLink(window,event,this)" href="mailto:bluez-users-request@lists.sourceforge.net" target="_blank"> bluez-users-request@lists.sourceforge.net</a>&gt; wrote:</span> 
<blockquote class="gmail_quote" style="PADDING-LEFT: 1ex; MARGIN: 0px 0px 0px 0.8ex; BORDER-LEFT: #ccc 1px solid">Send Bluez-users mailing list submissions to<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <a onclick="return top.js.OpenExtLink(window,event,this)" href="mailto:bluez-users@lists.sourceforge.net" target="_blank">
bluez-users@lists.sourceforge.net</a><br><br>To subscribe or unsubscribe via the World Wide Web, visit<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <a onclick="return top.js.OpenExtLink(window,event,this)" href="https://lists.sourceforge.net/lists/listinfo/bluez-users" target="_blank">
https://lists.sourceforge.net/lists/listinfo/bluez-users </a><br>or, via email, send a message with subject or body &#39;help&#39; to<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <a onclick="return top.js.OpenExtLink(window,event,this)" href="mailto:bluez-users-request@lists.sourceforge.net" target="_blank">
bluez-users-request@lists.sourceforge.net</a><br><br>You can reach the person managing the list at <br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <a onclick="return top.js.OpenExtLink(window,event,this)" href="mailto:bluez-users-owner@lists.sourceforge.net" target="_blank">
bluez-users-owner@lists.sourceforge.net</a><br><br>When replying, please edit your Subject line so it is more specific<br>than &quot;Re: Contents of Bluez-users digest...&quot; <br><br><br>Today&#39;s Topics:<br><br>&nbsp;&nbsp;1. Logitech MediaPad HOWTO send info to display (CIJOML)
<br>&nbsp;&nbsp;2. Re: headset /SCO / plugz (Gerhard Killesreiter)<br>&nbsp;&nbsp;3. Bluetooth setup (Vishal Gaurav)<br>&nbsp;&nbsp;4. Re: Is this list dead? Here is my problem... (John H.) <br>&nbsp;&nbsp;5. Re: Is this list dead? Here is my problem... (Anssi Saari)
<br>&nbsp;&nbsp;6. phone model and link manager version (Mikael Lindqvist)<br>&nbsp;&nbsp;7. Re: phone model and link manager version (Peter Stephenson)<br>&nbsp;&nbsp;8. meditation devil&#39;s advocate (Gwendoline J. Tapia) <br><br><br>----------------------------------------------------------------------
<br><br>Message: 1<br>Date: Thu, 8 Feb 2007 15:00:07 +0100<br>From: CIJOML &lt;<a onclick="return top.js.OpenExtLink(window,event,this)" href="mailto:cijoml@volny.cz" target="_blank">cijoml@volny.cz</a>&gt;<br>Subject: [Bluez-users] Logitech MediaPad HOWTO send info to display
<br>To: <a onclick="return top.js.OpenExtLink(window,event,this)" href="mailto:bluez-users@lists.sourceforge.net" target="_blank">bluez-users@lists.sourceforge.net</a><br>Message-ID: &lt;<a onclick="return top.js.OpenExtLink(window,event,this)" href="mailto:200702081500.07792.cijoml@volny.cz" target="_blank">
 200702081500.07792.cijoml@volny.cz</a>&gt;<br>Content-Type: text/plain;&nbsp;&nbsp;charset=&quot;iso-8859-2&quot;<br><br>Hi all,<br><br>I would like to know how to send some text (sensors stats the best and system<br>load) to the display on this MediaPad. I think Marcel made some work a year 
<br>ago in this direction, but I see no sources...<br><br>Any help?<br><br>Thanks a lot<br><br>Michal<br><br><br><br>------------------------------<br><br>Message: 2<br>Date: Thu, 08 Feb 2007 18:02:31 +0100<br>From: Gerhard Killesreiter &lt; 
<a onclick="return top.js.OpenExtLink(window,event,this)" href="mailto:gerhard@killesreiter.de" target="_blank">gerhard@killesreiter.de</a>&gt;<br>Subject: Re: [Bluez-users] headset /SCO / plugz<br>To: BlueZ users &lt;<a onclick="return top.js.OpenExtLink(window,event,this)" href="mailto:bluez-users@lists.sourceforge.net" target="_blank">
bluez-users@lists.sourceforge.net </a>&gt;<br>Message-ID: &lt;<a onclick="return top.js.OpenExtLink(window,event,this)" href="mailto:45CB57A7.1050505@killesreiter.de" target="_blank">45CB57A7.1050505@killesreiter.de</a>&gt;
<br>Content-Type: text/plain; charset=ISO-8859-1; format=flowed<br><br>Gerhard Killesreiter wrote:<br>&gt; Gerhard Killesreiter wrote: <br>&gt;&gt; Brad Midgley wrote:<br>&gt;&gt;&gt; Gerhard<br>&gt;&gt;&gt;<br>&gt;&gt;&gt;&gt; 6) now what? a2dpd doesn&#39;t show up in my output choices in xmms,
<br>&gt;&gt;&gt;&gt; &quot;headset&quot; shows up as a choice for the mixer device, but not the <br>&gt;&gt;&gt;&gt; general output device.<br>&gt;&gt;&gt; I have to type<br>&gt;&gt;&gt;&nbsp;&nbsp;a2dpd<br>&gt;&gt;&gt;&nbsp;&nbsp; or<br>&gt;&gt;&gt;&nbsp;&nbsp;headset
<br>&gt;&gt;&gt; freehand in the device choice in xmms. It&#39;s true it doesn&#39;t find it <br>&gt;&gt;&gt; automatically and we&#39;ve tried to document that.<br>&gt;&gt;&gt;<br>&gt;&gt;<br>&gt;&gt; Ok, tried that, but it still doesn&#39;t work.
<br>&gt;&gt;<br>&gt;&gt; Set to a2dpd and ran a2dpd:<br><br>Ok, I&#39;ve given up on a2dpd and tried headsetd for SCO (what I wanted to <br>do anyway): It works!<br><br>My problem apparently was that hibernating the laptop didn&#39;t allow
<br>usb/alsa/bluetooth to work properly after waking up the machine.<br>Switching the headset on/off also seems to help. I&#39;ve now added all usb <br>modules to the hibernate blacklist and will see if it still works after
<br>the next hibernation.<br><br>I have booted and headsetd will now work, I can direct sound output to<br>my headset as given on the &quot;build&quot; page and I can also record sound from <br>the microphone doing:<br><br>
arecord -D headset --format=S16_LE blah.wav<br><br>My problem is now that most apps don&#39;t allow for specific sound options<br>on the command line. I am thinking of skype and krut<br>(<a onclick="return top.js.OpenExtLink(window,event,this)" href="http://sourceforge.net/projects/krut/" target="_blank">
 http://sourceforge.net/projects/krut/</a>). Is there a way to make the<br>headset the default alsa device?<br><br>(later)<br><br>Apparently, the answer is yes and I need to modify my .asoundrc file.<br>Does anybody have a copy that works in such a way that when the headset 
<br>is available it is the default and in other cases the normal speaker/micro?<br><br><br>Cheers,<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Gerhard<br><br><br><br>------------------------------<br><br>Message: 3<br>Date: Fri, 9 Feb 2007 00:08:21 +0530<br>
From: &quot;Vishal Gaurav&quot; &lt;<a onclick="return top.js.OpenExtLink(window,event,this)" href="mailto:vishalgaurav01@gmail.com" target="_blank">vishalgaurav01@gmail.com</a>&gt;<br>Subject: [Bluez-users] Bluetooth setup
<br>To: <a onclick="return top.js.OpenExtLink(window,event,this)" href="mailto:bluez-users@lists.sourceforge.net" target="_blank">bluez-users@lists.sourceforge.net </a><br>Message-ID:<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &lt;<a onclick="return top.js.OpenExtLink(window,event,this)" href="mailto:9da2dbd10702081038w2116ea35k4af9e54a167c83a2@mail.gmail.com" target="_blank">
9da2dbd10702081038w2116ea35k4af9e54a167c83a2@mail.gmail.com</a>&gt;<br>Content-Type: text/plain; charset=&quot;iso-8859-1&quot; <br><br>I am just instaled Kubuntu on my desktop.I am new linux user.Can some one<br>know how can i setup bluetooth device with my phone to connect
<br>internet.Please help me.<br><br>--<br>Vishal Gaurav<br>-------------- next part -------------- <br>An HTML attachment was scrubbed...<br><br>------------------------------<br><br>Message: 4<br>Date: Thu, 8 Feb 2007 13:09:16 -0600
<br>From: &quot;John H.&quot; &lt;<a onclick="return top.js.OpenExtLink(window,event,this)" href="mailto:mistamaila@gmail.com" target="_blank">mistamaila@gmail.com </a>&gt;<br>Subject: Re: [Bluez-users] Is this list dead? Here is my problem...
<br>To: &quot;BlueZ users&quot; &lt;<a onclick="return top.js.OpenExtLink(window,event,this)" href="mailto:bluez-users@lists.sourceforge.net" target="_blank">bluez-users@lists.sourceforge.net</a>&gt;<br>Message-ID: <br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &lt;
<a onclick="return top.js.OpenExtLink(window,event,this)" href="mailto:5b9417770702081109r22d806fci366f0b01a678be73@mail.gmail.com" target="_blank">5b9417770702081109r22d806fci366f0b01a678be73@mail.gmail.com</a>&gt;<br>Content-Type: text/plain; charset=ISO-8859-1; format=flowed 
<br><br>It does, but that&#39;s not the point.&nbsp;&nbsp;I want to see if bluetooth is<br>working at all between your pc and the phone.<br><br>On 2/8/07, Xamindar &lt;<a onclick="return top.js.OpenExtLink(window,event,this)" href="mailto:junkxamindar@gmail.com" target="_blank">
junkxamindar@gmail.com</a> &gt; wrote:<br>&gt; John H. wrote:<br>&gt; &gt; Try unplugging the usb cable and turning off phone then back on... it<br>&gt; &gt; might also be worth your while to remove, in bluetooth settings, a
<br>&gt; &gt; reference on your phone to your computer. <br>&gt; &gt;<br>&gt; &gt; Then, just to be safe, put it in discovery mode and if there&#39;s a<br>&gt; &gt; setting for &quot;allow other computers to connect,&quot; do that.
<br>&gt; &gt;<br>&gt; &gt; But really, before all of this, please let us know if konqueror <br>&gt; &gt; bluetooth:/// can access your phone.<br>&gt; &gt;<br>&gt; Only kde programs I use are k3b and amarok.&nbsp;&nbsp;I really hope I don&#39;t have
<br>&gt; to go through the trouble of installing kde to get bluetooth working.&nbsp;&nbsp;I <br>&gt; may have to do that though, it seems kde has far superior bluetooth<br>&gt; support.&nbsp;&nbsp;I&#39;ll consider it.<br>&gt;<br>&gt;<br>&gt; -------------------------------------------------------------------------
<br>&gt; Using Tomcat but need to do more? Need to support web services, security? <br>&gt; Get stuff done quickly with pre-integrated technology to make your job easier.<br>&gt; Download IBM WebSphere Application Server 
v.1.0.1 based on Apache Geronimo<br>&gt; <a onclick="return top.js.OpenExtLink(window,event,this)" href="http://sel.as-us.falkag.net/sel?cmd=lnk&amp;kid=120709&amp;bid=263057&amp;dat=121642" target="_blank">http://sel.as-us.falkag.net/sel?cmd=lnk&amp;kid=120709&amp;bid=263057&amp;dat=121642
</a><br>&gt; _______________________________________________<br>&gt; Bluez-users mailing list<br>&gt; <a onclick="return top.js.OpenExtLink(window,event,this)" href="mailto:Bluez-users@lists.sourceforge.net" target="_blank">
Bluez-users@lists.sourceforge.net</a><br>&gt; <a onclick="return top.js.OpenExtLink(window,event,this)" href="https://lists.sourceforge.net/lists/listinfo/bluez-users" target="_blank">https://lists.sourceforge.net/lists/listinfo/bluez-users
</a><br>&gt;<br><br><br><br>------------------------------ <br><br>Message: 5<br>Date: Thu, 8 Feb 2007 22:03:39 +0200<br>From: Anssi Saari &lt;<a onclick="return top.js.OpenExtLink(window,event,this)" href="mailto:anssi.saari@modeemi.fi" target="_blank">
anssi.saari@modeemi.fi</a>&gt;<br>Subject: Re: [Bluez-users] Is this list dead? Here is my problem... <br>To: <a onclick="return top.js.OpenExtLink(window,event,this)" href="mailto:bluez-users@lists.sourceforge.net" target="_blank">
bluez-users@lists.sourceforge.net</a><br>Message-ID: &lt;<a onclick="return top.js.OpenExtLink(window,event,this)" href="mailto:20070208200339.GA15750@jolt.modeemi.cs.tut.fi" target="_blank">20070208200339.GA15750@jolt.modeemi.cs.tut.fi 
</a>&gt;<br>Content-Type: text/plain; charset=us-ascii<br><br>On Wed, Feb 07, 2007 at 01:42:00PM -0800, Xamindar wrote:<br>&gt; John H. wrote:<br>&gt; &gt; Yes, it looks as though you do.&nbsp;&nbsp;Can you do a regular rfcomm connect? 
<br>&gt; &gt; What if you use rfcomm1?<br>&gt; &gt;<br>&gt; What is a regular rfcomm connect?&nbsp;&nbsp;On the console it just gives me errors.<br><br>That would be rfcomm connect hci0 00:12:56:5A:92:59 8<br><br>Maybe you need to remove that weird stuff from 
rfcomm.conf first too. And what<br>about pairing, you haven&#39;t said anything about it?<br><br><br><br>------------------------------<br><br>Message: 6<br>Date: Fri, 9 Feb 2007 11:41:04 +0100<br>From: &quot;Mikael Lindqvist&quot; &lt; 
<a onclick="return top.js.OpenExtLink(window,event,this)" href="mailto:li.mikael.spam@gmail.com" target="_blank">li.mikael.spam@gmail.com</a>&gt;<br>Subject: [Bluez-users] phone model and link manager version<br>To: <a onclick="return top.js.OpenExtLink(window,event,this)" href="mailto:bluez-users@lists.sourceforge.net" target="_blank">
bluez-users@lists.sourceforge.net </a><br>Message-ID:<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &lt;<a onclick="return top.js.OpenExtLink(window,event,this)" href="mailto:b5dccebe0702090241w797ff03fk8dc41eb2e8881015@mail.gmail.com" target="_blank">b5dccebe0702090241w797ff03fk8dc41eb2e8881015@mail.gmail.com
</a>&gt;<br>Content-Type: text/plain; charset=ISO-8859-1; format=flowed <br><br>Hello,<br><br>I wonder if there is any correlation between the Link Manager Protocol<br>(LMP) Subversion and the model of a bluetooth phone. I mean, if I find
<br>out the LMP subversion of a remote device with for example hcitool, <br>like this:<br><br>sudo hcitool info &lt;bdaddr&gt;<br><br>Requesting information ...<br>...<br>LMP Version: 1.2 (0x2) LMP Subversion: 0x41c<br><br>
Can this subversion be used to identify the model of the phone?<br><br>If not, can it be used to suggest that the phone is any of a small set<br>of models?<br><br>If firmware updates are being made on the phone, will that affect the
<br>LMP subversion?<br><br>What process inside a phone manufacturer company decide that a <br>Bluetooth chip with a certain LMP subversion ends up in a specific<br>model? Is it just related to when the phone happened to be produced or
<br>is it somehow related to the model?<br><br>Thanks in advance!<br><br>-- Mikael <br><br><br><br>------------------------------<br><br>Message: 7<br>Date: Fri, 09 Feb 2007 11:02:17 +0000<br>From: Peter Stephenson &lt;<a onclick="return top.js.OpenExtLink(window,event,this)" href="mailto:pws@csr.com" target="_blank">
pws@csr.com</a>&gt;<br>Subject: Re: [Bluez-users] phone model and link manager version <br>To: BlueZ users &lt;<a onclick="return top.js.OpenExtLink(window,event,this)" href="mailto:bluez-users@lists.sourceforge.net" target="_blank">
bluez-users@lists.sourceforge.net</a>&gt;<br>Message-ID: &lt;<a onclick="return top.js.OpenExtLink(window,event,this)" href="mailto:200702091102.l19B2H0L012760@news01.csr.com" target="_blank">200702091102.l19B2H0L012760@news01.csr.com 
</a>&gt;<br>Content-Type: text/plain<br><br>&quot;Mikael Lindqvist&quot; wrote:<br>&gt; I wonder if there is any correlation between the Link Manager Protocol<br>&gt; (LMP) Subversion and the model of a bluetooth phone.<br>
<br>Yes and no, but mostly no.&nbsp;&nbsp;The LMP subversion is that of the link<br>manager on the Bluetooth chip, not (for example) the phone&#39;s GSM<br>baseband chip---unless Bluetooth is built into the latter, which is<br>possible but not very common.&nbsp;&nbsp;In either case it&#39;s probably not telling 
<br>you the sorts of things you want to know about the phone, simply about<br>the phone manufacturer&#39;s procurement policy.<br><br>Note that because they&#39;re telling you about the Bluetooth chip, the LMP<br>and HCI subversion numbers are useless without the Bluetooth 
<br>manufacturer ID (which is also reported).&nbsp;&nbsp;You can decode these<br>from <a onclick="return top.js.OpenExtLink(window,event,this)" href="http://www.bluetooth.org/assigned-numbers/company_identifiers.php" target="_blank">
http://www.bluetooth.org/assigned-numbers/company_identifiers.php</a> <br><br>There will be *some* correlation: an older version is likely to appear<br>in an older phone, obviously.&nbsp;&nbsp;But even the same model of phone might
<br>have a different version of the firmware, and in some cases even a <br>completely different Bluetooth chip.&nbsp;&nbsp;There&#39;s not even a requirement<br>that the LMP subversion is monotonically increasing with time.<br><br>
pws<br><br><br>To access the latest news from CSR copy this link into a web browser:&nbsp;&nbsp; <a onclick="return top.js.OpenExtLink(window,event,this)" href="http://www.csr.com/email_sig.php" target="_blank">http://www.csr.com/email_sig.php
</a><br><br>To get further information regarding CSR, please visit our Investor Relations page at <a onclick="return top.js.OpenExtLink(window,event,this)" href="http://ir.csr.com/csr/about/overview" target="_blank">http://ir.csr.com/csr/about/overview 
</a><br><br><br><br>------------------------------<br><br>Message: 8<br>Date: Fri, 9 Feb 2007 12:50:59 +0100<br>From: Gwendoline J. Tapia &lt;<a onclick="return top.js.OpenExtLink(window,event,this)" href="mailto:lmenht@devereux.homechoice.co.uk" target="_blank">
lmenht@devereux.homechoice.co.uk </a>&gt;<br>Subject: [Bluez-users] meditation devil&#39;s advocate<br>To: <a onclick="return top.js.OpenExtLink(window,event,this)" href="mailto:bluez-users@lists.sourceforge.net" target="_blank">
bluez-users@lists.sourceforge.net</a><br>Message-ID: &lt;<a onclick="return top.js.OpenExtLink(window,event,this)" href="mailto:45CC6023.2020407@devereux.homechoice.co.uk" target="_blank"> 45CC6023.2020407@devereux.homechoice.co.uk
</a>&gt;<br>Content-Type: text/plain; charset=&quot;us-ascii&quot;<br><br>An HTML attachment was scrubbed...<br>-------------- next part --------------<br>A non-text attachment was scrubbed... <br>Name: dud.gif<br>Type: image/gif
<br>Size: 14365 bytes<br>Desc: not available<br><br>------------------------------<br><br>-------------------------------------------------------------------------<br>Using Tomcat but need to do more? Need to support web services, security? 
<br>Get stuff done quickly with pre-integrated technology to make your job easier.<br>Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo<br><a onclick="return top.js.OpenExtLink(window,event,this)" href="http://sel.as-us.falkag.net/sel?cmd=lnk&amp;kid=120709&amp;bid=263057&amp;dat=121642" target="_blank">
http://sel.as-us.falkag.net/sel?cmd=lnk&amp;kid=120709&amp;bid=263057&amp;dat=121642</a><br><br>------------------------------<br><br>_______________________________________________<br>Bluez-users mailing list<br><a onclick="return top.js.OpenExtLink(window,event,this)" href="mailto:Bluez-users@lists.sourceforge.net" target="_blank">
Bluez-users@lists.sourceforge.net</a><br><a onclick="return top.js.OpenExtLink(window,event,this)" href="https://lists.sourceforge.net/lists/listinfo/bluez-users" target="_blank">https://lists.sourceforge.net/lists/listinfo/bluez-users
</a><br><br><br>End of Bluez-users Digest, Vol 10, Issue 11 <br>*******************************************<br></blockquote></div><br><br clear="all"><br></span></div>-- <br><span class="sg">Vishal Gaurav </span></blockquote>
</div><br><br clear="all"><br>-- <br>Vishal Gaurav 

------=_Part_28849_32460039.1171024099374--


--===============0930989844==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier.
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--===============0930989844==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============0930989844==--
