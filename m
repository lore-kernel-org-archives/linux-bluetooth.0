Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72BFC2C327E
	for <linux-bluetooth@vger.kernel.org>; Mon, 22 Sep 2025 14:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758552734; cv=none; b=Xt2H1HGvf9SBreKGVtInMbMLcpTw/licgwqLKrxy2Qo+EQ2KTCdPZCLiQTMCIk7Rhsgom8LMNR+i1+CyJUo5dtNB1PkINm7/0FcaupzoVLomBefDz9Kil91pHFPwQPlG+uuRF3E5AhC3chSEmCPt80nN9wxh3WTwjQsLGGhGdjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758552734; c=relaxed/simple;
	bh=IgEOKnsMiFgwhWpPEaei/HOVZMJIPyWsnnSP80F8Rts=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pSm7y/UmDbGtNRu8YQAEwkxvzdiR2lGYaCcoMDnDtTJtRtaX7pKhD0XlJh72GvSt0MHcKb+B6afHNsu4h5hs2uR2oGvn0pJr6X7S06KFoN+jdz7Yd8Q465mc8MHE8ZCJ7ifCF4c3QnNF9nIfDJNgZLAkk5MSXKeVrVY9kpVbZ9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EPSHvKa1; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EPSHvKa1"
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-363f137bbf8so30310531fa.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 22 Sep 2025 07:52:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758552730; x=1759157530; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IG5yBgwx6VZQUu5jIC5VIrApaz1N8AmdQXchUPrnmFI=;
        b=EPSHvKa1UlmfqFWOsYMlJeWAzbgAZs8LLt42iZEdbhx0GmI+0xReW1a+EvbLiB57RJ
         TKpH7s1YDNcnZXrrE3oOVgvpmg+8TJeqruefVbC8d9fnVpCYbJDXZl6FgK8y8Fg8Ud/f
         jcORdMq6sstlat7zDRoK1MX0NTt8+eO4Qt/8+VWZFWAoyIf1f1Na0Q+tbCB2HogfVBiz
         5EmrM/NKsJp5WOgAb0rhT23yxGsG78hu8V19CWs+OatdPxzB/h7xiRemYvspPd+ooKzU
         2M5WdSCs2zxSEM0zwpsJjN2XyN0AkbhCfYp878AiuaAY1MlOmWQR6y+azlNcXhAdXtff
         2Wvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758552730; x=1759157530;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IG5yBgwx6VZQUu5jIC5VIrApaz1N8AmdQXchUPrnmFI=;
        b=XbdPPYiXDbGwoa3NoEgDxAruAiLwbav9LLovQImAgMJS9CdLRMyQBrKoqMVp6l7eSM
         MaUAcMehubBiry0uhXr2E3IiiUxpShtK+q/fcQoOIGhosej+K7gT6Vo4CQ6mWKYLbU71
         XCOmNQLvMlsFb3b2G04Naf+X3nqzsEFWhVFZuTuwt/S/KBJIP3+vhw34wqZu8yGUeSYF
         zMtW2vqlGeLi74uZ8jOZMOsMvup6NU4BO8UcCxtkI9sY3Gl7d+OsWwzcst0sk/KgkrVu
         2SrEDjRK5LeSNfiPKJO4Azs9hqhNZFaQ41Fc8J9VuRaRPnkD6iE0O0Tg3Fbki/sHYi3+
         dQDg==
X-Gm-Message-State: AOJu0YwZ8cbqNNpS4hyYLofH1/cMe7HYUxhBWQAnuu2qszLs49nZVhpK
	TNbi4PlW3aGMlEdGjfK0FzzaThGqrmC1SLo3dTeL9eE6Eg7tVO8d53zy3g6Y0QI0d6Nf5e8Plto
	ne3XAoZXydLcSvbLwZ0wOcEIlWt1d3tI=
X-Gm-Gg: ASbGncuK8TXTzPkeoPc+7Cxk9brJbXD7GooYYPg1ZkSFQ3PYSZ64s3bynUWetSLqwaU
	wLX3EMOqbUSoyWZezZ6mbxgf5e+w/asdycqta2DLpLJHzALiNSlr90Ejp++ogHCSsLUmoZ1oY6V
	ZPWqokiI/CXG9GsoRoGukrnNcUKDWs2gVgIHCyU/eZymiIc1sAYUH8BLB5DwZxocbsBQoELvacj
	xat8A==
X-Google-Smtp-Source: AGHT+IFwg3LTQ/kzoo+H07IedK5cp/L/iirheDglQ4HkZZcLeZKHVVOWPvBy/t3JTUYg9cdI/B+dyvyYsQW74SHXIkE=
X-Received: by 2002:a2e:a582:0:b0:36b:c7d2:3aec with SMTP id
 38308e7fff4ca-36bc7d23f8dmr7752721fa.31.1758552730206; Mon, 22 Sep 2025
 07:52:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1758481869.git.pav@iki.fi> <a9e4e1c91a3b551f3ca57dfe816ed271e7da8c26.1758481869.git.pav@iki.fi>
