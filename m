Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CC102627FF
	for <linux-bluetooth@vger.kernel.org>; Wed,  9 Apr 2025 13:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744206959; cv=none; b=oPGS3xI7B4nR7Ia6P3wqJBoQNkMxgtTIkNuNLX0D3z23+mFEAcDcKJQfO6Z+WbWmduYD7ZYivQdpnfGTZsIPXEgE2kMoHSuxmJ7O/KK2bM9KCiqSsIOL68Jy0f56w7/8uPy/fOOX6mXaxe+QRvMrYiVhqswOXV/A2bYzDC48cJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744206959; c=relaxed/simple;
	bh=hgFjCqXIyqlawCiSSe9rf8sQxCsQ8GWM2KzK08qINA0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=Bgs8RY9H8Biey1QJd4QQdv5nKs/jxupFwzbw+2qBGLYvNkii4iTqf6jce+2u/jQ3G9SUGBMcvEnap3PVtzskjTsl7YX73XSGJy/UdA1tClJeDD04sFSyRbvkuzX8dkjN1naaM3Nxz2OoWtCEqbZzhTd1WQKgKpZfK7pP1bCLIFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LbLhyX2B; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LbLhyX2B"
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-30bf8632052so57714641fa.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 09 Apr 2025 06:55:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744206954; x=1744811754; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j/jZEJgBWws4GqJ35ZcWzGZ3GSIiP7UULc3vuRwdlMw=;
        b=LbLhyX2B4D8oAZzCTdNh16lIKEtEihZG/vH5JK2MH8hRM5btiQjKPhtxFx+kiZPUxF
         Na7P4o+e/HvFG81lF/BL6QMd5oNDdhJCQvybRD6EynKW9PypnPstXr45+JSMK8qRLnXE
         a3e0MvJOizu86UIpen5wn30JlmT/3SjPKl7gtKKb9UM82Jjvs0+yvfDmQMXv4AsURMLn
         cICosdxUOeAKHNBAq3ltvvLBlh2y6IIH6oqlkAEROVS/51sgF1P/Wuj/MA0lkqMNYt5k
         MNBaNL80ciCmtJ7fCFWi9+tXvlO1WgznBWd6rcxeR5mbfrDWFaoYA+R6vMixff34ePv5
         CKAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744206954; x=1744811754;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j/jZEJgBWws4GqJ35ZcWzGZ3GSIiP7UULc3vuRwdlMw=;
        b=c6O7tmK3rB7bCM26KMmddohEeJ3ebTVlOR/iZsu0y7gEW0hVP1sASNGLvWFI4O5P3h
         ACbWXGs/2G0OROWcW3/RcxXTBJp1GgzYnYygVj2OmGzN+98+lys0+o2BUvcORje2SppH
         1ddZLHpIT8CiVfgY5FBtfheJylboRr/UbYYE5pHUz4SVimjGdFDmPhyaX8kDr80oDmFN
         juJ94RidZGccE0hcbu9pBrbyo6JO3JKz2ezSBBTKCofJ2OxrIaR189Ilr30pwI+U3lHf
         ud/ie44ZzDI0I9fT4KvGrF3RxOSe57PJeErHYvX5S4MsbCEUROhbtS/hzusz9Wfgo1Zd
         pjZQ==
X-Gm-Message-State: AOJu0Yzd9Vi45aVhxLYoyy8Ewt2O/svLsi1DJpMrrbadPRea9caEwvFf
	is//Yd7jgS9zKJ5GP0lpYH+KS6+IpFl4NrJshwm2BHMqg623kYITnuiaQtgnaZUru6xcLMvRRi5
	DrqygXoPqUiSPT/fGsMw4akF2Xg9oEw==
X-Gm-Gg: ASbGncvQslOhiqezDwfa5ykKqzCBd+8RPN9rz3uA4gWq/sY4S5SHqtco/O2nht5hBqC
	KiZT7RONVgCEfKie3Tl5fsPLDtXyhFAmTTMKpEJvwFvqbn/O988uUUafSCkmGzFu9uswXJsk2Cw
	GVlLMAMQcVdLgYRmr1jm/P
X-Google-Smtp-Source: AGHT+IGeVjFOmaJf2er79TmuYlUWUxjoWDMg5PASXIEqP46nHk/fkkTqi5gYWnoNFglmnCcglkEVqxcemNZdjqYLlqE=
X-Received: by 2002:a2e:9a09:0:b0:30c:1fc4:418e with SMTP id
 38308e7fff4ca-30f43881c3fmr10939641fa.26.1744206953996; Wed, 09 Apr 2025
 06:55:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250409135402.212535-1-luiz.dentz@gmail.com>
