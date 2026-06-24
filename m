Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3B392D23A6
	for <linux-bluetooth@vger.kernel.org>; Wed, 24 Jun 2026 10:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782298587; cv=none; b=XwMQh9d+U8OXT6vaQVnPLSNL+R9RMT5N50zvXAM2aXQhYFqIHZtlu8GtqlcB8mFznG/kSuUx1nS2p6Iqg0/EEovNzopoCqZgZJti8kdk59hFrs3ONXooqpp6b8ozO/3y8QTzOWwb9R0S+SDLUdudcrn8l/ZN7k7EPkU2/wTcbVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782298587; c=relaxed/simple;
	bh=OAskSojY9S9GzYSrZYLXDAReXtrR+BnRjCU+yWxpozY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tMLrNaMl4Nm+7XcJOY7RxXi3ZRJfEpjIId2GW/MX1IQzWCYxsM/fgPTrHm1ip+7SHK72zidtXojFtviPY/Yj6zw90aJ1poV38IDyHfdWrBhSyQGiFkelIetsCuqbDiJ5RiuhxWK1X/96Hos1zEZozi7htradkuS9dA+Vz+gdxVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=o8ZOZqM8; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o8ZOZqM8"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-691c5776f95so1478522a12.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 24 Jun 2026 03:56:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782298585; x=1782903385; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wVpUsPMcOUp7aStO4/HxyiJ7/oBFz2LYmxiU2GOTN6E=;
        b=o8ZOZqM8yDNUIzsT1xgrKYsFpdCEV3AEUZWzxfMBIYg7cQun8KkVFzFLza5IVsXUo4
         a1/6ArEMuiDf+rCm5yKbQ/kXWx6ZlNDd9ajtEItwOs4nj6whYfnPj1EVRzwbbL8b8CoC
         YsEI3JDhqPyFPImO8QU1TqEahjU5bu8QB1Cfg069iiU9TbbBkQLzHt78n8Qxp96YFN0F
         ZNyD8uNRuVERP73BKnCCUpuPf4DIEnyh2pcTDX7agTbx72B/fR9qy6Uy3AfbdWLPeXTE
         X5LwOFKPCXM5VYEKkrFY1sEGNNgYV1LQ66KHR+ncLzlPzYkboKa3dsz+WabLEZeDTj9C
         lmsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782298585; x=1782903385;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wVpUsPMcOUp7aStO4/HxyiJ7/oBFz2LYmxiU2GOTN6E=;
        b=LUQSsmbsCFT6a5kl8GkOkm1xr5WiBtilZ2Hcqj5zn/kRL63JZ061oe4Fq/spzWtVIp
         W25SY9Sf8z5vceVCW9tX2MOHs+6n08E6Pxfe9uDpuH/qnxuB50uTUtGq7j2i3REyuWU4
         5sQ1xCOeR6o+4/Dn2tvjwQnN8yP+7lMSaw2T2cL6qMNbj8o25c914WcVB72b7wYBAV+L
         dk78wd+r3zbuW29KBnqmemM6KlIw+suQOm8dOKRjj9WWO/Bznqvo5EJYrAmhIjlmUehj
         v4l6hAu5eR3lFEbPd1AppWUNFm3h/lTOalKbzCPBEfwnASnPmUX8AcK8LdEj/mJSzG+/
         DBpw==
X-Forwarded-Encrypted: i=1; AHgh+Rrdv+zbWRYjlkgcrvhkNO24dmGGii80P3oTH4HXnQLMDWIV0DVnL2zXB5vPRNShxAqyJRIpospyqp31RAupq8k=@vger.kernel.org
X-Gm-Message-State: AOJu0YyujIR6a6/bmkPuxaZeilvvw+kxH2nMukXQO/jLk8UQfJXGvdVE
	21f9dB2Q3E6im73IJp7VV7t+LLeFXD4lvsPxZb7M3YNc5z8jP3VBiDNB
