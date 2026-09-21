Received: from mail-yx2-f15.google.com (mail-yx2-f15.google.com [74.125.224.143])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9037A4A8FE9
	for <linux-bluetooth@vger.kernel.org>; Mon, 21 Sep 2026 16:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.143
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790006856; cv=pass; b=tu/9fNReC6x9zvWX3+9M9KKIRp1C/CEdpnJc2NdhtrSH3Mzwsvo8fc+kkMJE7dAOIQPWZVehYAL/Y9lvaq0c1tlDzjDjzBuHFVRBPNEtPJfFJ7iv4Ome/04R9jalMbPxpMc3HU+ipg85lyQIWmUHnHvh6cdtIIi8fA0KhNFFOo8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790006856; c=relaxed/simple;
	bh=8U+Jq8fZFahjRXhXgyhKaNh5ZHD1oQFkV3wGoE2IZY4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TlpfKv8ULqc2p6JzPUnDujXSSIJOn7bVtJC4mw4F4+iG5vlLd0h8RO9QZwbSFh0bZTzAJ2qbVwYkstqE1rFpUfjsJfDSBSO/HR8UNuOS6KbEIo81N5HXYQ+SdUlBY+2+h3908kGgSS/ZzHwEM0yUdWkW1G/uDEPw4r3DPq3SCYE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EYYfbtD3; arc=pass smtp.client-ip=74.125.224.143
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EYYfbtD3"
Received: by mail-yx2-f15.google.com with SMTP id 956f58d0204a3-66e4aae3149so2385876d50.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 21 Sep 2026 09:07:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790006854; cv=none;
        d=google.com; s=arc-20260327;
        b=n9sEFbCZMFyMjGxDmyqProGaLiXsUsifN/2ySLCtTewjSYzzDy4YlVn6G70WwESdw+
         /WNGZYUynHlHN4PNr4smDd4y6T3j9ywMZCpjumjlt7zccagyYuk2uCH9zlXQl/3sMgHu
         Flsrsz/w3Ov1AZRHP4if2Q8Tk9oYePpYMCCMpeOdhdVe1XbrNDZLYzu6U+6D87kWQ+YT
         VxJgp07mQc47RtD0921OsbJnll6L64nZrUyjpvuYKv9GWuNHiGHQxeJ6hiq2SV5h0f16
         nkNdEeT54Xm2EnOzT9xOr/+/yfaLZbcpZA//SJEVhwwLN84nfviGrAApEzTQGKq2stys
         A8KA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=8U+Jq8fZFahjRXhXgyhKaNh5ZHD1oQFkV3wGoE2IZY4=;
        fh=KizQmmCICIdbKdpymOdZ4nOlodDfWmTCFlthC04ayfQ=;
        b=fiApXcg7Wh3ciexooZ6yfSVq97lgAIh1vRpbE1y5CaOZuFeLPr1HTAUECLYOy8bxVE
         30SMHgs2fxVHx2BLuREYyoA0tP0WQHqRwOnLztEtd3oXf3vDNuTcGBNYONMt9re65OI+
         M+iKIoYqfrS5HbUPaSYUZ33faJ50WO/3fy1/qqoKS6wptNj2PAOAkKpg1QNgJbiPDvay
         EQx/0Ky0G3IHIJvVfPaN87gjjtzdvA6YNfe5Tg4V6lxMBDQbScg1FINHpFdcqcOQGrzG
         ZrP9JzWHcqkxA10ssxXb/bNBQSj7olMexJ32wNhJcklPZ8zxovdao4I5YP0RzeEuOpoA
         Hv7A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790006854; x=1790611654; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=8U+Jq8fZFahjRXhXgyhKaNh5ZHD1oQFkV3wGoE2IZY4=;
        b=EYYfbtD3dV5+SV14zeQ9Wy/nYmH+E7XWarJbDpp1vKfzNRhKOwVSMHSQXcdVznjs6T
         jQ3cLaGkrE73u8mWkO9z3injieks5goluip64oH6W3vwbKE2yY3p7VVCTfya57RnY5FW
         JHdJ9fD100Z92T4b7gGnDMM3OwB3fRL1x39IdNsql5FiWrI4BIoaF209vCuMYkmbo3d9
         GI+1CWqDJmcy7WMuUXcFrqYkPiS1jLZFsLa6lWvkJY544mFxEBpN5J6QTU4DZ9mgbbPg
         wkSVVYxwVy8J8ERcNjdtAIoJTpEdyP4Wbc9fD9UqRLdAsyMb3dSdDIORykdXhEUqfKtM
         znpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790006854; x=1790611654;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8U+Jq8fZFahjRXhXgyhKaNh5ZHD1oQFkV3wGoE2IZY4=;
        b=HwuRQcArwgke7PHP+XxPNl+telhNzkeAF730X/QcsemAyWZutt54mBVIuK4d1SAZLi
         NGkHrj2eIYVwSZWGnH/aCWsEU54uvYjY+RBCNv/kjtA/LqF3pBC8G6phTyO4rhc+Zr+2
         horqB3fqPTHaZ4i8etWkKSQkKvlrjnPFgHsld/7rLtc+U7U3KzYO7w+CUKjDEThTIVeN
         VQzyrlucxgVSYLDoD+rfNwG2B+DlPlapMUE9onxZ6xWL7HqIOSHQ94LlkqjoBAEpfwGN
         RvXGFExCCD/ZEChgFzvbfo5+Cr37ccZxYmWcU9Ypyw+WtP3s9TQ9SSF7Au9zJV9EkVAt
         hCGA==
