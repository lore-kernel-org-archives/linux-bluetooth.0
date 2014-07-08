Return-Path: <cyrus@holtmann.org>
Date: Tue, 8 Jul 2014 21:36:45 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Szymon Janc <szymon.janc@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] client: Allow to terminate if bluetoothd was not started
Message-ID: <20140708183645.GA10358@t440s.P-661HNU-F1>
References: <1404841946-14501-1-git-send-email-szymon.janc@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1404841946-14501-1-git-send-email-szymon.janc@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

On Tue, Jul 08, 2014, Szymon Janc wrote:
> This allows to terminate bluetoothctl with CTRL-C if daemon didn't
> start. Otherwise input is not functional and user must kill
> bluetoothctl by sending signal from another terminal.
> ---
>  client/main.c | 23 +++++++++++++++++------
>  1 file changed, 17 insertions(+), 6 deletions(-)

Applied. Thanks.

Johan
