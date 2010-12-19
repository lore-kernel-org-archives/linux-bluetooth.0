Return-Path: <cyrus@holtmann.org>
Date: Sun, 19 Dec 2010 14:27:45 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Bruna Moreira <bruna.moreira@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org,
	Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: Re: [PATCH 1/4] Move get_eir_uuids() from src/adapter.c to
 src/event.c
Message-ID: <20101219122745.GB11112@jh-x301>
References: <1292597844-17135-1-git-send-email-bruna.moreira@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1292597844-17135-1-git-send-email-bruna.moreira@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Fri, Dec 17, 2010, Bruna Moreira wrote:
> Moving get_eir_uuids() to src/event.c removes the need to pass the raw
> EIR data to higher layers. Now it is not necessary to pass the original
> GSList of service UUIDs, because the list is concatenated (with
> verification of duplicate entries) on adapter_update_device_from_info()
> (for LE) and adapter_update_found_devices() (for BR/EDR).
> ---
>  src/adapter.c |  145 +++++++++++---------------------------------------------
>  src/adapter.h |    7 +--
>  src/event.c   |  114 +++++++++++++++++++++++++++++++++++++++++++--
>  3 files changed, 142 insertions(+), 124 deletions(-)

All four patches have been pushed upstream. Thanks.

Johan
