Return-Path: <cyrus@holtmann.org>
Message-ID: <1386634200.5021.4.camel@nuvo>
Subject: Re: [PATCH] core: Fix crash due to agent callback freeing the agent
From: Bastien Nocera <hadess@hadess.net>
To: Szymon Janc <szymon.janc@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Tue, 10 Dec 2013 01:10:00 +0100
In-Reply-To: <1386634100.5021.2.camel@nuvo>
References: <1386616856-16140-1-git-send-email-szymon.janc@gmail.com>
	 <1386634100.5021.2.camel@nuvo>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Tue, 2013-12-10 at 01:08 +0100, Bastien Nocera wrote:
> On Mon, 2013-12-09 at 20:20 +0100, Szymon Janc wrote:
> > Similar fix was provided for simple_agent_reply in a2f5d438 but missed
> > pincode_reply case.
> 
> That fixes the bug I reported in:
> http://thread.gmane.org/gmane.linux.bluez.kernel/41496

Though I'd still add an assertion in all the unref() calls you can find
in the bluez tree.