In-Reply-To: <20250409135402.212535-1-luiz.dentz@gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 9 Apr 2025 09:55:40 -0400
X-Gm-Features: ATxdqUHo9_WyQ38pV7DcduPNgebuve2PNtI6j7rHAJHTaMxkRwjiv_IroDceCRE
Message-ID: <CABBYNZKOUYLWxMx-dokfH0J7fAsi0Rp2LiKM7qB8E5OCuzY3Ug@mail.gmail.com>
Subject: Re: [PATCH v1] Bluetooth: hci_sync: Fix not clearing
 cmd_sync_work_list on power off
To: linux-bluetooth@vger.kernel.org, Shuai Zhang <quic_shuaz@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 9, 2025 at 9:54=E2=80=AFAM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>
> When powering off the cmd_sync_work_list may contain items which shall
> be cleared during power off as they shouldn't be run during power off
> sequence.
>
> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> ---
>  net/bluetooth/hci_sync.c | 20 +++++++++++++++-----
>  1 file changed, 15 insertions(+), 5 deletions(-)
>
> diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
> index 609b035e5c90..7a822ef71a74 100644
> --- a/net/bluetooth/hci_sync.c
> +++ b/net/bluetooth/hci_sync.c
> @@ -648,16 +648,22 @@ static void _hci_cmd_sync_cancel_entry(struct hci_d=
ev *hdev,
>         kfree(entry);
>  }
>
> -void hci_cmd_sync_clear(struct hci_dev *hdev)
> +/* Clear remaining entries in cmd_sync_work_list */
> +static void hci_cmd_sync_list_clear(struct hci_dev *hdev)
>  {
>         struct hci_cmd_sync_work_entry *entry, *tmp;
>
> +       list_for_each_entry_safe(entry, tmp, &hdev->cmd_sync_work_list, l=
ist)
> +               _hci_cmd_sync_cancel_entry(hdev, entry, -ECANCELED);
> +}
> +
> +void hci_cmd_sync_clear(struct hci_dev *hdev)
> +{
>         cancel_work_sync(&hdev->cmd_sync_work);
>         cancel_work_sync(&hdev->reenable_adv_work);
>
>         mutex_lock(&hdev->cmd_sync_work_lock);
> -       list_for_each_entry_safe(entry, tmp, &hdev->cmd_sync_work_list, l=
ist)
> -               _hci_cmd_sync_cancel_entry(hdev, entry, -ECANCELED);
> +       hci_cmd_sync_list_clear(hdev);
>         mutex_unlock(&hdev->cmd_sync_work_lock);
>  }
>
> @@ -678,6 +684,7 @@ EXPORT_SYMBOL(hci_cmd_sync_cancel);
>   *
>   * - Set result and mark status to HCI_REQ_CANCELED
>   * - Wakeup command sync thread
> + * - Clear cmd_sync_work_list if the interface is down
>   */
>  void hci_cmd_sync_cancel_sync(struct hci_dev *hdev, int err)
>  {
> @@ -692,6 +699,9 @@ void hci_cmd_sync_cancel_sync(struct hci_dev *hdev, i=
nt err)
>
>                 wake_up_interruptible(&hdev->req_wait_q);
>         }
> +
> +       if (err =3D=3D EHOSTDOWN || err =3D=3D -EHOSTDOWN)
> +               hci_cmd_sync_list_clear(hdev);
>  }
>  EXPORT_SYMBOL(hci_cmd_sync_cancel_sync);
>
> @@ -5159,14 +5169,14 @@ int hci_dev_close_sync(struct hci_dev *hdev)
>                 disable_delayed_work(&hdev->power_off);
>                 disable_delayed_work(&hdev->ncmd_timer);
>                 disable_delayed_work(&hdev->le_scan_disable);
> +               hci_cmd_sync_cancel_sync(hdev, ENODEV);
>         } else {
>                 cancel_delayed_work(&hdev->power_off);
>                 cancel_delayed_work(&hdev->ncmd_timer);
>                 cancel_delayed_work(&hdev->le_scan_disable);
> +               hci_cmd_sync_cancel_sync(hdev, EHOSTDOWN);
>         }
>
> -       hci_cmd_sync_cancel_sync(hdev, ENODEV);
> -
>         cancel_interleave_scan(hdev);
>
>         if (hdev->adv_instance_timeout) {
> --
> 2.49.0

Have a try with the above changes.

--=20
Luiz Augusto von Dentz
