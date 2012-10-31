Return-Path: <cyrus@holtmann.org>
Date: Wed, 31 Oct 2012 11:07:58 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Szymon Janc <szymon.janc@tieto.com>
Cc: =?iso-8859-1?Q?Fr=E9d=E9ric?= Danis
	<frederic.danis@linux.intel.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH v10 4/6] dbusoob: Set device name in device object
Message-ID: <20121031090758.GB20722@x220>
References: <1351616728-10075-1-git-send-email-frederic.danis@linux.intel.com>
 <1351616728-10075-4-git-send-email-frederic.danis@linux.intel.com>
 <14230948.4LRRcOUNYX@uw000953>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <14230948.4LRRcOUNYX@uw000953>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

On Wed, Oct 31, 2012, Szymon Janc wrote:
> > --- a/plugins/dbusoob.c
> > +++ b/plugins/dbusoob.c
> > @@ -193,6 +193,7 @@ static gboolean parse_data(DBusMessageIter *data, struct oob_data *remote_data)
> >  
> >  static gboolean store_data(struct btd_adapter *adapter, struct oob_data *data)
> >  {
> > +	bdaddr_t local = *adapter_get_address(adapter);
> >  	bdaddr_t bdaddr;
> >  
> >  	str2ba(data->addr, &bdaddr);
> > @@ -207,9 +208,13 @@ static gboolean store_data(struct btd_adapter *adapter, struct oob_data *data)
> >  		write_remote_class(adapter_get_address(adapter), &bdaddr,
> >  								data->class);
> >  
> > -	if (data->name)
> > -		write_device_name(adapter_get_address(adapter), &bdaddr, 0,
> > -								data->name);
> > +	if (data->name) {
> > +		char *str;
> > +
> > +		str = g_strdup(data->name);
> > +		btd_event_remote_name(&local, &bdaddr, str);
> > +		g_free(str);
> 
> Is this g_strdup needed? Why not just pass data->name directly?

This was because of missing const declarations in the event.h API. I
fixed this up and removed the extra strdup from this patch.

Johan
