Return-Path: <cyrus@holtmann.org>
Subject: RE: [PATCH] Make bluetooth-properties fit on smaller displays
From: Marcel Holtmann <marcel@holtmann.org>
To: Bastien Nocera <hadess@hadess.net>
Cc: Mario_Limonciello@Dell.com, linux-bluetooth@vger.kernel.org
In-Reply-To: <1222701730.3311.76.camel@cookie.hadess.net>
References: <FA7963CC89065B49AED46A6F797F0FA6F28694@AUSX3MPC128.aus.amer.dell.com>
	 <1222679240.1825.14.camel@violet.holtmann.net>
	 <1222679724.3311.53.camel@cookie.hadess.net>
	 <FA7963CC89065B49AED46A6F797F0FA6F28698@AUSX3MPC128.aus.amer.dell.com>
	 <1222701730.3311.76.camel@cookie.hadess.net>
Content-Type: text/plain
Date: Tue, 30 Sep 2008 01:41:33 +0200
Message-Id: <1222731693.1825.22.camel@violet.holtmann.net>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Bastien,

> > Here's the screenshots as requested:
> > 
> > Old: http://imagebin.org/27644
> > 
> > New: http://imagebin.org/27643
> > 
> > A lot of these MID devices don't have screens bigger than 1024x600
> > (some 800x600 depending on their aspect ratio).  This change really
> > just reorganizes the GUI so that both laptops and MID devices can use
> > the same layout.  I'm attaching an updated patch relative to 1.6.
> 
> Both versions would fit on both those screens. What's wrong with leaving
> it as is? In the worst case, I'd move the contextual buttons to the side
> of the treeview, instead of underneath, and add labels to those buttons.

I really don't see the advantage of the vertical layout. For the buttons
I tried to use a ToolBar, but that looks ugly since I can get rid of the
top and bottom frame. Otherwise we could have put that to the right of
the TreeView and saved the extra space you guys need.

Regards

Marcel



