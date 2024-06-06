Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06D706F06E;
	Thu,  6 Jun 2024 20:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717707234; cv=none; b=MANxux/dMtwCOV8eD3pQJ0JWkOu++2BaZW4dNX4AdGCuvpwIoBdBzUl7HyNpPxPukVa2Cb0MnQAR4HhGPq+ZherREoXzRhmGUQLmIajuoMyV0ClyTYp4tDSFeeLf5ji/qORPA+K4wSMfu0szlpxS+7YGwJzNnukcC6yvE1Qw6lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717707234; c=relaxed/simple;
	bh=xs/oD7HTgnoX74SDL1MTe+KSc283t/RE+0Yrs73x9ok=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bbwrGoV1/XZlJlkYLRIpBb8fWz6R9TezWgUHa4TP86f993nSk1C/aC1uxel7hHkstwcpKcJvRT1a8FlvtLslhPoI0L2SZ/9qGSqHSm70PIVN0CI7A29AAwe89uUt4dHQkLRPzjcTdOH+ptCbniw0c51EmNxXcbqcSbZqIDDOeyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a5UtJ1XW; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a5UtJ1XW"
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-52b92e73e2fso1617065e87.2;
        Thu, 06 Jun 2024 13:53:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717707231; x=1718312031; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MqoEdi+5Li7qCxgZnJ0d4rFJMsPiflzcBA1WO++S0A4=;
        b=a5UtJ1XWNyOocMn/NCpq2nNVx0Iu1Lki76zC/IH+YyzSpq2xrKNpEq+6iaq3GtfHJ3
         u/3XCK2r1MULv4uIMNv3Cqc0YsCOfOYSg3uV0aZGHFUfnMZbMa+TR0n/d1i4v+Pms5sg
         WEQ4EReEAY0B5FCHx5IuexQfx8TZ6jiqCXUtaOvZP9N3gbAffuzxV04Qz/n5c1tLHCC6
         vETizacRGPm2he0WUbUctAMk9en5c+ncF7iBTksyt5dMEbz8DaVY62BTIXKsn5mW/kYp
         EAeROx45H4v4JM9058Xv7Bw13KAfD68BLYQFTznzLWiwq0OeTudiwq0HT4aBghySIP7T
         FpZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717707231; x=1718312031;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MqoEdi+5Li7qCxgZnJ0d4rFJMsPiflzcBA1WO++S0A4=;
        b=ZYnYZ2UT0xTw7790GoXcCiTAohLMSJjAQ0O2gTUxSmPwRQIdJYPw1N8tt/GP39Mbyp
         W2oUPzThQqzW601z60QdDSaDKZJEunUPhtBZjZRrXkDIQLfB0YbfbyaI0je5xtvmgbsh
         YbToYAzGeQ3O4qEnKACOJHqt0UTF5fMsw5BwWCTRhpiL5xY/yQNVIKFP5Tev1dqqR3DS
         EuNhtfZae7EKPITGWCR9TLO2lkOpCbI3BCD29AOgCoQbBmS8QyNVJ/RYToTzsFAjHosk
         Wss2tYBfDiF/DjxGFsiZ9ujzSngNhk2Cjc4UbQULCngcjn/r6vYSqiguFqkoK2rZDSdT
         vr+g==
X-Forwarded-Encrypted: i=1; AJvYcCUk8pzxh/+qFnjGu6ArkYBY26AF/oSRGUDgkwG8kFTSqOK0uTkxUvmHAi52CYZTFcEBnrnSOVqQKhBuOwAeiLDb2ZT8FuVaPbU1VUxW3xCB/LbC3h20UOsIwK/LRx05/TFmfqqBJu1gomHG9aNN
X-Gm-Message-State: AOJu0YxSEse/SzfpPCFMX7tZWeQDfciblgpyXhqx9f1SwZCl+2nZAK/4
	0mZMFu23zdeWzbU4tCa4gx9jD+/LIvRG8gwmTJULz0iZspTAk1C+6ElQKeTI5wQmJsRLvX4I9MX
	ku1bhLeuezzZ0Ad9U6D1vq7cqdIc=
X-Google-Smtp-Source: AGHT+IGe+E8yRR+CT71Fsvaer0y2RqxtMLRAiJ6nUZRps3iY7/5o5Z2BUQ/38UuLanYuW7ZWdPOf501mR5Ez+VzmzyI=
X-Received: by 2002:a2e:8191:0:b0:2ea:83d1:47fe with SMTP id
 38308e7fff4ca-2eadce36253mr4325701fa.20.1717707230856; Thu, 06 Jun 2024
 13:53:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240606114321.30515-1-chris.lu@mediatek.com> <20240606114321.30515-3-chris.lu@mediatek.com>
In-Reply-To: <20240606114321.30515-3-chris.lu@mediatek.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 6 Jun 2024 16:53:38 -0400
Message-ID: <CABBYNZLRWpxfrYDk7JbozC-2mZk2r3BAOkCSEfhR48AH25RkZw@mail.gmail.com>
Subject: Re: [PATCH v4 2/4] Bluetooth: btusb: add callback function in btusb suspend/resume
To: Chris Lu <chris.lu@mediatek.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg <johan.hedberg@gmail.com>, 
	Sean Wang <sean.wang@mediatek.com>, Deren Wu <deren.Wu@mediatek.com>, 
	Aaron Hou <aaron.hou@mediatek.com>, Steve Lee <steve.lee@mediatek.com>, 
	linux-bluetooth <linux-bluetooth@vger.kernel.org>, 
	linux-kernel <linux-kernel@vger.kernel.org>, 
	linux-mediatek <linux-mediatek@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Chris,

On Thu, Jun 6, 2024 at 7:43=E2=80=AFAM Chris Lu <chris.lu@mediatek.com> wro=
te:
>
> Add new function: dev_suspend/dev_resume in btusb_data which are reserved
> for vendor specific usage during suspend/resume. dev_suspend will be
> added before stop traffic in btusb_suspend and dev_resume will be
> added after resubmit urb in btusb_resuem.
>
> Signed-off-by: Chris Lu <chris.lu@mediatek.com>
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> ---
>  drivers/bluetooth/btusb.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index 79aefdb3324d..83765c0c14b4 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -891,6 +891,9 @@ struct btusb_data {
>
>         int (*setup_on_usb)(struct hci_dev *hdev);
>
> +       int (*dev_suspend)(struct hci_dev *hdev);
> +       int (*dev_resume)(struct hci_dev *hdev);

I'd name these suspend, resume respectively.

>         int oob_wake_irq;   /* irq for out-of-band wake-on-bt */
>         unsigned cmd_timeout_cnt;
>
> @@ -4715,6 +4718,9 @@ static int btusb_suspend(struct usb_interface *intf=
, pm_message_t message)
>
>         cancel_work_sync(&data->work);
>
> +       if (data->dev_suspend)
> +               data->dev_suspend(data->hdev);
> +
>         btusb_stop_traffic(data);
>         usb_kill_anchored_urbs(&data->tx_anchor);
>
> @@ -4818,6 +4824,9 @@ static int btusb_resume(struct usb_interface *intf)
>                         btusb_submit_isoc_urb(hdev, GFP_NOIO);
>         }
>
> +       if (data->dev_resume)
> +               data->dev_resume(hdev);
> +
>         spin_lock_irq(&data->txlock);
>         play_deferred(data);
>         clear_bit(BTUSB_SUSPENDING, &data->flags);
> --
> 2.18.0
>


--=20
Luiz Augusto von Dentz
