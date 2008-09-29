Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH] Start wizard when left clicked
From: Bastien Nocera <hadess@hadess.net>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Mario_Limonciello@Dell.com, linux-bluetooth@vger.kernel.org
In-Reply-To: <1222679136.1825.12.camel@violet.holtmann.net>
References: 
	 <FA7963CC89065B49AED46A6F797F0FA6F28695@AUSX3MPC128.aus.amer.dell.com>
	 <1222678144.3311.47.camel@cookie.hadess.net>
	 <1222679136.1825.12.camel@violet.holtmann.net>
Content-Type: text/plain
Date: Mon, 29 Sep 2008 10:12:52 +0100
Message-Id: <1222679572.3311.51.camel@cookie.hadess.net>
Mime-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>

On Mon, 2008-09-29 at 11:05 +0200, Marcel Holtmann wrote:
> Hi Bastien,
> 
> > > Currently the applet doesn't seem to respond to any actions when left
> > > clicked unless it's blinking.  This is counter intuitive from the
> > > expectation that something will happen when left clicked.  Attached is
> > > a patch that will spawn the wizard when left clicked, or stop blinking
> > > if it was.
> > 
> > I'd rather it popped up the right-click menu instead of popping up the
> > wizard.
> 
> I added a simple menu to the left-click to allow starting the wizard.

Why a separate/different menu?
