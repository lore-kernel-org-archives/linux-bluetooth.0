Received: from mail-yx1-f46.google.com (mail-yx1-f46.google.com [74.125.224.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67CAF2FF65F
	for <linux-bluetooth@vger.kernel.org>; Wed, 10 Jun 2026 14:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781103170; cv=pass; b=TLJKTA2uuv5BeYWoxaPJ98wSyQBepdxUEyqfmfqRYmxACC5OkBxlVbKw7yk0Gy9RCfUuyGc6kPwQXab27Cn6R72USODFH4kfC5wRYWQhC/CuyEXWrCMJzyvdD/9jFucgY3776v9NMAtZuVGgKn0bSqtdkSmGQ4HVY7P2Pw9aN7E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781103170; c=relaxed/simple;
	bh=VVrLSiLJS5gidFt8B0bBQUfCsAheLUfwx3dR00dmFew=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c4wBZ13xmMl1dxOuXXs5sQjqSwW8sbTjrPBjYUBN1ECHOrEIuqy1p+/cZo61une3cmbQ8MEyZ0AwiJZKzD6p1Eia+ONZPGD7X1KA4pG/uVCqE6JEspQIBbexsCTiadIpBGQs6b28rL5hlWF1dMqVBSMC+VCpR/BHB1y7UPWC+k8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DlLbyFS2; arc=pass smtp.client-ip=74.125.224.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DlLbyFS2"
Received: by mail-yx1-f46.google.com with SMTP id 956f58d0204a3-660e9fef1d4so7773909d50.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 10 Jun 2026 07:52:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781103168; cv=none;
        d=google.com; s=arc-20240605;
        b=SWPzfpsxpe8KC+pWAiV1Wg5VJeXOVVQC2EZIhQFMBe/pdIo3Xfq8yYqq6i1j7NJhBR
         lBMlXMA/cypAQN2cGRAS1xSX5uiD0QpGIcglGi6OzSwopV7Cw7OluSRvykpUpzgXfrOg
         ajExZONz2Ot7mqPqKU825iIoKyVFXCYEZOdzDPxj0Ia2hpeREQiVaYlWXKYLWDSQCRT4
         IJm4/6IkRAC+z0Ai6r5EeHeAo3RSUj1FaUCtfa0+5BvheuTcNjepJCY5Hw7TNbUrKk6Y
         +jYIe63jdF4nTPiKsjk5ULFaiTFyyK3MuCKLWnz6b2zPM3UFGJAyTZKhh1BM16n7V7xp
         AsDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=SKmCbASdw/dqOVGouUV0C5jLhuqcWtSibWaL4jmWJHo=;
        fh=M/423zGF/Zfubyz5ph9CQ5QUH7qPGwPBRSs4PfGgs1Y=;
        b=AAfk1FnwNUlluEGu2jwQmBPDD4JaRcbqMgU33WkQz4+EkjdqBQVpRAdtaSiu+KJeYZ
         BOEeu+Y9uvyLSEmCFC1UVULGPtxqXNZBY0EReQ/Oeweo242B8UokKfVhGEDvUclvILUq
         wkm3QE5FXg5nERcJB/kezPpu2WZNE+8E2m2pzk2kVth/B3LvAcarmV7VuTUfjozPg2Oa
         blnAE+HQe/DYF5EiBusyKby4284S0GzHfspEdE5ZJXEaJHxwfUUcKpDYc93MD3MuzEMz
         xTsgE78HppBWJyALHS0lKjpZxr9RXjknPhBy8vHL8LzsZet1B04bS6jIRbGoSKGF2c+s
         GCmQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781103168; x=1781707968; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SKmCbASdw/dqOVGouUV0C5jLhuqcWtSibWaL4jmWJHo=;
        b=DlLbyFS2aqPCsXRVtYwArq5qPGBOoIcQoZUatdGs5YAnJVntQF7/uHq/eWLJ6pGM1v
         FoQU26RtvZ5idSDDB5p/hZb7X5gTJF7jExP4xR2asdHq61Ri+m4+/xfelPL1+XKD5RAv
         nHnblcGSSgJWaJJYkVjq+UScmXSXxyb4wphBQvZdx5JKegKUapIY9ySrFatIeqxCB1W6
         8JeCNe4v/n0orEySZhOnMeFCPvUduLA5xUloKFViVe9O+wxi2OAMjDjLZmNe9mw98VBY
         lUy+UvTF3/HCtaKHpdcS0J9O+lMr4GTbRwN1ctMGUnuKq58wEYz+n4U6u7R5oCtdqb6a
         RazQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781103168; x=1781707968;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SKmCbASdw/dqOVGouUV0C5jLhuqcWtSibWaL4jmWJHo=;
        b=RfporGIZVgPnIDar0qgCR5CmrhxDttDZ69nnp7siWfEFTEnFsji5yEACBtRkYwrW5n
         r7VysidFLFkK2im0Lv4biQTMXvuL9iBcQpoScnnGcknUu/gCobuHrTQd5kPXN29Zkwy8
         x40xxXx+kqhRfuX1wOcICaZnuKIM1Gnr5daEtNHnOtP9maSktDdiOTihpYmv/SOUec9P
         sVN71Y6AgZzKpPw88DBE92Q8/aoefXqBVyldkPzGp1yPQuiauqf1UA99C3J7J2wFnPTA
         4C93Ub75a7lEiJke3nBpv808e/w/ErM7xq/F+xOzv2zGLC5mHcnBfCY2RIHuyoVuPBxH
         CqQg==
X-Gm-Message-State: AOJu0Yxy7Yz5Y70Ss/0hW9P5kEtr1BKa2h8fKzKAs67FcAP1IRtZg1Qy
	RjcHYypogWuEIeXC/DNg/vtT4yUdDcbm0TG+kTv2+66OxRfHCFO5KGMPwa+HrkW7bzc4DoB42X5
	Oyep/Fk0FOTY+Z2AZrIExHN/Up84D51Jkq3VjH88=
X-Gm-Gg: Acq92OHbUnlp11y9R1ocrfHVEsNAyIubdbSxsY0GE51ZbTqiyNmIBD0H7VqKgqRN/5x
	exxXZFbHMQq/XZYdutoL7k8xEGYLlWWIYhUzypznjISphatleUzIMxljaqNbp/Qnh4l5RHA6F1i
	QtNqOuGehFvBamL5drHKN/WZiTUPWOCd83oH9IJf3NLvy5zh6KPcnO2+yOG3d4dky7AevlWe0lF
	6rIvsi3MWTLfybmE9GoXssWEqROfxMYf0915sl10pvK0jPBzeQYj28DwMQqqwRKNTB8WG4Tt8l8
	PxTg+PY70X+SuJPnTyPE2e0sC46eidDJh1hKloupsr9bo9TALfpC6ZxP07/hcTMkApr1nqmJOFv
	P1C6a
X-Received: by 2002:a05:690e:b85:b0:661:80f:5984 with SMTP id
 956f58d0204a3-661080f6b86mr21898006d50.12.1781103167976; Wed, 10 Jun 2026
 07:52:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260603075134.246832-1-jaggyaur@gmail.com>
In-Reply-To: <20260603075134.246832-1-jaggyaur@gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 10 Jun 2026 10:52:37 -0400
X-Gm-Features: AVVi8Ce1d8xvS2VznkpY9NsD-XQb4A8j44uPzvJSGTowxh0wpuRiDp1Zzbdsjdk
Message-ID: <CABBYNZJs7w=t6uj6GRy-GjrOcMwCTvCehz-DShUf5autxMKZkA@mail.gmail.com>
Subject: Re: [PATCH v3] Bluetooth: Fix Use-After-Free in hci_unregister_dev
To: Jordan Walters <jaggyaur@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jordan,

On Wed, Jun 3, 2026 at 4:09=E2=80=AFAM Jordan Walters <jaggyaur@gmail.com> =
wrote:
>
> The hci_unregister_dev() function fails to safely cancel the cmd_timer
> and ncmd_timer before freeing the hci_dev structure. If an asynchronous
> event or timeout occurs during device teardown, the timer callbacks
> may execute after the device has been freed, leading to a KASAN
> slab-use-after-free panic.
>
> This patch adds cancel_delayed_work_sync() calls at the end of
> hci_unregister_dev() after all teardown procedures have completed.
> This ensures the timers are fully flushed before the struct is freed,
> preventing any use-after-free conditions.
>
> Signed-off-by: Jordan Walters <jaggyaur@gmail.com>
> ---
>  net/bluetooth/hci_core.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> index 28d7929dc59..3db1b3738b5 100644
> --- a/net/bluetooth/hci_core.c
> +++ b/net/bluetooth/hci_core.c
> @@ -2698,6 +2698,9 @@ void hci_unregister_dev(struct hci_dev *hdev)
>                 rfkill_unregister(hdev->rfkill);
>                 rfkill_destroy(hdev->rfkill);
>         }
>
>         device_del(&hdev->dev);
> +
> +       cancel_delayed_work_sync(&hdev->cmd_timer);
> +       cancel_delayed_work_sync(&hdev->ncmd_timer);
> +
>         /* Actual cleanup is deferred until hci_release_dev(). */
>         hci_dev_put(hdev);
>  }

I'm not sure what's happening, but I cannot apply this change with
`git am`. Also, why did you revert to using `cancel` instead of
`disable`?

--=20
Luiz Augusto von Dentz
