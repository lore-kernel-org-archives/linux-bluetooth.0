Return-Path: <cyrus@holtmann.org>
Date: Mon, 13 Dec 2010 15:04:19 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Pawel Wieczorkiewicz <pawel.wieczorkiewicz@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Setting default Link Policy according to the chip
 supported features
Message-ID: <20101213130419.GA12963@jh-x301>
References: <1292243202-6821-1-git-send-email-pawel.wieczorkiewicz@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1292243202-6821-1-git-send-email-pawel.wieczorkiewicz@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Pawel,

On Mon, Dec 13, 2010, Pawel Wieczorkiewicz wrote:
> By default all features are enabled (RSWITCH, HOLD, PARK, SNIFF).
> When "read local supported features" complete event occurs, not supported
> features are disabled and then "Write default link policy" command with
> supported features is sent.
> 
> On behalf of ST-Ericsson SA
> ---
>  plugins/hciops.c |   31 ++++++++++++++++---------------
>  1 files changed, 16 insertions(+), 15 deletions(-)

In general the patch seems fine and is actually a big improvement to the
hard coded link policy. In the long run I think it'd make sense for the
kernel to do this intialization, and I think I'll do that for mgmtops.
However for this hciops change I do have a few comments:

>  static void read_local_features_complete(int index,
>  				const read_local_features_rp *rp)
>  {
> +    uint16_t policy;
> +
>  	if (rp->status)
>  		return;
>  
> +	/* Set default link policy */
> +	if (!(rp->features[0] & LMP_RSWITCH))
> +		main_opts.link_policy &= ~HCI_LP_RSWITCH;
> +	if (!(rp->features[0] & LMP_HOLD))
> +		main_opts.link_policy &= ~HCI_LP_HOLD;
> +	if (!(rp->features[0] & LMP_SNIFF))
> +		main_opts.link_policy &= ~HCI_LP_SNIFF;
> +	if (!(rp->features[1] & LMP_PARK))
> +		main_opts.link_policy &= ~HCI_LP_PARK;
> +
> +	policy = htobs(main_opts.link_policy);
> +	hci_send_cmd(SK(index), OGF_LINK_POLICY,
> +				OCF_WRITE_DEFAULT_LINK_POLICY, 2, &policy);
> +
>  	memcpy(FEATURES(index), rp->features, 8);

read_local_features is the first command that the kernel sends (after
HCI_Reset) when bringing up a device. Therefore, I think it's a bit
early for userspace to send its own commands at this point. So I'd do
this in through the start_adapter function instead.

> @@ -2046,15 +2056,6 @@ static void init_device(int index)
>  	if (hci_devinfo(index, &di) < 0)
>  		goto fail;
>  
> -	if (!ignore_device(&di)) {
> -		dr.dev_opt = main_opts.link_policy;
> -		if (ioctl(dd, HCISETLINKPOL, (unsigned long) &dr) < 0 &&
> -							errno != ENETDOWN) {
> -			error("Can't set link policy on hci%d: %s (%d)",
> -						index, strerror(errno), errno);
> -		}
> -	}
> -
>  	/* Start HCI device */
>  	if (ioctl(dd, HCIDEVUP, index) < 0 && errno != EALREADY) {
>  		error("Can't init device hci%d: %s (%d)",

It looks like the hci_devinfo call above isn't needed anymore after you
remove the ignore_device call. So please remove that too (as well as the
di variable from the function).

Johan
