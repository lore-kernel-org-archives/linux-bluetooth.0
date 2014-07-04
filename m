Return-Path: <cyrus@holtmann.org>
Date: Fri, 4 Jul 2014 21:14:04 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/2] Bluetooth: Move mgmt_event helper function to
 different location
Message-ID: <20140704181404.GC17855@t440s.P-661HNU-F1>
References: <1404493583-56960-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1404493583-56960-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Fri, Jul 04, 2014, Marcel Holtmann wrote:
> Move the mgmt_event function higher up in the code so that no forward
> declaration is needed.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  net/bluetooth/mgmt.c | 60 ++++++++++++++++++++++++++--------------------------
>  1 file changed, 30 insertions(+), 30 deletions(-)

Both patches have been applied to bluetooth-next. Thanks.

Johan
