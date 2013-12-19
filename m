Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/4] android/bluetooth: Add initial support for permanent storage
Date: Thu, 19 Dec 2013 10:46:23 +0100
Message-ID: <1539507.GD54UJZ94B@uw000953>
In-Reply-To: <20131219091423.GC6199@x220.p-661hnu-f1>
References: <1387375558-17976-1-git-send-email-szymon.janc@tieto.com> <8514937.6olCGu9n2J@uw000953> <20131219091423.GC6199@x220.p-661hnu-f1>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> Hi Szymon,
> 
> On Thu, Dec 19, 2013, Szymon Janc wrote:
> > > On Wed, Dec 18, 2013, Szymon Janc wrote:
> > > > +static void store_adapter_config(void)
> > > > +{
> > > > +	GKeyFile *key_file;
> > > > +	gsize length = 0;
> > > > +	char addr[18];
> > > > +	char *data;
> > > > +
> > > > +	key_file = g_key_file_new();
> > > > +
> > > > +	if (!g_key_file_load_from_file(key_file, ANDROID_STORAGEDIR"/settings",
> > > > +								0, NULL)) {
> > > > +		int fd = open(ANDROID_STORAGEDIR"/settings", O_CREAT, 0600);
> > > > +		if (fd < 0) {
> > > > +			error("Failed to create adapter config file: %d (%s)",
> > > > +							errno, strerror(errno));
> > > > +			return;
> > > > +		}
> > > > +
> > > > +		close(fd);
> > > > +	}
> > > > +
> > > > +	ba2str(&adapter.bdaddr, addr);
> > > > +
> > > > +	g_key_file_set_string(key_file, "General", "Address", addr);
> > > > +	g_key_file_set_string(key_file, "General", "Name", adapter.name);
> > > > +	g_key_file_set_integer(key_file, "General", "DiscoverableTimeout",
> > > > +						adapter.discoverable_timeout);
> > > > +
> > > > +	data = g_key_file_to_data(key_file, &length, NULL);
> > > > +
> > > > +	g_file_set_contents(ANDROID_STORAGEDIR"/settings", data, length, NULL);
> > > 
> > > The whole open(..., O_CREAT, ...) trick you do seems completely
> > > unnecessary as g_key_file_to_data will create the file if it doesn't
> > > exist. Instead, if you want to log an error you'd need to check if
> > > g_key_file_contents failed or not. Adding a GError into the mix and
> > > logging the exact error message would be even better.
> > 
> > This was done only to make sure proper permissions are used for file. Since
> > glib doens't offer any API (at least I couldn't find any) for that in g_file_*
> > (other than wrappers to standard unix calls)
> 
> What permissions does the file get created with if you omit this? Maybe
> the right fix is to set the umask explicitly in our main() or to modify
> how the daemon gets executed?

It was 0600 on Android so it looks like Android init is setting good mask, but
it was 0644 on Linux host.

I suppose we could fix system-emulator to set umask to have correct permissions
on host.

Will send V2.

-- 
BR
Szymon Janc


