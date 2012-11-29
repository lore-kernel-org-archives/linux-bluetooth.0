Return-Path: <cyrus@holtmann.org>
Date: Thu, 29 Nov 2012 08:27:47 -0200
From: Gustavo Padovan <gustavo@padovan.org>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [RFC 4/5] Bluetooth: Process receiving FCS_NONE in L2CAP Conf Rsp
Message-ID: <20121129102747.GB26707@joana>
References: <1354118382-25571-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1354118382-25571-4-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1354118382-25571-4-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

* Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com> [2012-11-28 17:59:41 +0200]:

> From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> 
> Process L2CAP Config rsp Pending with FCS Option 0x00 (No FCS)
> which is sent by Motorola Windows 7 Bluetooth stack. The trace
> is shown below (all other options are skipped).
> 
> ...
> < ACL data: handle 1 flags 0x00 dlen 48
>     L2CAP(s): Config req: dcid 0x0043 flags 0x00 clen 36
>       ...
>       FCS Option 0x00 (No FCS)
> > ACL data: handle 1 flags 0x02 dlen 48
>     L2CAP(s): Config req: dcid 0x0041 flags 0x00 clen 36
>       ...
>       FCS Option 0x01 (CRC16 Check)
> < ACL data: handle 1 flags 0x00 dlen 47
>     L2CAP(s): Config rsp: scid 0x0043 flags 0x00 result 4 clen 33
>       Pending
>       ...
> > ACL data: handle 1 flags 0x02 dlen 50
>     L2CAP(s): Config rsp: scid 0x0041 flags 0x00 result 4 clen 36
>       Pending
>       ...
>       FCS Option 0x00 (No FCS)
> < ACL data: handle 1 flags 0x00 dlen 14
>     L2CAP(s): Config rsp: scid 0x0043 flags 0x00 result 0 clen 0
>       Success
> > ACL data: handle 1 flags 0x02 dlen 14
>     L2CAP(s): Config rsp: scid 0x0041 flags 0x00 result 0 clen 0
>       Success
> ...
> 
> Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> ---
>  net/bluetooth/l2cap_core.c |    6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> index f10e4be..d30978b 100644
> --- a/net/bluetooth/l2cap_core.c
> +++ b/net/bluetooth/l2cap_core.c
> @@ -3429,6 +3429,12 @@ static int l2cap_parse_conf_rsp(struct l2cap_chan *chan, void *rsp, int len,
>  			l2cap_add_conf_opt(&ptr, L2CAP_CONF_EFS, sizeof(efs),
>  					   (unsigned long) &efs);
>  			break;
> +
> +		case L2CAP_CONF_FCS:
> +			if (*result == L2CAP_CONF_PENDING)
> +				if (val == L2CAP_FCS_NONE)
> +					set_bit(CONF_NO_FCS_RECV, &chan->conf_state);

Please break a line here as well.

	Gustavo
