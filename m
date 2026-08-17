Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56BE6451986
	for <linux-bluetooth@vger.kernel.org>; Mon, 17 Aug 2026 17:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786987961; cv=pass; b=LEd/xS+rOeWMsEymZ6NQHK4A/LS938uxT5Hrsc7xlILgGNcLG0d7bWgbCyZhB79QaZkPk1WNjmss5ND58PtHsWAu1lEDicQpffzP30Khw8eDWCNu6vtZZ4t+gUnm+MY9smihdKbYX7lDjGznbH35gyLMjWXZH0RsuEIrtqEL+UA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786987961; c=relaxed/simple;
	bh=UGXt1v8lzYIy5RWZxaevNP38Y360efpQ8u/2dkmbf6I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b37oOCppIIZvn+VDmGVsWDdpIbg+OQ55m/e2jEF3mqFaoNwKu+W9k4rKLFsoEkZSitpzfUhiON0Evtog97Z7m+qj+7YygIkLtiDRfh0cP7n2OCaY/+7z8giYHrBRbSYWxtDCZ1i7xSjVA8EnQQRIfXLjOxrIvw2VnCVU9qJ5blc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UDNetXjZ; arc=pass smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UDNetXjZ"
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-836c718715fso43419747b3.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 17 Aug 2026 10:32:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786987959; cv=none;
        d=google.com; s=arc-20260327;
        b=CyKLWsOTnfmXHiw+93C6HaIPKbme2ah2ytNpOQrEhRMMEluCgNGJOMHESkYp+gPC4p
         /60sbW0QT5ElxykFJ1fo84uKMCCk2YqE50DMX5xKI5H3AoMgpe2TEqKNeC+xF4MqIbvo
         mD86jGacmRHK4JhkSkpWFd+ygOwG7OZhmeaoP9sz8qnWmYjP/TNVz9Bk4Mp9TUPZPWpL
         KzgfM3G9vyr1eWHUuElixtozAU9xWkRq/iNSAM7H0V1fmdcLz375NvwISZtkbSWTa2q/
         GNm69zjzfu6J8SOzPgJRIn8kbTYYb8fskEFcAAiRyINVNyX14o7H7xY86ICQVRDAKHeq
         oktg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=O6NtOPuz7YXxI3CgzCU8k5jQwLkc89zpCvRdKJof0hU=;
        fh=gypoUBZHTEZNASL+Gkd60Clgblo19E4jctzSq7t8qvE=;
        b=X81xrpq5XXx9CIFm0E2FQ2CU3J3nWoJpnP0ZfnHkrQk/o0NVlW0QGjWdMDhNU4lWm+
         YrRxliTvPyEvJIivf6nq1w6JaTBSIBw6ByCiQQ/ZLnAhxG9uy8s5UVfYt34amsTcatBI
         XWJbSelFyZ2aLmHAHg1SrP0NtTG6asWjQ1uIp8cSbo2k6qtxUuiDZP3u7AqLiwQySC2T
         X3YpxGY7Uy0B/HVc6bXPPoQZjuuhgEF7eoRwUBaWfV+L+LVhuE9RzLJfjdx4Uo6qbYX1
         dkFT6KOaSd4xxZQyl2kmVXkpVxeA55YHMdT7kUcBDCse2W5L56Tat1Kvt53IEKouTDbP
         gSSg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786987959; x=1787592759; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=O6NtOPuz7YXxI3CgzCU8k5jQwLkc89zpCvRdKJof0hU=;
        b=UDNetXjZb9Fd/vySSD8ViJ2neIQqVKsB0pf7udmiLFhfESQ8vaAn+OuWHOP+IVRtQN
         UEP2o5SvzoEkDFltBdDld8XRG3tvlRX38aodDR7KMWkFdZEUP5wQ6SVmCb8pSZZxf9ua
         NxqfpQ9xaLPzu0XV0aoZkGPoXw1Xdc3OGHbORHGcz4ZiXNY6U5yth5lGQ7PHJrzWupkO
         IElADA7BQf4kAU+lKSFCteeFgc9U4VukE1YmYlTv9PJj7rhvYGJxof04VEsEn4MvDCqg
         RfSIB03xHYBYlKavz30g0ljW9Awy/4SWpfbVBrGqC/GjRGOSh4pnFtyNOgKm8KB8X30/
         bC0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786987959; x=1787592759;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=O6NtOPuz7YXxI3CgzCU8k5jQwLkc89zpCvRdKJof0hU=;
        b=Z8Glf7dWykOyhSNxURJSwzA5g14fqTJVw+Wius+YCy2zAx2rCAKZ+l4pj8THN+p36X
         aUaV39sH8hBsQlVbIdszOA1haQXV+cmK7MHjitrWlFfmShGKXGnSDT/zszxcqHLfBHOi
         YkTZOIXebUU1D8R7z4e4wcCdkm+TV85KBDWRMyAXhpWe12bEz6s9wOYyxkt8A9KMQy7O
         mfI1KC4tuCh+6o0MPFNtU+RHdW3Iuv6ThEPVuKyOyv5zHtFs0dYAsHdVWuULqSGWRBET
         UEf28If2dUVpMkDyQNBT0vSSa3GLG6hQvypaDHsR7xXyihqUvbY5Q4TtokByFjgrp4HY
         Drdg==
