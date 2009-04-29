Return-Path: <cyrus@holtmann.org>
Subject: Re: GSoC 2009: L2CAP Enhanced Retransmission mode
From: Marcel Holtmann <marcel@holtmann.org>
To: "Gustavo F. Padovan" <gustavo@las.ic.unicamp.br>
Cc: ngh@isomerica.net, linux-bluetooth@vger.kernel.org,
	Barry Reinhold <bbr@lampreynetworks.com>
In-Reply-To: <6b53b1990904290142u12165c30me531912137534e22@mail.gmail.com>
References: <6b53b1990904251605s75ad3478v987d3fc47e2bc318@mail.gmail.com>
	 <1240929768.3441.5866.camel@localhost.localdomain>
	 <1240933237.997.37.camel@localhost.localdomain>
	 <1240936070.3441.5901.camel@localhost.localdomain>
	 <1240937363.997.47.camel@localhost.localdomain>
	 <6b53b1990904281214y304fd3dav6ca79e7905e7c5d5@mail.gmail.com>
	 <6b53b1990904290142u12165c30me531912137534e22@mail.gmail.com>
Content-Type: text/plain
Date: Wed, 29 Apr 2009 07:28:17 -0700
Message-Id: <1241015297.997.73.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gustavo,

> I'm working on add the initial constant change to upstream. Until now
> I have squashed your 6 first commits and have made change on it.
> 
> http://www.las.ic.unicamp.br/~gustavo/git/?p=bluetooth-testing.git;a=commit;h=a75b529b5e70ecbbe4dd56527300bf2d4b95de2f

please send a proper inline mail with this patch to the mailing list so
I can comment on it.

>  A little report and some question about it:
> 
> 1. I Removed the L2CAP features bits that we won't use now. I'm
> supposing that we are going to implement ERTM, Streaming mode and FCS
> Option.

The order should be ERTM, FCS Option and then Streaming mode.

> 2. What did you mean with  "__u16    mtu_cnl;" ( first patch, I
> think)? connectionless MTU?

Don't bother with this values. We are not doing connless support.

> 3. #define L2CAP_MODE_DEFAULT    L2CAP_MODE_ENH_RETRANS
> I think that we can't default this now, because de code goes to
> upstream, same for L2CAP_FCS_DEFAULT.

For SOCK_SEQPACKET, the default mode is BASIC, for SOCK_STREAM it will
be ERTM. When using SOCK_SEQPACKET, the socket option L2CAP_OPTIONS need
be used to select ERTM. That option is already present.

> 4.
> @@ -1711,12 +1715,25 @@ static int l2cap_build_conf_req(struct sock
> *sk, void *data)
> ...
> +       if (pi->mode != L2CAP_MODE_BASIC) {
> +               rfc.mode = pi->mode;
> +               rfc.txwin_size = L2CAP_DEFAULT_RX_WINDOW;
> +               rfc.max_transmit = L2CAP_DEFAULT_MAX_RECEIVE;
> +               rfc.retrans_timeout =
> cpu_to_le16(L2CAP_DEFAULT_RETRANS_TIMEOUT);
> +               rfc.monitor_timeout =
> cpu_to_le16(L2CAP_DEFAULT_MONITOR_TIMEOUT);
> +               rfc.max_pdu_size = cpu_to_le16(L2CAP_DEFAULT_MAX_RX_APDU);
> +
> +               l2cap_add_conf_opt(&ptr, L2CAP_CONF_RFC, sizeof(rfc), &rfc);
> +       }
> 
> That's wrong. pi->mode == L2CAP_MODE_ENH_RETRANS it's better.
> txwin_size, max_transmit, retrans_timeout and monitor_timeout should
> be 0 in L2CAP_MODE_STREAMING.

Agreed.

Regards

Marcel


