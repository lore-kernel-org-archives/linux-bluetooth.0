Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C38B1C75F9
	for <linux-bluetooth@vger.kernel.org>; Sat, 22 Aug 2026 15:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787411800; cv=pass; b=VGz8V7s7h3lU3rg64cF9os8Yq6c2MMauBzNlB7Sa3f9SzUVbF0AdC+BFwUrK6arLlNmfUnOVVp43XE9l+hMAbaL5lo+eH+Qdk45IYh7VRpiE02zlDT1CcR+dKj0v2TaMVs+TXgOfj2Del1gzT8H8p04Xt2vQD2QwlkHKKDj4f/U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787411800; c=relaxed/simple;
	bh=8zNH43rr1DSYn7UO0sfax8rfxVo3/kIv7q+UAeXPF2g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VPDNRQRuZFvoaAp7piKJdonm+OoWjiB3qO5ebJA4c6M2yag3HeJcYcSNXI/8CcBLgk+SCoEWRbYevMrIfJM8Nv747QojIegxWwW8rkW1ogjfLc/Dl0wNVGFrK96lYl4hZ5NqXZf7A+YCp8BIHTfxElH6VmQLluuiZnZHCjaPAcs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pVAm84wZ; arc=pass smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pVAm84wZ"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-69fdfd98eb8so364969a12.0
        for <linux-bluetooth@vger.kernel.org>; Sat, 22 Aug 2026 08:16:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787411797; cv=none;
        d=google.com; s=arc-20260327;
        b=iGCOHHob/bCiReB9J+ifni5/fqhwBBNiZlBPHK8jdQxesRKkC4cPufCmSaSFznRFAo
         2TOe0iwhEYwtrJwTg+j63dbC9tfVCWYb0ku58lbPsbdtFMr5AWWr68itKB4dRH4/XCdE
         8ggqfpjY9d9yu8LFJFPFuY4sOhP8PpCrDHGv67d03KwIdIC4fxjoIEpLKTFDIEbMIpmm
         04gkJMLgMtRx79EVPW9+yoBHfcfCd4CcIDFKNB4rpbdDahv2zWNjnX5m/dvYWx5yWXXG
         B/Gy53wCirSOvTiitHRS9iOfTYn83UAAmaBd5CokEIWlyBGDk1IaHiLeq3DFmQw7c8Ae
         sXVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=8zNH43rr1DSYn7UO0sfax8rfxVo3/kIv7q+UAeXPF2g=;
        fh=DLGAIiZJcrjjVHxx/7oVYqQqAk3tid3Jxd7YzfOLTwE=;
        b=S+ZDLbh7amtsytI1w5PfTzEMXpDCqxhx+5OBJezKb6HjoWsDh7jsm6ju9GDkPIirSU
         JhRuQ9bHCxW+9nDlGcwx9zUmV1yYCbvq/pq+W15v//Uwij/wA2h2xAWq5/rPCxnWxUFu
         niLIUVaYNUCTM9ym5tXeN7BFwf+vcm0A8OkcS1uNzsvL2rjNyArHm2OxMIqa+W2pylMy
         zcVNtaesuiOZdoUzjEe/iKF9+59HCaXd4D69lD/v6YmKwWtgHGwzgCF1o0QNfWpUADCU
         BWAamiA2e3Qc9hUgcr8LrRLPvnC6Y9Q3iYy2LDmW4+8EL27HoLGhRmJyyaSdgVy+DNBz
         LhYQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787411797; x=1788016597; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=8zNH43rr1DSYn7UO0sfax8rfxVo3/kIv7q+UAeXPF2g=;
        b=pVAm84wZmrJwlyiX8tS5hiV+64Xg3VQ+RalyggtWA2yMrbTJhBD2lGZfiLIcb4qRJq
         QQwyHS9vVIz2aR1ZzWjug8swTtKGLWt/dloN8uMJ+vT9G5pSkstB2+aKGpcWM6CCMVVH
         sxERNyIpxxyB76VQqEMIzpU0B3peFOScatQUwU7qsYa04BB5DS8Mw3jK/G0By2sj33Lk
         rja5id5rJnlkl8ANFuOkBtDNVifpvtgM46JGBx3sGfduOwbe0Ji7takJGa4AcffTrNWg
         6mbn6/aHKexxgSk2nRjKc9KqyGftB1kcsEj4dI3wHp9R3lTeOhJ6IMM7FdRAVnaXdrTg
         txmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787411797; x=1788016597;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8zNH43rr1DSYn7UO0sfax8rfxVo3/kIv7q+UAeXPF2g=;
        b=A8IyQBbuDOKeKVMEgN3f0l16R7109YA0smYQBpefrJo51+OdVkYObTfUZr/8qOWIxO
         eEnIWrZfQRII/GuI2DhzasnDlvbW3oVNHTWFjqmUSmXW+ScssM/NqgA5zpEMGemRPWk6
         Rf+vDc4zV9ZFfNCdod0OixNxYz8SMijByX8CDIuKprcMgfNA7iwLvYNbMoke1m66fqNG
         5x3KjFFBZlZrY+j4YH5Ufkw1Yd6lLf9zG7MVDGreTh39GmEDya8iITAUeXgO5w19o4Cv
         kd9KJPsvBfnVidFeayMe30cA+KHjP535+5DlfmA+XXV2qWpQ1/r0em0+JAsFZqlVKj+R
         4QSg==
