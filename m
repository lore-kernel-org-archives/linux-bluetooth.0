Return-Path: <cyrus@holtmann.org>
Date: Thu, 16 Feb 2012 15:13:21 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org,
	Bruna Moreira <bruna.moreira@openbossa.org>
Subject: Re: [PATCH v2 BlueZ 1/3] thermometer: Fix device driver probe
Message-ID: <20120216131321.GC16080@x220.ger.corp.intel.com>
References: <1329241945-32414-1-git-send-email-anderson.lizardo@openbossa.org>
 <1329309499-14454-1-git-send-email-anderson.lizardo@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1329309499-14454-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lizardo,

On Wed, Feb 15, 2012, Anderson Lizardo wrote:
> The probe() function for GATT profiles should be transport agnostic.
> There is a btd_device_get_primaries() method which can be used to return
> a list of discovered GATT Primary Services, and it works for BR/EDR and
> LE. It is already used for Proximity, for instance.
> 
> device_services_from_record() is BR/EDR specific and should not be used
> by GATT profile code.
> 
> It also fixes a memory leak, given device_services_from_record() returns
> a heap allocated GSList.
> ---
>  thermometer/manager.c |   19 +++++++++++++++----
>  1 files changed, 15 insertions(+), 4 deletions(-)

All three patches have been applied. Thanks.

Johan
