Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH] Make bluetooth-properties fit on smaller displays
From: Marcel Holtmann <marcel@holtmann.org>
To: David Sainty <David.Sainty@dtsp.co.nz>
Cc: Bastien Nocera <hadess@hadess.net>, Mario_Limonciello@Dell.com,
	linux-bluetooth@vger.kernel.org
In-Reply-To: <48E1DCA8.2040005@dtsp.co.nz>
References: <FA7963CC89065B49AED46A6F797F0FA6F28694@AUSX3MPC128.aus.amer.dell.com>
	 <1222679240.1825.14.camel@violet.holtmann.net>
	 <1222679724.3311.53.camel@cookie.hadess.net>
	 <FA7963CC89065B49AED46A6F797F0FA6F28698@AUSX3MPC128.aus.amer.dell.com>
	 <1222701730.3311.76.camel@cookie.hadess.net>  <48E1DCA8.2040005@dtsp.co.nz>
Content-Type: text/plain
Date: Tue, 30 Sep 2008 10:17:29 +0200
Message-Id: <1222762649.1825.56.camel@violet.holtmann.net>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi David,

> >> A lot of these MID devices don't have screens bigger than 1024x600
> >> (some 800x600 depending on their aspect ratio).  This change really
> >> just reorganizes the GUI so that both laptops and MID devices can use
> >> the same layout.  I'm attaching an updated patch relative to 1.6.
> >>     
> >
> > Both versions would fit on both those screens. What's wrong with leaving
> > it as is? In the worst case, I'd move the contextual buttons to the side
> > of the treeview, instead of underneath, and add labels to those buttons.
> >   
> The preferences dialog on an Eee PC (701) screen is a real pain, it is 
> too big vertically.  800x480 screen, plus a window manager bar at the 
> bottom, plus some chunky window decorations up the top.  For a window to 
> fit conveniently on a standard Eee PC screen it needs to be 422 pixels 
> vertically it looks like (the standard decorations are VERY chunky :)

the dialog ix 420x420 and thus it should fit.

Regards

Marcel


