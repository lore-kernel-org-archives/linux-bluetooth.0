Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E4291AAA2C
	for <linux-bluetooth@vger.kernel.org>; Mon, 17 Mar 2025 17:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742233639; cv=none; b=i91JTrgUipyIyDW7uM+hhPoZBbGlQn6flSCTe5GXxxidcZqeu9kgISt6oxp6vorm0GU7cyRmj4Jsr9E/GNvbb9mC8qM7gz2Uj+gLzfGrzT0GF7nFIOg1QTC1Ql2iz9XRBemeWJUIYJuDEk4k/RjvKIM8UBjbBibs44JeQPLbX7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742233639; c=relaxed/simple;
	bh=iFU3xJQPx+HjRQ5CEPFwNFOglfvBB43mBUGnPocKHWQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S1/Z+QW8BAJl9Nyb0HA0Yr3cMAOL6h3xOXg4J35P28m6LdbooTCojve7MF7eIR89iIKeDj93RVzhNPzR9PCkNHr8qEKzk8hr9hbWyYG0LGdHFCLc0YEnEHf7/5CINYRVIh6uKP+aH2BlWdhhbljaPXfmnHAPRuCCuzUsb6cl7ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=chu2/UUi; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="chu2/UUi"
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-30bf8632052so50577591fa.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 17 Mar 2025 10:47:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742233635; x=1742838435; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PO8lqbcL8TLvGC88+aGFFH2cjsoL8HD0/cObPDThpx0=;
        b=chu2/UUiY4ZD7MKDTZnO9ixx9mO8kW8tMBX6Al6UkcIEeO8JlfHlQZlQQcPwaa8WhU
         bVpL/CSSnUdO/hp4iqNnDw4Ma9EiUh/TR9aOOku2zEeFxrJvML92krK6vzs2LhTGm74s
         eg3/CE/YfvifvF41dF5o/m6+xPFQlWhgr++y038C7ZQT5rlx8VaA2MzHEpzNEO9LlSv0
         R96Wo7CDIywrknAb3Ft3B/owHfmUd0Mb+8/qsXxXZFwgjEGtK9igcXPEZIQd4zkTp1f/
         l7YXX4XWo7+ijfv9AH8GZDcnuaJGH5AG5SrK8OxjJGhRdkZOWJbGq3LzU04TtrhWXdCq
         Bvyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742233635; x=1742838435;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PO8lqbcL8TLvGC88+aGFFH2cjsoL8HD0/cObPDThpx0=;
        b=sR4qIBahgOWXaefu9apR3b97vOIS8z2T9rWQeIG5AeL+/3U7fVgBdQR3KcMHKHjv3r
         iOO8iogz7F4g00ADTLyTM4tFMmn6lMjsR7oi9TNUZahxoWWCSPnWtArgTCMuDnGnFHlr
         mH62d2qqYfyI3cdSX6ehlC+ecJ3swyS9r8IWX2UR3gkvFPzuXm0KfJySPEkAPhr4P6gC
         950VeBfvTHwD3EcQWPfOfHOv2scxhhGn1OrBy/9BcAogNag3ryWqSpaeNA3dtokxRe9C
         7QgtNyPSOiXgdd5qyoMZxJVw3B02aJ6V+ygSS31nq28WeY2Lzvz6BEPavzTOIsZQVSz6
         7JAg==
X-Forwarded-Encrypted: i=1; AJvYcCW2Xkxa31NDjx3gIeY2v4cpMmNElcG07I903+8k6My+A66bZVxDi9mPOkbwClwb0W50TkVFVf5hjX7w91QBW3U=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywijc2HzPR8dffhq9FlJshR5vtLU+qQk53zc29iALuL0x/zuLp/
	4/nk+pEjK4wmeaTqicbETVwioY5mU+vtL/bYQFvVSxCa+7bZkrTi5DFN2qwcP+c58mDC0VKncbs
	8yJ3Vdw2KSIm2j3OKop42Vk4/bn4=
X-Gm-Gg: ASbGnct6XUabSXdixuyF3Awxeul6kbp6dLsShbpRlFspGejgxPO0LOEXJD/2bkfkfKO
	b4+T86RGGVJFgy39L3FJpWLpECsWRUf4YpL0vKTZjBZ7JINuv1xTrEP9mpi9csgmJFRDmDi2Grj
	Vw1+q8mzn+e70nmvrcn6xDxvQT
