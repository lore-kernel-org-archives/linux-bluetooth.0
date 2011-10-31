Return-Path: <cyrus@holtmann.org>
Date: Mon, 31 Oct 2011 17:01:29 -0200
From: Gustavo Padovan <padovan@profusion.mobi>
To: Arek Lichwa <arkadiusz.lichwa@tieto.com>
Cc: linux-bluetooth@vger.kernel.org, iliak@ti.com,
	ulrik.lauren@stericsson.com
Subject: Re: [PATCH cover letter] Bluetooth: Revert: Fix L2CAP connection ...
Message-ID: <20111031190129.GA10164@joana>
References: <1319621002-7122-1-git-send-email-arkadiusz.lichwa@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1319621002-7122-1-git-send-email-arkadiusz.lichwa@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Arek,

* Arek Lichwa <arkadiusz.lichwa@tieto.com> [2011-10-26 11:23:21 +0200]:

> Hi
> 
> We found during testing problem when setting rfcomm (SPP) channel between
> two 2.1 devices. 
> The test case always failed mostly saying security block on l2cap level 
> but sometimes the fail root cause was 'Command not understood' on l2cap 
> as well.
> Analyzing security block issue, I found that there's unencrypted link when
> l2cap command 'connection request' is sent to remote.
> The second issue with 'command not understood' has turn out to be related to 
> expiration of l2cap timer and its implications.
> 
> Solution that I found to fix the problem seems to be related to old commit 
> 330605423ca6eafafb8dcc27502bce1c585d1b06 made by Ilia Kolomisnky. When there's
> authentication ongoing, 'encryption pending' should be turn on, otherwise 
> there're situations when link stays unencrypted. 
> The issue with timer expiration is related to Andrzej Kaczmarek's patch 
> sent to community a couple days ago (~ 2011/10/20). 
> This patch actually recalculates (repairs) timer values on l2cap which were 
> wrongly converted before. 
> With this patch the expiration issue disappears during the test case 
> I've made, otherwise just reverting 330605423ca6eafafb8dcc27502bce1c585d1b06
> is not enough, since timer issue blocks very often passing the test case.

Are you saying that Andrzej's patch together with revert of 330605423 fixes
the problem? and are you sure that we are not creating any new regression?

	Gustavo
