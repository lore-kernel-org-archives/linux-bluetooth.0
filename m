Received: from mail-yx1-f44.google.com (mail-yx1-f44.google.com [74.125.224.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D898937418A
	for <linux-bluetooth@vger.kernel.org>; Mon, 30 Mar 2026 22:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774908281; cv=pass; b=QJGU2DAitMjBRLfvgKMcDpxoQO+2kXsphXKSj8M3uzX8IB1BhNOJxPZMHcopqmC2ctIG4/j4kzBPHr/8wPapRCGdOI0jvEHp96ChZskPFhPhFBCv6YV1uKdewIss6MXda4EkQrj8CBFUi2bbR8yAPSaQ+hO8yuLgLkGb5EI2cNE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774908281; c=relaxed/simple;
	bh=xlISX+kQZRWFv6zS2RAhxsp0vieukKFMNEYF6N/zAFA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P8RtpI5U4hSzDutfuy36TVmsgZ3VevjItEzwPkQK9wHGRPqTJMgDMyKZuJPOmDdezcNyeydvV1Bn4dDfkx9vajZfhgHl7IYUj80sBPu2G5Bbw5LXX6oOOog3wE0m+ZufVI6u4xFVxW5GcJWlDkNIJ3uU0yv2z+A+Ekq80gwx/Uk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ph/jAlY7; arc=pass smtp.client-ip=74.125.224.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ph/jAlY7"
Received: by mail-yx1-f44.google.com with SMTP id 956f58d0204a3-65009bfdcfdso4834593d50.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 30 Mar 2026 15:04:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774908279; cv=none;
        d=google.com; s=arc-20240605;
        b=jYHUqJA7TZ6fBvk11fNqn70O4Ds4UeZ35IprtO71Ib0pjBRIJTZjGC9WhNYDgybmmS
         k1uFqNkyKFRKhrqcMpm1roJrSXE7DtNXFacOocvKQ8OlSVXgJptBYZmZkD0u/lem5YcK
         d0IDpsyD7sN3z7xugGcMfxuAnQjy9jlzf3/E48R0hlU54ZKNGq/YCWObbZwDGs4q5mh0
         JNMz4gtSLO7Kahv/+coo2yclyeBa7OE3TUGbU4i9cNFelqFuiyDDWjIGQbOgrYahUfhQ
         qXqJgwx8auGLMlF20iHQuKtypZfEZfZLmaHyAOvUZ7sZTzRT8ypiZY0vF5ofmh5NWELp
         0nPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=xlISX+kQZRWFv6zS2RAhxsp0vieukKFMNEYF6N/zAFA=;
        fh=/3fG1G60NkfF2vGhsZ8p+C48a9MO5n/v9GjKVohyR84=;
        b=k2IPTsJdgtEsEtyX0+xsSvPkqgn4mCgp3I3IR2ySUFDNaywoNbj29VcUpPaVMu5M+Q
         fBYKVSOh0OCXLN2sWS+TJ8ZWd76hzvPraHKTvAdTp0XD6i5STzOeBKaC/XTB4TbRBHIZ
         uqDKe62KW5wc+kiYeuEdP7vs7dVBOWsgDkxxogeenEUbKk52MbyzwIDZdkVFZ1bYxiJe
         ptn4UyQdwIRsqjMlv477GdinclgxV85f/V0C/MCgQYgTYUAHAMhMc4FogvI+EGvo7+oS
         aSfSgpAdEKZ7qimZwu75xwD2qsjF9eSLOo8hpaR2e8dDphIGAAlV9LwmC6mRXxdQ8Ln2
         Ec/Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774908279; x=1775513079; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xlISX+kQZRWFv6zS2RAhxsp0vieukKFMNEYF6N/zAFA=;
        b=Ph/jAlY75w7r5kd/NIALHOA+zkU43KGrUAE/roBtb8aBewelXJ3jkloRN/iu6Jbu2n
         GW+tXlMr+hKR3lfzTDPZAMFpq50UGachAI29VBhJkmMo1YWa3cbJrHVLZoobdYQb09dn
         EEG8Z6y8EHeBcmT13Yqy1c7A0KsKojwk4PFPsgdF1KjOmpfeVczAyu8g1TZE/n8NdKL0
         UUl8Yd60uY7oHIgs5bPXKKSrRZ12n6KdtYdPOCMrBQoMq2W5PEIp9nbT2XNNnMyB2hjC
         9o5IHJRQvOmp8Bg4Cm6CSk0lpLha0PfD+u4gk6muZYSOX0vNElirV5s+n5/Y9Y2C22k2
         mz3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774908279; x=1775513079;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xlISX+kQZRWFv6zS2RAhxsp0vieukKFMNEYF6N/zAFA=;
        b=q7PXfu8eXt4THJjGltIVUL3Evv8FtwhlLG3ED0P4V/5o9Qe5lmqJN/H39tpqbGJsod
         nD7wCn5jvdFcvFtKRsey4NTxuXCs8QNrTDjoiZV/tDCV5KJKWKFjGpAv81x3iAPLOr1t
         v4bvSdza6V3/66n9z3PO0RrfVDx2eKXyISqiZNPVzbD7K3j3Fh7tGdmlvSwY1xYTgneG
         SnCyM6GH0EQLZpBZvhoByqAVski+yfz+JiMRyjYpZAV+1NSBtcRy8PFs7jDRtKKIXwpN
         jBHAmQw7fdQ5/Rg5lHz3ZJJ2uKq5gXvH4/RecoYvM9D+jC1JwJNS6BxNs0hTreNTxGhH
         4GFw==
X-Gm-Message-State: AOJu0YypTvy+kkY21jVRiZ3mMeTg/uqQmhQFzBQH6hVQK+3rIh+wibgu
	XbhPVHIXNoKBiu3yvpzeHj+9Uk/OWl+KO/C1+eh+S1THUuWhm3IWgwwC16OgYSqasAu7y+vLU+4
	CnAozvxfMAYbFKCZ7prjY7NhPzGQ4JjI=
X-Gm-Gg: ATEYQzzDLutFdufVHQQ3U47VkCrWqqUz1wbADeytMp/V7hzh4HpxIA0DuKQJ1wASqUr
	Me8XwBco1g2FU9E9biRSYIQvo158RsfdH3UEdB7frm8DYeGPVi9WjvkV0Odb6mSKGXqRpn0C+oa
	37WWkqhjZ/we5B3j0rIY7AibaGQ+Hcn6AZ7YsEfr6nxHn7mREv8X/YBlLu5qnz7ucGuDdhu2sUl
	leEl69ARINQhx3um3MNvkCl6Uxhu+zdDg5iNzW6HE2nD7ePkapz4pS7nptd6m3IWYt99T/8I1pz
	hRbNzZwhnURhneNDDOmkS0WnI0E5d8ufVTqkH4ZhmYK/vwc4oXL8vtwjnIz8CAULu+s=
X-Received: by 2002:a53:ac96:0:b0:650:182f:7799 with SMTP id
 956f58d0204a3-650182f7ca4mr6288934d50.72.1774908278709; Mon, 30 Mar 2026
 15:04:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260328200938.140528-1-xiaoguai0992@gmail.com> <69caf23c.050a0220.1dc7f1.f386@mx.google.com>
In-Reply-To: <69caf23c.050a0220.1dc7f1.f386@mx.google.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 30 Mar 2026 18:04:27 -0400
X-Gm-Features: AQROBzAMUkI-BbbB-rnYS7Pjyh_t1qXGBQKqMqF1VFmi7VRJw9Q6L6VCq_OVYPI
Message-ID: <CABBYNZKpBJbw765md-p3wwCBVVZuxf8ieVoC_VFO8A0dKYBb-A@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: ISO: validate ISO_END fragments
To: Nathan Rebello <nathan.c.rebello@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, marcel@holtmann.org, 
	xiaoguai0992@gmail.com, kyungtae.kim@dartmouth.edu
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Mar 30, 2026 at 5:59=E2=80=AFPM Nathan Rebello
<nathan.c.rebello@gmail.com> wrote:
>
> Hi,
>
> I submitted a fix for this same issue earlier on March 28th [1], and
> have since sent a v2 addressing Luiz's feedback on the end fragment
> check [2].
>
> [1] https://lore.kernel.org/linux-bluetooth/20260328035813.296410-1-natha=
n.c.rebello@gmail.com/
> [2] https://lore.kernel.org/linux-bluetooth/20260330212129.319339-1-natha=
n.c.rebello@gmail.com/
>
> Thanks,
> Nathan Rebello

And both seem to have the same problem:

https://sashiko.dev/#/patchset/20260330212129.319339-1-nathan.c.rebello%40g=
mail.com



--=20
Luiz Augusto von Dentz
