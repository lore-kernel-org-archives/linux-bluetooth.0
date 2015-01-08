Return-Path: <cyrus@holtmann.org>
Date: Thu, 8 Jan 2015 16:20:06 +0200
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/2] shared/gatt: Fix NULL dereference
Message-ID: <20150108142005.GB7114@aemeltch-MOBL1>
References: <1418981124-19877-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <20141222113251.GA25294@aemeltch-MOBL1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20141222113251.GA25294@aemeltch-MOBL1>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

ping

On Mon, Dec 22, 2014 at 01:32:56PM +0200, Andrei Emeltchenko wrote:
> ping
> 
> On Fri, Dec 19, 2014 at 11:25:23AM +0200, Andrei Emeltchenko wrote:
> > From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> > 
> > The which is executed after checking (!op) is dereferencing op in
> > function discovery_op_free().
> > ---
> >  src/shared/gatt-client.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/src/shared/gatt-client.c b/src/shared/gatt-client.c
> > index f7a90d1..c9fb05d 100644
> > --- a/src/shared/gatt-client.c
> > +++ b/src/shared/gatt-client.c
> > @@ -1075,11 +1075,12 @@ static void process_service_changed(struct bt_gatt_client *client,
> >  		return;
> >  	}
> >  
> > +	discovery_op_free(op);
> > +
> >  fail:
> >  	util_debug(client->debug_callback, client->debug_data,
> >  					"Failed to initiate service discovery"
> >  					" after Service Changed");
> > -	discovery_op_free(op);
> >  }
> >  
> >  static void service_changed_cb(uint16_t value_handle, const uint8_t *value,
> > -- 
> > 2.1.0
> > 
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
