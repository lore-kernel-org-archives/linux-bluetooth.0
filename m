Return-Path: <cyrus@holtmann.org>
Date: Sat, 1 Feb 2014 18:32:37 -0800
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Include security level 4 in connections check
Message-ID: <20140202023237.GA1544@x220.p-661hnu-f1>
References: <1391283145-21148-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1391283145-21148-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Sat, Feb 01, 2014, Marcel Holtmann wrote:
> This check is only used for RFCOMM connections and most likely no
> RFCOMM based profile will require security level 4 secure connection
> security policy. In case it ever does make sure that seucrity level 4
> is treated as sufficient security level.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  net/bluetooth/hci_conn.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)

Applied to bluetooth-next. Thanks.

Johan
