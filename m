Return-Path: <cyrus@holtmann.org>
Date: Wed, 19 Oct 2011 10:59:08 +0300
From: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCHv3 3/4] add 64 bit get_val support
Message-ID: <20111019075907.GD28113@aemeltch-MOBL1>
References: <1318839662-13609-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1318839662-13609-4-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1318865471.15441.96.camel@aeonflux>
 <20111018063327.GA7784@aemeltch-MOBL1>
 <1318953233.15441.125.camel@aeonflux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1318953233.15441.125.camel@aeonflux>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Tue, Oct 18, 2011 at 08:53:51AM -0700, Marcel Holtmann wrote:
> > > > +	case 8:
> > > > +		return btohll(bt_get_unaligned((uint64_t *) ptr));
> > > >  	}
> > > >  	return 0;
> > > >  }
> > > 
> > > turning everything into a uint64 is a bit heavy. Just change this into
> > > broken down version. get_uint64, get_uint32, get_uint16 etc. Otherwise
> > > you keep casting yourself crazy.
> > 
> > Yes, casting does not look nice. What about if I keep everything AS IS and
> > just use btohll(bt_get_unaligned((ptr)) to access 64 bit value.
> 
> this does not make it more readable. Create helpers like get_uint64 for
> it.

Is this OK:

--- a/parser/parser.h
+++ b/parser/parser.h
...
+static inline uint64_t get_uint64(void *ptr)
+{
+       return btohll(bt_get_unaligned((uint64_t *) ptr));
+}
...

--- a/parser/l2cap.c
+++ b/parser/l2cap.c
...
        case 0x0003:
-               fc_mask = btohll(bt_get_unaligned((uint64_t *) ptr));
+               fc_mask = get_uint64(ptr);
...

Best regards 
Andrei Emeltchenko 
 
