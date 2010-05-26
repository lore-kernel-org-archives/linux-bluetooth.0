Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH 1/1] Bluetooth: Synchronize SCO/eSCO connection
 requests to ACL state
From: Marcel Holtmann <marcel@holtmann.org>
To: Ron Shaffer <rshaffer@codeaurora.org>
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <4BFAEB65.2060503@codeaurora.org>
References: <4BFAEB65.2060503@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 26 May 2010 10:59:16 +0200
Message-ID: <1274864356.27220.155.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ron,

> Certain headsets such as the Motorola H350 will reject SCO and eSCO
> connection requests while the ACL is transitioning from sniff mode
> to active mode. Add synchronization so that SCO and eSCO connection
> requests will wait until the ACL has fully transitioned to active mode.

I am not completely happy with this patch. First please split it like
Gustavo asked since otherwise it becomes pretty hard to review. I don't
really bother to look into its technical nature before the split and the
coding style is in place.

Second, please don't make a special case for sniff mode. If we do this
then we also do it for park state and hold mode.

And third, I think this needs to be done a little bit more in the way we
handle attempts for connecting ACL links when the baseband is busy. So
can you send hcidump -X -V traces for the failure of SCO/eSCO setup when
sniff is active. I like to see which error codes are returned. Hacking
this directly into sniff exit handling makes the code pretty hard to
understand in the future.

Regards

Marcel


