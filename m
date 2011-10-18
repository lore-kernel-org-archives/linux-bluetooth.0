Return-Path: <cyrus@holtmann.org>
Date: Tue, 18 Oct 2011 09:33:34 +0300
From: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCHv3 3/4] add 64 bit get_val support
Message-ID: <20111018063327.GA7784@aemeltch-MOBL1>
References: <1318839662-13609-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1318839662-13609-4-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1318865471.15441.96.camel@aeonflux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1318865471.15441.96.camel@aeonflux>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Mon, Oct 17, 2011 at 08:31:08AM -0700, Marcel Holtmann wrote:
> Hi Andrei,
> 
> >  parser/l2cap.c |   18 ++++++++++--------
> >  1 files changed, 10 insertions(+), 8 deletions(-)
> > 
> > diff --git a/parser/l2cap.c b/parser/l2cap.c
> > index 6a5a4b2..e1fc1f8 100644
> > --- a/parser/l2cap.c
> > +++ b/parser/l2cap.c
> > @@ -232,7 +232,7 @@ static uint8_t get_ext_ctrl(int in, uint16_t handle, uint16_t cid)
> >  	return 0;
> >  }
> >  
> > -static uint32_t get_val(uint8_t *ptr, uint8_t len)
> > +static uint64_t get_val(uint8_t *ptr, uint8_t len)
> >  {
> >  	switch (len) {
> >  	case 1:
> > @@ -241,6 +241,8 @@ static uint32_t get_val(uint8_t *ptr, uint8_t len)
> >  		return btohs(bt_get_unaligned((uint16_t *) ptr));
> >  	case 4:
> >  		return btohl(bt_get_unaligned((uint32_t *) ptr));
> > +	case 8:
> > +		return btohll(bt_get_unaligned((uint64_t *) ptr));
> >  	}
> >  	return 0;
> >  }
> 
> turning everything into a uint64 is a bit heavy. Just change this into
> broken down version. get_uint64, get_uint32, get_uint16 etc. Otherwise
> you keep casting yourself crazy.

Yes, casting does not look nice. What about if I keep everything AS IS and
just use btohll(bt_get_unaligned((ptr)) to access 64 bit value.

Best regards 
Andrei Emeltchenko 
