Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E93F020DC9
	for <linux-bluetooth@vger.kernel.org>; Mon, 19 Feb 2024 07:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708328194; cv=none; b=rrAZZmIWRWXFH85PlydZ+MbA1SO9kaka4XbyFCFFDyRlVBE9NOOM/YfWuEj0nbqrUngq5zZ1jeCSuMqGzPaWeUBteor+hXucIblDgv2ocF4/99dyb95vZcV1WxA9pUQMYHFEeJnC2aoRiq8ibcSx36rXuJZULvMKaSUOfX6tb/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708328194; c=relaxed/simple;
	bh=Dd8xkwGAFhYKKjnFPCX7ZRi0j8j/NEuIy9NOJldN2Rs=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=ehFI0sogJSseJeCrf5LZVWr3FQ4qntoPc7/1nwjHGbti0OPo4cd2X57mQqJmvaWFmwmku20CCGPDP2eWe/7xLicshFKY5Ihr+aEZLbqa1gWafuu8jWbKgOskwSk46n0qEHLwgeWvQoeNVCAq0AKI9Mns7xgCHn5xMEp5eKLes+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.0.6] (ip5f5af479.dynamic.kabel-deutschland.de [95.90.244.121])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 5491C61E5FE01;
	Mon, 19 Feb 2024 08:36:03 +0100 (CET)
Message-ID: <eec5498c-6e35-4473-adeb-fdfb72078f05@molgen.mpg.de>
Date: Mon, 19 Feb 2024 08:36:02 +0100
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] profiles/audio/ccp: Add initial code for ccp plugin
Content-Language: en-US
To: Shahid Vichhi <shahid.bashir.vichhi@intel.com>
References: <20240218235401.2511586-1-shahid.bashir.vichhi@intel.com>
Cc: linux-bluetooth@vger.kernel.org
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20240218235401.2511586-1-shahid.bashir.vichhi@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Shahid,


Thank you very much for your patch. Should the string BlueZ be part of 
the tag? Also, “Add … code” is redundant in my opinion, as that often 
done. Maybe:

     Add CCP plugin for Call Control Profile

Am 19.02.24 um 00:54 schrieb Shahid Vichhi:
> This adds initial code for ccp plugin which handle call control profile and

handle*s* and I would capitalize Call Control Profile

> Telephone Bearer Services and Generic Telephone Bearer Services for
> client role.

Please document, which specification you used, and how you tested this.

I comment some more nits below.

> ---
>   Makefile.plugins     |   5 +
>   configure.ac         |   4 +
>   profiles/audio/ccp.c | 238 +++++++++++++++++++++++++++++++++++++++++++
>   3 files changed, 247 insertions(+)
>   create mode 100644 profiles/audio/ccp.c
> 
> diff --git a/Makefile.plugins b/Makefile.plugins
> index e960eedeabd3..4aa2c9c92854 100644
> --- a/Makefile.plugins
> +++ b/Makefile.plugins
> @@ -138,6 +138,11 @@ builtin_modules += micp
>   builtin_sources += profiles/audio/micp.c
>   endif
>   
> +if CCP
> +builtin_modules += ccp
> +builtin_sources += profiles/audio/ccp.c
> +endif
> +
>   if CSIP
>   builtin_modules += csip
>   builtin_sources += profiles/audio/csip.c
> diff --git a/configure.ac b/configure.ac
> index 70e9d4be8127..c7dadf79a565 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -200,6 +200,10 @@ AC_ARG_ENABLE(mcp, AS_HELP_STRING([--disable-mcp],
>           [disable MCP profile]), [enable_mcp=${enableval}])
>   AM_CONDITIONAL(MCP, test "${enable_mcp}" != "no")
>   
> +AC_ARG_ENABLE(ccp, AS_HELP_STRING([--disable-ccp],
> +        [disable CCP profile]), [enable_ccp=${enableval}])

I would also add the long name in the help text: Call Control Profile.