In-Reply-To: <a9e4e1c91a3b551f3ca57dfe816ed271e7da8c26.1758481869.git.pav@iki.fi>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 22 Sep 2025 10:51:57 -0400
X-Gm-Features: AS18NWBhXeGmSgQPEXsCl0R4a6qLf7XEHqNo_G58z5o7CfPezJkiCaNLVrz2vNA
Message-ID: <CABBYNZJ5VdBW1MSpxSqsi2Jzos3Us20S2aDhmhAYDa1cd5BamQ@mail.gmail.com>
Subject: Re: [RFC PATCH 17/24] Bluetooth: hci_sync: add helper for hdev
 locking across waits
To: Pauli Virtanen <pav@iki.fi>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Pauli,

On Sun, Sep 21, 2025 at 3:19=E2=80=AFPM Pauli Virtanen <pav@iki.fi> wrote:
>
> Add hci_dev_lock/unlock_sync, for holding hdev->lock except when waiting
> request completion on hdev->req_wait_q.
>
> This makes writing hci_sync subroutines somewhat simpler, as the lock
> needs to be acquired only on top level.  Routines will however still
> have to recheck conditions after waits.

This one doesn't sound quite right, I'm afraid this will impact the
lifetime of hdev itself as well since this means the hdev cannot be
freed while req_hdev_locked, so it is effectively another lock, also I
think we might be better of adding a lock directly to hci_conn in that
case since most problems seems related to accessing it after waiting
for an event.

> Signed-off-by: Pauli Virtanen <pav@iki.fi>
> ---
>  include/net/bluetooth/hci_core.h |  2 ++
>  include/net/bluetooth/hci_sync.h |  4 ++++
>  net/bluetooth/hci_sync.c         | 26 ++++++++++++++++++++++++++
>  3 files changed, 32 insertions(+)
>
> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci=
_core.h
> index 1e9b27b3b108..10960462c5dd 100644
> --- a/include/net/bluetooth/hci_core.h
> +++ b/include/net/bluetooth/hci_core.h
> @@ -533,6 +533,8 @@ struct hci_dev {
>         struct sk_buff          *req_skb;
>         struct sk_buff          *req_rsp;
>
> +       bool                    req_hdev_locked;
> +
>         void                    *smp_data;
>         void                    *smp_bredr_data;
>
> diff --git a/include/net/bluetooth/hci_sync.h b/include/net/bluetooth/hci=
_sync.h
> index e352a4e0ef8d..eabc423b210e 100644
> --- a/include/net/bluetooth/hci_sync.h
> +++ b/include/net/bluetooth/hci_sync.h
> @@ -188,3 +188,7 @@ int hci_le_conn_update_sync(struct hci_dev *hdev, str=
uct hci_conn *conn,
>
>  int hci_connect_pa_sync(struct hci_dev *hdev, struct hci_conn *conn);
>  int hci_connect_big_sync(struct hci_dev *hdev, struct hci_conn *conn);
> +
> +void hci_dev_lock_sync(struct hci_dev *hdev);
> +void hci_dev_unlock_sync(struct hci_dev *hdev);
> +void hci_assert_lock_sync_held(struct hci_dev *hdev);
> diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
> index 8fe2f5b73040..5391c1bb17f0 100644
> --- a/net/bluetooth/hci_sync.c
> +++ b/net/bluetooth/hci_sync.c
> @@ -20,6 +20,25 @@
>  #include "aosp.h"
>  #include "leds.h"
>
> +void hci_dev_lock_sync(struct hci_dev *hdev)
> +{
> +       hci_dev_lock(hdev);
> +       lockdep_assert(!hdev->req_hdev_locked);
> +       hdev->req_hdev_locked =3D true;
> +}
> +
> +void hci_dev_unlock_sync(struct hci_dev *hdev)
> +{
> +       lockdep_assert(hdev->req_hdev_locked);
> +       hdev->req_hdev_locked =3D false;
> +       hci_dev_unlock(hdev);
> +}
> +
> +void hci_assert_lock_sync_held(struct hci_dev *hdev)
> +{
> +       lockdep_assert(lockdep_is_held(&hdev->lock) && hdev->req_hdev_loc=
ked);
> +}
> +
>  static void hci_cmd_sync_complete(struct hci_dev *hdev, u8 result, u16 o=
pcode,
>                                   struct sk_buff *skb)
>  {
> @@ -159,6 +178,7 @@ struct sk_buff *__hci_cmd_sync_sk(struct hci_dev *hde=
v, u16 opcode, u32 plen,
>  {
>         struct hci_request req;
>         struct sk_buff *skb;
> +       bool locked =3D READ_ONCE(hdev->req_hdev_locked);
>         int err =3D 0;
>
>         bt_dev_dbg(hdev, "Opcode 0x%4.4x", opcode);
> @@ -173,10 +193,16 @@ struct sk_buff *__hci_cmd_sync_sk(struct hci_dev *h=
dev, u16 opcode, u32 plen,
>         if (err < 0)
>                 return ERR_PTR(err);
>
> +       if (locked)
> +               hci_dev_unlock(hdev);
> +
>         err =3D wait_event_interruptible_timeout(hdev->req_wait_q,
>                                                hdev->req_status !=3D HCI_=
REQ_PEND,
>                                                timeout);
>
> +       if (locked)
> +               hci_dev_lock(hdev);
> +
>         if (err =3D=3D -ERESTARTSYS)
>                 return ERR_PTR(-EINTR);
>
> --
> 2.51.0
>
>


--=20
Luiz Augusto von Dentz
