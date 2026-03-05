Received: from mail-yx1-f54.google.com (mail-yx1-f54.google.com [74.125.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88FC14F881
	for <linux-bluetooth@vger.kernel.org>; Thu,  5 Mar 2026 14:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772720458; cv=pass; b=Zmu23MOxZaqR1mNElW+pVwbTe/oboe4zsWvfR/nRRvjfbxxwyQQcUBCa2VFFJ1fvvW0wqK7hFzbJMy2t+ZDpzvjlh43l7jLlzsUzvvdjlIyf55gj54qzuLQ66QYHoNOAaa0WQCAPmwSeUs0gOC+1kp/dGrn5+ZzVXjsXdPkxmTs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772720458; c=relaxed/simple;
	bh=G9gcLwldVY49uS2WAbw9ePxjwQ+FkgYjOpB6bN6+nyw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PUfiIrM70WH+5SabC2rSMjFC8Wtl2T6uuCqiDIjwpPOC3nDo/A6iXhWw+bMpsPmRhWetLv8OxBWefFvHKH4u4sA1nyGxa4FenBnAWaKLcagLq1RHeC07xb6k5f81pCtGTzXB5PpVxCeBOqDKD/CKbeWgg9lDZ5219jVKPngk6h0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=adxHcwvO; arc=pass smtp.client-ip=74.125.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="adxHcwvO"
Received: by mail-yx1-f54.google.com with SMTP id 956f58d0204a3-64aea64bf15so7246733d50.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 05 Mar 2026 06:20:57 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772720456; cv=none;
        d=google.com; s=arc-20240605;
        b=bc43Bz8c8pFD9bn6f4FS+ZRstlLT7POga1ygoEBATzx6Oswwa294R0Vr00zjeBg0+n
         Upj7FlFgoN+Xwh/F1s5DRLSt3HiZzOUkkycXS8pMDhUhTsQlqRJUtgY124YNln8+LPoD
         jXDri/aqkB1bKyqUl+CLCglaDI4tOhXxCiAtONZPPjqwMXlBdYp849uPTfC21BAtpLtA
         Kk3uoCb2t17AiuWbgHc7Ujrz/Ce7aAi+8dH69sTwasBrK8Fhf5nhkOc12oV4uknI4kz1
         Tv1tzuwfrOQ6xUbzBKmyqOPIghiraI2WnJZjqiFCiytEUEd+9DmI6Zu9HBwFtzvYnmt4
         SCtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=xJvvJE9iEOyuDZ26u2reY+n0T3Uh5jqqjeP/ruR9aOU=;
        fh=mbf4iLNRRysej+EN6WcejmTQTGAZbYg9KjLWVR4Ag84=;
        b=hLBo+rojae3tiL9+p+oAg0la7qvonNNhTzYjiWwj4toyV3Ld2K/UPya29ja0mquBLB
         Bz4wea7pY7Nn1rBL0zRQ8FtrCLzJlOgkFWogaaPDOBgbSlEV0ZYJoRZVZzVAzbWkWgPO
         eqHf7XJJnxNEdFPR5QJGw3Ark7BHXBGi3vsq56Bz3YAjXVJ9+DKiKvw/V+drWBWauHBM
         VLoPQzz7qXxeAzJz/g6pG16HS5SCFwNXlxpz6Mn2UF/hkeBbNLeF2pN0C/kpO91Jvs8v
         iadpndbNB43vNl5ibVrnEwu9XOQcfxYT50GYeQV0jW/8CHlgE99y1nN25h9dha9vuTtp
         Zm0Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772720456; x=1773325256; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xJvvJE9iEOyuDZ26u2reY+n0T3Uh5jqqjeP/ruR9aOU=;
        b=adxHcwvOXxM5jKuwgK88KNSCbNqFHXX3y9cwV4hHIgyJsLJ4WWSUStDVjSVcFfypBR
         sHaAe0kQG+1rb8HIB5+VAwa5Dix+Q4AUg/hA2BWVxGqTatD+SI9qkJPVU8eyoiyaly6L
         inq6aDJafH9MSFlLsGOCUaaPUmJrkaxVLkoGOfldEyY5ycNEuGmnkP5dz1ZJmt+vYp/t
         /9O1giT4aR3oL5xi5q3eP6lxCnwBaf+xTg1Acs9Mmng96ZuYLJxXmY+thj7e/6BTytKe
         0qwwZGNzjdHMOeLNCTxBOJHK1ONRcb0awy9AP6JVe9Ly6BcqzGGaxGr4ifjiTTNNPbve
         y8Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772720456; x=1773325256;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xJvvJE9iEOyuDZ26u2reY+n0T3Uh5jqqjeP/ruR9aOU=;
        b=SM0zcEHex0pc6U39JVZBt81Tk1wg+Cq3U4lBRT+dDUGOFy8JXmUfINO7TU0LJTvIXr
         3vDZheyYXZv0+pzSkE7f5PP0FmEWGlmpnetuaMA7F1OynEvXyZ7uTiiTNvmMlsAshxGN
         ObOPrlMaG8Nk92plrXRmqzmdgShG1eRxdIq9Y3yAT5TYvTsi8fehLZhxWREqPryqRIEj
         UAQLZQT1OT39i7FgAQrkXurm9eO0akoOVtLDY9seF1v+9xfE+N6bRODqbLhpeJOqMcA+
         T1h4Zc0bdjnegi+uzjLD/JGMbhOqUCMf9h0N4GOHXKIJP6eAJ5ndWM+GfkeZ346XpX5k
         ewrQ==
X-Forwarded-Encrypted: i=1; AJvYcCVM4eyRCWMDSbO66OeDUQPBG9QeNSkZ+29zKvD9c3TANjLUnHJdMt73EVrLIpBkgzcxoBnhqSdARWVC1B/LH6Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkT1K7uQukPAj4WRqVnUVM8Cg8SzaDPalVN+teZ+S112eizmS3
	StiaUcAIoTDl+OWLT8FnA5RmkkxprU4vQst6QbBtRZPfEcX/ftLvAKP25s8UQ641gkxyHL7kvUE
	aqQQLvljYffupBgLXBLhs8gPaUmNrr8c=
X-Gm-Gg: ATEYQzwulUlf5zVe/9uUJJppSfiKDcOEtfyVMy3E5Lvn6Xp8UFsKydfI9xkXHmFtw79
	8+AZHnBawnsiBUNT/+a52xIcrWYprRwwm2N+qHzkPC1BGNjh5zUoVwtaGrY/mQTnUXcwOyR2k5b
	ft0xbvErNueAaERC5jngrpeIOZkzUiCODCjsjj/7RdWVD2O658NC02jbBpJ2BZ0xc2tq3kZV048
	pZf9KnqKDISeyyhZs8HFKan+RwguAdUKjbNYdpEUDm44GObcwTmUupF0IWE19yYk8gUAtgU7rF9
	DU2nEpYBwMGOMzIVhz3VXtmG/DqAPyI6pA5yQMmyRysaJmwAiyQy7rDhPW2QAP5C+agrdA==
X-Received: by 2002:a05:690e:2042:b0:64b:1e85:36e3 with SMTP id
 956f58d0204a3-64cf9bd9040mr4245772d50.67.1772720456477; Thu, 05 Mar 2026
 06:20:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260305-bluetooth-fixes-v1-1-43effb810fba@pengutronix.de>
In-Reply-To: <20260305-bluetooth-fixes-v1-1-43effb810fba@pengutronix.de>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 5 Mar 2026 09:20:45 -0500
X-Gm-Features: AaiRm532buYEs_C0eiEIJRX7N_HG1AY3f9pL-zQbgE3IT0VtrnYR-XMTAAHbBKQ
Message-ID: <CABBYNZKsS5rKjK0LBo_zUmYi0nLLd5AZMaoQk+kZJ73TwsYMmQ@mail.gmail.com>
Subject: Re: [PATCH] net: bluetooth: hci_sync: fix hci_le_create_conn_sync
To: Michael Grzeschik <m.grzeschik@pengutronix.de>
Cc: Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg <johan.hedberg@gmail.com>, 
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kernel@pengutronix.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Michael,

On Thu, Mar 5, 2026 at 8:51=E2=80=AFAM Michael Grzeschik
<m.grzeschik@pengutronix.de> wrote:
>
> While introducing hci_le_create_conn_sync the functionality
> of hci_connect_le was ported to hci_le_create_conn_sync including
> the disable of the scan before starting the connection.
>
> When this code was run non synchronously the immediate call that was
> setting the flag HCI_LE_SCAN_INTERRUPTED had an impact. Since the
> completion handler for the LE_SCAN_DISABLE was not immediately called.
> In the completion handler of the LE_SCAN_DISABLE event, this flag is
> checked to set the state of the hdev to DISCOVERY_STOPPED.
>
> With the synchronised approach the later setting of the
> HCI_LE_SCAN_INTERRUPTED flag has not the same effect. The completion
> handler would immediately fire in the LE_SCAN_DISABLE call, check for
> the flag, which is then not yet set and do nothing.
>
> To fix this issue and make the function call work as before, we move the
> setting of the flag HCI_LE_SCAN_INTERRUPTED before disabling the scan.
>
> Fixes: Bluetooth: hci_sync: Add hci_le_create_conn_sync ('8e8b92ee60de534=
1e9db83c11f75a525e555e2b3')
> Signed-off-by: Michael Grzeschik <m.grzeschik@pengutronix.de>
> ---
>  net/bluetooth/hci_sync.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
> index 121dbc8208ec231210505135187e769028c17483..3166914b0d6ce3e56ced2f9a7=
914427296d38c48 100644
> --- a/net/bluetooth/hci_sync.c
> +++ b/net/bluetooth/hci_sync.c
> @@ -6627,8 +6627,8 @@ static int hci_le_create_conn_sync(struct hci_dev *=
hdev, void *data)
>          * state.
>          */
>         if (hci_dev_test_flag(hdev, HCI_LE_SCAN)) {
> -               hci_scan_disable_sync(hdev);
>                 hci_dev_set_flag(hdev, HCI_LE_SCAN_INTERRUPTED);
> +               hci_scan_disable_sync(hdev);
>         }

The change is probably correct but now I wonder if we should even keep
the HCI_LE_SCAN_INTERRUPTED because with the cmd sync we could
actually do wait for the scan to be disabled so we might as well do
hci_discovery_set_state(hdev, DISCOVERY_STOPPED) after
hci_scan_disable_sync completes, anyway I can make the change on top
of yours since I don't think we want to backport such a change since
it won't be a one liner like the above.

>         /* Update random address, but set require_privacy to false so
>
> ---
> base-commit: c107785c7e8dbabd1c18301a1c362544b5786282
> change-id: 20260305-bluetooth-fixes-b2c85a0aeb2a
>
> Best regards,
> --
> Michael Grzeschik <m.grzeschik@pengutronix.de>
>


--=20
Luiz Augusto von Dentz
