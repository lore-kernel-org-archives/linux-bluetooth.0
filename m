Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E26D363C5F
	for <linux-bluetooth@vger.kernel.org>; Mon, 24 Aug 2026 14:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787582460; cv=none; b=CRhNU2gBKm7qXt8aUNMQwawYtx9XooshCwiujOfHBwYKPU+cwtLI18m5XeH6BIZ+DUS06P56TFRmVj5aSyVePKi7NkvDFHnLmHIJ7mQhUkefvQebHsB5qUbhdiUVLdRGfZEOZQv77OtuPhvTBajeboD84tZ8Gge9+GgDoQIzLIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787582460; c=relaxed/simple;
	bh=QvPRordQBEP+YJt89UXWlh9W5eenSZujQghB4DOd398=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XRAdTE0N4XJg/qYoT8YALHsy0TNTdSEBHKxcT13O9r4RONyF8Q2Pu88OhFxKbOAg+HHXgOg6erAtpz0N5GRwmw4vdR1oBduWyvj390/wTNOINiAm0SvHTvLGwHci63S4cb4V8DpS8yrESbE89SQgmgT/8XRkmPYtiS7reDQZm3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ju/BJszJ; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ju/BJszJ"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-395ea741d07so1457044a91.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 24 Aug 2026 07:40:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787582459; x=1788187259; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=x3IQRXITFMDe1ddVJj0V8oul9t4BpMVbA4OwUmQgnZA=;
        b=ju/BJszJIEquI6Wet3upmIl/55np0IIcadGXDMhPC8rPBuWkiKidYfSzJGdIFck/CH
         w6y/Hajd2iLR/oQirxosLDOYsjXABFJMMNKQgXNU0GF7VKyGoRAQBEx+alVYxrcxYjCb
         Lk0J2Q2uVpIL2STQWQ6RO0lQT7LuS6Gkpl1W1RUhrnKDk7+voi/umSvuSj0w2y5IF/bo
         lAEyQ7AMpV15YCaOiyIa/K2V3jQW9pHkLnytuVdJU3IZACyvuDQJf3lHwn7tL/+xlgNx
         VRd0Z7clpedH7lNVqcbw6CtPO/0ZYsQH80OThDyj9bnXHWBBrLZYahHQNZPraUE1GV3Q
         elVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787582459; x=1788187259;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=x3IQRXITFMDe1ddVJj0V8oul9t4BpMVbA4OwUmQgnZA=;
        b=X8Mq/Ed5zH7xy2ni/4h5YoyQwupLRQDbzByUcKjlznXFhGHLY8gTkCLkjN1aGHX0RX
         P412hbymYOQBohSjW3LAGE7cRAZFeDzBuRVhtLdTSU49XCwfjIbLf/tqiK+84TgfbpoW
         yO6Elg8GVtxz1IKC8CYiPh8a9+4QB44eowIso7ZZa0SIyfndcvHXJuqJyJo17nIiHqk5
         8VXta0TGVAIXOIZMLWf+57wheZwertHL0jTQbeYa+9B6jq4OubfBgSWvDiKvcRflnvds
         rEw1afjVpJtuQsICsLkvUJTa+aVnHWRUoT7TqqkRQWZdGqhtjKLzDfPLSdZxc7UmfCXO
         oXNA==
X-Gm-Message-State: AFuF++mG5nNCVErGPOlry7udgLAKEEpIHwEwslYBoDxDTG820Pb0OvKC
	nEKc9pvfpfj1EpBnJOTJVnBh1/03ayM9dXs2bncbKFEBT8kIdDMzH0qe
X-Gm-Gg: AR+sD11HEqwYcJ5cNtk/YV29rmdCk6uhMgJ9FcWn6jX7iBlPDMcA1Udq5h5ezjYCt66
	Kx3LUpDDjI/VIouODTJ5OaOotEvkTYij9aD1uQm0qel7zplEhc3liuPgZ2hhbq67797zEzwXKAL
	TQcKZu405IX6kDgqAlC783v2ertTwlg4i+Bo6lg/mbNRCidxFRK8KcpnJWW2gcmC4QyVUlkLooa
	AkvtWElWanfjNg+tqfbIS34PsnqTg4NeUkiNoOlljSTT1T3nT/Jl4OE5VbmYUDLquGk9B74g4qP
	dF7MUwpFJqoxynYHy6EwDhyrsa+RZepOq5+jHHLg217uGiB4Mm0SG7bd/VP28KX84+ZrPInoIWi
	yIGAW9EeVFx7Bn8qMzH1ZxwycD8nlyhxN/sFDLLJ34GqNKXBnu7RyN6SIy1bEm6mibt5KYAo6yA
	aHtOH0QXd1UVjBPuDErFkA2RSpJB/k13fQH7LIgj27gxB1NNwzcUfZTMoHdC2jwc9u1oMdA8Hhh
	LDx5DwvCiklQIlPPh+yR5thIZ/mje/K/1la7S8tzwcXhoao835usQKyB4g14HTFh1w3ycQqUWyJ
	UTEIu+CC3PxtdKC7rkFyTAi5bYkOnCdo2ZjvHNSDnJl2IVNvMMnGttg/o8YUTu2Kj/mgHfgrL09
	uMbVsbZTM29/PalXbcQhkSU0SGjs1YTvodHQjG/KWMxtuhdc=
X-Received: by 2002:a17:90b:2f0c:b0:395:4de5:1054 with SMTP id 98e67ed59e1d1-395c3847e85mr49724324a91.16.1787582458723;
        Mon, 24 Aug 2026 07:40:58 -0700 (PDT)
Received: from localhost.localdomain ([101.251.7.10])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-327f90c31a5sm27138656eec.11.2026.08.24.07.40.55
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 24 Aug 2026 07:40:58 -0700 (PDT)
From: Laxman Acharya Padhya <acharyalaxman8848@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	Marcel Holtmann <marcel@holtmann.org>,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: hci_codec: validate vendor codec count length
Date: Mon, 24 Aug 2026 20:25:51 +0545
Message-ID: <20260824144051.50010-1-acharyalaxman8848@gmail.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <CABBYNZ+h-m9YQCim5Zm2_sgARZh+jM=POFYX_zTQ=xYUdxz-vw@mail.gmail.com>
References: <20260823161638.32348-1-acharyalaxman8848@gmail.com> <CABBYNZ+h-m9YQCim5Zm2_sgARZh+jM=POFYX_zTQ=xYUdxz-vw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Luiz,

You are right that sizeof(*vnd_codecs) and
sizeof(vnd_codecs->num) are both one byte here.  The issue is the order
in which the existing check performs the access: vnd_codecs->num must
be evaluated as the count argument to flex_array_size() before the
result can be compared with skb->len.

For example, consider a V1 reply containing exactly these three bytes:

	status = 0, std_codecs->num = 1, std_codecs->codec[0]

It passes the initial sizeof(*rp) check.  After pulling the status byte,
the standard codec length check also passes, and pulling that array
leaves skb->len equal to zero.  The existing vendor length check then
evaluates vnd_codecs->num with vnd_codecs pointing at the end of the
skb data.

The added check uses sizeof(), whose operand is not evaluated, to make
sure the count byte is present before the following expression reads
vnd_codecs->num.  The V2 parser has the same ordering issue.

Thanks,
Laxman
