Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEC1A17C98
	for <linux-bluetooth@vger.kernel.org>; Wed,  3 Apr 2024 16:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712162144; cv=none; b=YfwoelEqPYNFgeDW5i8oL4ziroWCjLzL2CSAAS1ycjpd4ChzOdKYzQhraaN+tmQIpOIdH/CrLHmKrmd4xVJiBydCR5p8fUh/DrKobk8WNPe9jRfm/nFjuvfKg5js5QDOd57EgUNP0EitsIr94aWjlShWXUmI9Pt6ZSHJnrMFxlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712162144; c=relaxed/simple;
	bh=5J1y18JW2daZxBMhgXu52DM/+FwFYzBXVii0gXprOAs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Bl05X2cPgtUreWWtUOtC7CvVYHizL2bwM0wLeSi95MVJ2sMNi6yKjgeEqfsQkIJy8kYcVcVIaRS6osWTdS7T0r4FPu9/DOrZuPaeEpdUgJfw6tYlDpzt1VfdTWC5GxIKx7HqzuYIhMVQNSLzfZPwEo5folyf1udXxDcB3wAGxfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=OHhN5g/I; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="OHhN5g/I"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1712162140;
	bh=5J1y18JW2daZxBMhgXu52DM/+FwFYzBXVii0gXprOAs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=OHhN5g/Iwvj9P5fLHExealBWqHyU2a+j37GXQ9XpIQ3AZjFz6pO8MbPGw2O4G56ss
	 6sAGQJ5Pv1LMXjR60HYiqqsTV7XJIHgDqrmAIGtVzydFtMKdlI4XVYPdRncfBMgJW7
	 OL4kr6vwZtPnGPv4zm+EImzafZgaf8Klfohou6J9MAmvPF2Kth1+rxeiZCbORD8l8L
	 Y1Jhs9FUfavKiiovY1TrJQbYh+0DUOfPE4NGc8TNUGKvqZ4Mkr3zlZSBgNxAkMqIJT
	 rf0U02grHG++EWcrRgm0pXhPk1gPsXdSj4bSx8xhoFFifbbdYEzvXdkTf8ltUSsj8m
	 jcgIafQgR6Jfg==
Received: from [100.72.96.248] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 97AAB378000E;
	Wed,  3 Apr 2024 16:35:40 +0000 (UTC)
Message-ID: <75805a80-f714-4cc4-9929-72992399c30b@collabora.com>
Date: Wed, 3 Apr 2024 18:35:39 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH BlueZ] plugins: Add new plugin to fix airpods pairing
To: Szymon Janc <szymon.janc@codecoup.pl>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
References: <20240403110808.805771-1-frederic.danis@collabora.com>
 <CAAEJBhL6pb=PeO_mezcga+aVxDew+zQwTDhTWkHT-wnfXONHtQ@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Fr=C3=A9d=C3=A9ric_Danis?= <frederic.danis@collabora.com>
In-Reply-To: <CAAEJBhL6pb=PeO_mezcga+aVxDew+zQwTDhTWkHT-wnfXONHtQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi,

On 03/04/2024 15:50, Szymon Janc wrote:
> Hi,
>
> On Wed, 3 Apr 2024 at 13:08, Frédéric Danis
> <frederic.danis@collabora.com> wrote:
>> Apple Airpods are discoverable and pairable in BREDR mode, but also
>> advertise in unconnectable mode in LE with the same Public address, at the
>> same time. As the pairing process uses the latest seen address, sometimes
>> it uses the LE Public address to pair, which fails.
>>
>> This commit adds a new adapter driver plugin which force the BREDR last
>> seen time on LE Public address device found event related to an Apple
>> device, allowing pairing process to always use the BREDR.
>>
> While I'm fine with having plugin for this specific case, I wonder if
> select_conn_bearer() shouldn't take
> bearer's connectable state into account when selecting bearer for connection

Yes, this could be a lot simpler, but couldn't it break some other 
pairing case?

