Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6423A3E49E
	for <linux-bluetooth@vger.kernel.org>; Fri, 11 Oct 2024 16:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728665125; cv=none; b=secWs7UidNZQN79YFvFma5I4WdIjt/i3My2//XP/VLhWIN5DsRGraLys08JNq2bopcqPMLbPEFTggPsczjJTAd7bVfZ/N1uUku6jP34CffawHB9JQDPdewj6UDcgz5x0Trt3OFgmWvyoNVnLFIhvUqxBr3/iFq354d09viP6Dko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728665125; c=relaxed/simple;
	bh=7j5povKNWGZPOiYZaZi02MTnZjk/9eTnbUPfTSf4A6I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AUI5u2Qz0F6b6tYF1OesqHubtujhdsLueNh6pq4Z5ethinmIdCgYxqdYsmBt4k59suwhdxdmcrRogx9kpxC69yorDnxIvbEUtJyOQAacFwS945n3axqSRdpWwzFixDZwNsXFq0HF9PX3NyCZZapMQXB5XLifZQYUjlPTx12X4Xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L8nnUHcZ; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L8nnUHcZ"
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2f7657f9f62so22238241fa.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 11 Oct 2024 09:45:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728665121; x=1729269921; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8Fk2s6DcAEibYx0ZvgptcwuJtMXp3usvNvik9kfBwHk=;
        b=L8nnUHcZPUdolMbns+aKEgqmjshxcJaprcvPtZF0qc/XSdnNnw2zMY93UHuxOlpZGf
         11BraNyTeC4rEGkD6XmY55ZjfUB0NnUe5fjMahqofjsy7cBhh1zNUxFSuiNfae8VOMNl
         EQo34tOlsw84aQxn2t1PKzkwOM8PGYMcgIMnn81WJnsDITKwqlIqxeWewneLvUPoPj2c
         enCBgCaWvd/FmdNd0uv08res6UI9xrOFgLt5AF2acEiaI+ssoUikmjOt3RZt4twX36Uc
         DMC6Alrr18WETdxjspD4fHqRVCAQgNUcc+maEeobTsqyQDI2oQYMldUnL4Na5FO24QuK
         Ul1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728665121; x=1729269921;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8Fk2s6DcAEibYx0ZvgptcwuJtMXp3usvNvik9kfBwHk=;
        b=Ug9a7B/xNoHAXJxfgQiSBtrgrySDT/bRdcEfY689HUOTrqR1+eUdr5hrFG0jhdRgDs
         PbivZ5jriZWSvajuT6Bu5FfQyyVWNBAH5YN4vR2F5+psGDVAy4M8Vm2N7zdc5h4oTdDz
         4GTlSFvK4obhjbpAO/n/t8tibrK07pt7oDJSKXdglyj8cKUPjA8X+mBj5nD+9oAoTxku
         DpP/qXtROPReuSLpTUjL0bI3qdQFELugKZ3z8WAaR+SzYWADXXpqFYy2AvRMO4aASEHA
         w5TML/s8TiyQXaHnTRchiZOU6D7rG8BYLzYPo5tkCNgPX7z3AE08mUjPemZSIhUKbqB7
         3oTg==
X-Gm-Message-State: AOJu0YyLCleN44zawZf6eKIb2KBT2ElbGk8k2SMgD7dr6SIPJSkSTriJ
	/H9CGXXctom3C8VzYtCNOsQrklGTGiEQP01Ai7Fs0rL0OOYf3HxfDJezYOK6+WuSX3gph76GWEb
	0YHWUaQCzbwFXSWufwGpQsS0JaybUvaq5
X-Google-Smtp-Source: AGHT+IGE3mPXXBcFVXOHJye/xdQMMHUa6HhgTsKitPG9HkiBXrk/ssyHyOcvSq6XQfIhpIAthjydlnojWZx7JYH5slk=
X-Received: by 2002:a05:651c:210e:b0:2ef:296d:1dd5 with SMTP id
 38308e7fff4ca-2fb325bbc04mr17628331fa.0.1728665121302; Fri, 11 Oct 2024
 09:45:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <a1062c42-9e58-465b-ba27-079d3c18af11@quicinc.com>
In-Reply-To: <a1062c42-9e58-465b-ba27-079d3c18af11@quicinc.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Fri, 11 Oct 2024 12:45:08 -0400
Message-ID: <CABBYNZKCg0P2=ZZmtqitDoeyhtQKHj5UHf4NEysz2S+=b9kRBw@mail.gmail.com>
Subject: Re: AVDTP connection timer is not allowing to wait for send
 setconfiguration error code response
To: Raghavender Reddy Bujala <quic_rbujala@quicinc.com>
Cc: linux-bluetooth@vger.kernel.org, 
	=?UTF-8?B?RnLDqWTDqXJpYyBEYW5pcw==?= <frederic.danis@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Frederic,

On Fri, Oct 11, 2024 at 5:16=E2=80=AFAM Raghavender Reddy Bujala
<quic_rbujala@quicinc.com> wrote:
>
> Hi,
>
> We are trying to verify the below PTS usecase, where remote initiates
> the connection and sends AVDTP setconfiguration with unknown sampling
> frequency.
>
> PTS case: A2DP/SNK/AVP/BI-03-C
>
> Description:
> Verify that the SNK IUT, acting as an AVDTP Acceptor, returns error
> codes when the Lower Tester, acting as an A2DP SRC and an AVDTP INT,
> configures a stream using an invalid configuration
> (INVALID_SAMPLING_FREQUENCY).
>
> (TSPC_A2DP_15b_1 AND (TSPC_A2DP_5_6 OR TSPC_A2DP_5_4 OR TSPC_A2DP_5_1))
> OR TSPC_ALL
>
>
>
> User prompt:
> Please prepare the IUT to reject an AVDTP SET CONFIGURATION command with
> error code INVALID_SAMPLING_FREQUENCY,
>
> then press 'OK 'to continue."
>
>
> Results:
>
> Expectation: DUT needs to reject the setconfiguration with invalid
> sampling frequency error code.
>
> Behavior: When PTS asks for user prompt to prepare and press ok to
> continue. it is failing, because in bluez there is a 1 second timer for
> connection. this timer is getting expired and avdtp signalling(DISCOVER
> procedure) starting again from dut.
>
> diconnect timer source link:
> https://github.com/bluez/bluez/blob/5.65/profiles/audio/avdtp.c#L1202
>
> due to this behaviour we were unable to send setconfiguration with
> invalid sampling frequency error code from dut.
>
> Is there any workaround for this to fix?

git log to the rescue:

commit fb681e795027edb3e995e2c75657ebab0360a299
Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
Date:   Fri Dec 8 11:17:11 2023 +0100

    tools: avtest: Add reject-code option

    Some PTS tests like A2DP/SNK/AVP/BI-03-C, A2DP/SNK/AVP/BI-08-C , =E2=80=
=A6
    request some specific rejection code to pass.
    This commit adds an option to specify the rejection code during
    AVDTP_SET_CONFIGURATION rejection.

    E.g. "avtest --reject setconf --reject-code 195" to reject setconf with
    INVALID_SAMPLING_FREQUENCY code.

Yeah, we need to put together these instructions into a proper
documentation, which is why I was asking companies to collaborate:

https://github.com/orgs/bluez/discussions/817

> Bluez version: 5.65
> pulseaudio version: 15.0
> kernel version: 6.6.38
>
> Note: We are observing avdtp connection failure with iphone due to this
> timer sometimes.
>
>
> Thanks & Regards,
> Raghavender
>
>
>
>
>


--=20
Luiz Augusto von Dentz
