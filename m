Return-Path: <cyrus@holtmann.org>
Date: Thu, 17 Oct 2013 14:20:10 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCHv5 1/7] android: Add capabilities and set userid
Message-ID: <20131017112010.GA19836@x220.p-661hnu-f1>
References: <1381833423-862-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1381998406-16662-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1381998406-16662-2-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1381998406-16662-2-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On Thu, Oct 17, 2013, Andrei Emeltchenko wrote:
> The patch set UID as standard Bluetooth user for Android (AID_BLUETOOTH).
> For SDP server we need to bind to lower port, acquire this capability.

Which POSIX capability is "this capability" exactly?

> +	cap.effective = cap.permitted =
> +		CAP_TO_MASK(CAP_SETGID) |
> +		CAP_TO_MASK(CAP_NET_RAW) |
> +		CAP_TO_MASK(CAP_NET_ADMIN) |
> +		CAP_TO_MASK(CAP_NET_BIND_SERVICE);

I just checked the kernel L2CAP socket code and all it requires for
binding to a low L2CAP PSM (needed e.g. by SDP) is CAP_NET_BIND_SERVICE.
So you'll need to explain what you need these other capabilities for.

Johan
