Return-Path: <cyrus@holtmann.org>
Message-ID: <1324160268.1965.92.camel@aeonflux>
Subject: Re: [RFC 00/22] Bluetooth: change tasklets to workqueue
From: Marcel Holtmann <marcel@holtmann.org>
To: "Gustavo F. Padovan" <padovan@profusion.mobi>
Cc: linux-bluetooth@vger.kernel.org
Date: Sat, 17 Dec 2011 14:17:48 -0800
In-Reply-To: <1324157382-1815-1-git-send-email-padovan@profusion.mobi>
References: <1324157382-1815-1-git-send-email-padovan@profusion.mobi>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gustavo,

> Here are the patches to run the receive path in workqueue.  With these patches
> l2cap and rfcomm seems to be working fine, but some more work still needs to be
> done.

so besides my two comments, this looks fine to me.

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel


