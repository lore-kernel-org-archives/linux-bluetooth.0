Return-Path: <cyrus@holtmann.org>
Date: Thu, 5 May 2011 14:34:45 -0300
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: David Herrmann <dh.herrmann@googlemail.com>
Cc: linux-bluetooth@vger.kernel.org, johan.hedberg@gmail.com,
	hadess@hadess.net, dforsi@gmail.com
Subject: Re: [PATCH 1/4] Add length argument to hci pincode reply
Message-ID: <20110505173445.GA2098@joana>
References: <1302455477-27664-1-git-send-email-dh.herrmann@googlemail.com>
 <1302455477-27664-2-git-send-email-dh.herrmann@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1302455477-27664-2-git-send-email-dh.herrmann@googlemail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

* David Herrmann <dh.herrmann@googlemail.com> [2011-04-10 19:11:14 +0200]:

> This adds a new "length" argument to the hci pincode reply to allow
> sending binary pins including \0 characters.
> ---
>  plugins/hciops.c  |    9 ++++-----
>  plugins/mgmtops.c |   14 ++++++--------
>  src/adapter.c     |    2 +-
>  src/adapter.h     |    2 +-
>  4 files changed, 12 insertions(+), 15 deletions(-)
> 
> diff --git a/plugins/hciops.c b/plugins/hciops.c
> index 93f6f21..afac330 100644
> --- a/plugins/hciops.c
> +++ b/plugins/hciops.c
> @@ -3296,7 +3296,7 @@ static int hciops_remove_bonding(int index, bdaddr_t *bdaddr)
>  	return 0;
>  }
>  
> -static int hciops_pincode_reply(int index, bdaddr_t *bdaddr, const char *pin)
> +static int hciops_pincode_reply(int index, bdaddr_t *bdaddr, const char *pin, size_t pinlen)
>  {
>  	struct dev_info *dev = &devs[index];
>  	char addr[18];
> @@ -3307,14 +3307,13 @@ static int hciops_pincode_reply(int index, bdaddr_t *bdaddr, const char *pin)
>  
>  	if (pin) {
>  		pin_code_reply_cp pr;
> -		size_t len = strlen(pin);
>  
> -		dev->pin_length = len;
> +		dev->pin_length = pinlen;
>  
>  		memset(&pr, 0, sizeof(pr));
>  		bacpy(&pr.bdaddr, bdaddr);
> -		memcpy(pr.pin_code, pin, len);
> -		pr.pin_len = len;
> +		memcpy(pr.pin_code, pin, pinlen);
> +		pr.pin_len = pinlen;
>  		err = hci_send_cmd(dev->sk, OGF_LINK_CTL,
>  						OCF_PIN_CODE_REPLY,
>  						PIN_CODE_REPLY_CP_SIZE, &pr);
> diff --git a/plugins/mgmtops.c b/plugins/mgmtops.c
> index 042afc5..d03a29d 100644
> --- a/plugins/mgmtops.c
> +++ b/plugins/mgmtops.c
> @@ -493,7 +493,7 @@ static void mgmt_connect_failed(int sk, uint16_t index, void *buf, size_t len)
>  	btd_event_bonding_complete(&info->bdaddr, &ev->bdaddr, ev->status);
>  }
>  
> -static int mgmt_pincode_reply(int index, bdaddr_t *bdaddr, const char *pin)
> +static int mgmt_pincode_reply(int index, bdaddr_t *bdaddr, const char *pin, size_t pinlen)

This is over 80 characters. And call pinlen, pin_len instead to keep the same
name and have a small diff here.

>  {
>  	char buf[MGMT_HDR_SIZE + sizeof(struct mgmt_cp_pin_code_reply)];
>  	struct mgmt_hdr *hdr = (void *) buf;
> @@ -501,7 +501,7 @@ static int mgmt_pincode_reply(int index, bdaddr_t *bdaddr, const char *pin)
>  	char addr[18];
>  
>  	ba2str(bdaddr, addr);
> -	DBG("index %d addr %s pin %s", index, addr, pin ? pin : "<none>");
> +	DBG("index %d addr %s pinlen %lu", index, addr, pinlen);
>  
>  	memset(buf, 0, sizeof(buf));
>  
> @@ -518,10 +518,8 @@ static int mgmt_pincode_reply(int index, bdaddr_t *bdaddr, const char *pin)
>  		buf_len = sizeof(*hdr) + sizeof(*cp);
>  	} else {
>  		struct mgmt_cp_pin_code_reply *cp;
> -		size_t pin_len;
>  
> -		pin_len = strlen(pin);
> -		if (pin_len > 16)
> +		if (pinlen > 16)
>  			return -EINVAL;
>  
>  		hdr->opcode = htobs(MGMT_OP_PIN_CODE_REPLY);
> @@ -530,8 +528,8 @@ static int mgmt_pincode_reply(int index, bdaddr_t *bdaddr, const char *pin)
>  
>  		cp = (void *) &buf[sizeof(*hdr)];
>  		bacpy(&cp->bdaddr, bdaddr);
> -		cp->pin_len = pin_len;
> -		memcpy(cp->pin_code, pin, pin_len);
> +		cp->pin_len = pinlen;
> +		memcpy(cp->pin_code, pin, pinlen);
>  
>  		buf_len = sizeof(*hdr) + sizeof(*cp);
>  	}
> @@ -568,7 +566,7 @@ static void mgmt_pin_code_request(int sk, uint16_t index, void *buf, size_t len)
>  	err = btd_event_request_pin(&info->bdaddr, &ev->bdaddr);
>  	if (err < 0) {
>  		error("btd_event_request_pin: %s", strerror(-err));
> -		mgmt_pincode_reply(index, &ev->bdaddr, NULL);
> +		mgmt_pincode_reply(index, &ev->bdaddr, NULL, 0);
>  	}
>  }
>  
> diff --git a/src/adapter.c b/src/adapter.c
> index c400bfd..83f3217 100644
> --- a/src/adapter.c
> +++ b/src/adapter.c
> @@ -3703,7 +3703,7 @@ int btd_adapter_remove_bonding(struct btd_adapter *adapter, bdaddr_t *bdaddr)
>  int btd_adapter_pincode_reply(struct btd_adapter *adapter, bdaddr_t *bdaddr,
>  							const char *pin)
>  {
> -	return adapter_ops->pincode_reply(adapter->dev_id, bdaddr, pin);
> +	return adapter_ops->pincode_reply(adapter->dev_id, bdaddr, pin, pin ? strlen(pin) : 0);

Over 80 here as well.

>  }
>  
>  int btd_adapter_confirm_reply(struct btd_adapter *adapter, bdaddr_t *bdaddr,
> diff --git a/src/adapter.h b/src/adapter.h
> index 308af75..fd2fc12 100644
> --- a/src/adapter.h
> +++ b/src/adapter.h
> @@ -221,7 +221,7 @@ struct btd_adapter_ops {
>  	int (*read_local_features) (int index, uint8_t *features);
>  	int (*disconnect) (int index, bdaddr_t *bdaddr);
>  	int (*remove_bonding) (int index, bdaddr_t *bdaddr);
> -	int (*pincode_reply) (int index, bdaddr_t *bdaddr, const char *pin);
> +	int (*pincode_reply) (int index, bdaddr_t *bdaddr, const char *pin, size_t pinlen);

same here.

-- 
Gustavo F. Padovan
http://profusion.mobi
