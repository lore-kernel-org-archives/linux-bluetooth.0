Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH 1/1] Bluetooth: Synchronize SCO/eSCO connection
 requests to ACL state
From: Marcel Holtmann <marcel@holtmann.org>
To: Ron Shaffer <rshaffer@codeaurora.org>
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <4BFD307B.6060805@codeaurora.org>
References: <4BFAEB65.2060503@codeaurora.org>
	 <1274864356.27220.155.camel@localhost.localdomain>
	 <4BFD307B.6060805@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 26 May 2010 17:31:57 +0200
Message-ID: <1274887917.27220.166.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ron,

> I'll split the patch into three. No problem. When I resubmit, I'll push
> the hcidump log out as well. Because the failure occurs during eSCO 
> negotiation and SCO request with the remote, most of the interesting 
> stuff is in LMP, so I'll include the FTS sniffer trace as well.

don't bother with FTS traces. I don't care. I just need to see the
output of hcidump -X -V so that I can figure out what the problem is
here and what are possible solutions. Send the hcidump now before
redoing the patches.

Regards

Marcel


