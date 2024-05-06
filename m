Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB9672BAE5
	for <linux-bluetooth@vger.kernel.org>; Mon,  6 May 2024 20:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715027595; cv=none; b=FzcAM+QvPnJhvGWTqaiciGy5QqXsQbybsR+lcqUizT1H5J30QPLblxxPwzp8T0H78AI6Omq+0OdyODpoGAbiPh4OvlRXtZ3icEEXos6zOWZpwq6Be2hDe8C46T1+5iUHzME+igKUr6Fick5Cj/j81jpHdmtQNcNKZYUKBvKA5iA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715027595; c=relaxed/simple;
	bh=BZhzDxsoi/mRkLebWyeMiZIF/Ba0xVAvCs+t/OYlonY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=pKn759NkWKTyifBpg5am1WkGzPlvXorcmorOoXPBIiDnYJzEY9ekRsCATW5BWwPiJTxPaIrVqeadrYiiCTaM0SKVH94hgXzNIDcm4ZzR1Z5xhwH4HToQ1lRibGvPFWJ22ikJ8H/AdvnD7Ds4WLoJzxlLlqgOnpBybbcoJUtEwkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.0.224] (ip5f5ae97d.dynamic.kabel-deutschland.de [95.90.233.125])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 6549861E5FE01;
	Mon,  6 May 2024 22:32:48 +0200 (CEST)
Message-ID: <dc60cebd-5a0b-430c-b99c-c0b1b509bfff@molgen.mpg.de>
Date: Mon, 6 May 2024 22:32:46 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH BlueZ v2] bluetoothctl: Add submenu for Call control
 profile testing
To: Ajay KV <ajay.k.v@intel.com>
References: <20240506235643.114778-1-ajay.k.v@intel.com>
Content-Language: en-US
Cc: linux-bluetooth@vger.kernel.org
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20240506235643.114778-1-ajay.k.v@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Dear Ajay,


Am 07.05.24 um 01:56 schrieb Ajay KV:
> This adds submeu in bluetoothctl for CCP Testing with

subme*n*u

> options like answer and reject the active call . This feature

Please remove the space before the dot.

> is tested with windows machnine as CCP server which uses Teams

machine

> application to make calls

Is that setup described somewhere?

