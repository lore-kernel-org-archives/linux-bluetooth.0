Return-Path: <cyrus@holtmann.org>
Date: Wed, 14 Sep 2011 00:51:04 -0300
From: Gustavo Padovan <padovan@profusion.mobi>
To: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCHv1 5/5] Bluetooth: EWS: prevent unneeded fragmentation in
 l2cap
Message-ID: <20110914035104.GN16856@joana>
References: <1315404314-12045-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1315404314-12045-6-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1315404314-12045-6-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

* Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com> [2011-09-07 17:05:14 +0300]:

> From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> 
> Calculate pdu length before creating I-frame. Otherwise if
> conn->mtu - (headers) < remote_mps we get fragmented packets in
> create_iframe_pdu function.

You might check the way we set the remote_mps, it seems you are not taking
that in account.

	Gustavo
