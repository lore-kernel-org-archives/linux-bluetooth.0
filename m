Return-Path: <cyrus@holtmann.org>
Date: Mon, 25 Nov 2013 15:40:05 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCHv9 18/21] android/socket: Use security level for connect
Message-ID: <20131125134005.GB19445@x220.p-661hnu-f1>
References: <1385384937-29858-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1385384937-29858-19-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1385384937-29858-19-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On Mon, Nov 25, 2013, Andrei Emeltchenko wrote:
> Use low security level for connections without profile and default
> sec_level for others. rfsock now has pointer to profile info for
> outcoming connections.
> ---
>  android/socket.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)

Patches 1-17 have been applied, but I can't apply from this one onwards
since the default security level should be MEDIUM and not LOW. OPP is
the only exception that should have LOW and SAP the only exception that
should have HIGH.

Johan
