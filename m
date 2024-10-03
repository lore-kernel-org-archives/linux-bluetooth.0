Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 002F61779A5;
	Thu,  3 Oct 2024 16:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727974470; cv=none; b=H7PAEBPLYQrCTcKAH42UNxovo3MyzqsVdvj5PAWX+PBk8K8WeBs+29etu3kjvRB3zVwkmDPkdZeAi41jYMi7gs5QkcrpHvvdnoQlEYfcPh1QLcN7f/ZN9XU0t0XZSaxS3M9Tm+vg4q9dFuTn6EQ6hkgE+2juX4HBEdkT4pmy21I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727974470; c=relaxed/simple;
	bh=U7j7UqnFkFY9xYsaBm2qcbgHB+fmA5UPnziejffWI8M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P8c51Gx3gS94bBkbN9zQEmkjQYGFdLvguqk8MSQYcBEVf+VPao6X4WH+sxbgF4hgyJB2kF2NNEckVWWSlXW9Qo2YOE+V5qTpanRdjwG0HVQ/sE0quRiRlr7RKfTMfaG3nvvrWbSBruXF+ZsQgv7dtqsMgigDCwND5sZ5WQ8JBVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fEe85A9s; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fEe85A9s"
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2fabfc06de3so14117971fa.1;
        Thu, 03 Oct 2024 09:54:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727974467; x=1728579267; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=feM/pb2TRQDjkTAc93/S9PAq+YwwxZL7OxPm8CgyVeA=;
        b=fEe85A9s0Ue9Y6FoX16IxWcq5G97OTiDMmw50QJQECtExvNgQqfYtkGgtB4EeOL2oG
         M0jFa64Rg+x75jbdo+MQIvErJpzCgopA/ztJleB9DW4C25s3Mt3+BFyXJ9WYgjSTmgJg
         SqEpUK+3Y4FBrz6wxDi8ehUA9vSts/mcmdEjEoQRQG6oBjnXsG0/bfM64+W7gJT6R8Yc
         i3rhrPDsPk9DHuRPeHjYkkMJYqnfTuVxYdjwCIUTk3Q4BCQrsUJtAHRsR1+StdHK7rGQ
         6T9ESE/VazUbR9XNgwaRRwIgrMPpmdQZfQ0FnRHyqaskUuZDfcPsTbYu1yh9bNFKwcDA
         hsAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727974467; x=1728579267;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=feM/pb2TRQDjkTAc93/S9PAq+YwwxZL7OxPm8CgyVeA=;
        b=KLgCw/SMYJa/NPqSxe+hvjfSK0fxMljvznG8LtljhmMV50ioRCRlglcbZmewqlFeaM
         6YaI3iykEQxkThNFDyEC6dE26gqTeYXyOvMLbhVsbRjtXvICq9RooaUg+gYmvI+JldAp
         oHptRvKr3Rhkw2xSNK1F28tsUItkixmlAnoWzqtef4nVaKbzuzcieQ/U4bXAFGcUZQ8x
         CCQRT+JDBnkqZ5MSRt7164hBGGCKfd9oPOS+kmNz/5Odwaca+0cUQ3iLWMM1OgXGqAMH
         Xx1T/Ow/q1E/FHs6T4unUUsTbz3nSVk0lUlAyvTv5NxUk/S7DOPrKaTV9F4vxYkE7eNG
         ff0w==
X-Forwarded-Encrypted: i=1; AJvYcCUD5xJV6KaSW2C14UFkNa2ma7Y2SCh79wpErhxDjsOCC3nTj6gM+RMT1TVy7X+bVVhbyUqJNJwf31RNHmQkh4M=@vger.kernel.org, AJvYcCXevdIT/KVsq3COJHX/kxfhorMml9W/NQlhNRDWJ2aNcEEiT4eDebsRDZuiDkruPHPHDQzhBxO4MitaQC/y@vger.kernel.org
X-Gm-Message-State: AOJu0Ywml2CS1g5aTM2Tvkvt3ghYtkVygLeEddjurtjzNUCcmGNwiwHt
	DM0CQ88vdCcKfg9di0R3V2ifso9j6TxTTtqgyTkS+DkLo2NPkHIudvM3h+ggvi1ZdyxRtC8cW0D
	rJlxSPm5Y89whMolc885mERrpWtsDn9sD
X-Google-Smtp-Source: AGHT+IGXGlGWDf7MgytdrxddZK2S2P5gwa5fcr/tyZl8ajv3BXmP/fZsMTKOv+5vCtnLtXNGtwwlLD/fuxLCouXlO+I=
X-Received: by 2002:a05:651c:b2a:b0:2fa:d345:18b9 with SMTP id
 38308e7fff4ca-2fae10b4157mr45619721fa.38.1727974466669; Thu, 03 Oct 2024
 09:54:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Zv67JUPfzgQp7Kgf@fedora> <66fec4aa.050a0220.9ec68.004b.GAE@google.com>
 <Zv7KOuMKKHrLTvfw@fedora>
In-Reply-To: <Zv7KOuMKKHrLTvfw@fedora>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 3 Oct 2024 12:54:13 -0400
Message-ID: <CABBYNZ+BwrGdL0HYh3cmQ39RFwEqjzreJSyYhFkkhSWxeoorNg@mail.gmail.com>
Subject: Re: [syzbot] [bluetooth?] KASAN: slab-use-after-free Read in set_powered_sync
To: Qianqiang Liu <qianqiang.liu@163.com>
Cc: syzbot <syzbot+03d6270b6425df1605bf@syzkaller.appspotmail.com>, 
	johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, marcel@holtmann.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Qianqiang,

On Thu, Oct 3, 2024 at 12:46=E2=80=AFPM Qianqiang Liu <qianqiang.liu@163.co=
m> wrote:
>
> #syz test
>
> diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
> index 5533e6f561b3..20d0793d3832 100644
> --- a/net/bluetooth/hci_sync.c
> +++ b/net/bluetooth/hci_sync.c
> @@ -325,9 +325,11 @@ static void hci_cmd_sync_work(struct work_struct *wo=
rk)
>                         int err;
>
>                         hci_req_sync_lock(hdev);
> -                       err =3D entry->func(hdev, entry->data);
> -                       if (entry->destroy)
> -                               entry->destroy(hdev, entry->data, err);
> +                       if (entry->data) {
> +                               err =3D entry->func(hdev, entry->data);
> +                               if (entry->destroy)
> +                                       entry->destroy(hdev, entry->data,=
 err);
> +                       }
>                         hci_req_sync_unlock(hdev);
>                 }
>
> diff --git a/net/bluetooth/mgmt_util.c b/net/bluetooth/mgmt_util.c
> index 0115f783bde8..eccc51bfaf2e 100644
> --- a/net/bluetooth/mgmt_util.c
> +++ b/net/bluetooth/mgmt_util.c
> @@ -307,6 +307,7 @@ void mgmt_pending_free(struct mgmt_pending_cmd *cmd)
>         sock_put(cmd->sk);
>         kfree(cmd->param);
>         kfree(cmd);
> +       cmd =3D NULL;
>  }
>
>  void mgmt_pending_remove(struct mgmt_pending_cmd *cmd)
>
> --
> Best,
> Qianqiang Liu

Are you sure this hasn't been already fixed by Bluetooth: MGMT: Fix
possible crash on mgmt_index_removed?

--=20
Luiz Augusto von Dentz
