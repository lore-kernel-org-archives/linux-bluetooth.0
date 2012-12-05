Return-Path: <cyrus@holtmann.org>
Date: Wed, 5 Dec 2012 13:14:30 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Szymon Janc <szymon.janc@tieto.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH] adapter: Fix compilation on some architectures
Message-ID: <20121205111430.GA5233@x220.ger.corp.intel.com>
References: <1354701750-15578-1-git-send-email-szymon.janc@tieto.com>
 <20121205102958.GA1650@x220.ger.corp.intel.com>
 <1564894.mIcBMGi0ah@uw000953>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1564894.mIcBMGi0ah@uw000953>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

On Wed, Dec 05, 2012, Szymon Janc wrote:
> > > --- a/src/adapter.c
> > > +++ b/src/adapter.c
> > > @@ -2673,7 +2673,7 @@ static void convert_ltk_entry(GKeyFile *key_file, void *value)
> > >  static void convert_entry(char *key, char *value, void *user_data)
> > >  {
> > >  	struct device_converter *converter = user_data;
> > > -	char device_type = -1;
> > > +	signed char device_type = -1;
> > >  	char filename[PATH_MAX + 1];
> > >  	GKeyFile *key_file;
> > >  	char *data;
> > 
> > Couldn't we just initialize the value to BDADDR_BREDR or maybe use an
> > int for it. And the naming is confusing as the value contains an address
> > type and not a device type.
> 
> Initializing it to BDADDR_BREDR wouldn't fix compilation as problem is in
> comparing >=0 when type is unsigned (and would change function flow as now
> device_set_type is called only if device_type is >=0)...  I'm not sure what
> was decided about storage changes so didn't wanted to fiddle with that.

I meant that you'd also then remove the test for >= 0 and always write
the type (defaulting to BR/EDR)

> So, if it is OK to always fall back to BDADDR_BREDR I can resent V2 with that
> change, else I can sent V2 with use of int if you prefer it over signed char.

I'd just default to BDADDR_BREDR. That's what entries without an
explicit type are going to be anyway since older BlueZ versions didn't
support LE.

Johan
