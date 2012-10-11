Return-Path: <cyrus@holtmann.org>
Date: Thu, 11 Oct 2012 17:00:56 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>,
	linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: SMP: Fix setting unknown auth_req bits
Message-ID: <20121011150056.GA31247@x220.example.org>
References: <1349965566-29482-1-git-send-email-johan.hedberg@gmail.com>
 <20121011143355.GA28051@aemeltch-MOBL1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20121011143355.GA28051@aemeltch-MOBL1>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On Thu, Oct 11, 2012, Andrei Emeltchenko wrote:
> > @@ -230,7 +232,7 @@ static void build_pairing_cmd(struct l2cap_conn *conn,
> >  		req->max_key_size = SMP_MAX_ENC_KEY_SIZE;
> >  		req->init_key_dist = 0;
> >  		req->resp_key_dist = dist_keys;
> > -		req->auth_req = authreq;
> > +		req->auth_req = (authreq & AUTH_REQ_MASK);
> >  		return;
> >  	}
> >  
> > @@ -239,7 +241,7 @@ static void build_pairing_cmd(struct l2cap_conn *conn,
> >  	rsp->max_key_size = SMP_MAX_ENC_KEY_SIZE;
> >  	rsp->init_key_dist = 0;
> >  	rsp->resp_key_dist = req->resp_key_dist & dist_keys;
> > -	rsp->auth_req = authreq;
> > +	rsp->auth_req = (authreq & AUTH_REQ_MASK);
> 
> Would it be better to omit braces like in the line above? For both cases.

I actually didn't notice the line above the second chunk. I always
thought it was good practice to have explicit braces around bitwise
operations to avoid evaluation-order bugs (particularly in
if-statements) so I just always do it. I'll leave this to Gustavo or
Marcel to object to if necessary (otoh Marcel already gave his ack).

Johan
