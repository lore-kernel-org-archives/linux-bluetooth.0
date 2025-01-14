Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22DA022F19;
	Tue, 14 Jan 2025 12:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736856884; cv=none; b=F+Lb5MPM9R9jcEpNmG9PGt9+XYPc1FgRoGfUWMJaBHQuxAU/S26f501v5QnIwv/k2o/GLhnrMakN/sLV+3a2bSdX9wbBxie43oDqEi0c0StlHCs+0BevXOLi1+/LdZ4WBYGQqiWMp0LB6mp+Rn3aOEJ59rBEO2pud2jZyFamHxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736856884; c=relaxed/simple;
	bh=GJYxaUgpldAc2Rmq2YJs3EbNslvfibOIhyrN+JZtSG0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ptloqChQmbGYfbjCqyL9eRKpbZnNLaUOPWcu+HMgj+NKy+Kqor8UA1qxVYqTo1Vjrq4udJ4tbWmsFdhQ9pgYnAjSLCG+q/GN9odCL2wLmTM9E9DnhTWRmzPiWAyo8LpDVjUlQ8xdlMwhOsawdYBt3aBtW8AA4z6TdXAbaLQiVXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YqoKu3hT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YqoKu3hT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA0F7C4CEDD;
	Tue, 14 Jan 2025 12:14:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736856883;
	bh=GJYxaUgpldAc2Rmq2YJs3EbNslvfibOIhyrN+JZtSG0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YqoKu3hTIWjtKLE+UWklJ8olOIRqTrbKH9eR1DSJD9xGQMftpSwJJ5HZBXAEG0mP4
	 u/dW1ClE9qPda8uAt8pUCKkkJV0lmyXh22eMDH/AuwILb5Rl7hcA6AnrNt8z2LeoMZ
	 U0jCa8gYtO8/G/V2J7TUdfIik255T6yTDtlxK3tkffDAa/AfAEInHbZKnY0fHfBUF/
	 d3IKYeibhZ40lmVZNrNQ7Ze7eXd920oc4gKiS/jrV44jYvHhfKFFUrb1smNuf3SvcR
	 j+B0OEzgoE1+uv+NdKq/TfbqDLPBajkGiKATq/fpn4JBowoenJlAijU34oaEDgfStd
	 UmjXpbPxfCdLg==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1tXfoj-000000002nj-1lhy;
	Tue, 14 Jan 2025 13:14:46 +0100
Date: Tue, 14 Jan 2025 13:14:45 +0100
From: Johan Hovold <johan@kernel.org>
To: Andreas Kemnade <andreas@kemnade.info>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com, pmenzel@molgen.mpg.de,
	jirislaby@kernel.org, gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
	Adam Ford <aford173@gmail.com>, Tony Lindgren <tony@atomide.com>,
	tomi.valkeinen@ideasonboard.com,
	=?utf-8?B?UMOpdGVy?= Ujfalusi <peter.ujfalusi@gmail.com>,
	robh@kernel.org, hns@goldelico.com
Subject: Re: [PATCH v4 2/4] Bluetooth: ti-st: Add GNSS subdevice for TI
 Wilink chips
Message-ID: <Z4ZVNU0PdCDpMaNY@hovoldconsulting.com>
References: <20240606183032.684481-1-andreas@kemnade.info>
 <20240606183032.684481-3-andreas@kemnade.info>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240606183032.684481-3-andreas@kemnade.info>

On Thu, Jun 06, 2024 at 08:30:30PM +0200, Andreas Kemnade wrote:
> Some of these chips have GNSS support.

Please be more specific here.

> GNSS support is available through
> channel 9 whilst FM is through channel 8. Add a platform subdevice for
> GNSS so that a driver for that functionality can be build.

> To avoid having
> useless GNSS devices, do it only when the devicetree node name contains
> gnss.

That's seems like an unorthodox use of device tree. These devices are
primarily (WiFi and) Bluetooth controllers so should probably not have
gone about and updated the node names to 'bluetooth-gnss' as you did,
for example, here:

	https://lore.kernel.org/all/20231127200430.143231-1-andreas@kemnade.info/

and instead have used a boolean property for the optional subfunctions
like GNSS, FM radio and NFC (as Rob suggested in one of the earlier
attempts by others).
 
> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
> ---
>  drivers/bluetooth/hci_ll.c   | 81 ++++++++++++++++++++++++++++++++++++
>  include/linux/ti_wilink_st.h |  8 ++++
>  2 files changed, 89 insertions(+)
> 
> diff --git a/drivers/bluetooth/hci_ll.c b/drivers/bluetooth/hci_ll.c
> index 4a0b5c3160c2b..09e5a4dbd2f8c 100644
> --- a/drivers/bluetooth/hci_ll.c
> +++ b/drivers/bluetooth/hci_ll.c
> @@ -32,6 +32,7 @@
>  #include <linux/signal.h>
>  #include <linux/ioctl.h>
>  #include <linux/of.h>
> +#include <linux/platform_device.h>
>  #include <linux/serdev.h>
>  #include <linux/skbuff.h>
>  #include <linux/ti_wilink_st.h>
> @@ -68,6 +69,9 @@ struct ll_device {
>  	struct gpio_desc *enable_gpio;
>  	struct clk *ext_clk;
>  	bdaddr_t bdaddr;
> +
> +	void (*gnss_recv_func)(struct device *dev, struct sk_buff *skb);
> +	struct platform_device *gnssdev;
>  };
>  
>  struct ll_struct {
> @@ -78,6 +82,8 @@ struct ll_struct {
>  	struct sk_buff_head tx_wait_q;	/* HCILL wait queue	*/
>  };
>  
> +static int ll_gnss_register(struct ll_device *lldev);
> +static int ll_gnss_recv_frame(struct hci_dev *hdev, struct sk_buff *skb);
>  /*
>   * Builds and sends an HCILL command packet.
>   * These are very simple packets with only 1 cmd byte
> @@ -411,6 +417,13 @@ static int ll_recv_frame(struct hci_dev *hdev, struct sk_buff *skb)
>  	.lsize = 0, \
>  	.maxlen = 0
>  
> +#define LL_RECV_GNSS \
> +	.type = 9, \
> +	.hlen = 3, \
> +	.loff = 1, \
> +	.lsize = 2
> +
> +
>  static const struct h4_recv_pkt ll_recv_pkts[] = {
>  	{ H4_RECV_ACL,       .recv = hci_recv_frame },
>  	{ H4_RECV_SCO,       .recv = hci_recv_frame },
> @@ -419,6 +432,7 @@ static const struct h4_recv_pkt ll_recv_pkts[] = {
>  	{ LL_RECV_SLEEP_ACK, .recv = ll_recv_frame  },
>  	{ LL_RECV_WAKE_IND,  .recv = ll_recv_frame  },
>  	{ LL_RECV_WAKE_ACK,  .recv = ll_recv_frame  },
> +	{ LL_RECV_GNSS,      .recv = ll_gnss_recv_frame },
>  };
>  
>  /* Recv data */
> @@ -677,9 +691,69 @@ static int ll_setup(struct hci_uart *hu)
>  		}
>  	}
>  
> +	if (strstr(of_node_full_name(serdev->dev.of_node), "gnss"))
> +		ll_gnss_register(lldev);

So this should be based on a boolean property, not the node name.

> +
> +	return 0;
> +}
> +
> +struct hci_dev *st_get_hci(struct device *dev)
> +{
> +	struct ll_device *lldev = dev_get_drvdata(dev);
> +
> +	return lldev->hu.hdev;
> +}
> +EXPORT_SYMBOL(st_get_hci);

And this seems like a too raw abstraction.

Unless you can follow through with Marcel's idea of exposing these
vendor channels in Bluetooth core, I think you should use something more
driver specific here (i.e. an interface for sending data rather than
exposing the entire Bluetooth device).

> +void st_set_gnss_recv_func(struct device *dev,
> +			   void (*recv_frame)(struct device *, struct sk_buff *))
> +{
> +	struct ll_device *lldev = dev_get_drvdata(dev);
> +
> +	lldev->gnss_recv_func = recv_frame;
> +}
> +EXPORT_SYMBOL(st_set_gnss_recv_func);
> +
> +static int ll_gnss_recv_frame(struct hci_dev *hdev, struct sk_buff *skb)
> +{
> +	struct hci_uart *hu = hci_get_drvdata(hdev);
> +	struct ll_device *lldev = container_of(hu, struct ll_device, hu);
> +
> +	if (!lldev->gnssdev)
> +		return 0;
> +
> +	if (lldev->gnss_recv_func) {
> +		lldev->gnss_recv_func(&lldev->gnssdev->dev, skb);
> +		return 0;
> +	}
> +	kfree_skb(skb);
> +
>  	return 0;
>  }

Please also consider that these devices also support other subfunctions
and that any abstraction should allow for the driver to be extended with
support for things like FM radio (and NFC).

> +static int ll_gnss_register(struct ll_device *lldev)
> +{
> +	struct platform_device *pdev;
> +	int ret;
> +
> +	pdev = platform_device_alloc("ti-ai2-gnss", PLATFORM_DEVID_AUTO);
> +	if (!pdev)
> +		return -ENOMEM;

I believe believe you should be using the auxiliary device abstraction
for subfunctions.

> +
> +	pdev->dev.parent = &lldev->serdev->dev;
> +	lldev->gnssdev = pdev;
> +	ret = platform_device_add(pdev);
> +	if (ret)
> +		goto err;
> +
> +	return 0;
> +
> +err:
> +	lldev->gnssdev = NULL;
> +	platform_device_put(pdev);
> +	return ret;
> +}
> +
>  static const struct hci_uart_proto llp;
>  
>  static int hci_ti_probe(struct serdev_device *serdev)
> @@ -757,12 +831,19 @@ static int hci_ti_probe(struct serdev_device *serdev)
>  	}
>  
>  	return hci_uart_register_device(hu, &llp);
> +
> +
> +	return 0;

This change makes no sense.

>  }
>  
> +

Stray newline.

>  static void hci_ti_remove(struct serdev_device *serdev)
>  {
>  	struct ll_device *lldev = serdev_device_get_drvdata(serdev);
>  
> +	if (lldev->gnssdev)
> +		platform_device_unregister(lldev->gnssdev);
> +
>  	hci_uart_unregister_device(&lldev->hu);
>  }
>  
> diff --git a/include/linux/ti_wilink_st.h b/include/linux/ti_wilink_st.h
> index 10642d4844f0c..eccc2db004069 100644
> --- a/include/linux/ti_wilink_st.h
> +++ b/include/linux/ti_wilink_st.h
> @@ -381,6 +381,14 @@ unsigned long st_ll_getstate(struct st_data_s *);
>  unsigned long st_ll_sleep_state(struct st_data_s *, unsigned char);
>  void st_ll_wakeup(struct st_data_s *);
>  
> +/**

This is not kernel doc.

> + * various funcs used to interact between FM, GPS and BT
> + */
> +struct hci_dev *st_get_hci(struct device *dev);
> +void st_set_gnss_recv_func(struct device *dev,
> +			   void (*recv_frame)(struct device *, struct sk_buff *));
> +
> +
>  /*
>   * header information used by st_core.c for FM and GPS
>   * packet parsing, the bluetooth headers are already available

Johan
