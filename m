Return-Path: <cyrus@holtmann.org>
Date: Tue, 28 Jun 2011 11:51:32 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Bastien Nocera <hadess@hadess.net>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Add adaptername plugin
Message-ID: <20110628085132.GH18047@dell.ger.corp.intel.com>
References: <1308742198-6024-3-git-send-email-hadess@hadess.net>
 <1308836553-12460-1-git-send-email-hadess@hadess.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1308836553-12460-1-git-send-email-hadess@hadess.net>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Bastien,

I've pushed the two first patches and was also about to push this one
after doing some minor fixes first myself. However, I kept on finding
more and more issues to fix, so unfortunately here goes another feedback
round...

On Thu, Jun 23, 2011, Bastien Nocera wrote:
> + *  BlueZ - Bluetooth protocol stack for Linux
> + *
> + *  Copyright (C) 2011  Red Hat, Inc.
> + *

You'll still need to keep also Marcel's copyright here due to
considerable portions (such as the expand_name function) having been
copied from elsewhere.

> +static int adaptername_probe(struct btd_adapter *adapter)
> +{
> +	int current_id;
> +	char name[MAX_NAME_LENGTH + 1];
> +	char *pretty_hostname;
> +	bdaddr_t bdaddr;
> +
> +	current_id = adapter_get_dev_id(adapter);
> +
> +	pretty_hostname = read_pretty_host_name();
> +	if (pretty_hostname != NULL) {
> +		int default_adapter;
> +
> +		default_adapter = get_default_adapter_id();
> +
> +		/* Allow us to change the name */
> +		adapter_set_allow_name_changes(adapter, TRUE);
> +
> +		/* If it's the first device, let's assume it will
> +		 * be the default one, as we're not told when
> +		 * the default adapter changes */
> +		if (default_adapter < 0)
> +			default_adapter = current_id;
> +
> +		if (default_adapter != current_id) {
> +			char *str;
> +
> +			/* +1 because we don't want an adapter called "Foobar's laptop #0" */
> +			str = g_strdup_printf("%s #%d", pretty_hostname, current_id + 1);
> +			DBG("Setting name '%s' for device 'hci%d'", str, current_id);
> +
> +			adapter_update_local_name(adapter, str);
> +			g_free(str);
> +		} else {
> +			DBG("Setting name '%s' for device 'hci%d'", pretty_hostname, current_id);
> +			adapter_update_local_name(adapter, pretty_hostname);
> +		}
> +		g_free(pretty_hostname);
> +
> +		/* And disable the name change now */
> +		adapter_set_allow_name_changes(adapter, FALSE);
> +
> +		return 0;
> +	}

I think I already mentioned this in another email, but this longish
if-branch should really be its own function. E.g. something like:

	if (pretty_hostname != NULL) {
		set_pretty_host_name(adapter, pretty_hostname);
		return 0;
	}

> +	while (i < len) {
> +		struct inotify_event *pevent = (struct inotify_event *) &buf[i];
> +
> +		/* check that it's ours */
> +		if (pevent->len &&
> +		    pevent->name != NULL &&
> +		    strcmp(pevent->name, MACHINE_INFO_FILE) == 0) {

The above two lines mix tabs and spaces for indentation.

> +static void adaptername_remove(struct btd_adapter *adapter)
> +{
> +	if (watch_fd >= 0)
> +		close(watch_fd);
> +	if (inotify != NULL)
> +		g_io_channel_shutdown(inotify, FALSE, NULL);
> +}
> +
> +static struct btd_adapter_driver adaptername_driver = {
> +	.name	= "adaptername",
> +	.probe	= adaptername_probe,
> +	.remove	= adaptername_remove,
> +};
> +
> +static int adaptername_init(void)
> +{
> +	int ret;
> +	int inot_fd;
> +
> +	ret = btd_register_adapter_driver(&adaptername_driver);
> +
> +	if (ret != 0)
> +		return ret;

Please use "err" and the check should be if (err < 0). Also, no empty
line before the if-statement.

> +	inot_fd = inotify_init();
> +	if (inot_fd < 0) {
> +		error("Failed to setup inotify");
> +		return 0;
> +	}
> +	watch_fd = inotify_add_watch(inot_fd,

Empty line after after the } line please.

> +				     MACHINE_INFO_DIR,
> +				     IN_CLOSE_WRITE | IN_DELETE | IN_CREATE |
> +				     IN_MOVED_FROM | IN_MOVED_TO);

Mixed tabs and spaces in the above lines. The code might get easier to
read if you created a "uint32_t mask" variable in the function and
passed that to the inotify_add_watch call.

> +	if (watch_fd < 0) {
> +		error("Failed to setup watch for '%s'",
> +		      MACHINE_INFO_DIR);

Mixed tabs and spaces in the above line.

> +		return 0;
> +	}

Shouldn't you close(inot_fd) before the above return?

Johan
