Return-Path: <cyrus@holtmann.org>
Date: Fri, 27 Jun 2014 17:10:05 +0300
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: Szymon Janc <szymon.janc@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCHv3 05/12] android/health: Refactor channel creation
Message-ID: <20140627141003.GA21456@aemeltch-MOBL1>
References: <1403855994-29262-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1403868303-8129-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1403868303-8129-5-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <2928119.zKrzGcmLP8@uw000953>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <2928119.zKrzGcmLP8@uw000953>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

On Fri, Jun 27, 2014 at 03:54:20PM +0200, Szymon Janc wrote:
> Hi Andrei,
> 
> On Friday 27 of June 2014 14:24:56 Andrei Emeltchenko wrote:
> > From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> > 
> > Avoid using app_id when we shall use app structure itself. Otherwise we
> > end up with unnecessary searches for app and problems for incoming
> > connections.
> > ---
> >  android/health.c | 43 ++++++++++++++++++++++---------------------
> >  1 file changed, 22 insertions(+), 21 deletions(-)
> > 
> > diff --git a/android/health.c b/android/health.c
> > index 3cb2016..d664324 100644
> > --- a/android/health.c
> > +++ b/android/health.c
> > @@ -1477,43 +1477,37 @@ static struct health_device *create_device(struct health_app *app,
> >  	return dev;
> >  }
> >  
> > -static struct health_device *get_device(uint16_t app_id, const uint8_t *addr)
> > +static struct health_app *get_app(uint16_t app_id)
> > +{
> > +	return queue_find(apps, match_app_by_id, INT_TO_PTR(app_id));
> > +}
> > +
> > +static struct health_device *get_device(struct health_app *app,
> > +							const uint8_t *addr)
> >  {
> > -	struct health_app *app;
> >  	struct health_device *dev;
> >  	bdaddr_t bdaddr;
> >  
> > -	app = queue_find(apps, match_app_by_id, INT_TO_PTR(app_id));
> > -	if (!app)
> > -		return NULL;
> > -
> >  	android2bdaddr(addr, &bdaddr);
> >  	dev = queue_find(app->devices, match_dev_by_addr, &bdaddr);
> >  	if (dev)
> >  		return dev;
> >  
> > -	dev = create_device(app, addr);
> > -	if (dev)
> > -		dev->app_id = app_id;
> > -
> > -	return dev;
> > +	return create_device(app, addr);
> >  }
> >  
> > -static struct health_channel *create_channel(uint16_t app_id,
> > +static struct health_channel *create_channel(struct health_app *app,
> >  						uint8_t mdep_index,
> >  						struct health_device *dev)
> >  {
> > -	struct health_app *app;
> >  	struct mdep_cfg *mdep;
> >  	struct health_channel *channel;
> >  	uint8_t index;
> >  	static unsigned int channel_id = 1;
> >  
> > -	if (!dev)
> > -		return NULL;
> > +	DBG("mdep %u", mdep_index);
> >  
> > -	app = queue_find(apps, match_app_by_id, INT_TO_PTR(app_id));
> > -	if (!app)
> > +	if (!dev || !app)
> >  		return NULL;
> >  
> >  	index = mdep_index + 1;
> > @@ -1539,7 +1533,7 @@ static struct health_channel *create_channel(uint16_t app_id,
> >  	return channel;
> >  }
> >  
> > -static struct health_channel *get_channel(uint16_t app_id,
> > +static struct health_channel *get_channel(struct health_app *app,
> >  						uint8_t mdep_index,
> >  						struct health_device *dev)
> >  {
> > @@ -1555,7 +1549,7 @@ static struct health_channel *get_channel(uint16_t app_id,
> >  	if (channel)
> >  		return channel;
> >  
> > -	return create_channel(app_id, mdep_index, dev);
> > +	return create_channel(app, index, dev);
> >  }
> >  
> >  static void bt_health_connect_channel(const void *buf, uint16_t len)
> > @@ -1564,14 +1558,21 @@ static void bt_health_connect_channel(const void *buf, uint16_t len)
> >  	struct hal_rsp_health_connect_channel rsp;
> >  	struct health_device *dev = NULL;
> >  	struct health_channel *channel = NULL;
> > +	struct health_app *app;
> >  
> >  	DBG("");
> >  
> > -	dev = get_device(cmd->app_id, cmd->bdaddr);
> > +	app = get_app(cmd->app_id);
> > +	if (!app)
> > +		goto fail;
> > +
> > +	dev = get_device(app, cmd->bdaddr);
> >  	if (!dev)
> >  		goto fail;
> >  
> > -	channel = get_channel(cmd->app_id, cmd->mdep_index, dev);
> > +	dev->app_id = cmd->app_id;
> 
> Isn't device already having this set?

This one is just refactoring, so I leave all logic.

Best regards 
Andrei Emeltchenko 

