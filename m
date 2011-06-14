Return-Path: <cyrus@holtmann.org>
Date: Tue, 14 Jun 2011 11:07:30 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Bastien Nocera <hadess@hadess.net>
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>,
	linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: Re: [PATCH] adaptername: Move adapter naming into a plugin
Message-ID: <20110614080730.GC28890@dell.ger.corp.intel.com>
References: <BANLkTind9qu33viRE+eSB6b7SiGhr_DTLQ@mail.gmail.com>
 <1307554688-21555-1-git-send-email-hadess@hadess.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1307554688-21555-1-git-send-email-hadess@hadess.net>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Bastien,

On Wed, Jun 08, 2011, Bastien Nocera wrote:
> +++ b/plugins/adaptername.c
> @@ -0,0 +1,293 @@
> +/*
> + *
> + *  BlueZ - Bluetooth protocol stack for Linux
> + *
> + *  Copyright (C) 2004-2010  Marcel Holtmann <marcel@holtmann.org>

You sure you don't want to add your own copyright here? Marcel's
copyright is justified due to copied portions of the file, but the
amount of new code that you're adding would also entitle you to add your
own declaration.

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
> +		default_adapter = manager_get_default_adapter_id();
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

Since this is a quite large if-branch and the only exit from it is the
"return 0;" statement, I think it's a quite good indication that the
code should be in its own function (it'll also help you with following
the max 79 characters per line rule).

> +static gboolean handle_inotify_cb(GIOChannel *channel,
> +		GIOCondition condition, gpointer data)
> +{
> +	char buf[EVENT_BUF_LEN];
> +	GIOStatus err;
> +	gsize len, i;
> +	gboolean changed;
> +
> +	changed = FALSE;
> +
> +	err = g_io_channel_read_chars(channel, buf, EVENT_BUF_LEN, &len, NULL);
> +	if (err != G_IO_STATUS_NORMAL) {
> +		error("Error reading inotify event: %d\n", err);
> +		return FALSE;
> +	}
> +
> +	i = 0;
> +	while (i < len) {
> +		struct inotify_event *pevent = (struct inotify_event *) &buf[i];
> +
> +		/* check that it's ours */
> +		if (pevent->len &&
> +		    pevent->name != NULL &&
> +		    strcmp(pevent->name, MACHINE_INFO_FILE) == 0) {

The two above line mix tabs and spaces for indentation. Please only use
tabs.

> +static int adaptername_init(void)
> +{
> +	int ret;
> +	int inot_fd;
> +
> +	ret = btd_register_adapter_driver(&adaptername_driver);
> +
> +	if (ret != 0)
> +		return ret;
> +
> +	inot_fd = inotify_init();
> +	if (inot_fd < 0) {
> +		error("Failed to setup inotify");
> +		return 0;
> +	}
> +	watch_fd = inotify_add_watch(inot_fd,
> +				     MACHINE_INFO_DIR,
> +				     IN_CLOSE_WRITE | IN_DELETE | IN_CREATE);

Same here (two above lines).

> +	if (watch_fd < 0) {
> +		error("Failed to setup watch for '%s'",
> +		      MACHINE_INFO_DIR);

And here.

> -	adapter->name_stored = FALSE;
> +	if (adapter->up) {
> +		int err = adapter_ops->set_name(adapter->dev_id, name);
> +		if (err < 0)
> +			return err;
> +	}
> +
> +	return 0;

This could simply be:

	if (adapter->up)
		return adapter_ops->set_name(adapter->dev_id, name);

	return 0;

Other than that I didn't find any major issues, however please consider
the suggestion from Lizardo to split the patch in two parts.

Johan