X-Gm-Gg: AfdE7ck6EyyqkDwlpURuEKbLXdgMqz66snAI0aZaHPkJUJSyNQXvdJ7k5Dy8E6qfoiC
	dtLlRhFLLU+YFQ2mEocsgTvvrUve/VN9vEjoAmOHoq4sEW+cc5caVmhMxirdktLfc83fbJvdnwN
	RMGyOoFlH9edAz8iAR9z5ztMqT1mkH1mTy+cAEwvXyZP/0bvTRWELuzyqrARTVZ4q3XBFKtkwMp
	ZMoVvvKD5A4/nkZBUnRWXSyvtUoHUFJUaxtDJy12WB8tQmo0d2AJ1DIFzHgVUonsWcZgKJkACzj
	KGM1XjiZLvyUMWdic9yYZ9EQH+nCr72b1Vv8E0Bs8qKr7k7j9Nk3Qy0SvmoP1YekgW/ILrGX4Zu
	e0nc6Q7CNRuq58UtsHMtUHmEsbePIyk/6G23DdcNoazzL3JYpBkL+cLwTjjFfjdkaajIctCJPIJ
	NbrgeNSf9Z
X-Received: by 2002:a05:6402:3218:b0:697:b10a:35ce with SMTP id 4fb4d7f45d1cf-697dba620e2mr3554762a12.1.1782298584851;
        Wed, 24 Jun 2026 03:56:24 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-697f3ac5df0sm1005336a12.1.2026.06.24.03.56.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2026 03:56:24 -0700 (PDT)
Date: Wed, 24 Jun 2026 13:56:20 +0300
From: Dan Carpenter <error27@gmail.com>
To: Haoxiang Li <haoxiang_li2024@163.com>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com, yangyingliang@huawei.com,
	mst@redhat.com, linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: virtio_bt: unregister HCI device on open
 failure
Message-ID: <aju31PkIMuvyIcCR@stanley.mountain>
References: <20260624084333.2885144-1-haoxiang_li2024@163.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260624084333.2885144-1-haoxiang_li2024@163.com>

On Wed, Jun 24, 2026 at 04:43:33PM +0800, Haoxiang Li wrote:
> virtbt_probe() registers the HCI device before calling
> virtbt_open_vdev(). If opening the virtio Bluetooth
> device fails, the error path frees the HCI device without
> unregistering it.
> 
> Fixes: dc65b4b0f90a ("Bluetooth: virtio_bt: fix device removal")
> Cc: stable@vger.kernel.org
> Signed-off-by: Haoxiang Li <haoxiang_li2024@163.com>
> ---
>  drivers/bluetooth/virtio_bt.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/bluetooth/virtio_bt.c b/drivers/bluetooth/virtio_bt.c
> index 140ab55c9fc5..bf6827431bb8 100644
> --- a/drivers/bluetooth/virtio_bt.c
> +++ b/drivers/bluetooth/virtio_bt.c
> @@ -397,6 +397,7 @@ static int virtbt_probe(struct virtio_device *vdev)
>  	return 0;
>  
>  open_failed:
> +	hci_unregister_dev(hdev);
>  	hci_free_dev(hdev);
>  failed:
>  	vdev->config->del_vqs(vdev);

I have written a blog about how to write error handling.
https://staticthinking.wordpress.com/2022/04/28/free-the-last-thing-style/

Originally this code using One Err style error handling where every
error path just did "goto fail".  It's also using ComeFrom label names
which don't say what the goto does only where the goto is...  Ideally if
hci_register_dev() failed it would use the unwind ladder to clean up it
instead calls hci_free_dev() and then goto fail.

The beauty of writing a normal kernel style unwind ladder is that it
writes the cleanup function automatically...  Let's look at the cleanup
function here.

   406  static void virtbt_remove(struct virtio_device *vdev)
   407  {
   408          struct virtio_bluetooth *vbt = vdev->priv;
   409          struct hci_dev *hdev = vbt->hdev;
   410  
   411          hci_unregister_dev(hdev);
   412          virtio_reset_device(vdev);
   413          virtbt_close_vdev(vbt);

I'm really uncomfortable with having the hci_unregister_dev()
before the close.  Potential use after free?

   414  
   415          hci_free_dev(hdev);
   416          vbt->hdev = NULL;
   417  
   418          vdev->config->del_vqs(vdev);
   419          kfree(vbt);

The probe function should free "vbt" but it doesn't so that's
another leak.

   420  }

So this fix is fine but it's also only a partial fix.

regards,
dan carpenter


