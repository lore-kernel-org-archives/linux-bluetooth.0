Return-Path: <cyrus@holtmann.org>
Date: Fri, 25 Mar 2011 10:33:50 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Szymon Janc <szymon.janc@tieto.com>
Cc: linux-bluetooth@vger.kernel.org,
	par-gunnar.p.hjalmdahl@stericsson.com,
	henrik.possung@stericsson.com
Subject: Re: [PATCH v6 3/6] Add support for Out of Band (OOB) association
 model in hciops
Message-ID: <20110325083350.GC30796@jh-x301>
References: <1300974459-24076-1-git-send-email-szymon.janc@tieto.com>
 <1300974459-24076-4-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1300974459-24076-4-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

On Thu, Mar 24, 2011, Szymon Janc wrote:
> +static void remote_oob_data_request(int index, bdaddr_t *bdaddr)
>  {
>  	struct dev_info *dev = &devs[index];
> +	GSList *match;
>  
>  	DBG("hci%d", index);
>  
> -	hci_send_cmd(dev->sk, OGF_LINK_CTL,
> -				OCF_REMOTE_OOB_DATA_NEG_REPLY, 6, ptr);
> +	match = g_slist_find_custom(dev->oob_data, bdaddr, oob_bdaddr_cmp);
> +
> +	if (match) {
> +		struct oob_data *data;
> +		remote_oob_data_reply_cp cp;
> +
> +		data = match->data;
> +
> +		bacpy(&cp.bdaddr, &data->bdaddr);
> +		memcpy(cp.hash, data->hash, sizeof(cp.hash));
> +		memcpy(cp.randomizer, data->randomizer, sizeof(cp.randomizer));
> +
> +		dev->oob_data = g_slist_delete_link(dev->oob_data, match);
> +
> +		hci_send_cmd(dev->sk, OGF_LINK_CTL, OCF_REMOTE_OOB_DATA_REPLY,
> +				REMOTE_OOB_DATA_REPLY_CP_SIZE, &cp);
> +
> +	} else {
> +		hci_send_cmd(dev->sk, OGF_LINK_CTL,
> +				OCF_REMOTE_OOB_DATA_NEG_REPLY, 6, bdaddr);
> +	}
> +
>  }

Unnecessary empty line at the end of the function.

> +		data = g_new(struct oob_data, 1);
> +		bacpy(&data->bdaddr, bdaddr);
> +		dev->oob_data = g_slist_prepend(dev->oob_data, data);

Probably g_new0 would be better here (doesn't oob_data have more members
than just the bdaddr?

Johan
