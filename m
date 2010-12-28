Return-Path: <cyrus@holtmann.org>
Date: Tue, 28 Dec 2010 20:49:03 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v3] Fix leak of EIR data if RSSI does not change
Message-ID: <20101228184903.GB18053@jh-x301>
References: <1293473827-26418-1-git-send-email-anderson.lizardo@openbossa.org>
 <1293559820-10738-1-git-send-email-anderson.lizardo@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1293559820-10738-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lizardo,

On Tue, Dec 28, 2010, Anderson Lizardo wrote:
> If RSSI value does not change, memory used by parsed EIR data would leak
> because it would not be assigned to the remote_dev_info structure.
> ---
>  src/adapter.c |   20 ++++++++++++++------
>  src/adapter.h |    6 +++---
>  src/event.c   |   49 ++++++++++++++++++++++++++++---------------------
>  3 files changed, 45 insertions(+), 30 deletions(-)

Thanks. This latest version looks fine to me. The patch has been pushed
upstream.

Johan
