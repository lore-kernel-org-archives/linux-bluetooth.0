Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCHv3 3/4] add 64 bit get_val support
From: Marcel Holtmann <marcel@holtmann.org>
To: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Wed, 19 Oct 2011 08:59:27 -0700
In-Reply-To: <20111019075907.GD28113@aemeltch-MOBL1>
References: <1318839662-13609-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
	 <1318839662-13609-4-git-send-email-Andrei.Emeltchenko.news@gmail.com>
	 <1318865471.15441.96.camel@aeonflux> <20111018063327.GA7784@aemeltch-MOBL1>
	 <1318953233.15441.125.camel@aeonflux>
	 <20111019075907.GD28113@aemeltch-MOBL1>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <1319039969.15441.145.camel@aeonflux>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

> > > > > +	case 8:
> > > > > +		return btohll(bt_get_unaligned((uint64_t *) ptr));
> > > > >  	}
> > > > >  	return 0;
> > > > >  }
> > > > 
> > > > turning everything into a uint64 is a bit heavy. Just change this into
> > > > broken down version. get_uint64, get_uint32, get_uint16 etc. Otherwise
> > > > you keep casting yourself crazy.
> > > 
> > > Yes, casting does not look nice. What about if I keep everything AS IS and
> > > just use btohll(bt_get_unaligned((ptr)) to access 64 bit value.
> > 
> > this does not make it more readable. Create helpers like get_uint64 for
> > it.
> 
> Is this OK:
> 
> --- a/parser/parser.h
> +++ b/parser/parser.h
> ...
> +static inline uint64_t get_uint64(void *ptr)
> +{
> +       return btohll(bt_get_unaligned((uint64_t *) ptr));
> +}
> ...

that would be fine with me.

And if you wanna go all out, then you could fix the weird SDP big-endian
conversion/handling that is lingering around the source code and all
parsers for a while now.

Maybe just something like get_le64, get_le32, get_be32 etc. Think about
it a little bit and if you are up for some major cleanup task.

Regards

Marcel


