Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/4] android/bluetooth: Add initial support for permanent storage
Date: Thu, 19 Dec 2013 09:35:52 +0100
Message-ID: <8514937.6olCGu9n2J@uw000953>
In-Reply-To: <20131219082907.GA2549@x220.p-661hnu-f1>
References: <1387375558-17976-1-git-send-email-szymon.janc@tieto.com> <1387375558-17976-2-git-send-email-szymon.janc@tieto.com> <20131219082907.GA2549@x220.p-661hnu-f1>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,


> Hi Szymon,
> 
> On Wed, Dec 18, 2013, Szymon Janc wrote:
> > +static void store_adapter_config(void)
> > +{
> > +	GKeyFile *key_file;
> > +	gsize length = 0;
> > +	char addr[18];
> > +	char *data;
> > +
> > +	key_file = g_key_file_new();
> > +
> > +	if (!g_key_file_load_from_file(key_file, ANDROID_STORAGEDIR"/settings",
> > +								0, NULL)) {
> > +		int fd = open(ANDROID_STORAGEDIR"/settings", O_CREAT, 0600);
> > +		if (fd < 0) {
> > +			error("Failed to create adapter config file: %d (%s)",
> > +							errno, strerror(errno));
> > +			return;
> > +		}
> > +
> > +		close(fd);
> > +	}
> > +
> > +	ba2str(&adapter.bdaddr, addr);
> > +
> > +	g_key_file_set_string(key_file, "General", "Address", addr);
> > +	g_key_file_set_string(key_file, "General", "Name", adapter.name);
> > +	g_key_file_set_integer(key_file, "General", "DiscoverableTimeout",
> > +						adapter.discoverable_timeout);
> > +
> > +	data = g_key_file_to_data(key_file, &length, NULL);
> > +
> > +	g_file_set_contents(ANDROID_STORAGEDIR"/settings", data, length, NULL);
> 
> The whole open(..., O_CREAT, ...) trick you do seems completely
> unnecessary as g_key_file_to_data will create the file if it doesn't
> exist. Instead, if you want to log an error you'd need to check if
> g_key_file_contents failed or not. Adding a GError into the mix and
> logging the exact error message would be even better.

This was done only to make sure proper permissions are used for file. Since
glib doens't offer any API (at least I couldn't find any) for that in g_file_*
(other than wrappers to standard unix calls)

-- 
BR
Szymon Janc

