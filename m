Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23FF42F5A2D
	for <linux-bluetooth@vger.kernel.org>; Tue, 27 Jan 2026 10:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769508921; cv=none; b=Sth9lFVWMgcMcvVBxHej4Vr0DUHqsQEkUJWtM3v6GcBEYJQB6li1RHdYedNbLsEY89cK9t+JoHV9PzQscmA48S9tD2jRyZOjo5mu/D2Bx8hhSgXrHr4eozEZYne4kFT63Ol01bL+q14Dxho49f4kC6kpebtfDqf7oD5T8pAJVmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769508921; c=relaxed/simple;
	bh=bQ3xaa51ZQdVxNW+sMkb28nQ+48svHKlV0RBkNj8eKs=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MEVHJm/O3LaQo9ggrZH7Rjnu+u1zzg25cBKe6ZlAOikjcj+2KoKfbaiQ758bOkR/+YHoWmEXmCh8Msq1YAI8OWaKM8kSnm24dmxXXowYUqgSLCRtMaBvCsrYqKW+T+zFJ0N+Nz8qJkwYHyyeshumE80kOm840QHXZnkEvwuizME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OH13AhpE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OH13AhpE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD0BDC2BCB0
	for <linux-bluetooth@vger.kernel.org>; Tue, 27 Jan 2026 10:15:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769508920;
	bh=bQ3xaa51ZQdVxNW+sMkb28nQ+48svHKlV0RBkNj8eKs=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc:From;
	b=OH13AhpETYi4yE15YbaZf3ow/tdCBuLfFfyMtLcXTmTJ9gZXZY8AKjtph8RfJ40WF
	 VdxzlbNqtLWTSLzimgxIigFMlS6yzkkV9e8nA5LUg3wL0CUQ27AZVQFcB+ofpZ66gm
	 61/K52en3F3LOqNrXVGkNX85CvGm6wMwJkU30aZGJhmp4jSsMOgZZ3xMohpgczyVa+
	 nydMSNHC4KDMpGYAy7sKNwizOX5+SA5qGEN65qWNwc7P//R5+nWBQ1lqlEaXtEeeAE
	 MBYMXwrsNgOA1whTwy4BqoFpcg5NJBaIeFrFgQNp/ra+2hTdvlzzH8hyzLWpwfwIJh
	 NheyxYAzVziMw==
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-59ddf02b00aso5898819e87.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 27 Jan 2026 02:15:20 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV9DnvAsKnClEnoGGjKLroWHZqc4IEiyI+AWHbQbaahNnMLS+uWoUWRpyC9/YIZKNEWHHrPuk3PjZQk+ETRVmk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrkaqC1F/tNFGQW7uluV4LfAPdEQY9/xfugvzJyprvy8gyO1g2
	6VK+6B1AV6gl1/XI3ajgFhcg5oDGPdeLYK5etfLE1aSy4hrp2vMyTJlAGNtR+i/UJSO7r+KbWSw
	an9MTvc6JgEWPX8rhAUE+J6enaqn7+6J0ODoxgs648A==
X-Received: by 2002:a05:6512:3b90:b0:59b:6d49:233f with SMTP id
 2adb3069b0e04-59e0412d009mr560326e87.31.1769508919455; Tue, 27 Jan 2026
 02:15:19 -0800 (PST)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 27 Jan 2026 02:15:18 -0800
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 27 Jan 2026 02:15:18 -0800
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <20260127025423.1418207-2-mengshi.wu@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260127025423.1418207-1-mengshi.wu@oss.qualcomm.com> <20260127025423.1418207-2-mengshi.wu@oss.qualcomm.com>
Date: Tue, 27 Jan 2026 02:15:18 -0800
X-Gmail-Original-Message-ID: <CAMRc=MeZ49wU+FsQQS8S58N4gObEWhtEqvfo91tpxdY7mmh9pQ@mail.gmail.com>
X-Gm-Features: AZwV_Qj4SzOnq8ZA0FvuOvcJPHa2wbB2nzhgeIGsc7TxA6Xd59iy_PV-jMlz96c
Message-ID: <CAMRc=MeZ49wU+FsQQS8S58N4gObEWhtEqvfo91tpxdY7mmh9pQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] Bluetooth: hci_qca: Refactor HFP hardware offload
 capability handling
To: Mengshi Wu <mengshi.wu@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, shuai.zhang@oss.qualcomm.com, 
	cheng.jiang@oss.qualcomm.com, chezhou@qti.qualcomm.com, 
	wei.deng@oss.qualcomm.com, yiboz@qti.qualcomm.com, 
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, Bartosz Golaszewski <brgl@kernel.org>, 
	Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 27 Jan 2026 03:54:22 +0100, Mengshi Wu
<mengshi.wu@oss.qualcomm.com> said:
> Replace SoC-specific check with capability-based approach for HFP
> hardware offload configuration. Add QCA_CAP_HFP_HW_OFFLOAD capability
> flag and support_hfp_hw_offload field to qca_serdev structure. Add
> QCA_CAP_HFP_HW_OFFLOAD capability flag to QCA2066 device data
> structures.
>
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> Signed-off-by: Mengshi Wu <mengshi.wu@oss.qualcomm.com>
> ---

Acked-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
