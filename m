Return-Path: <cyrus@holtmann.org>
Date: Tue, 1 Feb 2011 11:10:10 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Andre Dieb Martins <andre.dieb@signove.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Fix hciconfig leadv returned response.
Message-ID: <20110201091010.GA21421@jh-x301>
References: <1296500253-11888-1-git-send-email-andre.dieb@signove.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1296500253-11888-1-git-send-email-andre.dieb@signove.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi André,

On Mon, Jan 31, 2011, Andre Dieb Martins wrote:
> Fixes hciconfig leadv returned response by treating both status of the command
> execution and HCI error code.
> ---
>  tools/hciconfig.c |   15 ++++++++++++---
>  1 files changed, 12 insertions(+), 3 deletions(-)

The patch has been pushed upstream. Thanks. However, I did have to fix
your commit message first: the summary line should not have a '.' at the
end and no line should be longer than 74 characters so that the message
is properly viewable with git log on a 80 character wide terminal.

Johan