X-Forwarded-Encrypted: i=1; AKwUvBwmhAbRkEzQXP10meBzBUxkNUwx/RKzIqsfAmV8M+5goLvXeoljGBhHyC6ogwnVDF5JIyH0EST6cAZST7kl49E=@vger.kernel.org
X-Gm-Message-State: AFuF++mFWlTdp9H/Ux5QRSCThCnLTpatBmsc+fsgwxFiUSsOOcfFzKCE
	TJaS2q+gArM90hLywbCQdXIMdN6Www2ZyrFf2SChgkwxbeufiOMs0Ukwm30z/38hyhQ8AnQX06e
	vBM5W/d3RuzJag65G1yL2/nKChrRMm1U=
X-Gm-Gg: AYBFou3jwmAq1fbrFygjE1B+L3FJbWokR2Y4L09qAqYI7mUZz8yA94zU2IHPJMk19Q4
	CfUDpnKvY9QLmtrQwivI2Mwi1MfpJIKs+WGnQT/EC9YItrkAb9WZHfVnsdQTxAodpekuq36bmDJ
	7R4XWz5W+RaeuM3CYpl2Rl4kWxQLBcRTb6vOOoy4uB4RLtRZkStYnicSE34g+v/mS61wa7Lc1Zy
	h6dsjHoNNEAq87clile8xZiyYuha4YaBDL9f1KRiPIgvAATLl/d/EpWU4Z+ytyo/SHDQSvd9SvL
	/VGZR6A5AzNSEmqvF0qx/T4tDuJItC4pxkw4WgNJbdqcnDpKWPXh2HprgJS1Q1JOofe5e4PanGl
	KG2yE/SYalZjTxulQa9EgBlGjc8wPMps8RYWyhu27hA==
X-Received: by 2002:a05:690e:128c:b0:66f:d9f8:dd29 with SMTP id
 956f58d0204a3-6717fdf95d6mr3615202d50.51.1790006854347; Mon, 21 Sep 2026
 09:07:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pm-series-6lowpan-lifecycle-82fab5876048c8c9503c-0@gmail.com>
In-Reply-To: <pm-series-6lowpan-lifecycle-82fab5876048c8c9503c-0@gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 21 Sep 2026 12:07:23 -0400
X-Gm-Features: AcwNN1WmkeWpi8m3H7d76vk_SIS_5wb-0CVhUhHUq4MeloT5gzQAsbG5yKchJ88
Message-ID: <CABBYNZK2fK_iPL3u5YC8msj853QeGgH1o2i=nPqDFKXMV9UVAw@mail.gmail.com>
Subject: Re: [PATCH 0/5] Bluetooth: 6LoWPAN lifecycle fixes
To: Cen Zhang <zzzccc427@gmail.com>
Cc: Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>, 
	Marcel Holtmann <marcel@holtmann.org>, Marco Elver <elver@google.com>, 
	Jukka Rissanen <jukka.rissanen@linux.intel.com>, linux-kernel@vger.kernel.org, 
	linux-bluetooth@vger.kernel.org, baijiaju1990@gmail.com, jjzuming@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Cen,

On Mon, Sep 21, 2026 at 11:39=E2=80=AFAM Cen Zhang <zzzccc427@gmail.com> wr=
ote:
>
> 6LoWPAN shares L2CAP channels between connection setup, published peers
> and packet transmission, while teardown also schedules asynchronous
> cleanup. These paths currently disagree on when channel ownership, peer
> visibility and module lifetime end. The resulting failures range from
> leaked or unusable connections and peers surviving disable to transmit
> use-after-free and execution of unloaded module code.
>
> This series establishes a consistent ownership and teardown order across
> those paths. Shared L2CAP and workqueue changes provide the lifetime
> guarantees needed by the following 6LoWPAN changes, which make failed set=
up
> recoverable and stop users of a peer before releasing its resources.
> Keeping the changes together avoids fixing one lifetime while shortening
> another.
>
> The timer support adds one ordered workqueue per L2CAP connection and
> serializes that connection's channel timers.
>
> Assisted-by: LLM

Something suggests none of this was tested, as IPSP was never
mentioned once in this set.

--=20
Luiz Augusto von Dentz
