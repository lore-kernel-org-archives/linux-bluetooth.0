Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon@janc.net.pl>
To: Peter Hurley <peter@hurleysoftware.com>
Subject: Re: [PATCH] Bluetooth: Increase command tx timeout
Date: Tue, 26 Jul 2011 21:52:23 +0200
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
References: <1311189131-8592-1-git-send-email-szymon@janc.net.pl> <1311264883.17476.65.camel@THOR>
In-Reply-To: <1311264883.17476.65.camel@THOR>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <201107262152.23761.szymon@janc.net.pl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Peter,

> Respectfully, I disagree that this is the correct fix for this problem.
> 
> After an HCI_Reset, *no* hci commands should be issued until after the
> *successful* Command Complete is received. IMHO, the current code
> suffers two defects:
>   - it doesn't wait for Command Complete after the Reset command is sent
>   - it ignores the result code from that Command Complete
> 
> I believe the proper fix is to _loop_ over the HCI_Reset until a
> successful Command Complete is received.

Yes, You've got a point.. I've already prepared and tested a proper fix and 
will send it shortly.

Thanks for advice!

-- 
Szymon K. Janc
szymon@janc.net.pl // GG: 1383435

