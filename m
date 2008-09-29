Return-Path: <cyrus@holtmann.org>
Subject: RE: [PATCH] Make bluetooth-properties fit on smaller displays
From: Bastien Nocera <hadess@hadess.net>
To: Mario_Limonciello@Dell.com
Cc: marcel@holtmann.org, linux-bluetooth@vger.kernel.org
In-Reply-To: <FA7963CC89065B49AED46A6F797F0FA6F28698@AUSX3MPC128.aus.amer.dell.com>
References: 
	 <FA7963CC89065B49AED46A6F797F0FA6F28694@AUSX3MPC128.aus.amer.dell.com>
	 <1222679240.1825.14.camel@violet.holtmann.net>
	 <1222679724.3311.53.camel@cookie.hadess.net>
	 <FA7963CC89065B49AED46A6F797F0FA6F28698@AUSX3MPC128.aus.amer.dell.com>
Content-Type: text/plain
Date: Mon, 29 Sep 2008 16:22:10 +0100
Message-Id: <1222701730.3311.76.camel@cookie.hadess.net>
Mime-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>

On Mon, 2008-09-29 at 10:05 -0500, Mario_Limonciello@Dell.com wrote:
> Hi Bastien & Marcel:
> 
> Here's the screenshots as requested:
> 
> Old: http://imagebin.org/27644
> 
> New: http://imagebin.org/27643
> 
> A lot of these MID devices don't have screens bigger than 1024x600
> (some 800x600 depending on their aspect ratio).  This change really
> just reorganizes the GUI so that both laptops and MID devices can use
> the same layout.  I'm attaching an updated patch relative to 1.6.

Both versions would fit on both those screens. What's wrong with leaving
it as is? In the worst case, I'd move the contextual buttons to the side
of the treeview, instead of underneath, and add labels to those buttons.
