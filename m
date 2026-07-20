Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A101F38E12D
	for <linux-bluetooth@vger.kernel.org>; Mon, 20 Jul 2026 19:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784577313; cv=pass; b=SO1eEksp2cUosHiixisiuI2JLsVPkt+3wMZb1YTK3s6y+JTmVoDwb5uPTNPuD+bYWr8TOj/bYZX6lvAK1xTo8sxVBtjcttZyBD6F/ScLOaasg14u2NARWk9OgaBej1shGWHpaW4/2FDkUeUYJkvmDZkz/y7M/NLEvTFCx+rqDz0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784577313; c=relaxed/simple;
	bh=U6naqr8/fm2E7FQtlwL+QylvLk20pczaI7HxTKdFd5s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QEg9Vqnrl8hdREreoqOTefWW8OHpGXhZuTxjxPj53yMrGfSHmEX+GZxWVVYbD0Yb7b/Cgm0MgMVadlEprq3paPdUutUAO1Ft6HiSQ5H1zZ0qdKcXtwPfRWbLarsLX+GGNm328Hx8hQ4dTW26q+qL+XmxJpcIf30Q89QNcM5ZBOI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FWiRO74l; arc=pass smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FWiRO74l"
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-81e6f0b4610so110493187b3.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 20 Jul 2026 12:55:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784577310; cv=none;
        d=google.com; s=arc-20260327;
        b=Sfpu3E05slod7D5RwkjvxBEfrtkvk6yKUvHw0agsKbOGK72cXCfiEmIgoRrPxylafz
         bDZmjhDVfCFF5gEOGNN/myZ07Flm9lBRf/dKPNOiXfVWsOD1st+kKZaTMp7BaO/sWwG5
         +xeoHbAlAw/pAUtqpFLJJVhB8bR0gTyjfLw7eLwOyRQS0MOIBvJs7Fk/KcrJz8GVvIOn
         4+BBFWyIYF4ZUybKaLEdnkWtKJRGwxs150xIf5L9k5mCXQegtFjLdl6ID8Woy3UnEq7j
         YoXjhh+4ymI4Zko/y0LswdS60OIpYBvyTYZGqAQo90JEZ0m7NCpmFSdcN9dMi5YEknBX
         4ocA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/AOtXMyuIHsHhRfVMauZWyjtCTCZoSPj81jh5GgUwec=;
        fh=UOCTs6jdHPlfzPKuNb51I6vQiCaMXSycb/FPhNl8YFI=;
        b=NlDk7/AS6Mf6S5T4120LjjngWE0ZAJSAfN4ir4EEgfqosp12a1fveAsH369f1943Cl
         oxlGV8FfTostCtPB87xgnyHdKcZtG2t1+XK8uzu5rsRZxIgOcSMT2ZsHfmf/zZCn3nCt
         dxzVA/7ESN9hKFhxsiYNwLxIhnMYkR4VHnb3kUIS5pQDYMfvZop08KYR7LPjk7K+H4Lf
         Tq+HupgvMg7dwQnf3wlkPn+6hMcmTnQ3b570WCTMyNXakuIyJJxwPo1vOCjNbshW9oMO
         qzJD+Xy7cXPi+jSQZa9aEsJQmOGa6/kIsbafX9WdlnVomyeW3UnxSOfnKt1O8tHPACbq
         3pxg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784577310; x=1785182110; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/AOtXMyuIHsHhRfVMauZWyjtCTCZoSPj81jh5GgUwec=;
        b=FWiRO74lhMxjxDk1LJhjl3w7DuNoRlmfDWqxJjJsyiAW+mnUhf87q+4lvWDg4O3VSc
         aOtePuRrmshG1TQchNxYgQdGCfXDI44KT8/zjQ97KoxRiY/LA2EGFS0nevUhpuykRMe7
         a25Ym9J4NvTzwF0zbg4mkSadvKPGdFb/MVQSZZDBxyoYDaxplhSQ2Ac5qL/s/aRslfAY
         BrM75O5ZFKeRcty/fALGa9DKcpSptQmlQiStgF6t2Mv7jSQY5pqPy6ppqtssyhMGtorA
         5MxkwDwEAHRCuWuLqS7iH802zev0FfHrjUgLOei9IjvyPN2Xp9wOgBFsn78BNBwIoQA1
         kdmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784577310; x=1785182110;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/AOtXMyuIHsHhRfVMauZWyjtCTCZoSPj81jh5GgUwec=;
        b=JnuxxRkExpA6PhcatgCzpftwGBxKLq7XkCR8fKrmQoOdoBnf31RKCkP0am0ZuLYBaj
         9CkAhxE1SziuFKXvzxWyjh8SboAKDKntGij/JYXEifF9rfY9WI6hWY7XZpUR7a5RUuNr
         TcjqfhgrzCoQbP0bG/MgP1+3qd4mAXsLXp6u05NDkf5DFciAUqixEXATlWrGvZaYsTf5
         TR3iUGp8wIEQl2AKGrvvqsggqQvR1u3etUARuXewb+4A5yvm9TEgxossWjQ15JczPl+E
         Fm+dK/FLglQGEvTB+FSj5Lp3ZclZtqYRa4t/K8Joc99Bi5Ne/uCWn3aiiGxamq9qhg9T
         0s/Q==
