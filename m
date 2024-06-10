Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96D7B15219B
	for <linux-bluetooth@vger.kernel.org>; Mon, 10 Jun 2024 23:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718063553; cv=none; b=df3cB/LBEjSwvZxRDettsymaeFdTh3iHlvNMSuGasx7wtvJgbkDaHc2v6AibKPuKcmYqkoEJKFAhklkm6PLwbS7+yLLMIyNSYLbpSvPAECrReU1Aw2SzTEwK2lysyzx1HzPjNnHi1+PCu4xUkhJ69Mue0iYrtpBYuquA3UEzWoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718063553; c=relaxed/simple;
	bh=yhoEmJg27/Tq8Hg3TZJQhkLMO/opRq6IHsJgd01KjZk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Qlv1WEPkySDg6iFXFZRv2wjqIH6yXOt+crS88oaIV2b7xwmbvwIa/ZbyT7C74DebwmXB76UL5qpjnJn0kn9G+4hlE7NXWvTyxF9t9PBvzSNsKR8tqERMVW9GfqSDn5UHCP9PUG8842PV1e30Rm+Czh/63ZdQ8t5JMJ7C9SryDeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=WmVwVdni; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="WmVwVdni"
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-62a0809c805so50384827b3.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 10 Jun 2024 16:52:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1718063549; x=1718668349; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yI7oeA4ugo7i1lcCgMOoLmqHrdLmEsXBFh/0GoJ3ACI=;
        b=WmVwVdnipZpHlvS7riXFMqBE6Do2jNis2xcyFz+ruKmYrUhpbha0UW+alxhvxLE+o4
         jircyJS0iN9SBtxld55r3L1N0cyjOweNb01Ipj6H4kxMglh3wzVHrDxw3A/w+9ZRTf9k
         2GpGXlVXq9cq/of1jFmW4i7rk69dz0+4GmtQk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718063549; x=1718668349;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yI7oeA4ugo7i1lcCgMOoLmqHrdLmEsXBFh/0GoJ3ACI=;
        b=ESb5TroiqApWcbQWjsIlMD1bBemRjy5f7Fp/420tL1iINoFBMwJvklpU+pFUcnoj06
         y3Nf/V7G/gtTLYlIiiCS6Y+St+IzYKd5GLrlqMlqoIFM7+dXxecfakoiZoJzaeS9jg3e
         TA+6ax4B62E0S/yUoSYRxAUnYu3RbgHuFfl94FmwIn9AfZhYKVpBtr0dT33HziqtYD44
         JEiH3mgXwGCgbhSmD5UZknn1zmKxI3HLASf82qJWTtl8L+s4QoLtSoxHWC7pMD2gp5JD
         TpDjOg9LvhqcHmNlKM3VOyvY3SJATuflQYW+wA5gUvBPqQNIh81oAAUgZNJ/KTvzX/nm
         3S2Q==
X-Forwarded-Encrypted: i=1; AJvYcCUsI+o4TkMWUMAQVqfiGc6WnEAgE4Rsluu5dUDwMmxerunAlZG3a4bdJCU9I0PIQC7tOJhJaG9YPJTniYvUIGFDYSFYH5A4FQab0jv3YQZw
X-Gm-Message-State: AOJu0Yy3yM5YP8KPJRkPbW0DgoYla83xu3xtW3OsIOLBy5LiByLlQ3MZ
	cdAN4MnCZ1OVLrF+HSo8+sdp+7nJEyWsktj/aopJDn1AdJLmHAjjTh3YHYJBSYcUSQ89rdnbwqw
	=
X-Google-Smtp-Source: AGHT+IGCQ3YqBTfgZDCAQFpovXS6ECQ9BJ74ZdpBe36Oet9qKbc4qZDPxj211AB+OkUCg5uYwsYGxQ==
X-Received: by 2002:a81:6e85:0:b0:62c:e74d:8152 with SMTP id 00721157ae682-62ce74d8337mr74899617b3.19.1718063548720;
        Mon, 10 Jun 2024 16:52:28 -0700 (PDT)
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com. [209.85.160.175])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b086017a53sm8734106d6.57.2024.06.10.16.52.27
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Jun 2024 16:52:28 -0700 (PDT)
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-4405cf01a7fso88721cf.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 10 Jun 2024 16:52:27 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXkTz0qY3QXFTiWTHTPYVn72h9RecWgJ9QfssxE09BjNsetHHPkp+Z+uV9t1dqlOqUb/0PxN99YAwRWCl6PISQbxhmxNC/ajpX1ZBYiGOhB
X-Received: by 2002:a05:622a:5b09:b0:441:4920:1fc4 with SMTP id
 d75a77b69052e-44149202169mr577491cf.28.1718063547155; Mon, 10 Jun 2024
 16:52:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240517170246.1.Ia769fe5fbeaa6aca2edfb01b82eb7df0c6955459@changeid>
In-Reply-To: <20240517170246.1.Ia769fe5fbeaa6aca2edfb01b82eb7df0c6955459@changeid>
From: Doug Anderson <dianders@chromium.org>
Date: Mon, 10 Jun 2024 16:52:10 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Wd4UdjGdFODGCa4acviQG2V_YuM9J8oxi8A--ZmseNUA@mail.gmail.com>
Message-ID: <CAD=FV=Wd4UdjGdFODGCa4acviQG2V_YuM9J8oxi8A--ZmseNUA@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: qca: If memdump doesn't work, re-enable IBS
To: Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Stephen Boyd <swboyd@chromium.org>, Guenter Roeck <groeck@chromium.org>, 
	Johan Hovold <johan+linaro@kernel.org>, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, 
	Sai Teja Aluvala <quic_saluvala@quicinc.com>, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, May 17, 2024 at 5:03=E2=80=AFPM Douglas Anderson <dianders@chromium=
.org> wrote:
>
> On systems in the field, we are seeing this sometimes in the kernel logs:
>   Bluetooth: qca_controller_memdump() hci0: hci_devcd_init Return:-95
>
> This means that _something_ decided that it wanted to get a memdump
> but then hci_devcd_init() returned -EOPNOTSUPP (AKA -95).
>
> The cleanup code in qca_controller_memdump() when we get back an error
> from hci_devcd_init() undoes most things but forgets to clear
> QCA_IBS_DISABLED. One side effect of this is that, during the next
> suspend, qca_suspend() will always get a timeout.
>
> Let's fix it so that we clear the bit.
>
> Fixes: 06d3fdfcdf5c ("Bluetooth: hci_qca: Add qcom devcoredump support")
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
> I'm nowhere near an expert on this code so please give extra eyes on
> this patch. I also have no idea how to reproduce the problem nor even
> how to trigger a memdump to test it. I'd love any advice that folks
> could give. ;-)
>
>  drivers/bluetooth/hci_qca.c | 1 +
>  1 file changed, 1 insertion(+)

Totally fine if you just need more time, but I wanted to follow up and
check to see if there is anything you need me to do to help move this
patch forward. If not, I'll snooze this patch and check up on it again
sometime around the end of July.


Thanks!

-Doug
