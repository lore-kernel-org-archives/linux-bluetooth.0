Return-Path: <cyrus@holtmann.org>
Message-ID: <3e9cdced0806111111o2f4d922ai8ee7fe501e4f0b2b@mail.gmail.com>
Date: Wed, 11 Jun 2008 20:11:16 +0200
From: "Fritz Code" <codefritz@googlemail.com>
To: "BlueZ users" <bluez-users@lists.sourceforge.net>
In-Reply-To: <1213188654.1593.15.camel@pcmik05.zmk.uni-kl.de>
MIME-Version: 1.0
References: <3e9cdced0806110010v2d5db37di201da69e956e2194@mail.gmail.com>
	<1213176225.1593.8.camel@pcmik05.zmk.uni-kl.de>
	<3e9cdced0806110233w2252f8f4od7a49ea09676079b@mail.gmail.com>
	<1213188654.1593.15.camel@pcmik05.zmk.uni-kl.de>
Subject: Re: [Bluez-users] hidd and hidp
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0806870705=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============0806870705==
Content-Type: multipart/alternative;
	boundary="----=_Part_14637_2742776.1213207876516"

------=_Part_14637_2742776.1213207876516
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Wed, Jun 11, 2008 at 2:50 PM, Thomas Ilnseher <illth@gmx.de> wrote:

>
> Am Mittwoch, den 11.06.2008, 11:33 +0200 schrieb Fritz Code:
> > Thanks for your help so far.
> > I will take a look in detail concerning the functionality of hidp and
> > its real prerequisites.
> > The thing is, I can only use Kernel 2.4.21.
> > It might be ok to port the module hidp to kernel 2.4 but if it also
> > uses a generic HID Impl. of 2.6 which is total different to the one in
> > 2.4 it might be too much work..
> It is very different to 2.4 'cause 2.4 has an integrated usbhid driver.
> i think bt was teh reason for the split in 2.6 ...
> > However, I've also tried bthid of Peter Klausler, it worked fine so
> > far, but if the Keyboard goes in idle-mode and tries to reconnect,
> > bthid crashes with a segmentation fault. So there seems to be a bug in
> > the listen mode of bthid.
> never heard of that.
>
> Just to be curious: are you using some kind of hacked 2.4 kernel for
> some embedded system, or are there other reasons why you want to stay
> with 2.4 ?

yes thats right.

Btw, it seems Version 1.1 of hidp doesnt use the generiv HID input system
but the traditional input system of linux (input/input.c).

>
> >
> > So I will still focus both strategies... we will see which one is
> better...
> > 1. porting hipd, hidd to Kernel 2.4!
> > 2. debugging bthid!
> >
> > Any help, hints are welcome...
>
> >
> >
> --
> Thomas Ilnseher <illth@gmx.de>
>
>
> -------------------------------------------------------------------------
> Check out the new SourceForge.net Marketplace.
> It's the best place to buy or sell services for
> just about anything Open Source.
> http://sourceforge.net/services/buy/index.php
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users
>



-- 
Regards,
--Codefritz

------=_Part_14637_2742776.1213207876516
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<br><br><div class="gmail_quote">On Wed, Jun 11, 2008 at 2:50 PM, Thomas Ilnseher &lt;<a href="mailto:illth@gmx.de">illth@gmx.de</a>&gt; wrote:<br><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
<br>
Am Mittwoch, den 11.06.2008, 11:33 +0200 schrieb Fritz Code:<br>
<div class="Ih2E3d">&gt; Thanks for your help so far.<br>
&gt; I will take a look in detail concerning the functionality of hidp and<br>
&gt; its real prerequisites.<br>
&gt; The thing is, I can only use Kernel <a href="http://2.4.21." target="_blank">2.4.21.</a><br>
&gt; It might be ok to port the module hidp to kernel 2.4 but if it also<br>
&gt; uses a generic HID Impl. of 2.6 which is total different to the one in<br>
&gt; 2.4 it might be too much work..<br>
</div>It is very different to 2.4 &#39;cause 2.4 has an integrated usbhid driver.<br>
i think bt was teh reason for the split in 2.6 ...<br>
<div class="Ih2E3d">&gt; However, I&#39;ve also tried bthid of Peter Klausler, it worked fine so<br>
&gt; far, but if the Keyboard goes in idle-mode and tries to reconnect,<br>
&gt; bthid crashes with a segmentation fault. So there seems to be a bug in<br>
&gt; the listen mode of bthid.<br>
</div>never heard of that.<br>
<br>
Just to be curious: are you using some kind of hacked 2.4 kernel for<br>
some embedded system, or are there other reasons why you want to stay<br>
with 2.4 ?</blockquote><div>yes thats right. <br><br>Btw, it seems Version 1.1 of hidp doesnt use the generiv HID input system but the traditional input system of linux (input/input.c).<br></div><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
<br>
<div class="Ih2E3d">&gt;<br>
&gt; So I will still focus both strategies... we will see which one is better...<br>
&gt; 1. porting hipd, hidd to Kernel 2.4!<br>
&gt; 2. debugging bthid!<br>
&gt;<br>
&gt; Any help, hints are welcome...<br>
<br>
&gt;<br>
&gt;<br>
</div>--<br>
<div><div></div><div class="Wj3C7c">Thomas Ilnseher &lt;<a href="mailto:illth@gmx.de">illth@gmx.de</a>&gt;<br>
<br>
<br>
-------------------------------------------------------------------------<br>
Check out the new SourceForge.net Marketplace.<br>
It&#39;s the best place to buy or sell services for<br>
just about anything Open Source.<br>
<a href="http://sourceforge.net/services/buy/index.php" target="_blank">http://sourceforge.net/services/buy/index.php</a><br>
_______________________________________________<br>
Bluez-users mailing list<br>
<a href="mailto:Bluez-users@lists.sourceforge.net">Bluez-users@lists.sourceforge.net</a><br>
<a href="https://lists.sourceforge.net/lists/listinfo/bluez-users" target="_blank">https://lists.sourceforge.net/lists/listinfo/bluez-users</a><br>
</div></div></blockquote></div><br><br clear="all"><br>-- <br>Regards,<br>--Codefritz<br><br><br><br>

------=_Part_14637_2742776.1213207876516--


--===============0806870705==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://sourceforge.net/services/buy/index.php
--===============0806870705==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============0806870705==--
