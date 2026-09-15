Received: from mail-yx2-f12.google.com (mail-yx2-f12.google.com [74.125.224.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECBF736BCE8
	for <linux-bluetooth@vger.kernel.org>; Tue, 15 Sep 2026 14:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789481577; cv=pass; b=A3UJbehYuYHmsubXZp95lkzm02CU3oQIu4ErD9i2+FRgPwTa5QaY06igNzCA4QWNwACLIBnfKQJAENGyyAW0BxgJCDiQQrznxFKqF/u94tMNXpC92IWWZdk6KoceISL6fuO2wpZG5Pi8Im3TbNCvljoMcl8RtzOjH5Dap9SXiSk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789481577; c=relaxed/simple;
	bh=GOIj/wh8TpMzTX5lAHQylDSLT6REWsoLA66TfJssIhY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aR3HKainGk9Kro1Lo2oG9j4DLvBUrFHnplXe1u1fLFUhOVAeY935SMXH2EAMfDAYZGvj2tfxMa2KZos9ZNnVTmh9RqRkU8hcesWKqp90hbvsb55GcdO/XsWU89Mi835sy6QRO5i4xP+8wv//T+M+ajxdN7Q0PhK5G2FwpHgpeD4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gBMVMD/b; arc=pass smtp.client-ip=74.125.224.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gBMVMD/b"
Received: by mail-yx2-f12.google.com with SMTP id 956f58d0204a3-66e4ab22370so358362d50.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 15 Sep 2026 07:12:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789481575; cv=none;
        d=google.com; s=arc-20260327;
        b=JlubIlbMlT6bnL2iLcteGx9TFYcNHIH/RNHfAixRBCImC/HcV+ojP+USUAise9izXc
         WWZwLL3QdljULY9C3TuarkYhxGvTL2RTHZln21diRRgucW+RKvqrXHfhKsvhdQuogVq+
         aPhXtJn71ocIX1aezVO3TN25SNjJcSFn2zj3t5U97QmFwKroksCL9lfR/iMSp3oDg5oY
         9VNJYYXjQuqHh3rerBzgQvtA/nMAtKkLPlvbEL/ydAwXPMqo+64MmPRAWHYt7068huGI
         v69EH+EK/Ri2Iknqlak5pGkJCxYGD2CJoPKG1pbffPPWseLIDVyE5/7wfksCrMbboaxz
         zR5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1NYnDGtx4S3hUcN9F7tPg8j9ZhqHNHLvb5FEYUCdHzQ=;
        fh=ivpO4PhIkrh3sEqXHPn70/6Ih9P7TT4ugGxFfFNhu8w=;
        b=ejqG9yycP2HmFWpPrGuHhe2LLOTR6XPez30KI32VN+zuTd2cpyaxUoBlc8ZV727H9A
         kUnMRNsmfSArpcrPuRTHdmzwLjHJZx/ah2DHx4LHmRpr1VcFV6ERQG0HV7sYmMHeGeU1
         IpBELE/MirqMwBdVxaDssrtXd7ZXep1WYQWOPMb2vYwdy0dRmQStEMtS7ywbqUWfkSDQ
         L5DLdRMSK6qxCuZDY9lIrC5L9fGIttwpVF4QwMgdoCP2hDZ7pnHBKCmX48wqVhcfd/vj
         EhWOoEocCuju39z6ZEwXOJoz5QY9TeVjXTH3RG48pdi12vrDDEh8EBIGg5sPbTiynEeg
         Hxbw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789481575; x=1790086375; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=1NYnDGtx4S3hUcN9F7tPg8j9ZhqHNHLvb5FEYUCdHzQ=;
        b=gBMVMD/b90KDsg8N9ReLfQCx0nDTs4pkhe0acKIyCzfzujZGt4TVJ5AJnG948sKeyG
         Y5MzPBl3CvSqEJMuTp/Ragb4zCerGiMEnBTVcyQjQrfvMnAKvUiwqwfuvSY/keHLETh2
         W+sGxw3tIYqMFvqCSPH0IqX02/UoRYnVjE+nO8RbCntLs4yQalxPaNwgg5O0nTkFKPdj
         TqzSjc+9rNSmFzXelsxJLGa8+MwwR8yEj2IUUJ8lqurNE6QSJD/SHGLmWkPCsVPE1BN2
         rbHGhaJFVbE5LfsmX+F46tjtfnx7OxZS47k4+DCloEdjiRaJ2b95MqzDlki77L8ekh5+
         hcpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789481575; x=1790086375;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1NYnDGtx4S3hUcN9F7tPg8j9ZhqHNHLvb5FEYUCdHzQ=;
        b=p4y5YabYEcndgVAKyDhdpXNkYf9JlSL+vzRHfberBp8HaM9wxScv11ReN5UwoOV1lD
         P2Gy5/jt43pHhA7RDPDvQVfMTec08NV3YwwFK8P2XUH0YtMjipXSxbrww9/dd0/xDfrS
         rmCOU/F0oRHuBLYPWkHt6wdAU9vtfVfd/BAGK5lxii2jmtkTK7lCn7s1ipildftChTtO
         zNoAzkWtr0qgjFcS2oqJhCHjTw9bxGUbSuxtYiBJ2QaM/UIKWaKxJiMxMtWJaBgcNcfB
         4r7kJUUypcth1A3oMTSOAG6wT60pkWUYLoSeupT+A2k4BGrPmZUTXUWlHfeySuduHSrM
         QwEw==
X-Forwarded-Encrypted: i=1; AKwUvBwxJK7q9p4Qt44lvEGCFmnQ9bu0Cbw8Ec0RRvVYCZC8xTg4wOM2pg7oPsRZzwsvEryiuKnVlbyF09fwiilAVfs=@vger.kernel.org
X-Gm-Message-State: AFuF++kPgwYTVouHkhNJ/VFB//fpHqK0mxN4m0Xw7txQvRbRN0dV1kbD
	XIsfipN3JlQF8e/LNEkYMF2BmeYqokIbymShwg4kSNRz+HmjbrbpqMIMdeujnoZ3iBimVBamFNp
	Of/JBrIxHGwLmItOYWVYVRYa67b7OR70=
X-Gm-Gg: AYBFou0n0YD/THSKO68r3dRTijtWVLr8blWjwfew4OFEs5/GY+MLyb4KXGoSiz0DA+n
	0a0a04fOIP7VdphRARXbDHS901ik8+ViI7qyu8lHBPSQpbhu78RCmGnrXVR3z5Eu6rrge8DdqTE
	pgAXrTiwaQrL9VHy2xSsdGwXEjjvN2rEKiLzhj8LvM9aj+Pn3usKHLjObk9K21hWnUZZQq7Kq6K
	Oo35d7DFhTyYXVTpyOOemREQ9BkXPAXl7sc370lbliT2cKvU76RRavlOsTsDUUSBJpfmLeP0yog
	7HJmFVYzAmVFnP9gsqHGtHLf+WGznD8ob0NNgXLkgSvO0Ai8UvLkq9NNv7oZ0XaoagBGdkgsBwp
	HuGFXBow7zbnmT9DY1iw9wZPv3huq+dF9Nu8lOOPfjQ==
X-Received: by 2002:a05:690e:4594:20b0:66b:163f:57c3 with SMTP id
 956f58d0204a3-6715cb260c5mr368015d50.42.1789481574586; Tue, 15 Sep 2026
 07:12:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260914-misc_fix-v2-0-6178d838c946@oss.qualcomm.com> <20260914-misc_fix-v2-2-6178d838c946@oss.qualcomm.com>
In-Reply-To: <20260914-misc_fix-v2-2-6178d838c946@oss.qualcomm.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 15 Sep 2026 10:12:42 -0400
X-Gm-Features: AcwNN1WOQ6YdQ_AZPzyODQbHVSLQS9HgiYHVZizdb_BYFTX2VeFJBY8ma8WFpkY
Message-ID: <CABBYNZLMbWgi=tizwOsNwAUjJA0AzpMa6XNrQWkJBGL+PwOWeQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] Bluetooth: btnxpuart: Fix skb leak in nxp_process_fw_dump()
To: Zijun Hu <zijun.hu@oss.qualcomm.com>
Cc: Amitkumar Karwar <amitkumar.karwar@nxp.com>, Neeraj Kale <neeraj.sanjaykale@nxp.com>, 
	Marcel Holtmann <marcel@holtmann.org>, Zijun Hu <zijun_hu@icloud.com>, 
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Zijun,

On Tue, Sep 15, 2026 at 1:41=E2=80=AFAM Zijun Hu <zijun.hu@oss.qualcomm.com=
> wrote:
>
> When CONFIG_DEV_COREDUMP=3Dn, hci_devcd_append() returns -EOPNOTSUPP
> without freeing its skb argument. This leaks the cloned skb and also
> prevents nxp_set_ind_reset() from being called to perform recovery.
>
> Fix by guarding hci_devcd_append(hdev, skb_clone(skb, GFP_ATOMIC)) with
> CONFIG_DEV_COREDUMP.
>
> Fixes: 998e447f443f ("Bluetooth: btnxpuart: Add support for HCI coredump =
feature")
> Signed-off-by: Zijun Hu <zijun.hu@oss.qualcomm.com>
> ---
>  drivers/bluetooth/btnxpuart.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/bluetooth/btnxpuart.c b/drivers/bluetooth/btnxpuart.=
c
> index 69e897444112..a0b64fdcbcc1 100644
> --- a/drivers/bluetooth/btnxpuart.c
> +++ b/drivers/bluetooth/btnxpuart.c
> @@ -1383,19 +1383,21 @@ static int nxp_process_fw_dump(struct hci_dev *hd=
ev, struct sk_buff *skb)
>                 err =3D hci_devcd_init(hdev, NXP_FW_DUMP_SIZE);
>                 if (err < 0)
>                         goto free_skb;
>
>                 schedule_delayed_work(&hdev->dump.dump_timeout,
>                                       msecs_to_jiffies(20000));
>         }
>
> +#ifdef CONFIG_DEV_COREDUMP
>         err =3D hci_devcd_append(hdev, skb_clone(skb, GFP_ATOMIC));
>         if (err < 0)
>                 goto free_skb;
> +#endif

I guess IS_ENABLED is preferable here so the code is still compiled in
leaving it up to the compiler to remove it in case it is considered
dead code.

>
>         if (buf_len =3D=3D 0) {
>                 bt_dev_warn(hdev, "=3D=3D=3D=3D FW dump complete =3D=3D=
=3D");
>                 hci_devcd_complete(hdev);
>                 nxp_set_ind_reset(hdev, NULL);
>         }
>
>  free_skb:
>
> --
> 2.34.1
>


--=20
Luiz Augusto von Dentz