> +AM_CONDITIONAL(CCP, test "${enable_ccp}" != "no")
> +
>   AC_ARG_ENABLE(vcp, AS_HELP_STRING([--disable-vcp],
>   		[disable VCP profile]), [enable_vcp=${enableval}])
>   AM_CONDITIONAL(VCP, test "${enable_vcp}" != "no")
> diff --git a/profiles/audio/ccp.c b/profiles/audio/ccp.c
> new file mode 100644
> index 000000000000..fe97911e75f4
> --- /dev/null
> +++ b/profiles/audio/ccp.c
> @@ -0,0 +1,238 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + *
> + *  BlueZ - Bluetooth protocol stack for Linux
> + *
> + *  Copyright (C) 2024  Intel Corporation. All rights reserved.
> + *
> + *
> + */
> +
> +#ifdef HAVE_CONFIG_H
> +#include <config.h>
> +#endif
> +
> +#define _GNU_SOURCE
> +
> +#include <ctype.h>
> +#include <stdbool.h>
> +#include <stdlib.h>
> +#include <stdio.h>
> +#include <string.h>
> +#include <sys/types.h>
> +#include <sys/stat.h>
> +#include <fcntl.h>
> +#include <errno.h>
> +
> +#include <glib.h>
> +
> +#include "gdbus/gdbus.h"
> +
> +#include "lib/bluetooth.h"
> +#include "lib/hci.h"
> +#include "lib/sdp.h"
> +#include "lib/uuid.h"
> +
> +#include "src/dbus-common.h"
> +#include "src/shared/util.h"
> +#include "src/shared/att.h"
> +#include "src/shared/queue.h"
> +#include "src/shared/gatt-db.h"
> +#include "src/shared/gatt-client.h"
> +#include "src/shared/gatt-server.h"
> +#include "src/shared/ccp.h"
> +
> +#include "btio/btio.h"
> +#include "src/plugin.h"
> +#include "src/adapter.h"
> +#include "src/gatt-database.h"
> +#include "src/device.h"
> +#include "src/profile.h"
> +#include "src/service.h"
> +#include "src/log.h"
> +#include "src/error.h"
> +
> +#define GTBS_UUID_STR "0000184C-0000-1000-8000-00805f9b34fb"
> +
> +struct ccp_data {
> +	struct btd_device *device;
> +	struct btd_service *service;
> +	struct bt_ccp *ccp;
> +	unsigned int state_id;
> +};
> +
> +static void ccp_debug(const char *str, void *user_data)
> +{
> +	DBG_IDX(0xffff, "%s", str);
> +}
> +
> +static struct ccp_data *ccp_data_new(struct btd_device *device)
> +{
> +	struct ccp_data *data;
> +
> +	data = new0(struct ccp_data, 1);
> +	data->device = device;
> +
> +	return data;
> +}
> +
> +static int ccp_probe(struct btd_service *service)
> +{
> +	struct btd_device *device = btd_service_get_device(service);
> +	struct btd_adapter *adapter = device_get_adapter(device);
> +	struct btd_gatt_database *database = btd_adapter_get_database(adapter);
> +	struct ccp_data *data = btd_service_get_user_data(service);
> +	char addr[18];
> +
> +	ba2str(device_get_address(device), addr);
> +	DBG("%s", addr);
> +
> +	/* Ignore, if we were probed for this device already */

The comment is redundant, as the error message says the same.

> +	if (data) {
> +		error("Profile probed twice for the same device!");
> +		return -EINVAL;
> +	}
> +
> +	data = ccp_data_new(device);
> +	data->service = service;
> +
> +	data->ccp = bt_ccp_new(btd_gatt_database_get_db(database),
> +			       btd_device_get_gatt_db(device));
> +
> +	bt_ccp_set_debug(data->ccp, ccp_debug, NULL, NULL);
> +	btd_service_set_user_data(service, data);
> +
> +	return 0;
> +}
> +
> +static void ccp_data_free(struct ccp_data *data)
> +{
> +	if (data->service) {
> +		btd_service_set_user_data(data->service, NULL);
> +		bt_ccp_set_user_data(data->ccp, NULL);
> +	}
> +
> +	bt_ccp_unref(data->ccp);
> +	free(data);
> +}
> +
> +static void ccp_data_remove(struct ccp_data *data)
> +{
> +	DBG("data %p", data);
> +
> +	ccp_data_free(data);
> +}
> +
> +static void ccp_remove(struct btd_service *service)
> +{
> +	struct btd_device *device = btd_service_get_device(service);
> +	struct ccp_data *data;
> +	char addr[18];
> +
> +	ba2str(device_get_address(device), addr);
> +	DBG("%s", addr);
> +
> +	data = btd_service_get_user_data(service);
> +	if (!data) {
> +		error("CCP service not handled by profile");
> +		return;
> +	}
> +
> +	ccp_data_remove(data);
> +}
> +
> +static int ccp_accept(struct btd_service *service)
> +{
> +	struct btd_device *device = btd_service_get_device(service);
> +	struct bt_gatt_client *client = btd_device_get_gatt_client(device);
> +	struct ccp_data *data = btd_service_get_user_data(service);
> +	char addr[18];
> +
> +	ba2str(device_get_address(device), addr);
> +	DBG("%s", addr);
> +
> +	if (!bt_ccp_attach(data->ccp, client)) {
> +		error("VCP unable to attach");

What is VCP?

> +		return -EINVAL;
> +	}
> +
> +	/*TODO: register telephony operations here*/

I’d add a space after /* and before */.

> +
> +	btd_service_connecting_complete(service, 0);
> +
> +	return 0;
> +}
> +
> +static int ccp_connect(struct btd_service *service)
> +{
> +	struct btd_device *device = btd_service_get_device(service);
> +	char addr[18];
> +
> +	ba2str(device_get_address(device), addr);
> +	DBG("%s", addr);
> +
> +	return 0;
> +}
> +
> +static int ccp_disconnect(struct btd_service *service)
> +{
> +	struct btd_device *device = btd_service_get_device(service);
> +	struct ccp_data *data = btd_service_get_user_data(service);
> +	char addr[18];
> +
> +	ba2str(device_get_address(device), addr);
> +	DBG("%s", addr);
> +
> +	bt_ccp_detach(data->ccp);
> +
> +	btd_service_disconnecting_complete(service, 0);
> +
> +	return 0;
> +}
> +
> +static int
> +ccp_server_probe(struct btd_profile *p,
> +		 struct btd_adapter *adapter)

