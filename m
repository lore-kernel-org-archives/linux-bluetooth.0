Return-Path: <cyrus@holtmann.org>
Date: Tue, 5 Aug 2014 22:07:01 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ] core: Fix Device1.Disconnect not always disabling
 auto connect
Message-ID: <20140805190701.GA8665@t440s.P-661HNU-F1>
References: <1407245446-16366-1-git-send-email-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1407245446-16366-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Tue, Aug 05, 2014, Luiz Augusto von Dentz wrote:
> Disconnect has the ability to disable auto connect temporarily until
> Connect is then called again, but currently it can only do that if
> the device is connected.
> ---
>  src/device.c | 77 ++++++++++++++++++++++++++++++++----------------------------
>  1 file changed, 41 insertions(+), 36 deletions(-)

Applied. Thanks.

Johan