> Signed-off-by: Ajay KV <ajay.k.v@intel.com>
> ---
>   Makefile.tools    |   4 +-
>   client/ccp_test.c | 212 ++++++++++++++++++++++++++++++++++++++++++++++
>   client/ccp_test.h |  12 +++
>   client/main.c     |   5 +-
>   4 files changed, 231 insertions(+), 2 deletions(-)
>   create mode 100644 client/ccp_test.c
>   create mode 100644 client/ccp_test.h
> 
> diff --git a/Makefile.tools b/Makefile.tools
> index 679c914bf8cd..a5587427f549 100644
> --- a/Makefile.tools
> +++ b/Makefile.tools
> @@ -13,7 +13,9 @@ client_bluetoothctl_SOURCES = client/main.c \
>   					client/gatt.h client/gatt.c \
>   					client/admin.h client/admin.c \
>   					client/player.h client/player.c \
> -					client/mgmt.h client/mgmt.c
> +					client/mgmt.h client/mgmt.c \
> +					client/ccp_test.c \
> +					client/ccp_test.h
>   client_bluetoothctl_LDADD = lib/libbluetooth-internal.la \
>   			gdbus/libgdbus-internal.la src/libshared-glib.la \
>   			$(GLIB_LIBS) $(DBUS_LIBS) -lreadline
> diff --git a/client/ccp_test.c b/client/ccp_test.c
> new file mode 100644
> index 000000000000..d53fc2393c13
> --- /dev/null
> +++ b/client/ccp_test.c
> @@ -0,0 +1,212 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + *
> + *  BlueZ - Bluetooth protocol stack for Linux
> + *
> + *  Copyright (C) 2024  Intel Corporation. All rights reserved.
> + *
> + */
> +
> +#ifdef HAVE_CONFIG_H
> +#include <config.h>
> +#endif
> +
> +#define _GNU_SOURCE
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include "gdbus/gdbus.h"
> +#include "lib/bluetooth.h"
> +#include "src/shared/shell.h"
> +#include "print.h"
> +#include "ccp_test.h"
> +
> +/* String display constants */
> +#define COLORED_NEW	COLOR_GREEN "NEW" COLOR_OFF
> +#define COLORED_CHG	COLOR_YELLOW "CHG" COLOR_OFF
> +
> +#define BLUEZ_CCP_TEST_INTERFACE "org.bluez.CCPTest1"
> +
> +static DBusConnection *dbus_conn;
> +static GDBusProxy *default_call;
> +static GList *callList;
> +static GDBusClient *client;
> +
> +static char *proxy_description(GDBusProxy *proxy, const char *title,
> +			       const char *description)
> +{
> +	const char *path;
> +
> +	path = g_dbus_proxy_get_path(proxy);
> +	return g_strdup_printf("%s%s%s%s %s ",
> +					description ? "[" : "",
> +					description ? : "",
> +					description ? "] " : "",
> +					title, path);
> +}
> +
> +static void print_info(void *data, void *user_data)
> +{
> +	GDBusProxy *proxy = data;
> +	const char *description = user_data;
> +	char *str;
> +
> +	str = proxy_description(proxy, "CCPTest", description);
> +
> +	bt_shell_printf("%s%s\n", str,
> +			default_call == proxy ? "[default]" : "");
> +
> +	g_free(str);
> +}
> +
> +static void call_reject_reply(DBusMessage *message, void *user_data)
> +{
> +	DBusError error;
> +
> +	dbus_error_init(&error);
> +
> +	if (dbus_set_error_from_message(&error, message) == TRUE) {
> +		bt_shell_printf("Failed to reject call: %s\n", error.name);
> +		dbus_error_free(&error);
> +		return bt_shell_noninteractive_quit(EXIT_FAILURE);
> +	}
> +
> +	bt_shell_printf("operation completed\n");
> +
> +	return bt_shell_noninteractive_quit(EXIT_SUCCESS);
> +}
> +
> +static void cmd_reject(int argc, char *argv[])
> +{
> +	if (!default_call) {
> +		bt_shell_printf("No active calls present\n");
> +		return bt_shell_noninteractive_quit(EXIT_FAILURE);
> +	}
> +
> +	if (g_dbus_proxy_method_call(default_call, "reject", NULL,
> +				     call_reject_reply, NULL, NULL) == FALSE) {
> +		bt_shell_printf("Failed to reject call\n");
> +		return bt_shell_noninteractive_quit(EXIT_FAILURE);
> +	}
> +}
> +
> +static void call_answer_reply(DBusMessage *message, void *user_data)
> +{
> +	DBusError error;
> +
> +	dbus_error_init(&error);
> +
> +	if (dbus_set_error_from_message(&error, message) == TRUE) {
> +		bt_shell_printf("Failed to answer call: %s\n", error.name);
> +		dbus_error_free(&error);
> +		return bt_shell_noninteractive_quit(EXIT_FAILURE);
> +	}
> +
> +	bt_shell_printf("operation completed\n");
> +
> +	return bt_shell_noninteractive_quit(EXIT_SUCCESS);
> +}
> +
> +static void cmd_answer(int argc, char *argv[])
> +{
> +	if (!default_call)
> +		return bt_shell_noninteractive_quit(EXIT_FAILURE);
> +
> +	if (g_dbus_proxy_method_call(default_call, "answer", NULL,
> +				     call_answer_reply, NULL, NULL) == FALSE) {
> +		bt_shell_printf("Failed to answer the call\n");
> +		return bt_shell_noninteractive_quit(EXIT_FAILURE);
> +	}
> +}
> +
> +static const struct bt_shell_menu call_menu = {
> +	.name = "ccp test",
> +	.desc = "ccp test settings submenu",
> +	.entries = {
> +		    { "answer", NULL, cmd_answer, "answer the active call" },
> +		    { "reject", NULL, cmd_reject, "reject the active call" },
> +		   },
> +};
> +
> +static void ccp_add_call(GDBusProxy *proxy)
> +{
> +	bt_shell_printf("[CHG] CCP Test caller added\n");
> +	callList = g_list_append(callList, proxy);
> +
> +	if (!default_call)
> +		default_call = proxy;
> +
> +	print_info(proxy, COLORED_NEW);
> +}
> +
> +static void ccp_remove_call(GDBusProxy *proxy)
> +{
> +	bt_shell_printf("[CHG] CCP Test caller removed\n");
> +
> +	if (default_call == proxy)
> +		default_call = NULL;
> +
> +	callList = g_list_remove(callList, proxy);
> +}
> +
> +static void proxy_added(GDBusProxy *proxy, void *user_data)
> +{
> +	const char *interface;
> +
> +	interface = g_dbus_proxy_get_interface(proxy);
> +
> +	if (!strcmp(interface, BLUEZ_CCP_TEST_INTERFACE))
> +		ccp_add_call(proxy);
> +}
> +
> +static void proxy_removed(GDBusProxy *proxy, void *user_data)
> +{
> +	const char *interface;
> +
> +	interface = g_dbus_proxy_get_interface(proxy);
> +
> +	if (!strcmp(interface, BLUEZ_CCP_TEST_INTERFACE))
> +		ccp_remove_call(proxy);
> +}
> +
> +static void ccptest_property_changed(GDBusProxy *proxy, const char *name,
> +				     DBusMessageIter *iter)
> +{
> +	char *str;
> +
> +	str = proxy_description(proxy, "CCP Test", COLORED_CHG);
> +	print_iter(str, name, iter);
> +	g_free(str);
> +
> +	bt_shell_printf("[CHG] CCP Test property : %s\n", name);
> +}
> +
> +static void property_changed(GDBusProxy *proxy, const char *name,
> +			     DBusMessageIter *iter, void *user_data)
> +{
> +	const char *interface;
> +
> +	interface = g_dbus_proxy_get_interface(proxy);
> +
> +	if (!strcmp(interface, BLUEZ_CCP_TEST_INTERFACE))
> +		ccptest_property_changed(proxy, name, iter);
> +}
> +
> +void ccptest_add_submenu(void)
> +{
> +	bt_shell_add_submenu(&call_menu);
> +
> +	dbus_conn = bt_shell_get_env("DBUS_CONNECTION");
> +	if (!dbus_conn || client)
> +		return;
> +
> +	client = g_dbus_client_new(dbus_conn, "org.bluez", "/org/bluez");
> +
> +	g_dbus_client_set_proxy_handlers(client, proxy_added, proxy_removed,
> +					 property_changed, NULL);
> +	g_dbus_client_set_disconnect_watch(client, NULL, NULL);
> +}
> +
> +void ccptest_remove_submenu(void)
> +{
> +	g_dbus_client_unref(client);
> +}
> diff --git a/client/ccp_test.h b/client/ccp_test.h
> new file mode 100644
> index 000000000000..fc2ab2042bb8
> --- /dev/null
> +++ b/client/ccp_test.h
> @@ -0,0 +1,12 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + *
> + *  BlueZ - Bluetooth protocol stack for Linux
> + *
> + *  Copyright (C) 2024 Intel Corporation. All rights reserved.
> + *
> + *
> + */
> +
> +void ccptest_add_submenu(void);
> +void ccptest_remove_submenu(void);
> diff --git a/client/main.c b/client/main.c
> index c8b0f7f1c2d8..dba6dea639d9 100644
> --- a/client/main.c
> +++ b/client/main.c
> @@ -34,6 +34,7 @@
>   #include "admin.h"
>   #include "player.h"
>   #include "mgmt.h"
> +#include "ccp_test.h"
>   
>   /* String display constants */
>   #define COLORED_NEW	COLOR_GREEN "NEW" COLOR_OFF
> @@ -3060,7 +3061,7 @@ static const struct bt_shell_menu gatt_menu = {
>   					"Unregister application service" },
>   	{ "register-includes", "<UUID> [handle]", cmd_register_includes,
>   					"Register as Included service in." },
> -	{ "unregister-includes", "<Service-UUID> <Inc-UUID>",
> +	{ "unregister-includes", "<Service-UUID><Inc-UUID>",

Is that an intentional change?


Kind regards,

Paul


>   			cmd_unregister_includes,
>   				 "Unregister Included service." },
>   	{ "register-characteristic",
> @@ -3199,6 +3200,7 @@ int main(int argc, char *argv[])
>   
>   	admin_add_submenu();
>   	player_add_submenu();
> +	ccptest_add_submenu();
>   	mgmt_add_submenu();
>   
>   	client = g_dbus_client_new(dbus_conn, "org.bluez", "/org/bluez");
> @@ -3216,6 +3218,7 @@ int main(int argc, char *argv[])
>   
>   	admin_remove_submenu();
>   	player_remove_submenu();
> +	ccptest_remove_submenu();
>   	mgmt_remove_submenu();
>   
>   	g_dbus_client_unref(client);
