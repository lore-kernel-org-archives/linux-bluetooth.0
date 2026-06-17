Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F54B3AD510
	for <linux-bluetooth@vger.kernel.org>; Wed, 17 Jun 2026 09:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781688227; cv=none; b=lmTUuoYLY+4qmhWInr0gUkenHTGSeV0GJjkTaEELBrG37nosKrAS9yMMHE8x2pnnCFsqyCDOtKvVe/9gKA4F+9vGOZmmYMOslA0z0QNR8yVyjPzWJ6n9K56QTOUpbnxRQ2Adu6WMP1PPYDnm224QPNByRuuDH6XQ2cvLr563bw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781688227; c=relaxed/simple;
	bh=/jzXzj5kl9OSHAAxQ44sAsgzPukMryR3eIcUT6hyEEI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TymiRuJxHDj2T29kyF8Nn7FBbLrfa73/dHfXoffzKFQSQEzsfesrkB+0mdmk0j+attaG01chOS4ABlcap06IWq04uhAgYRD3wsgsHrkAAt6OfPSRCZjcgZB5KnsRqvz9+3tuKcld9ih23yLCg03FpirLo0nTTsXrK+OCV6Av03Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sung-woo.kim; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sung-woo.kim
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-bf1cdcfd6deso666370366b.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 17 Jun 2026 02:23:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781688224; x=1782293024;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/+gQwJOoMqlr++NVRfL9ZMDY7vxhH1sfFQiAI4dSbrA=;
        b=GmD/7ca1U0OsDE+uqrPd9anccPynpNccpv55SrEYO7BrbCMeOIRTwkifZ4dRDpnhiq
         7bvDqC3kU8GoPp8efRkc76aSEeXQtox7MyLGAPBqWWoFqyUfFdM1nzjBfyHw/MzjQTII
         mwnfimzfH3MbH9RFcUssM3DaO0IOSsCLWUR8z62tKsNm+bBqYZTiMSDskKRMkYfKU9sr
         rnjx24PkCFMx7zKT6K44E2Z6/eWwqDi6Yev0Y3o4XEckXPSlMY5mABTUBOMwQMdHqTqu
         2nMTsZZPf9I/HYgI6SslfNu9ZHnRXTE+A+ucAmvZGdIAdW0ZVhgHXN7sL6mBHhbPzZi4
         v07Q==
X-Forwarded-Encrypted: i=1; AFNElJ9h4GVvgzXyh9wvPMnJFsEIqfu5BfJ9/gucxuJh24AGWuStYkfyqVMJbzH9UoCZjZ/Qb9RA475FIWbFWfwyC58=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxI+qWXVsBa6MCrcOeig6epLHhfcm3ICMIiijgvLOjXRAhqjeU
	Td94jxlxAW6UbIIBgDblXYzQi8jFAUjm++yUtS8Tw1ZlWdpLntGJ//TTx3cfGh2f
X-Gm-Gg: Acq92OHnhby4HJk98127/krx/F6TfXw0MfCIzlhmlqMt69aAlfivBecv8EHPvM7NGRi
	bew1IqmfdRsn12EhFzhLUUzK357oLaREaWYSFKjjoKhgJWi3r7udGx7S4bms1ad0Olz6I42kgJE
	5haCZPR2hf9+iseyRwnj/S9BWvn5gyXMCl7BiIB2nNP+WUsb7gyoCQBU2IVSuuuMOQgF3AVVit6
	MY+beSuUCYu883dq0wCo+F6xS1xIzGOXiRV+T+zj20XGt3DYb98e4zE+izKsx+WGNzCjl2VkZmK
	/Ro/t24CkcrHXK6N1UPiSKKanTRhKOYVNxBUYpF7Kn6g1t4Vz4PH96NNQW33tUY3q4JdHrkFXP9
	OaD2S9c+9UPi5/U1ifGHiCFBSdBdEMzF+bUYcsR1TxuhvoOoRYV3+5pwRCiAvPBzWJmr8nvFKaf
	ariTwFgs611oYdpYhN0cC40yS+cCFI230eYSrP9EmVH3Br
X-Received: by 2002:a17:907:db02:b0:bb8:b593:edba with SMTP id a640c23a62f3a-c05a73aef45mr226149866b.38.1781688221874;
        Wed, 17 Jun 2026 02:23:41 -0700 (PDT)
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com. [209.85.128.41])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c06079325adsm60942966b.58.2026.06.17.02.23.41
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jun 2026 02:23:41 -0700 (PDT)
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4905529b933so54798675e9.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 17 Jun 2026 02:23:41 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ/DFNq9dEAGYwB9pe77qVdqFrj/NZwgmlUSiZzcrtFFhyLuLPtfarqmhZsFI3ERjZXO3Z91tDK5AKPjR7PobDI=@vger.kernel.org
X-Received: by 2002:a05:600c:c0c8:b0:490:ba61:7981 with SMTP id
 5b1f17b1804b1-492333e2958mr41775425e9.23.1781688220892; Wed, 17 Jun 2026
 02:23:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260617035421.341457-2-iam@sung-woo.kim>
In-Reply-To: <20260617035421.341457-2-iam@sung-woo.kim>
From: Sungwoo Kim <iam@sung-woo.kim>
Date: Wed, 17 Jun 2026 05:23:24 -0400
X-Gmail-Original-Message-ID: <CAJNyHpK4rSoS9pFPY-B5w6dD0ZbW87GRYtaZ8TWgb4HKjyj4Fg@mail.gmail.com>
X-Gm-Features: AVVi8CeSjEMxjQM-b6mnhCgP9OdjLRJ24225jyJp2MlExgC9Pp0LHE8S4SFo5f8
Message-ID: <CAJNyHpK4rSoS9pFPY-B5w6dD0ZbW87GRYtaZ8TWgb4HKjyj4Fg@mail.gmail.com>
Subject: Re: [PATCH RFC] bluetooth: hci: Fix null-ptr-deref in hci_conn_timeout
To: Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Dave Tian <daveti@purdue.edu>, Luiz Augusto von Dentz <luiz.von.dentz@intel.com>, 
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 16, 2026 at 11:55=E2=80=AFPM Sungwoo Kim <iam@sung-woo.kim> wro=
te:
>
> RFC only.
>
> The hci_conn_timeout() function dereferences hdev->sent_cmd when handling
> connection timeouts. However, an HCI_EV_HARDWARE_ERROR can trigger an
> asynchronous reset sequence that sets hdev->sent_cmd to NULL via
> hci_dev_close_sync().
>
> hdev->sent_cmd is dereferenced when conn->disc_work timeout:
>
> hci_conn_timeout()
>   hci_abort_conn()
>     switch (hci_skb_event(hdev->sent_cmd)) {
>       ...
>
> However, an HCI hardware error event (HCI_EV_HARDWARE_ERROR) resets the
> hci device, setting hdev->sent_cmd =3D NULL asynchornously:
>
> hci_hardware_error_evt()
>   hci_error_reset() (async)
>     hci_dev_do_close()
>       hci_dev_close_sync()
>         hdev->sent_cmd =3D NULL;
>
> As a result, a race condition exists between conn->disc_work execution
> and the reset path, which can lead to a NULL pointer dereference when
> hci_abort_conn() accesses hdev->sent_cmd.

The Sashiko review[1] looks correct.
The race window is invalid because hci_conn_hash_flush() synchronously
disables all conn->disc_work, so hci_abort_conn() cannot execute
concurrently with hdev->sent_cmd being cleared.

[1] https://sashiko.dev/#/patchset/20260617035421.341457-2-iam%40sung-woo.k=
im

[snip]
