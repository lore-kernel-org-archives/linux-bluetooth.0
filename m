Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: RE: [PATCH] Make bluetooth-properties fit on smaller displays
Date: Tue, 30 Sep 2008 08:38:02 -0500
Message-ID: <FA7963CC89065B49AED46A6F797F0FA6F2869C@AUSX3MPC128.aus.amer.dell.com>
References: <FA7963CC89065B49AED46A6F797F0FA6F28694@AUSX3MPC128.aus.amer.dell.com>	 <1222679240.1825.14.camel@violet.holtmann.net>	 <1222679724.3311.53.camel@cookie.hadess.net>	 <FA7963CC89065B49AED46A6F797F0FA6F28698@AUSX3MPC128.aus.amer.dell.com>	 <1222701730.3311.76.camel@cookie.hadess.net>  <48E1DCA8.2040005@dtsp.co.nz> <1222762649.1825.56.camel@violet.holtmann.net> <48E1E9D3.8050202@dtsp.co.nz>
From: <Mario_Limonciello@Dell.com>
To: <david.sainty@dtsp.co.nz>,
	<marcel@holtmann.org>
Cc: <hadess@hadess.net>,
	<linux-bluetooth@vger.kernel.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Folks:

I would think the DPI of the environment is playing into this.  David, =
what DPI is on your EEE?

Regards

Mario Limonciello=20
Dell | Linux Engineering=20
Mario_Limonciello@Dell.com=20



-----Original Message-----
From: David Sainty [mailto:david.sainty@dtsp.co.nz]
Sent: Tue 9/30/2008 3:56 AM
To: Marcel Holtmann
Cc: Bastien Nocera; Limonciello, Mario; linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Make bluetooth-properties fit on smaller displays
=20
Marcel Holtmann wrote:
> Hi David,
>
>  =20
>>>> A lot of these MID devices don't have screens bigger than 1024x600
>>>> (some 800x600 depending on their aspect ratio).  This change really
>>>> just reorganizes the GUI so that both laptops and MID devices can =
use
>>>> the same layout.  I'm attaching an updated patch relative to 1.6.
>>>>    =20
>>>>        =20
>>> Both versions would fit on both those screens. What's wrong with =
leaving
>>> it as is? In the worst case, I'd move the contextual buttons to the =
side
>>> of the treeview, instead of underneath, and add labels to those =
buttons.
>>>  =20
>>>      =20
>> The preferences dialog on an Eee PC (701) screen is a real pain, it =
is=20
>> too big vertically.  800x480 screen, plus a window manager bar at the =

>> bottom, plus some chunky window decorations up the top.  For a window =
to=20
>> fit conveniently on a standard Eee PC screen it needs to be 422 =
pixels=20
>> vertically it looks like (the standard decorations are VERY chunky :)
>>    =20
>
> the dialog ix 420x420 and thus it should fit.
>  =20
Interesting - that's not what I'm seeing.  I've just tried xwininfo on=20
bluez-gnome-1.7 on both an Eee PC and a full sized PC (possibly with=20
slightly different support library versions).

Full sized PC geometry for the preferences window is 420x521.  EeePC=20
geometry for the same is 420x523.
  I'm not sure where the 2 pixel difference comes from (I don't think=20
the geometry here is including the window manager decorations).  But=20
neither are close to 420x420.  You weren't thinking 420x520 perchance?
