Return-Path: <cyrus@holtmann.org>
Date: Mon, 7 Oct 2013 09:20:47 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Send new settings only when pairable changes
Message-ID: <20131007072047.GA5838@x220.p-661hnu-f1>
References: <1381101117-64767-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1381101117-64767-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Sun, Oct 06, 2013, Marcel Holtmann wrote:
> In case the current value of pairable is already configured, do not
> send a new settings event indicating that something has changed while
> in reality everything is the same.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  net/bluetooth/mgmt.c | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)

Applied to bluetooth-next. Thanks.

Johan
