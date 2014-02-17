Return-Path: <cyrus@holtmann.org>
Date: Mon, 17 Feb 2014 15:51:11 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcin Kraglak <marcin.kraglak@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCHv2] emulator/bthost: Check length of received RFCOMM UIH
 frames
Message-ID: <20140217135111.GA25478@x220.p-661hnu-f1>
References: <1392643682-12370-1-git-send-email-marcin.kraglak@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1392643682-12370-1-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcin,

On Mon, Feb 17, 2014, Marcin Kraglak wrote:
> Add correct calculation of frame length. If frame is too short, ignore it.
> ---
>  emulator/bthost.c | 38 ++++++++++++++++++++++++++++++--------
>  1 file changed, 30 insertions(+), 8 deletions(-)

Applied. Thanks.

Johan
