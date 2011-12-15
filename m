Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20111215115942.GA9850@x220>
References: <1323857512-5626-1-git-send-email-sancane@gmail.com>
	<1323857512-5626-2-git-send-email-sancane@gmail.com>
	<20111215115942.GA9850@x220>
Date: Thu, 15 Dec 2011 13:57:13 +0100
Message-ID: <CACLukzJ3g2Nnh7oTfD8h8g_RXzSffK4Ox5YrCpuvQoKtVxFHfA@mail.gmail.com>
Subject: Re: [PATCH 2/4] mcap_sync.c: Fix include paths
From: Santiago Carot <sancane@gmail.com>
To: Santiago Carot-Nemesio <sancane@gmail.com>,
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

2011/12/15 Johan Hedberg <johan.hedberg@gmail.com>:
> Hi Santiago,
>
> On Wed, Dec 14, 2011, Santiago Carot-Nemesio wrote:
>> ---
>>  health/mcap_sync.c |    4 ++--
>>  1 files changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/health/mcap_sync.c b/health/mcap_sync.c
>> index 5545cea..e2d7715 100644
>> --- a/health/mcap_sync.c
>> +++ b/health/mcap_sync.c
>> @@ -28,8 +28,8 @@
>>  #include <stdlib.h>
>>  #include <bluetooth/bluetooth.h>
>>  #include <bluetooth/l2cap.h>
>> -#include "../src/adapter.h"
>> -#include "../src/manager.h"
>> +#include <adapter.h>
>> +#include <manager.h>
>>  #include <sys/ioctl.h>
>>
>>  #include "config.h"
>
> There's more to fix here than this. config.h should come before anything
> else (and should be inside a #ifdef HAVE_CONFIG_H) and we sort the libc
> includes first, then dbus,glib,etc and finally the bluez internal
> includes.
>

You are right, I didn't notice it. I'll send a new patch solving this issue.
Regards.
