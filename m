Return-Path: <cyrus@holtmann.org>
Date: Wed, 30 Oct 2013 12:13:22 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v2 0/6] Initial HAL support for device discovery
Message-ID: <20131030101322.GA21059@x220.p-661hnu-f1>
References: <1383127232-25147-1-git-send-email-jakub.tyszkowski@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1383127232-25147-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jakub,

On Wed, Oct 30, 2013, Jakub Tyszkowski wrote:
> v2 Changes:
> 	* fixed coding style issues pointed by jhe and niko1
> 	* extracted property repacking code for reuse
> 
> Jakub Tyszkowski (6):
>   android/hal: Add support for start/cancel device discovery commands
>   android/hal: Add support for handling discovery state change event
>   android/hal: Extract bt property repacking code for further reuse
>   android/hal: Add device found event handler
>   android/hal: Add device state changed event handler
>   android: Add missing discovery state definitions to IPC header
> 
>  android/hal-bluetooth.c | 92 +++++++++++++++++++++++++++++++++++++++----------
>  android/hal-msg.h       |  3 ++
>  2 files changed, 76 insertions(+), 19 deletions(-)

All patches have been applied. Thanks.

Johan