Breaking the line like this looks inconsistent with above.

> +{
> +	struct btd_gatt_database *database = btd_adapter_get_database(adapter);
> +
> +	bt_ccp_register(btd_gatt_database_get_db(database));
> +
> +	return 0;
> +}
> +
> +static void
> +ccp_server_remove(struct btd_profile *p,
> +		  struct btd_adapter *adapter)
> +{
> +	DBG("CCP remove Adapter");

I’d use lower-case adapter.

> +}
> +
> +static struct btd_profile ccp_profile = {
> +	.name			= "ccp",
> +	.priority		= BTD_PROFILE_PRIORITY_MEDIUM,
> +	.remote_uuid	= GTBS_UUID_STR,
> +	.device_probe	= ccp_probe,
> +	.device_remove	= ccp_remove,
> +	.accept			= ccp_accept,
> +	.connect		= ccp_connect,
> +	.disconnect		= ccp_disconnect,
> +
> +	.adapter_probe	= ccp_server_probe,
> +	.adapter_remove = ccp_server_remove,
> +
> +	.experimental	= true,
> +};
> +
> +static int ccp_init(void)
> +{
> +	return btd_profile_register(&ccp_profile);
> +}
> +
> +static void ccp_exit(void)
> +{
> +	btd_profile_unregister(&ccp_profile);
> +}
> +
> +BLUETOOTH_PLUGIN_DEFINE(ccp, VERSION, BLUETOOTH_PLUGIN_PRIORITY_DEFAULT,
> +			ccp_init, ccp_exit)


Kind regards,

Paul