X-Forwarded-Encrypted: i=1; AHgh+RpjhRdYbB0B5KOqlG/vn6QGJAJdWr/pZfgH6Xbgm2us1IiTasnbjmXDZG9Mu4jvFtVC0r8GCI6zFmCQESpzaFw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzacsdk+v/qC3Zi8fLPYI3KiJnyNEYn3m+ww5pAavmeCCYH5S+1
	qGlYCNZmcQXCxAQC3K7XB39BPV3tmq9YOzFPikHXmxD/rmQya4kCurPbgQ6A1uUums7AYlWeK9X
	Tae1hGJ3W9n9RbaMG9lE5xngh0WCjI0w=
X-Gm-Gg: AR+sD10BEA8eBE4uDrWIZZjk7xPl5hLxQNAhHxMKrI1yvn7ZCANAwNxqENR8J13ZvJD
	XIg4PQbUkv/WKRqH7gDhTdikBYQnHj+aXqbMXeaafwIjoh7BNUt26iwuHY5l6cvbur8IStauabU
	shOHxYknXP52OrGSyfNutgRtSehagFeA+yx91cB2KvWH0z3OQYbwFQvQMKKlFqDLyx/9yxMxZFK
	aCfSL60pw5L+lQtxMAz0AO0mK4tLjLAUaLa2eKkrpsFs5lRWVUeY/IKQ1aOYVLQA+nvYWlxeC02
	fYHy1a66Llms2s7YxwW3i1q9/lvcBwx1Z3eHWrTUVCVIIUAisAxmAS9OdAseJ59oNw8+oyiImZh
	7yUsL06pOO+4fM23tcvhO+mL/Lj3I5eA=
X-Received: by 2002:a53:ee50:0:b0:667:8f12:c48 with SMTP id
 956f58d0204a3-66c72cc4ba1mr6644503d50.26.1786987959233; Mon, 17 Aug 2026
 10:32:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260814231248.3096377-1-tristmd@gmail.com>
In-Reply-To: <20260814231248.3096377-1-tristmd@gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 17 Aug 2026 13:32:27 -0400
X-Gm-Features: AcwNN1X0vZKR87eRnLXX9W9oXASCIrnh3TRfwnQscaGmWvciEcy9UpEb8C34WZc
Message-ID: <CABBYNZ+7UbQcO40RGEQNtfptWTf_BhnSmwounR-dOFZpmU=E7g@mail.gmail.com>
Subject: Re: [PATCH bluetooth] Bluetooth: cancel devcoredump work during
 device teardown
To: Tristan Madani <tristmd@gmail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, 
	Abhishek Pandit-Subedi <abhishekpandit@chromium.org>, Manish Mandlik <mmandlik@google.com>, 
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, Tristan Madani <tristan@talencesecurity.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Tristan,

On Fri, Aug 14, 2026 at 7:12=E2=80=AFPM Tristan Madani <tristmd@gmail.com> =
wrote:
>
> From: Tristan Madani <tristan@talencesecurity.com>
>
> hci_devcd_setup() initializes dump_timeout and dump_rx work items
> during device allocation, but hci_unregister_dev() does not cancel
> them before the device is freed. If a devcoredump is in progress
> when the device is unregistered, the dump_timeout delayed work timer
> remains active. When it fires after hci_release_dev() frees the
> hci_dev struct, it accesses freed memory.
>
> Add hci_devcd_destroy() to disable dump work items and purge the
> dump queue, called from hci_unregister_dev() alongside the existing
> disable_work_sync() calls.
>
> Fixes: 9695ef876fd1 ("Bluetooth: Add support for hci devcoredump")
> Cc: stable@vger.kernel.org
> Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
> ---
>  include/net/bluetooth/hci_core.h | 9 +++++++++
>  net/bluetooth/hci_core.c         | 2 ++
>  2 files changed, 11 insertions(+)
>
> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci=
_core.h
> index 3df59849dcbea..5a60c3f94a462 100644
> --- a/include/net/bluetooth/hci_core.h
> +++ b/include/net/bluetooth/hci_core.h
> @@ -1800,6 +1800,15 @@ static inline void hci_devcd_setup(struct hci_dev =
*hdev)
>  #endif
>  }
>
> +static inline void hci_devcd_destroy(struct hci_dev *hdev)
> +{
> +#ifdef CONFIG_DEV_COREDUMP
> +       disable_delayed_work_sync(&hdev->dump.dump_timeout);
> +       disable_work_sync(&hdev->dump.dump_rx);
> +       skb_queue_purge(&hdev->dump.dump_q);
> +#endif
> +}
> +
>  int hci_dev_open(__u16 dev);
>  int hci_dev_close(__u16 dev);
>  int hci_dev_do_close(struct hci_dev *hdev);
> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> index 5ba9fe8261ec8..d4d559dabf422 100644
> --- a/net/bluetooth/hci_core.c
> +++ b/net/bluetooth/hci_core.c
> @@ -2671,6 +2671,8 @@ void hci_unregister_dev(struct hci_dev *hdev)
>         disable_delayed_work_sync(&hdev->cmd_timer);
>         disable_delayed_work_sync(&hdev->ncmd_timer);
>
> +       hci_devcd_destroy(hdev);
> +
>         hci_cmd_sync_clear(hdev);
>
>         hci_unregister_suspend_notifier(hdev);
> --
> 2.47.3

Sashiko found 2 issues, both seem valid to me:

https://sashiko.dev/#/patchset/20260814182849.940976-1-ali%40iusegentoo.com

--=20
Luiz Augusto von Dentz
