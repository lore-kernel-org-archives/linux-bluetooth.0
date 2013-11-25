Return-Path: <cyrus@holtmann.org>
Date: Mon, 25 Nov 2013 15:24:54 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Szymon Janc <szymon.janc@tieto.com>
Cc: Sebastian <sebastianchlad@gmail.com>,
	linux-bluetooth@vger.kernel.org,
	Sebastian Chlad <sebastian.chlad@tieto.com>
Subject: Re: [PATCH] Adding paired-devices cmd to the bluetoothctl
Message-ID: <20131125132454.GA19445@x220.p-661hnu-f1>
References: <1384978912-27461-1-git-send-email-sebastian.chlad@tieto.com>
 <7144304.2MX7gdvi4Y@uw000953>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <7144304.2MX7gdvi4Y@uw000953>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

On Mon, Nov 25, 2013, Szymon Janc wrote:
> > Paired-devices command lists only paired devices
> > ---
> >  client/main.c | 22 ++++++++++++++++++++++
> >  1 file changed, 22 insertions(+)
> > 
> > diff --git a/client/main.c b/client/main.c
> > index 0dd1510..c39ebf8 100644
> > --- a/client/main.c
> > +++ b/client/main.c
> > @@ -538,6 +538,26 @@ static void cmd_devices(const char *arg)
> >  	}
> >  }
> >  
> > +static void cmd_devices_paired(const char *arg)
> > +{
> > +	GList *list;
> > +
> > +	for (list = g_list_first(dev_list); list; list = g_list_next(list)) {
> > +		DBusMessageIter iter;
> > +		GDBusProxy *proxy = list->data;
> > +		dbus_bool_t paired;
> > +
> > +		if (g_dbus_proxy_get_property(proxy, "Paired", &iter) == FALSE)
> > +			return;
> > +		dbus_message_iter_get_basic(&iter, &paired);
> > +
> > +		if (!paired)
> > +			break;
> 
> Shouldn't this be
>   if (!paired)
>       continue;
> 
> ? Or paired devices are guaranteed to be first on list?

They're not, and the same goes the for return statement in case
g_dbus_proxy_get_property fails. Since this was the last patch pushed I
did a git commit --amend + git push --force to avoid a fixup patch.

Johan
