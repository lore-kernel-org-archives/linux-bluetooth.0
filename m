Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B27C9445;
	Thu, 23 May 2024 15:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716476915; cv=none; b=ldVmduZgWCmvExanhETo7WxJDvR5vGRCHXWdEEDnNOfRpgPd2Qt6CqNPxZH6bHZhDsSX/qA6VfR0hyUObaoF7nS0nUAi/EJNgNp7/1Td1NukSvdcp3IH0zrXHgSBov0ii1VeWPK5d5DVE1HBQ5gw55sqL8lpz3OiLV+/5uKU8oI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716476915; c=relaxed/simple;
	bh=IyIGy6VWgLqUXcFrF3VdTl+p4eBZcX4cd1pLlZhwBMs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iJXzXR481c1YIJT8/0tDnakbo1wef7GYeFF5HdHQSDD9fn7ojmt+uBPyjFN1Tn7N5l7u1Rdm3DZIeDpwOqkobBvetb4Fb6Pl0zt9hAPVJ4KvXmmILnEGmswpxjmOkL1cvGa0kgVJjaXFX7YxXo5LGJHxOY2xaZvi7fKpv38yYfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=kqPLEkRp; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="kqPLEkRp"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
	:Subject; bh=mHuv9GVH4hRpVlLMKaOsNb8TFghnSs0MzQgBlppEn1w=; b=kqPLEkRpn+tKOFQF
	1Wq7+EeCnSOeFPwy4a+K0GetzMeKVpn7MMu2+agkwzQXy2Gfa8CfGah8oyT2MX5yr/7CjFS2g9Hng
	f3sCDljaKlEq2hOr6TF8McsLrWbaU1MESh21cijziSWs1eGRIjBTDOb2fJVqE3vYhkFkHt2xfJFz4
	1xjRg1S1CyDNPMjCXFh8dCyu0/D8B8G4B/e4HNUGGZkeph2cn/byjBSojejDMIt1gIKCSoOzLQYp6
	j643RJOiuT5/mHzV9UdkkUSO1tO5ucUyd7YvMjLP6CCVnuIZtnFjyhBZ7KPvEHUiSrWSkmHRxBHzW
	6rMz7/j7qiz6tC3nmA==;
Received: from dg by mx.treblig.org with local (Exim 4.96)
	(envelope-from <dg@treblig.org>)
	id 1sAA3P-002FKt-28;
	Thu, 23 May 2024 15:08:27 +0000
Date: Thu, 23 May 2024 15:08:27 +0000
From: "Dr. David Alan Gilbert" <linux@treblig.org>
To: marcel@holtmann.org, luiz.dentz@gmail.com
Cc: linux-bluetooth@vger.kernel.org, sre@kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Bluetooth/nokia: Remove unused struct
 'hci_nokia_radio_hdr'
Message-ID: <Zk9b683tsQrDCjl0@gallifrey>
References: <20240509001138.204427-1-linux@treblig.org>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20240509001138.204427-1-linux@treblig.org>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.1.0-21-amd64 (x86_64)
X-Uptime: 15:07:45 up 15 days,  2:21,  1 user,  load average: 0.00, 0.00, 0.00
User-Agent: Mutt/2.2.12 (2023-09-09)

* linux@treblig.org (linux@treblig.org) wrote:
> From: "Dr. David Alan Gilbert" <linux@treblig.org>
> 
> 'hci_nokia_radio_hdr' looks like it was unused since it's
> initial commit.
> 
> Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>

Ping?
I see a message from the bot asking for a change to the header
which I think wants Bluetooth: nokia: ?
(But then a load of segfaults in the test scripts).

Anything else?

Dave

> ---
>  drivers/bluetooth/hci_nokia.c | 5 -----
>  1 file changed, 5 deletions(-)
> 
> diff --git a/drivers/bluetooth/hci_nokia.c b/drivers/bluetooth/hci_nokia.c
> index 97da0b2bfd17e..62633d9ba7c43 100644
> --- a/drivers/bluetooth/hci_nokia.c
> +++ b/drivers/bluetooth/hci_nokia.c
> @@ -116,11 +116,6 @@ struct hci_nokia_neg_evt {
>  #define SETUP_BAUD_RATE		921600
>  #define INIT_BAUD_RATE		120000
>  
> -struct hci_nokia_radio_hdr {
> -	u8	evt;
> -	u8	dlen;
> -} __packed;
> -
>  struct nokia_bt_dev {
>  	struct hci_uart hu;
>  	struct serdev_device *serdev;
> -- 
> 2.45.0
> 
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/
