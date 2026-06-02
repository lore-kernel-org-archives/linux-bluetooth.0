Received: from mail-yx1-f52.google.com (mail-yx1-f52.google.com [74.125.224.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2FD435F5E4
	for <linux-bluetooth@vger.kernel.org>; Tue,  2 Jun 2026 14:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780412016; cv=pass; b=aJW1nuADpcW+mj72+beq7bqoz/ImErQAelINkJUJ+qPC8b236zJ/3Ckrm0y2cqs2YcSgh3vpFSAI/jdZZ2bV6LZ92dg70PMjUwqB5InqDSZ6fErJDT3PNfJIBmTbp6vHf12cMHifJU1NAORt8ssAediRMqW/MQEcig3OU61GkLQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780412016; c=relaxed/simple;
	bh=KMvIilH1OsxMCdPP2Y5v6Fcvgg7lO8kUQPohX00mIVI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=giWOlPfOJTHWcx7M/69nY27eTwMixs9RH4z9t81a9G0tbVJtntVSa64xDbkRyLWdWGwOClT9VC0CFzL6VR9Ng83iy8P0BuAhxs5CeODQRNYk30/y2PaYm/WTipxSk0g0/Xk/+pYH/N/dTOmzkkl3aUS6OnpZ+QcluC1k5FInPvc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EZWdDA06; arc=pass smtp.client-ip=74.125.224.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EZWdDA06"
Received: by mail-yx1-f52.google.com with SMTP id 956f58d0204a3-66049669d78so4472936d50.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 02 Jun 2026 07:53:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780412014; cv=none;
        d=google.com; s=arc-20240605;
        b=Ias5Dn9SZ8FkN6MOjno5t90nr+KFRV9dMD1+2OnwtO3lDxW5QljyIkjl2g2jRUr3E2
         c6FAGSbBMu1Dt7piBQd8Wcetos1r+A1B+igGjuQp+kuOtsJubZfvZ2thWpaQO2/913dT
         qVxQZYmuNU05/usECk4PAWonO1i71IrY9OqMQ2/iL+5XM6sbHEtvMzQFLpwc52k7i7Cy
         x46LGyfcLYd7g90sTSOeBF9lzuhyIK87HQkZA9+WjuJ7xOJybm0biHjX6B8o/dCVePIr
         GXWZB0HSmYBtZynt2lFd+KXz8FLXXlm9nUIy07xArd0y1o6kmBl1zlnJlaQxP2nrmGnz
         WnKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=o52YDU89DCmOeenerzA77YRbefFJjXMTgmHyjwDrmKs=;
        fh=ZFlyP5+YKgJkmoBW5+QP1miOu0vNYasz89rr0yCZ/+4=;
        b=VbJJIE9xoBJdSjPQBqgiDf8U02TP1mZgjhIMA+e15K4jogfF6IO9lImP5UFdix2aMY
         bbhinMzY0u54p8FQH5onpVmlRYei3EUnWs5sGLNQ29ElvzMQ2IrJG3x1SA4aNil58T8/
         KRs+I5FFHDtWDdddx0c80TPN63CMjhLajAkHspgnUifVPVYNlCwhludwXPHGV9WnozaL
         K3mlCt6OsvxEY9XmCJhTJP5sLCUQh9r/UB8nXxeAogeb5EpVNjKg0w6eofdquYZN7CpD
         i4ZkH80B3A3GXrH/8w2st39jes9aKVnDd59oM9PH96E8xABxT8SRSL1MsNYSB3hsjEdh
         YlgQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780412014; x=1781016814; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o52YDU89DCmOeenerzA77YRbefFJjXMTgmHyjwDrmKs=;
        b=EZWdDA06ViNXd9Pe6kysS0HXPIXT+q+Y8Qsm8nlqi8+hB/eajCULKbd0/EMTsWfllA
         Qgv5Vs+1qiPAYDZlcXMnOQmpLO/8e7BLhNAbi/on6JIiB93IbnJURGUVZKfu32icYwJh
         1CekIkYZt7F7/54BEw6qx1ra+q/M/IsjrNLs/konRzK7GCWz80DSPe54VM6zk1I28nrO
         TeWBe1vKu3Kaov99Sk8Ix3M9MTkdI0e94ZjdxJA2828QBLhbYHnrboVwhBK2iedod2py
         3HbHAr8zvtyCQYcgiax2QKUL0W2qeQ5PDkv4V3Lm2rMW6UhmZk9CC8E8zYGw49FwSeai
         Q07Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780412014; x=1781016814;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=o52YDU89DCmOeenerzA77YRbefFJjXMTgmHyjwDrmKs=;
        b=heDoA8ZIjmMXSpo/CczGY//dgaPRjJjTlSF6h5wgkg5gO1JifnywTjtt3kIqhcYb/B
         UZPpmXYHzzFMptulW1Pi1jfH3xh3EOqek8VP31SBhZnhPxUeyaE3MLBl4g1WkAT5chw2
         dVQ1fapjg1WjPyM1/JIfHDfXGuNz1yVQ8wGWtza6pNqpK71nRPhsuIrsreKU/TxgENRw
         rx7O0Rc8eU8WsHTv04f5njvmdNpxjs4Ux90Ej2bUJYFqRKfzYpTJbl9tVUqsatM3NNaw
         5MvofP30kIvvv0LRUNHGZLzX04q6DH1t5VAvMTL6iEcLOThPIiyfjzmM+CX0qkGGteGj
         WEDw==
X-Gm-Message-State: AOJu0Yw10Q3mDlnpma3xRcgkOSd/7W+R62HA7MNWAb63YDH8ybsLNwAY
	CmsPmE+ST19HXm8rZCgcrQY9wR4Xlmgr4is9NuzIPX1aEbreSbti5OeVyiAt9yngnfembpql/RW
	OX09mjJju7kqspR/QYUrQpMBXCbGcx2Crk9sGTx0=
X-Gm-Gg: Acq92OGpzBVh4FCqwH78tUxNht77JN0I/ppP8vqMBFbKKdlJ5hoBWAyXKkO2ucJLeUN
	+MpZYgbgXDLzaAZ4hZ8EYhkST8P/aMykz35qwyN2jmgdlHFycHzD+ecGiKGiVRL3c3G6gwkG8Bx
	Cf7qkZ4xjsBPt3gaqsLnN53z7f9Q3NcKPabeStRQ3r32C9q90HUdcOVSbSlRhDyJC+RgzCOdLlF
	T8Hi4D4gRhqekyQGb5zN5txb8xJnCmcg5jlQcPaHxY9DaTllWGLGuuEsLRbIWrOP5Mgb246TagN
	c5mssT6rY9xYjhsLHLabzmpU9YP5+ZE2l9JYmDBa8QkXl/hALXSEVe96wnnPbhj45LVbAw/lR2V
	lZJ9DjlIa0kCE
X-Received: by 2002:a05:690e:9:b0:660:30db:6929 with SMTP id
 956f58d0204a3-660d5ed866bmr52046d50.20.1780412013708; Tue, 02 Jun 2026
 07:53:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260602082925.7061-1-raghavendra.rao@collabora.com>
In-Reply-To: <20260602082925.7061-1-raghavendra.rao@collabora.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 2 Jun 2026 10:53:22 -0400
X-Gm-Features: AVHnY4KMftVgMEgmMoKIngDnIffnfjBd739ooAXo5kZ2WGz4vXJhw9UUCbgZTFA
Message-ID: <CABBYNZ+J3Kep=wqc9hObEFgzLM1qLiU6ozqeuZCEYCvgo76C0w@mail.gmail.com>
Subject: Re: [BlueZ PATCH 0/1] shared/bap: add ASE Control Point error responses
To: raghu447 <raghavendra.rao@collabora.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Raghu,

On Tue, Jun 2, 2026 at 4:35=E2=80=AFAM raghu447 <raghavendra.rao@collabora.=
com> wrote:
>
> This patch adds the responses that are expected by PTS.
> These changes are requited to Pass PTS tests BAP/USR/SPE/BI-01[5]-C.

Hmm, it doesn't look like we have any SPE test case captured in
unit/test-bap.c, maybe we should start with that.

> raghavendra (1):
>   shared/bap: add ASE Control Point error responses
>
>  src/shared/bap.c | 78 ++++++++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 76 insertions(+), 2 deletions(-)
>
>


--=20
Luiz Augusto von Dentz
