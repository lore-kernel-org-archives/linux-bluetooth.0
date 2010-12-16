Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.00.1012150817580.12898@linux-sea-02>
References: <1292251105-31130-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
	<1292251105-31130-2-git-send-email-Andrei.Emeltchenko.news@gmail.com>
	<20101214192223.GD18509@vigoh>
	<alpine.DEB.2.00.1012150817580.12898@linux-sea-02>
Date: Thu, 16 Dec 2010 16:40:54 +0200
Message-ID: <AANLkTi=Kfm9jV0HA=Sa9=hs1meXthrpZEzn5-czTaSO+@mail.gmail.com>
Subject: Re: [RFC] Bluetooth: Use non-flushable pb flag by default for ACL
 data on capable chipsets.
From: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
To: Mat Martineau <mathewm@codeaurora.org>
Cc: "Gustavo F. Padovan" <padovan@profusion.mobi>,
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Wed, Dec 15, 2010 at 6:35 PM, Mat Martineau <mathewm@codeaurora.org> wrote:
<skipped>
> There is one more thing missing:  Even though there is an L2CAP socket
> option to set flush_to, and the flush_to is passed around during L2CAP
> configuration, there is no use of the "Write Automatic Flush Timeout" HCI
> command to tell the baseband what the flush timeout is!  Since the flush
> timeout is shared across all connections on the ACL, how should BlueZ handle
> the case where different flush timeouts are set on connections that share
> the same ACL?  (My guess is that either the longest or shortest timeout
> should be used, but there are good arguments either way)

I would suggest bluetoothd to take care about setting Flush Timeout.
There is of course possibility to have sockopt for timeout and send HCI command
but this looks like a dirty hack.

I think bluetoothd can read compare and write new flush timeout value.

Regards,
Andrei
