Return-Path: <cyrus@holtmann.org>
Date: Thu, 19 Dec 2013 10:29:07 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Szymon Janc <szymon.janc@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/4] android/bluetooth: Add initial support for permanent
 storage
Message-ID: <20131219082907.GA2549@x220.p-661hnu-f1>
References: <1387375558-17976-1-git-send-email-szymon.janc@tieto.com>
 <1387375558-17976-2-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1387375558-17976-2-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

On Wed, Dec 18, 2013, Szymon Janc wrote:
> +static void store_adapter_config(void)
> +{
> +	GKeyFile *key_file;
> +	gsize length = 0;
> +	char addr[18];
> +	char *data;
> +
> +	key_file = g_key_file_new();
> +
> +	if (!g_key_file_load_from_file(key_file, ANDROID_STORAGEDIR"/settings",
> +								0, NULL)) {
> +		int fd = open(ANDROID_STORAGEDIR"/settings", O_CREAT, 0600);
> +		if (fd < 0) {
> +			error("Failed to create adapter config file: %d (%s)",
> +							errno, strerror(errno));
> +			return;
> +		}
> +
> +		close(fd);
> +	}
> +
> +	ba2str(&adapter.bdaddr, addr);
> +
> +	g_key_file_set_string(key_file, "General", "Address", addr);
> +	g_key_file_set_string(key_file, "General", "Name", adapter.name);
> +	g_key_file_set_integer(key_file, "General", "DiscoverableTimeout",
> +						adapter.discoverable_timeout);
> +
> +	data = g_key_file_to_data(key_file, &length, NULL);
> +
> +	g_file_set_contents(ANDROID_STORAGEDIR"/settings", data, length, NULL);

The whole open(..., O_CREAT, ...) trick you do seems completely
unnecessary as g_key_file_to_data will create the file if it doesn't
exist. Instead, if you want to log an error you'd need to check if
g_key_file_contents failed or not. Adding a GError into the mix and
logging the exact error message would be even better.

Johan