X-Forwarded-Encrypted: i=1; AHgh+RojzwFNLFyXFhKrNa4mU6glGFkPcGVDWHS1/EGWP5wdejy5E2ZXiEZQc1mg1YKdiLLHvGmA41k/rUlfCfUn8XI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwO4gHR3qNU5ISSYPopbG604UHCTzDSQsYgjEQiME6nr42s7mg8
	99TcU20CkRYF/hV80DwBsAULvgIFkU5i5da2+OcgEKq1vJDsKQ8AsjJ9nORhNy0EAoxp1aB6cxH
	IQmN1DD+ZFYUhHdjDabDNLPYyRCWIZDiWGr8d9lPB+g==
X-Gm-Gg: AR+sD11l71YnyNeMRQdcLy6tTPAvyxbCqbEf5xvW50skVOds4ykdVsBVToWvywPPaHB
	XgmoSINgQQHYrX9ETbPAwqWVKFpufTWvLZIcLuagEdkhUhre/f7Y3OGX+esOwuW7mVepvCbENZb
	UfO5ezWhXs4eG4m4eDVfWlbdSSOA9JWqdvebxrY9zrHGkasHrb9MIdf6kh2RMXje7/RIIUZC217
	GWcXi5ox57mewkz1NB4E/1X11w6mdbJoXJVFUk4hrpTYzYGj8o5kVwWRqHMbWEheFvd9OK0afZK
	d5wzIFwjs80CH3QVyWBlxqf8z6RU6e5jTNvZ0O8RIiEG1e2e
X-Received: by 2002:a05:690c:6702:b0:81e:2e67:bb9b with SMTP id
 00721157ae682-81ef26edccfmr47109007b3.58.1784577310290; Mon, 20 Jul 2026
 12:55:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260720164738.2921802-1-nicoyip.dev@gmail.com>
