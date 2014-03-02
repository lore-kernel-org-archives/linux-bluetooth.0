Return-Path: <cyrus@holtmann.org>
Date: Sun, 2 Mar 2014 18:39:34 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ] monitor: Validate HCI event/command parameter
 length when parsing
Message-ID: <20140302163934.GA398@localhost.P-661HNU-F1>
References: <1393701808-27186-1-git-send-email-anderson.lizardo@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1393701808-27186-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lizardo,

On Sat, Mar 01, 2014, Anderson Lizardo wrote:
> Print an error message if the parameter length for HCI commands/events
> does not match the actual remaining packet size.
> 
> This mainly avoids using garbage bytes when parsing corrupted packets.
> The check was inspired on those used when parsing SCO/ACL packets.
> ---
>  monitor/packet.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)

Applied. Thanks.

Johan