X-Google-Smtp-Source: AGHT+IG4RHYQJtsUJ9ATQvwXw7nOYUHw4MNKApP7ZMFKDVH+zOL2KmqudVPdo2wjX0r+FS1NQD+o0Ljo+iz+ZTxXK2U=
X-Received: by 2002:a05:651c:506:b0:30b:e96a:7d69 with SMTP id
 38308e7fff4ca-30c4a8e519emr79302761fa.35.1742233634947; Mon, 17 Mar 2025
 10:47:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250317154715.15023-1-guanwentao@uniontech.com>
In-Reply-To: <20250317154715.15023-1-guanwentao@uniontech.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 17 Mar 2025 13:47:02 -0400
X-Gm-Features: AQ5f1JpDqePWUkYUt80ozqJf4cl9JnCKlO9Ny5xITzrVxZq4Sea6LB7w6mWqOpw
Message-ID: <CABBYNZ+MdXNdLrgNb0UOuh2aFnukcUTTAvGkD6M5js=pvQuQkw@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: HCI: Add definition of hci_rp_remote_name_req_cancel
To: Wentao Guan <guanwentao@uniontech.com>
Cc: luiz.von.dentz@intel.com, linux-bluetooth@vger.kernel.org, 
	marcel@holtmann.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Wentao,

On Mon, Mar 17, 2025 at 11:53=E2=80=AFAM Wentao Guan <guanwentao@uniontech.=
com> wrote:
>
> Return Parameters is not only status, also bdaddr:
>
> BLUETOOTH CORE SPECIFICATION Version 5.4 | Vol 4, Part E
> page 1870:
> BLUETOOTH CORE SPECIFICATION Version 5.0 | Vol 2, Part E
> page 802:
>
> Return parameters:
>   Status:
>   Size: 1 octet
>   BD_ADDR:
>   Size: 6 octets
>
> Note that it also fixes the warning:
> "Bluetooth: hci0: unexpected cc 0x041a length: 7 > 1"

Please add the Fixes tag pointing to the patch which introduced the
hci_rp_remote_name_req_cancel.

> Signed-off-by: Wentao Guan <guanwentao@uniontech.com>
> ---
>  include/net/bluetooth/hci.h | 5 +++++
>  net/bluetooth/hci_event.c   | 4 ++--
>  2 files changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
> index 0d51970d809f..b9a95c2735e0 100644
> --- a/include/net/bluetooth/hci.h
> +++ b/include/net/bluetooth/hci.h
> @@ -855,6 +855,11 @@ struct hci_cp_remote_name_req_cancel {
>         bdaddr_t bdaddr;
>  } __packed;
>
> +struct hci_rp_remote_name_req_cancel {
> +       __u8     status;
> +       bdaddr_t bdaddr;
> +} __packed;
> +
>  #define HCI_OP_READ_REMOTE_FEATURES    0x041b
>  struct hci_cp_read_remote_features {
>         __le16   handle;
> diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> index 2cc7a9306350..a7b0e36609d9 100644
> --- a/net/bluetooth/hci_event.c
> +++ b/net/bluetooth/hci_event.c
> @@ -4005,8 +4005,8 @@ static const struct hci_cc {
>         HCI_CC_STATUS(HCI_OP_INQUIRY_CANCEL, hci_cc_inquiry_cancel),
>         HCI_CC_STATUS(HCI_OP_PERIODIC_INQ, hci_cc_periodic_inq),
>         HCI_CC_STATUS(HCI_OP_EXIT_PERIODIC_INQ, hci_cc_exit_periodic_inq)=
,
> -       HCI_CC_STATUS(HCI_OP_REMOTE_NAME_REQ_CANCEL,
> -                     hci_cc_remote_name_req_cancel),
> +       HCI_CC(HCI_OP_REMOTE_NAME_REQ_CANCEL,
> +                     hci_cc_remote_name_req_cancel, sizeof(struct hci_rp=
_remote_name_req_cancel)),
>         HCI_CC(HCI_OP_ROLE_DISCOVERY, hci_cc_role_discovery,
>                sizeof(struct hci_rp_role_discovery)),
>         HCI_CC(HCI_OP_READ_LINK_POLICY, hci_cc_read_link_policy,
> --
> 2.20.1
>
>


--=20
Luiz Augusto von Dentz