X-Forwarded-Encrypted: i=1; AHgh+RoHF2mr1VAG3PUJqJA83AxIx+5TUXVGnp0MwQd0KaIDmDINXaPe+xe233qqzePN37whMvswhmwru7UjxMr4U3s=@vger.kernel.org
X-Gm-Message-State: AFuF++nrGkeVmYgKJj/nH7Nr3NDGFfc1O1/Jds0usmtq5LSdqASkvfj1
	ew+9NvybR8fne5V6w7rVT0crz0uwqZ4CeUTs7Hn3gQtxvSUol1VpOwfWv+Lc1MdhcQ5BNrow5uw
	HKb0WyG/5OZqA5r/Lqi76a6w7+4kvDNQ=
X-Gm-Gg: AR+sD13AO61gKTZ0gZ4AwcNYRjTa41q2V19bnr00ywlNjcIYFrrdW0mSaTzWE65LeU7
	jPU1gb03t66NFZRAvs3bzzJNoRGTVlwB4B9l6KzgFvnmNbiBIiOvw6OBqGAGzKJoeQneTjwwoJ7
	BkLF4yr6G9G0xVoMI8rtk2WbIsrXJNWUBLFY6cEoFgl7TClnz5P0cSzbn3tSnfyCLqKfiBnTr4F
	xaw+pZml1hpQRXheVzBA+1TXqB66EVW1XpIWjypuXK10LZ/xWfjDCedAkRkFrFLVI7mG1cCzgPd
	4oO+mbvaieEjIy8xMJD7Fmd4SQstNEHp8hNjpEDdff6nbXw9qswBaJy5Fq0JeP9JmLOX1WjzoQ=
	=
X-Received: by 2002:a05:6402:5d0:b0:6a1:de1:f739 with SMTP id
 4fb4d7f45d1cf-6a42f21945emr8149275a12.2.1787411797281; Sat, 22 Aug 2026
 08:16:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260821174514.3034851-1-nicoyip.dev@gmail.com>
 <CAAo+4rUJomK9jJ6nHC6LU0AHiR0LhO_Wwp4-Z8iJOo=Za1JR2g@mail.gmail.com> <20260822083054.913656-1-ali@iusegentoo.com>
In-Reply-To: <20260822083054.913656-1-ali@iusegentoo.com>
From: Chengfeng Ye <nicoyip.dev@gmail.com>
Date: Sat, 22 Aug 2026 23:16:25 +0800
X-Gm-Features: AcwNN1WNrizOShYdt95GyUZ5UOsmbuiQCjNYS5AmdMYaJmyfyAXxqJ-2vGOXJh4
Message-ID: <CAAo+4rUi3o=sTx_ZjD32qYWoYm_EcFv9UZsSeCFaL=oQM6vBTQ@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: RFCOMM: serialize session teardown
To: Ali Ahmet Memis <ali@iusegentoo.com>
Cc: Pauli Virtanen <pav@iki.fi>, Marcel Holtmann <marcel@holtmann.org>, 
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>, Kees Cook <kees@kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
	Pengpeng Hou <pengpeng@iscas.ac.cn>, Jiale Yao <yaojiale02@163.com>, 
	SeungJu Cheon <suunj1331@gmail.com>, Tim Bird <tim.bird@sony.com>, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi all,

Thanks for your review and feedback, the v2 is just sent:
https://lore.kernel.org/linux-bluetooth/20260822150619.3684599-1-nicoyip.de=
v@gmail.com/T/#u

On Sat, Aug 22, 2026 at 4:31=E2=80=AFPM Ali Ahmet Memis <ali@iusegentoo.com=
> wrote:
> rfcomm_security_cfm() -> rfcomm_session_get() is the one I'd worry about.
> It runs from the hci_cb callback with only hci_cb_list_lock held, while
> krfcommd can free the same session under rfcomm_mutex. I haven't tried to
> reproduce that one.

You are right on that, actually I have a reproducer for that UAF and
just have not yet been able to send a patch for it as I am afraid
sending too many patches in a short period will introduce a high
review workload. That one is a real security issue as it can be
reachable from unprivileged users, as it is now raised in the public
maillist, I will send a patch for it soon.

Best regards,
Chengfeng