>> This commit is based on proposal
>> https://lore.kernel.org/all/20240103101328.1812899-1-clancy_shang@163.com/
>> ---
>>   Makefile.plugins  |   3 ++
>>   plugins/airpods.c | 132 ++++++++++++++++++++++++++++++++++++++++++++++
>>   2 files changed, 135 insertions(+)
>>   create mode 100644 plugins/airpods.c
>>
>> diff --git a/Makefile.plugins b/Makefile.plugins
>> index 4aa2c9c92..2ebd8aaf6 100644
>> --- a/Makefile.plugins
>> +++ b/Makefile.plugins
>> @@ -11,6 +11,9 @@ builtin_sources += plugins/autopair.c
>>   builtin_modules += policy
>>   builtin_sources += plugins/policy.c
>>
>> +builtin_modules += airpods
>> +builtin_sources += plugins/airpods.c
>> +
>>   if ADMIN
>>   builtin_modules += admin
>>   builtin_sources += plugins/admin.c
>> diff --git a/plugins/airpods.c b/plugins/airpods.c
>> new file mode 100644
>> index 000000000..5043f0cca
>> --- /dev/null
>> +++ b/plugins/airpods.c
>> @@ -0,0 +1,132 @@
>> +// SPDX-License-Identifier: GPL-2.0-or-later
>> +/*
>> + *
>> + *  BlueZ - Bluetooth protocol stack for Linux
>> + *
>> + *  Copyright (C) 2024 Frédéric Danis <frederic.danis@collabora.com>
>> + *
>> + *
>> + */
>> +
>> +#ifdef HAVE_CONFIG_H
>> +#include <config.h>
>> +#endif
>> +
>> +#include <stdbool.h>
>> +
>> +#include <glib.h>
>> +
>> +#include "bluetooth/bluetooth.h"
>> +
>> +#include "lib/mgmt.h"
>> +#include "src/plugin.h"
>> +#include "src/adapter.h"
>> +#include "src/device.h"
>> +#include "src/eir.h"
>> +#include "src/log.h"
>> +#include "src/shared/mgmt.h"
>> +#include "src/shared/util.h"
>> +
>> +#define APPLE_INC_VENDOR_ID 0x004c
>> +
>> +static struct mgmt *mgmt;
>> +
>> +static bool eir_msd_is_apple_inc(GSList *msd_list)
>> +{
>> +       GSList *msd_l, *msd_next;
>> +
>> +       for (msd_l = msd_list; msd_l != NULL; msd_l = msd_next) {
>> +               const struct eir_msd *msd = msd_l->data;
>> +
>> +               msd_next = g_slist_next(msd_l);
>> +
>> +               if (msd->company == APPLE_INC_VENDOR_ID)
>> +                       return true;
>> +       }
>> +
>> +       return false;
>> +}
>> +
>> +static void airpods_device_found_callback(uint16_t index, uint16_t length,
>> +                                       const void *param, void *user_data)
>> +{
>> +       struct btd_device *dev;
>> +       const struct mgmt_ev_device_found *ev = param;
>> +       struct btd_adapter *adapter = user_data;
>> +       uint16_t eir_len;
>> +       uint32_t flags = le32_to_cpu(ev->flags);
>> +       struct eir_data eir_data;
>> +
>> +       dev = btd_adapter_find_device(adapter,  &ev->addr.bdaddr,
>> +                                       ev->addr.type);
>> +       if (!dev)
>> +               return;
>> +
>> +       if (length < sizeof(*ev)) {
>> +               warn("Too short device found event (%u bytes)", length);
>> +               return;
>> +       }
>> +
>> +       eir_len = btohs(ev->eir_len);
>> +       if (length != sizeof(*ev) + eir_len) {
>> +               warn("Device found event size mismatch (%u != %zu)",
>> +                                       length, sizeof(*ev) + eir_len);
>> +               return;
>> +       }
>> +
>> +       if (eir_len == 0)
>> +               return;
>> +
>> +       memset(&eir_data, 0, sizeof(eir_data));
>> +       eir_parse(&eir_data, ev->eir, eir_len);
>> +
>> +       if (eir_msd_is_apple_inc(eir_data.msd_list) &&
>> +                               (flags & MGMT_DEV_FOUND_NOT_CONNECTABLE) &&
>> +                               (ev->addr.type == BDADDR_LE_PUBLIC)) {
>> +               DBG("Force BREDR last seen");
>> +               device_set_bredr_support(dev);
>> +               device_update_last_seen(dev, BDADDR_BREDR, true);
>> +       }
>> +}
>> +
>> +static int airpods_probe(struct btd_adapter *adapter)
>> +{
>> +       if (!mgmt)
>> +               mgmt = mgmt_new_default();
>> +
>> +       if (!mgmt) {
>> +               fprintf(stderr, "Failed to open management socket\n");
>> +               return 0;
>> +       }
>> +
>> +       mgmt_register(mgmt, MGMT_EV_DEVICE_FOUND,
>> +                                       btd_adapter_get_index(adapter),
>> +                                       airpods_device_found_callback,
>> +                                       adapter, NULL);
>> +
>> +       return 0;
>> +}
>> +
>> +static void airpods_remove(struct btd_adapter *adapter)
>> +{
>> +       mgmt_unregister_index(mgmt, btd_adapter_get_index(adapter));
>> +}
>> +
>> +static struct btd_adapter_driver airpods_driver = {
>> +       .name   = "airpods",
>> +       .probe  = airpods_probe,
>> +       .remove = airpods_remove,
>> +};
>> +
>> +static int airpods_init(void)
>> +{
>> +       return btd_register_adapter_driver(&airpods_driver);
>> +}
>> +
>> +static void airpods_exit(void)
>> +{
>> +       btd_unregister_adapter_driver(&airpods_driver);
>> +}
>> +
>> +BLUETOOTH_PLUGIN_DEFINE(airpods, VERSION,
>> +               BLUETOOTH_PLUGIN_PRIORITY_LOW, airpods_init, airpods_exit)
>> --
>> 2.34.1
>>
>>
>

-- 
Frédéric Danis
Senior Software Engineer

Collabora Ltd.
Platinum Building, St John's Innovation Park, Cambridge CB4 0DS, United Kingdom
Registered in England & Wales, no. 5513718

