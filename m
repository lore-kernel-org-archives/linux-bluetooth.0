Return-Path: <kevin.baradon@gmail.com>
Message-ID: <bd87e7590607261504y5ee8867dp6ce89b5405b39a79@mail.gmail.com>
Date: Thu, 27 Jul 2006 00:04:07 +0200
From: "Kevin Baradon" <kevin.baradon@gmail.com>
To: "Marcel Holtmann" <marcel@holtmann.org>
Subject: Re: [Bluez-devel] Lockdep: possible recursive locking detected in hidd
Cc: "BlueZ development" <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1153899329.746.24.camel@localhost>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_13561_20164494.1153951447541"
References: <200607181921.52647.Kevin.Baradon@gmail.com>
	 <1153899329.746.24.camel@localhost>
List-ID: <bluez-devel.lists.sourceforge.net>

------=_Part_13561_20164494.1153951447541
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

2006/7/26, Marcel Holtmann <marcel@holtmann.org>:
>
> Hi Kevin,


Hi,

> I've got a Logitech Bluetooth keyboard.
> > With lockdep enabled, I've got the following message just after boot,
> after
>
> this looks like a lock problem in L2CAP. We fixed one, but I am not sure
> if it already made it into 2.6.18-rc2 or not. Can you give the latest
> tree from Linus repository a try?


Since I'm on holiday, I don't have any access to my box.
I will try with a fresh tree as soon as possible (maybe not before the end
of august).
I will keep you informed.

Regards


Regards.

Marcel


--
Kevin Baradon
Networks & Telecom Student
-

------=_Part_13561_20164494.1153951447541
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<div><span class="gmail_quote">2006/7/26, Marcel Holtmann &lt;<a href="mailto:marcel@holtmann.org">marcel@holtmann.org</a>&gt;:</span>
<blockquote class="gmail_quote" style="PADDING-LEFT: 1ex; MARGIN: 0px 0px 0px 0.8ex; BORDER-LEFT: #ccc 1px solid">Hi Kevin,</blockquote>
<div>&nbsp;</div>
<div>Hi,</div><br>
<blockquote class="gmail_quote" style="PADDING-LEFT: 1ex; MARGIN: 0px 0px 0px 0.8ex; BORDER-LEFT: #ccc 1px solid">&gt; I've got a Logitech Bluetooth keyboard.<br>&gt; With lockdep enabled, I've got the following message just after boot, after
<br><br>this looks like a lock problem in L2CAP. We fixed one, but I am not sure<br>if it already made it into 2.6.18-rc2 or not. Can you give the latest<br>tree from Linus repository a try?</blockquote>
<div>&nbsp;</div>
<div>Since&nbsp;I'm on holiday,&nbsp;I don't have any access to my box. </div>
<div>I will try with a fresh tree as soon as possible (maybe not before the&nbsp;end of august).</div>
<div>I will keep you informed.</div><br>
<blockquote class="gmail_quote" style="PADDING-LEFT: 1ex; MARGIN: 0px 0px 0px 0.8ex; BORDER-LEFT: #ccc 1px solid">Regards</blockquote>
<div>&nbsp;</div>
<div>Regards.</div><br>
<blockquote class="gmail_quote" style="PADDING-LEFT: 1ex; MARGIN: 0px 0px 0px 0.8ex; BORDER-LEFT: #ccc 1px solid">Marcel</blockquote>
<div>&nbsp;</div>
<div>--</div>
<div>Kevin Baradon</div>
<div>Networks &amp; Telecom Student</div>
<div>-</div></div>

------=_Part_13561_20164494.1153951447541--
