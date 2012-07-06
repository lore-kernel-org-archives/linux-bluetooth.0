Return-Path: <cyrus@holtmann.org>
Date: Fri, 6 Jul 2012 17:24:21 -0300
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: Vinicius Costa Gomes <vcgomes@gmail.com>,
	linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ] mgmtops: Fix calling btd_adapter_start() for an
 off adapter
Message-ID: <20120706202421.GA3084@echo>
References: <1341600448-26310-1-git-send-email-vinicius.gomes@openbossa.org>
 <20120706200412.GA17578@x220.spectrum.wifi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20120706200412.GA17578@x220.spectrum.wifi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

On 21:04 Fri 06 Jul, Johan Hedberg wrote:
> Hi Vinicius,
> 
> On Fri, Jul 06, 2012, Vinicius Costa Gomes wrote:
> > When the adapter mode is off and the controller is down, we should
> > not consider that the adapter is powered up.
> > ---
> >  plugins/mgmtops.c |    2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/plugins/mgmtops.c b/plugins/mgmtops.c
> > index c060ada..4c86389 100644
> > --- a/plugins/mgmtops.c
> > +++ b/plugins/mgmtops.c
> > @@ -1074,7 +1074,7 @@ static void read_info_complete(int sk, uint16_t index, void *buf, size_t len)
> >  
> >  	if (mode != MODE_OFF && !mgmt_powered(info->current_settings))
> >  		mgmt_set_powered(index, TRUE);
> > -	else {
> > +	else if (mode != MODE_OFF) {
> >  		get_connections(sk, index);
> >  		btd_adapter_start(adapter);
> >  	}
> 
> Thanks for catching this, but I think the following would be even more
> clear:
> 
> 	if (mode != MODE_OFF) {
> 		if (mgmt_powered(info->current_settings)) {
> 			get_connections(sk, index);
> 			btd_adapter_start(adapter);
> 		} else
> 			mgmt_set_powered(index, TRUE);
> 	}
> 
> Could you please resend a patch with this logic (assuming you agree)?

Yeah, I agree. Patch coming in a few moments.

> 
> Johan


Cheers,
-- 
Vinicius
