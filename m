Return-Path: <cyrus@holtmann.org>
Date: Tue, 30 Jun 2009 16:34:39 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Filippo Giunchedi <filippo@esaurito.net>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 3/4] test/agent.c: register object path only
Message-ID: <20090630133439.GA27640@jh-x301>
References: <1246213659-24559-1-git-send-email-filippo@esaurito.net> <1246213659-24559-3-git-send-email-filippo@esaurito.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1246213659-24559-3-git-send-email-filippo@esaurito.net>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Sun, Jun 28, 2009, Filippo Giunchedi wrote:
> remove unused register_agent and unregister_agent, will be handled by
> CreatePairedDevice

I don't think we want to remove the RegisterAgent and UnregisterAgent
feature. It is needed when you want the agent to passively wait for
incoming pairing request. E.g. the simple-agent script supports it too
when you run it without arguments.

So could you please redo the patches so that the Register/UnregisterAgent
support remains. Thanks.

Johan
