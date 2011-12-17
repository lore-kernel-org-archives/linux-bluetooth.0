Return-Path: <cyrus@holtmann.org>
Date: Sat, 17 Dec 2011 19:34:56 -0200
From: Gustavo Padovan <padovan@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Subject: Re: [RFC 00/22] Bluetooth: change tasklets to workqueue
Message-ID: <20111217213456.GA2621@joana>
References: <1324157382-1815-1-git-send-email-padovan@profusion.mobi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1324157382-1815-1-git-send-email-padovan@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

* Gustavo F. Padovan <padovan@profusion.mobi> [2011-12-17 19:29:20 -0200]:

> From: "Gustavo F. Padovan" <padovan@profusion.mobi>
> 
> Here are the patches to run the receive path in workqueue.  With these patches
> l2cap and rfcomm seems to be working fine, but some more work still needs to be
> done.

You can also check the ongoing work at 

http://git.kernel.org/?p=linux/kernel/git/padovan/bluetooth-testing.git

	Gustavo
