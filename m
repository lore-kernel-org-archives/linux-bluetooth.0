Return-Path: <cyrus@holtmann.org>
Message-ID: <1337742738.15105.30.camel@aeonflux>
Subject: Re: [PATCHv2] Bluetooth: Send a configuration request after
 security confirmation
From: Marcel Holtmann <marcel@holtmann.org>
To: Mat Martineau <mathewm@codeaurora.org>
Cc: linux-bluetooth@vger.kernel.org, gustavo@padovan.org,
	pkrystad@codeaurora.org
Date: Wed, 23 May 2012 05:12:18 +0200
In-Reply-To: <1337720145-8019-1-git-send-email-mathewm@codeaurora.org>
References: <1337720145-8019-1-git-send-email-mathewm@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mat,

> Sometimes an ACL link must be raised to a higher security level after
> an L2CAP connection is requested, but before a connection response is
> sent.  In this case, a connection response sent by L2CAP was not
> immediately followed by a configuration request.  Other code paths do
> send this configuration request right away.  It was possible for the
> connection to time out while L2CAP waited for the remote device (like
> PTS) to trigger the configuration process.
> 
> This change immediately sends a configuration request after a connect
> response rather than waiting for a configuration request from the
> remote device.  It fixes connection stalls in a variety of PTS test
> cases.

any change you can add a before and after hcidump in the commit message?

Regards

Marcel


