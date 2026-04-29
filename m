Received: from mail-yx1-f41.google.com (mail-yx1-f41.google.com [74.125.224.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2545378D82
	for <linux-bluetooth@vger.kernel.org>; Wed, 29 Apr 2026 15:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777476087; cv=pass; b=snw1KFIcgBzTnAY7cn4CkP0HujLSkOzX5eD5YQzlPH6I1R3PcucVbLM9JXtAimPEYkSUIfquDLAC3Zkmbd5CPk0e3gf8yq/8M+mqwio0EZNXtrw9aq/YkKU5/2rxZPU+2luKJgYy7K41owo+nveDi1DF4dYL0LtfHEhN0kW9k/A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777476087; c=relaxed/simple;
	bh=F0LKnQYydEFVmmpjFG0F4ArdLOZrbz8l2Ink5YAL6Vo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KdJNJHfCX2AbJ2mh36HwOipCu3mc5KiwCszOIoSUaUHaKdVQYQlG1/X/DJxRdA6FsHjcrJUqzIZt+w6JlFE9/eg4p4WqrsMys2p682kgL8LxwGDqKX1keRDM2acz5SX+FTNsKiP6yEVwa4gz/xZxyZc1bC8iwXUr5GWPhe4S2es=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EHVjhNUF; arc=pass smtp.client-ip=74.125.224.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EHVjhNUF"
Received: by mail-yx1-f41.google.com with SMTP id 956f58d0204a3-6501c9903edso13276357d50.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 29 Apr 2026 08:21:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777476081; cv=none;
        d=google.com; s=arc-20240605;
        b=a5wYP08/vdFsDmzJeoVOiXIDqZLr++4fUbB287I9Q6g+ddtI8OwLVc8uUp0GiMYa6r
         krNUY75u69vmbm+gl7BeLzxw4/xgtkvqkc9CQ7MQn5id3o3o+zNoJaDMrbvGhd3fPiaL
         gbway864PLpX7erPmm5vvpOd+Ze0DrcsbCUBgHREAEQYax3pfSaVbhI/YiZbYVRsDiGC
         PCdYiPnK+1C4ESTri1vpUFnaYSF/pD3DTzHOme6ZmoK+byaaHs4dFPvJRbkKBDejKe5S
         3/XVs7tkx8jh3g44ukfMAxJmJmRe/u9BJ7CIaHzVbTE8INW4QyREYFdbX+JZoDNqLL49
         W9zQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=CYcRgbXTHmNUItUJBfcu/cdStn3hD3SAzjFhApjzb6g=;
        fh=c9TJwGERlmG/f7CwKxtFIairecNlH5y7I6qMgeGFA10=;
        b=QEX7sE/DyZagSPt7axarY21hTaGPls2FwHHb6R8FA/mrV+AsGXoRgcH8goeaf4NQ8x
         RX59kSZvVc0ssdIKrxuEiS5GONftwLVGLU7lauIZjgLyNgIoyM4HX5xqpfiwTbXUBUcl
         1EISasbqZk+XQsIwpmIQzwBxdRtWugmCi8iM2CIYzi+IdecGu9TQ0ubXBOBpbHvJwmag
         IpyBOH/PmfdWv8e4uIeCIBNTCku2g+I7mp8ZJn8PpEHv7V9ZgzLbsGNLlu8+Ch+CC1xb
         0ZW6VjnU2QkdAxtP6ehljFKiYzT0PmebQyLfM5ZndTt8SrJCAPFceR4zzGjPCTAgqGci
         vh/w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777476081; x=1778080881; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CYcRgbXTHmNUItUJBfcu/cdStn3hD3SAzjFhApjzb6g=;
        b=EHVjhNUFqW3dlEmuycVkIWpsAoxpo61CBPu7XAMnt/+xzvfg/9TQXphN0UqDm7Uhd+
         0umiRpjcWOHO4q6SZkbdJbyL9al0YMMOL9y5JIu0aIe9h3uPy6PuWLrBH5c4dleRBwsK
         39imtFLJu2x+0FhBslMA0dPZkAlNbxjdjTDqhtjVez4RPhGPhmF5VCTaI1slkCf/V8bc
         FUeU2+8Yd5/kWIicvHzK/+qiR+93+8keCedQVPL6VLrfcVagCL5s24kAI+BpQe5GgWcs
         jNhY8vnwyFsT3LYcPwwDqHXIYq5hLGtWjIOuVUMb7TWW4PvF5i8wBMA4x5ZtINDmDccs
         4fqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777476081; x=1778080881;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CYcRgbXTHmNUItUJBfcu/cdStn3hD3SAzjFhApjzb6g=;
        b=IFObQ+IT+L1TTC8vudw6oJVqcx/Naeb/1lZQsJ0KsjRXgQGoBIoIK00b+/6597OGzP
         S/FGi7TIfvF2M9mBzMyyVbHUDa2/TBstJ7tZkogNe0nT7hVbCs5XUdjh10dWCZR5Vp3/
         dD2ywIcEnOL6I4q0Ak0R0HtZd7GqKmiw8G8n2KXQCbr+RUIr7a2iEGg8Ff/MXy4o2l3q
         ZDaBtaRxQDliC0mKtwbBXNaZmuixvbIUstU2twuBRqNTieFBvuUa7d/ifWiVPJFwvgBs
         zYHBMnvenjD0C30kMMoOdwJwFl04PKyVIXnzjcjMoLLkFCZJXdoSrV9isE5tDa67FNsS
         n1Og==
X-Forwarded-Encrypted: i=1; AFNElJ+LryAEmp1lJvu33jtZw7+BIKHGqbaM1bbyKS0eYt5ZpZE69Pxxkcc+BlIKE75z0ojqB36372UsUNrjp3fGpGk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgG+TVmZTcwjHuc6LpNqcTWD+Qo3H0CSZbm0UVu4ydgXU+9+Ig
	0vrDkwN+vhlvZlXsEFOWeNjb0HnYtcTGRbRTHLDePgHxCu0YA6QveNbYmANlbgC5m7Us4xs1/gU
	RM6RpqHDtA41lThrYEpdFiWz7xP1+Tos=
X-Gm-Gg: AeBDieuzLZuKVaTBG9JhC7dK4WsgviQkpTF5x42gHaO7QCKs7tCdC+IuOmMTbaJaIvG
	Kh40QHOAE6DFWaJRhkk9OIMMBCOJFNnlW41h1D7hYR1Ntp7phk6og3YTrGZPJV24a/uWz6iivLQ
	s01Glnc9Z6b505WFS6+qIxWhmwcRKHNm0voQW4zvKlJgBqnA4234jbQeH+3RGYzUynhcegQVIg+
	mzooNDRVci+bp3paJV3bwg3odyEEt6ZK50rparIwzSYikNUtEhdjtMr4mDABKUm0fkg8yesseBQ
	/aJwIVOM3euofGEQNViXExj7LFGT8/G5aU63WbEccYwQRll9G0S+G73S46ZSQS4L9VwKUhnJ+1f
	5Brs0
X-Received: by 2002:a53:4211:0:b0:64a:cff3:8f4c with SMTP id
 956f58d0204a3-65beeecf3e9mr5086213d50.65.1777476080690; Wed, 29 Apr 2026
 08:21:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260429123802.1310681-1-shuai.zhang@oss.qualcomm.com>
In-Reply-To: <20260429123802.1310681-1-shuai.zhang@oss.qualcomm.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 29 Apr 2026 11:21:09 -0400
X-Gm-Features: AVHnY4J4oK22A47FRROvHNLoScTG-JkEQRDEopdcMvPE6dQIUXQ3j_XdrBBGTSA
Message-ID: <CABBYNZLQcTa2528KGOXHProu7E2O7WQey=i20-VLxRAG2hFvHA@mail.gmail.com>
Subject: Re: [PATCH v5] Bluetooth: hci_qca: Convert timeout from jiffies to ms
To: Shuai Zhang <shuai.zhang@oss.qualcomm.com>
Cc: Bartosz Golaszewski <brgl@kernel.org>, Marcel Holtmann <marcel@holtmann.org>, linux-arm-msm@vger.kernel.org, 
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	cheng.jiang@oss.qualcomm.com, quic_chezhou@quicinc.com, 
	wei.deng@oss.qualcomm.com, jinwang.li@oss.qualcomm.com, 
	mengshi.wu@oss.qualcomm.com, stable@vger.kernel.org, 
	Paul Menzel <pmenzel@molgen.mpg.de>, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Shuai,

On Wed, Apr 29, 2026 at 8:38=E2=80=AFAM Shuai Zhang
<shuai.zhang@oss.qualcomm.com> wrote:
>
> Since the timer uses jiffies as its unit rather than ms, the timeout valu=
e
> must be converted from ms to jiffies when configuring the timer. Otherwis=
e,
> the intended 8s timeout is incorrectly set to approximately 33s.
>
> Wake timer depends on commit c347ca17d62a
>
> Cc: stable@vger.kernel.org
> Fixes: d841502c79e3 ("Bluetooth: hci_qca: Collect controller memory dump =
during SSR")
> Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
> Acked-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> Signed-off-by: Shuai Zhang <shuai.zhang@oss.qualcomm.com>
> ---
> Changes v5:
> - add depends on commit
> - Link to v4
>   https://lore.kernel.org/all/20260327082941.1396521-1-shuai.zhang@oss.qu=
alcomm.com/
>
> Changes v4:
> - add review-by signoff
> - Link to v3
>   https://lore.kernel.org/all/20251107033924.3707495-1-quic_shuaz@quicinc=
.com/
>
> Changes v3:
> - add Fixes tag
> - Link to v2
>   https://lore.kernel.org/all/20251106140103.1406081-1-quic_shuaz@quicinc=
.com/
>
> Changes v2:
> - Split timeout conversion into a separate patch.
> - Clarified commit messages and added test case description.
> - Link to v1
>   https://lore.kernel.org/all/20251104112601.2670019-1-quic_shuaz@quicinc=
.com/
> ---
>  drivers/bluetooth/hci_qca.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
> index cd1834246..89073adec 100644
> --- a/drivers/bluetooth/hci_qca.c
> +++ b/drivers/bluetooth/hci_qca.c
> @@ -1607,7 +1607,7 @@ static void qca_wait_for_dump_collection(struct hci=
_dev *hdev)
>         struct qca_data *qca =3D hu->priv;
>
>         wait_on_bit_timeout(&qca->flags, QCA_MEMDUMP_COLLECTION,
> -                           TASK_UNINTERRUPTIBLE, MEMDUMP_TIMEOUT_MS);
> +                           TASK_UNINTERRUPTIBLE, msecs_to_jiffies(MEMDUM=
P_TIMEOUT_MS));

Well defining it as ms seems useless then, just do #define
MEMDUMP_TIMEOUT msecs_to_jiffies(<value in ms>).

>
>         clear_bit(QCA_MEMDUMP_COLLECTION, &qca->flags);
>  }
> --
> 2.34.1
>


--=20
Luiz Augusto von Dentz
