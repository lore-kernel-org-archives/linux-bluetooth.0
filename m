Return-Path: <cyrus@holtmann.org>
Date: Fri, 02 Oct 2009 01:55:27 +0100
From: Rick Jones <rick@activeservice.co.uk>
To: Bastien Nocera <hadess@hadess.net>, Dan Williams <dcbw@redhat.com>
Subject: Re: So very close, but so frustrating...
Message-ID: <CB7A3691FBC7EB0E857B7330@mineee>
In-Reply-To: <1254439169.22191.317.camel@localhost.localdomain>
References: <4AC3EFD9.1020602@shic.co.uk>
	<7cd7fc040909301718r3e441c53x767084b0b01f4a7c@mail.gmail.com>
	<1254433173.9657.155.camel@localhost.localdomain>
	<1254439169.22191.317.camel@localhost.localdomain>
MIME-Version: 1.0
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>,
	networkmanager-list@gnome.org
List-Unsubscribe: <http://mail.gnome.org/mailman/options/networkmanager-list>,
	<mailto:networkmanager-list-request@gnome.org?subject=unsubscribe>
List-Archive: <http://mail.gnome.org/archives/networkmanager-list/>
List-Post: <mailto:networkmanager-list@gnome.org>
List-Help: <mailto:networkmanager-list-request@gnome.org?subject=help>
List-Subscribe: <http://mail.gnome.org/mailman/listinfo/networkmanager-list>,
	<mailto:networkmanager-list-request@gnome.org?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0565932402=="
Sender: networkmanager-list-bounces@gnome.org
Errors-To: networkmanager-list-bounces@gnome.org
List-ID: <linux-bluetooth.vger.kernel.org>

--===============0565932402==
Content-Type: multipart/alternative;
 boundary="==========859D65B41421F3EA5F3C=========="
Content-Disposition: inline

--==========859D65B41421F3EA5F3C==========
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

I've just installed blueman, to replace bluez-gnome, and it does this 
perfectly.

It's a much better UI-oriented manager for BT devices altogether, it shows 
my phone, I click on "attach serial service", and it exposes the BT modem 
in DBus. NM 0.7 sees it just like a USB modem and it connects first time. 
Magic!

I'm too hardened to be often impressed first-time with a piece of software, 
but this was spot-on (does audio, obex, etc just as neatly). OK, it takes a 
couple of extra clicks to connect the phone, which I guess a built-in NM 
implementation could do automatically, but that's pretty minor.

Rick

--On Friday, October 02, 2009 00:19:29 +0100 Bastien Nocera 
<hadess@hadess.net> wrote:

> On Thu, 2009-10-01 at 14:39 -0700, Dan Williams wrote:
> > On Wed, 2009-09-30 at 20:18 -0400, Darren Albers wrote:
> <snip>
> > > At this time Network Manager does not support Bluetooth modems.   I
> > > think 0.8 supports phones if they use Bluetooth PAN but not Bluetooth
> > > DUN.
> >
> > Correct; I may just get bored enough today triaging bugs to go implement
> > DUN in 0.8.  That opens up a huge number of cellphones, which will
> > inevitably lead to even more bugs since there's much more phone
> > variation than in the relatively small data card space.  Oh well; it
> > would help a lot of people out.
>
> 1. Add ability for MM to identify Bluetooth modems
> 2. Add plugin in bluez to poke at the modem with MM if it doesn't know
> the type of device, cache the result, the bluez plugin exports the
> information through a service
> 3. Add DUN gnome-bluetooth plugin to nm-applet which would poke the
> bluez service
> 4. Add native support in NM to do the connection through bluetoothd
>
> After 3., if the box is ticked, the device should appear like an
> unconfigured WWAN modem to the user. The service configuration can then
> be done through nm-applet.
>
> I can certainly take care of 2. and 3. if you do 1. and the left-overs
> of 4 :)
>
> Cheers
>
>
>



--==========859D65B41421F3EA5F3C==========
Content-Type: text/html; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

<HTML>

<BODY>

I've just installed blueman, to replace bluez-gnome, and it does this =
perfectly.<br>
<br>
It's a much better UI-oriented manager for BT devices altogether, it shows =
my phone, I click on &quot;attach serial service&quot;, and it exposes the =
BT modem in DBus. NM 0.7 sees it just like a USB modem and it connects =
first time. Magic!<br>
<br>
I'm too hardened to be often impressed first-time with a piece of software, =
but this was spot-on (does audio, obex, etc just as neatly). OK, it takes a =
couple of extra clicks to connect the phone, which I guess a built-in NM =
implementation could do automatically, but that's pretty minor.<br>
<br>
Rick<br>
<br>
--On Friday, October 02, 2009 00:19:29 +0100 Bastien Nocera =
&lt;hadess@hadess.net&gt; wrote:<br>
<font color=3D"#993366"><br>
&gt; On Thu, 2009-10-01 at 14:39 -0700, Dan Williams wrote:<br>
&gt; &gt; On Wed, 2009-09-30 at 20:18 -0400, Darren Albers wrote:<br>
&gt; &lt;snip&gt;<br>
&gt; &gt; &gt; At this time Network Manager does not support Bluetooth =
modems.&nbsp;&nbsp;&nbsp;I<br>
&gt; &gt; &gt; think 0.8 supports phones if they use Bluetooth PAN but not =
Bluetooth<br>
&gt; &gt; &gt; DUN.<br>
&gt; &gt; <br>
&gt; &gt; Correct; I may just get bored enough today triaging bugs to go =
implement<br>
&gt; &gt; DUN in 0.8.&nbsp;&nbsp;That opens up a huge number of cellphones, =
which will<br>
&gt; &gt; inevitably lead to even more bugs since there's much more =
phone<br>
&gt; &gt; variation than in the relatively small data card =
space.&nbsp;&nbsp;Oh well; it<br>
&gt; &gt; would help a lot of people out.<br>
&gt; <br>
&gt; 1. Add ability for MM to identify Bluetooth modems<br>
&gt; 2. Add plugin in bluez to poke at the modem with MM if it doesn't =
know<br>
&gt; the type of device, cache the result, the bluez plugin exports the<br>
&gt; information through a service<br>
&gt; 3. Add DUN gnome-bluetooth plugin to nm-applet which would poke =
the<br>
&gt; bluez service<br>
&gt; 4. Add native support in NM to do the connection through =
bluetoothd<br>
&gt; <br>
&gt; After 3., if the box is ticked, the device should appear like an<br>
&gt; unconfigured WWAN modem to the user. The service configuration can =
then<br>
&gt; be done through nm-applet.<br>
&gt; <br>
&gt; I can certainly take care of 2. and 3. if you do 1. and the =
left-overs<br>
&gt; of 4 :)<br>
&gt; <br>
&gt; Cheers<br>
&gt; <br>
&gt; <br>
&gt; </font><br>
<br>
<br>


</BODY>

</HTML>

--==========859D65B41421F3EA5F3C==========--


--===============0565932402==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
NetworkManager-list mailing list
NetworkManager-list@gnome.org
http://mail.gnome.org/mailman/listinfo/networkmanager-list

--===============0565932402==--
