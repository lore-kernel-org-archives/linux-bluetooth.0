Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE3A82D7B8
	for <linux-bluetooth@vger.kernel.org>; Thu, 25 Jul 2024 18:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721932502; cv=none; b=Pfo/6wIQ427z8X2iakBLrc2vZsKXdSyCXomey8UCgiifN1hLEelYLeh6dsPpsQ7XwbLU+aP4Em7XvpY9jWlapaEoOxsVjcAhaeLlIxF5c1veoxeXliA5L1EPNaRSKdbjj3a7khIxT/FmFXqWmqFvtSoA7V90GGP/IR3j7LRbZXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721932502; c=relaxed/simple;
	bh=w6SefIOyaRbylcpUIcPjQj7NI6YTXIBVGKcniD9WUOY=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=p4c5EpGW5CQHRcZD+3UqwjYErQ7BFg99BcSrecifG6cOrJFgXob/Or8TpOQ5x4sx2pT9ESXvSPMEuOJ7GuEM1nrm7QobIazKuFb1c1g8UuCkclVDcQgV+qyWOi9hEP8+RwBkVtLPM+Fn03zkr8j58uhSEKYZ62MVBl6Hn7BwuVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=penguintechs.org; spf=pass smtp.mailfrom=penguintechs.org; dkim=pass (1024-bit key) header.d=penguintechs.org header.i=@penguintechs.org header.b=XaMMhZd9; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=penguintechs.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=penguintechs.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=penguintechs.org header.i=@penguintechs.org header.b="XaMMhZd9"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1fec34f94abso11114835ad.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 25 Jul 2024 11:34:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=penguintechs.org; s=google; t=1721932498; x=1722537298; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ePPqpqxpwRpHp4c4VoK8WY3CUX1m3KFoHcZgTgYLD9A=;
        b=XaMMhZd9p81TIHvw1VDlOQuMHDog53JHBRejy4P9yDlW+cCp1Qv2TLm4+xQ2Ast6Tz
         aNqPiyNSupDeDXp0VCH9tv8zoVNVkKdx1c9FBUYeihp1dtOYvt+uz9/jmTBTIg0P02z2
         neiHnzzbQ3wOL7SBRjVvqqbDjHo03Fyv/uQHs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721932498; x=1722537298;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ePPqpqxpwRpHp4c4VoK8WY3CUX1m3KFoHcZgTgYLD9A=;
        b=fwYBvX5jT6KhyKolRicTdSn7QdfGyC0BA8xLD+YlQhuer92LjyyntWkpuNKotO1kmr
         Eg5qHxbHwNfoeWzjtCDwQlYvW1SCq/lH0sRPdAKAcMLcV/MIQnPNqvdnzOjiGDOmyVsT
         vn1NzzlAzSKgp8GgFG0nvSwRbyIk/rnjPVdiZ2bU8TSJ97otM368gyXZQ9Qk+kybwkwN
         N4rfwB/enh3/gz/F1w3YGxI8uoyYv13D7RkQ/Gv4U/ZdpvOjzr5+un1AMQDYu81FoO3H
         1cjNZHogpqhTgVUPYDZ7DQ8sQTR1TdDHIOCUWGExven7VPgQ36mlDmi6hEZ4PXI5GdZq
         jz4w==
X-Gm-Message-State: AOJu0YzpuJuSV54I0wxCBIWXeVrj5Hg7p3peLi5HmdIFWYftgODtBAyq
	i6uR/uJdR6EwxixVFCguR3xUOAdwCD8sdr5rHK2XlrnGcPfZLBWdbj/7iDQlNf0fnADFQC6LMN0
	=
X-Google-Smtp-Source: AGHT+IHhWsjOKMq6d6kcBEwOETQaBDLOPFhfurMQ46A/cSFo1DI0cerjdYt1WiVXlV9PY77QopUDAw==
X-Received: by 2002:a17:902:d486:b0:1fd:9420:104f with SMTP id d9443c01a7336-1fed92ca3ddmr28811165ad.53.1721932497859;
        Thu, 25 Jul 2024 11:34:57 -0700 (PDT)
Received: from ?IPV6:2601:646:8700:dd30:5f3e:5ba7:e0ea:9a08? ([2601:646:8700:dd30:5f3e:5ba7:e0ea:9a08])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fed7fccb63sm17371415ad.284.2024.07.25.11.34.56
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Jul 2024 11:34:57 -0700 (PDT)
Message-ID: <27e6a6c5-fb63-4219-be0b-eefa2c116e06@penguintechs.org>
Date: Thu, 25 Jul 2024 11:34:55 -0700
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: linux-bluetooth@vger.kernel.org
From: Wren Turkal <wt@penguintechs.org>
Subject: QCA6390 broken in current kernel
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello BT folks,

Just so y'all know, the QCA6390 bluetooth hardware appears to be broken 
at least since commit 720261cfc732.

The KDE and Gnome bluetooth control panels appear to think there is no 
bluetooth hardware. Rolling back to 6.10 appear to function.

I have a Dell XPS13 9310.

I will attempt to capture some kernel logs in a bit.

wt
-- 
You're more amazing than you think!

