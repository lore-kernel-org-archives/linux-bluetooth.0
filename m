Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B16E12586EE
	for <linux-bluetooth@vger.kernel.org>; Wed,  9 Jul 2025 20:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752091569; cv=none; b=eGsPcuSpYHuJJ4aG5B3mgrG2cmzoq5n25jGsTEwTn0Jgg7lHvAGpBfB+ttNXKurbWtYYwvbYC0NDQaCcoHGRdvhocjaiHcx+kVkUmVxiHOSj2L7cRYTfY1ArEFqTy34A5Q+sCWHM50J3hnV9SQi2vSrsmRJPi5YGgyM31Qld510=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752091569; c=relaxed/simple;
	bh=BLF9WS+NmN74OV3unLPr7RDka+fyd66KEmhdXWZ5yP8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=ejLIxaJVIcyWC6NSeFvyAjd+a/uhjYQb+fnWQEec4RGER3WNfsgHyqn15lVFHusijNdtHYrE/PAHB15D53eqIRjtde4+ULYFEzyJFNMnQIt1SJtAf4izG4OS8eFHe/uxzrVeXJHnQKF4fufkKLwnZ2v0HFNMrFM7451ljFSZKSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AP4FvZL+; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AP4FvZL+"
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-32b3b250621so1885381fa.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 09 Jul 2025 13:06:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752091565; x=1752696365; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SBkoUbwVrnFNzQTw8qUHbRKshrcfZ6i0YYAsAlgzSzg=;
        b=AP4FvZL+ALHDqda0xmoGHQaS+HSK5KP/PTIn3luDWEkFnZSxa9r6bp4VN5zEH+x8Qo
         Hb9aeLJyiWZHfvn8LVeN2229pMCxdhVirRDghy7J0OFw2z8j4hbh/na4RSsE33vKsDPr
         xoUhMFMDfSBw30LqX19jmdItyoYaM3u7P5k5/jdLGBBIt3ShhsAS28K+bf5wbQoh/+hN
         t+uErtiQGrnNUxG2iOcvD1rSAqKoo/81YM7Qibr3iWZyfkO6p54YFoEYqksdpyHL7CH3
         s3VF8DenImZjyEbDDhxRX6vOiIbn55KWbnyYqtUJ/Kc7cKQZ7euefBwvAzCVs/3kIUkV
         04NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752091565; x=1752696365;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SBkoUbwVrnFNzQTw8qUHbRKshrcfZ6i0YYAsAlgzSzg=;
        b=G1c9aLz8dpqsmzUTAY6kPBHz7T+7wNve7eiHWBJZ6R13pk+lOwX39PyB12gxpM+ovR
         aP0hvtO126VFhYYPqHwgPGXokEGhZwSY4E9XNmmWQ3n2BGjnV2yTRP/+S7EGf2xoclz1
         G6zt7lHyODVfpiX6utWP+Xd0dyZz8o6OjBZM6vk4DhkLXe3pnTf12kAfd6Nmht1Pd4+L
         bBf+jnwcv13LsylRs8xOUgBZPJxeHht1PGopgF41gh4Yvbm42DzCAPjEkuc3O5YbGSRQ
         2PzQkp/o4ZXWWPsYwhRAL/vGSwjbnX6Pd5HAzmIO8WdYQGJfWd0WpxsKLafIAD5NbLlx
         ZQwQ==
X-Gm-Message-State: AOJu0Yz54YGWURa/+avOlACkT4mBF+jrz6XFNNdbHf3rRqp9UHTDCwkU
	cKjPhZEUatrbUh9R+qEkVeqkAHHjbCzLyLJCjVce+VBqlkIxiFk/yZw5vAUsfUhDBwjfoifakTj
	+c5fD7MVymHZIai/dAIzIlgsajAP5SN59VZF/spo=
X-Gm-Gg: ASbGncuhnIiCEho7XOR6/mvfKeNpIKMh+6WQKWb9Bz2qNqsDAR3QPow+tJ8aFDFKFN8
	GKiK1BGai45mGi+L0TojqUVNF9JioE/FBwe/TPWIe+TVd8UygOgrMVvhuONyBTScZ60lxqUB7I4
	b6LYLh2VcQAWTBhIYJes5lDSwP09dZBMNI4ehU5x1F/4EyCw==
X-Google-Smtp-Source: AGHT+IGj3U9snCt/T0gZ1umz5Wi0o1rM55H9FeH+Tn+R6SFVdsSDBysFCsNk2UGDoDb2BJmSckD2XMXmC5NON2jfxy8=
X-Received: by 2002:a2e:b8c8:0:b0:32b:719f:1260 with SMTP id
 38308e7fff4ca-32f484e8177mr15800451fa.9.1752091564765; Wed, 09 Jul 2025
 13:06:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250709191333.3374053-1-luiz.dentz@gmail.com>
In-Reply-To: <20250709191333.3374053-1-luiz.dentz@gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 9 Jul 2025 16:05:51 -0400
X-Gm-Features: Ac12FXzOJqCrA8eDvJxqc0qfSPOWcRYWq2G3oKPkuUFfJKNVS5hnM4UHGWV2nv0
Message-ID: <CABBYNZJLLWu2EEEsZ+tE0+0H4o1ba3gG2ab9dLaPbAxz2BzGmA@mail.gmail.com>
Subject: Re: [PATCH v1] Bluetooth: btintel: Check if controller is ISO capable
 on btintel_classify_pkt_type
To: linux-bluetooth@vger.kernel.org, Sean Rhodes <sean@starlabs.systems>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Sean,

On Wed, Jul 9, 2025 at 3:13=E2=80=AFPM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>
> Due to what seem to be a bug with variant version returned by some
> firmwares the code may set hdev->classify_pkt_type with
> btintel_classify_pkt_type when in fact the controller doesn't even
> support ISO channels feature but may use the handle range expected from
> a controllers that does causing the packets to be reclassified as ISO
> causing several bugs.
>
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D219553
> Link: https://bugs.launchpad.net/ubuntu/+source/linux/+bug/2100565
> Link: https://github.com/StarLabsLtd/firmware/issues/180
> Fixes: f25b7fd36cc3 ("Bluetooth: Add vendor-specific packet classificatio=
n for ISO data")
> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> ---
>  drivers/bluetooth/btintel.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
> index 55cc1652bfe4..06575a0b9aee 100644
> --- a/drivers/bluetooth/btintel.c
> +++ b/drivers/bluetooth/btintel.c
> @@ -2670,7 +2670,7 @@ static u8 btintel_classify_pkt_type(struct hci_dev =
*hdev, struct sk_buff *skb)
>          * Distinguish ISO data packets form ACL data packets
>          * based on their connection handle value range.
>          */
> -       if (hci_skb_pkt_type(skb) =3D=3D HCI_ACLDATA_PKT) {
> +       if (iso_capable(hdev) && hci_skb_pkt_type(skb) =3D=3D HCI_ACLDATA=
_PKT) {
>                 __u16 handle =3D __le16_to_cpu(hci_acl_hdr(skb)->handle);
>
>                 if (hci_handle(handle) >=3D BTINTEL_ISODATA_HANDLE_BASE)
> --
> 2.50.0

Can you try with the changes above?

--=20
Luiz Augusto von Dentz