In-Reply-To: <20260720164738.2921802-1-nicoyip.dev@gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 20 Jul 2026 15:54:58 -0400
X-Gm-Features: AUfX_mwx2tFRY0jR9aCJZGYE-cu6e-hrJK27ReHcPbzYy4X9ldy2V3BG6Q6JokQ
Message-ID: <CABBYNZ+G3jD3A6-k1fEm2sSRa27o8s0PNN_arzVa8de-eJK8oQ@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: hci_sync: Fix scan response data UAF
To: Chengfeng Ye <nicoyip.dev@gmail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Jul 20, 2026 at 12:47=E2=80=AFPM Chengfeng Ye <nicoyip.dev@gmail.co=
m> wrote:
>
> eir_create_scan_rsp() calls hci_find_adv_instance(), whose return value i=
s
> valid only while hdev->lock is held.  After advertising setup was moved t=
o
> hci_cmd_sync_work, neither scan response data builder held that lock.
> hci_set_ext_scan_rsp_data_sync() also kept the returned pointer while
> waiting for the controller and wrote scan_rsp_changed through it afterwar=
d.
>
> An advertising termination event can therefore interleave as follows:
>
>   hci_cmd_sync_work                 hci_rx_work
>   hci_find_adv_instance()
>   __hci_cmd_sync_status()
>     wait for controller reply       hci_dev_lock()
>                                     hci_remove_adv_instance()
>                                       kfree(adv)
>   adv->scan_rsp_changed =3D false
>
> KASAN reported:
>
>   BUG: KASAN: slab-use-after-free in hci_set_ext_scan_rsp_data_sync+0x2e1=
/0x300
>   Write of size 1 at addr ffff88810a45d21d by task kworker/u17:0/88
>   Workqueue: hci0 hci_cmd_sync_work
>   Call Trace:
>    hci_set_ext_scan_rsp_data_sync+0x2e1/0x300
>    hci_schedule_adv_instance_sync+0x390/0x4c0
>    hci_cmd_sync_work+0x173/0x300
>   Allocated by task 87:
>    hci_add_adv_instance+0x538/0xac0
>    add_advertising+0x885/0x1160
>   Freed by task 89:
>    kfree+0x131/0x3c0
>    hci_remove_adv_instance+0x1d8/0x3b0
>    hci_le_ext_adv_term_evt+0x17b/0x730
>
> Hold hdev->lock while looking up the instance, building the scan
> response, and clearing its dirty bit.  Clear the bit before waiting for
> the controller so no adv_info pointer survives the wait, and restore it
> under the lock if the command fails.  This also preserves an update that
> races with a successful command because that update sets the bit again.
> Protect the legacy scan response builder with the same lock.
>
> Fixes: cba6b758711c ("Bluetooth: hci_sync: Make use of hci_cmd_sync_queue=
 set 2")
> Cc: stable@vger.kernel.org
> Signed-off-by: Chengfeng Ye <nicoyip.dev@gmail.com>
> ---
>  net/bluetooth/hci_sync.c | 32 +++++++++++++++++++++++++++-----
>  1 file changed, 27 insertions(+), 5 deletions(-)
>
> diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
> index 532534bc601c..8c69a98c71e8 100644
> --- a/net/bluetooth/hci_sync.c
> +++ b/net/bluetooth/hci_sync.c
> @@ -1490,9 +1490,13 @@ static int hci_set_ext_scan_rsp_data_sync(struct h=
ci_dev *hdev, u8 instance)
>         int err;
>
>         if (instance) {
> +               hci_dev_lock(hdev);
> +
>                 adv =3D hci_find_adv_instance(hdev, instance);
> -               if (!adv || !adv->scan_rsp_changed)
> +               if (!adv || !adv->scan_rsp_changed) {
> +                       hci_dev_unlock(hdev);
>                         return 0;
> +               }
>         }
>
>         len =3D eir_create_scan_rsp(hdev, instance, pdu->data);
> @@ -1502,15 +1506,27 @@ static int hci_set_ext_scan_rsp_data_sync(struct =
hci_dev *hdev, u8 instance)
>         pdu->operation =3D LE_SET_ADV_DATA_OP_COMPLETE;
>         pdu->frag_pref =3D LE_SET_ADV_DATA_NO_FRAG;
>
> +       if (adv) {
> +               adv->scan_rsp_changed =3D false;
> +               hci_dev_unlock(hdev);
> +       }
> +
>         err =3D __hci_cmd_sync_status(hdev, HCI_OP_LE_SET_EXT_SCAN_RSP_DA=
TA,
>                                     struct_size(pdu, data, len), pdu,
>                                     HCI_CMD_TIMEOUT);
> -       if (err)
> +       if (err) {
> +               if (instance) {
> +                       hci_dev_lock(hdev);
> +                       adv =3D hci_find_adv_instance(hdev, instance);
> +                       if (adv)
> +                               adv->scan_rsp_changed =3D true;
> +                       hci_dev_unlock(hdev);
> +               }
> +
>                 return err;
> +       }
>
> -       if (adv) {
> -               adv->scan_rsp_changed =3D false;
> -       } else {
> +       if (!instance) {
>                 memcpy(hdev->scan_rsp_data, pdu->data, len);
>                 hdev->scan_rsp_data_len =3D len;
>         }
> @@ -1525,8 +1541,14 @@ static int __hci_set_scan_rsp_data_sync(struct hci=
_dev *hdev, u8 instance)
>
>         memset(&cp, 0, sizeof(cp));
>
> +       if (instance)
> +               hci_dev_lock(hdev);
> +
>         len =3D eir_create_scan_rsp(hdev, instance, cp.data);
>
> +       if (instance)
> +               hci_dev_unlock(hdev);
> +
>         if (hdev->scan_rsp_data_len =3D=3D len &&
>             !memcmp(cp.data, hdev->scan_rsp_data, len))
>                 return 0;
> --
> 2.43.0

It looks like Sashiko found some other places where this could be a problem=
:

https://sashiko.dev/#/patchset/20260720164738.2921802-1-nicoyip.dev%40gmail=
.com

--=20
Luiz Augusto von Dentz
