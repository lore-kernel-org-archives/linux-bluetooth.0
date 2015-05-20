Return-Path: <cyrus@holtmann.org>
Date: Wed, 20 May 2015 20:56:51 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Szymon Janc <szymon.janc@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/3] emulator: Verify Set Controller To Host Flow Control
 Command
Message-ID: <20150520175651.GA8383@t440s.P-661HNU-F1>
References: <1432141845-9207-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1432141845-9207-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

On Wed, May 20, 2015, Szymon Janc wrote:
> Return invalid parameters error if reserved value is used.
> ---
>  emulator/btdev.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)

All three patches have been applied. Thanks.

Bonus points if you also implement the missing HCI commands in
emulator/le.c :)

Johan
