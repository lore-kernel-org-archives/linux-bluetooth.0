Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66C8C2957B6
	for <linux-bluetooth@vger.kernel.org>; Wed,  5 Nov 2025 19:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762369446; cv=none; b=olBX181zg4+Ta0m9Tyg9LEB+OKTra0wxAdur0PhTcOb1eGy3WzzHFdZEY/TZFD1iMhVnNqcUTGHNLavnIA1hSedhId2u5VdKqfYH7JGtQCAitDsSA3n2DbY3meWHUuBwql+G5SRk/+c5KdeSZhCvCx5rVy3QHAewTZMzdwJuho0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762369446; c=relaxed/simple;
	bh=u9rmZpBvMezDctwJo0rwiGqkxhnz+tnImP6t7UnhM5g=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=mnL/NXJy0Dan2zjp9IQrSa20b7IwQEiUQPe8v3ZGI55FSsQ0/be7lAtelP4eYgd+U8b5qv8XS4JdMpwFwLbAkEuu6WfOhX6nFpqrMOffRuMk3vdtt71iIBdWoOtTSlKeAdGo78oq1ETWH+V1jQTT3S85qp08JCFmryqALEdJzz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dReMjxuq; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dReMjxuq"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-7ade456b6abso207139b3a.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 05 Nov 2025 11:04:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762369443; x=1762974243; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language:subject
         :references:cc:to:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o0oPPPAsw+FYjV2RdYT3vlBD7M9XMtEjJDNDkXAtf5Q=;
        b=dReMjxuqwi2fKal28sgt4yZ5cC4zL1DPMlulHWT1eJKO5fbctVYwPV4GJFFKY/jR0L
         C1OQgrxUrVqnJtu74VOhbYkPU5GlhfOn+gZWcNhtUxD1Dg08LumPBht6HfGAjqK50ZIx
         r527T0BRTwuW37fWJ7GNTs8JQ1mMmdecf5+9TKp9CcFgifLCiig0NaX0JUmyPbO4p97f
         TS6J/a1uW4r6O1dw4KjqgvMlcIRjHalsP8VoAWlJVFUbGISE5MS3M4iGy9JajM8vELyO
         Goy3cS936KKc0TvgvutPx2EKPaS7fcE0zKaAXTzNYB8MaMwdHMq57GUqysmnaPvAiIcb
         Uy7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762369444; x=1762974244;
        h=content-transfer-encoding:in-reply-to:from:content-language:subject
         :references:cc:to:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=o0oPPPAsw+FYjV2RdYT3vlBD7M9XMtEjJDNDkXAtf5Q=;
        b=LFlqRPgSOIeejPN2dqluc4y80dFZFnPGQqmsIZDyJ3+Imi2Yjq6TECHMSm+rIgUCeM
         JGVxrseeBH8aaxYgyOuvPX74Ym8b4u6a8hKBnK9jVTGYFVsxJNcHln7xqfk8ZCh31GIK
         hf6o9uLl5xv/DihGdJ5QJE1MZ5Mtegea8iS94xwkxS6QRYa6DgVpgEx4e6EgxnoxO9/N
         UWfVNpemjkI099Grrh/tmO09NIU1AXTSffmYcaY2zTf82mOph147EW+KMwY/0mnk/yNc
         ys2vnExHqHJu+DYlp9tjhjx0Vly6AIY+tJJTVxvx+XZ5WV+nXhdct/yu3pM8oUoV3RYu
         PnDA==
X-Gm-Message-State: AOJu0YwQlgeEe8Gu2evpS/g4P2uO0sicomXSr92QKlEEdURbI/eOO8hP
	YPdAl7ak2CAe9Zolv+iFTAJfH2rJHFZSK+gYLwIFF9YNGW7ln/K+HB3+
X-Gm-Gg: ASbGncsW8J2xHj64EhLIuCfwhiALzbGuoaMzXw1iLsA3LmMFQ5QuIalsCObeK1ySm3z
	R95+aXTh+6BjJt6EKuWX1DAL+QKvb7CUdA3gPXFt7cYHCX6kuaA1zXzwXxt4x9VJreAEUUP+69R
	ltSP/fn+uVjMhFFM3IRKuXWztfzGuiTNNQJ7Bpj++4WXdvtDMqXX55199FXYpFyyDSKXL+WeaiP
	GEiYIVKipKXijFdAJPuJ/pQMwatjiaPJpSWh3ZW49NVD0gjlnItQDVK6J/WFntE75bbM7m0ZxFZ
	dQP3cRVJmd7N3GezkiTyHds1WZFrB27a6kNslJQ7iOrlW3z358oHOJy2xyUsBFCdQ6QbVpxJ9c2
	7nc1J+6JhPo/1BUzxwhxe1bXP+sQDuznZTBknBkKbZBfWJf1poUO8/tmbWu6yOSnjB9kGBgAYAl
	6fkLeEkw==
X-Google-Smtp-Source: AGHT+IG91YOfQpBrlRmdeV/ensq1qmlbYvELGbxX5vxy1W6uNgK21OwZ8LoBoKG6gX9FbcpgxH+iug==
X-Received: by 2002:a05:6a21:6d88:b0:34f:7454:b98e with SMTP id adf61e73a8af0-34f839e0358mr5682519637.4.1762369443501;
        Wed, 05 Nov 2025 11:04:03 -0800 (PST)
Received: from [192.168.1.13] ([110.226.177.99])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7af7f7569cbsm171826b3a.4.2025.11.05.11.04.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Nov 2025 11:04:03 -0800 (PST)
Message-ID: <ecb7b4e7-5006-4642-8807-01b764cd4b2b@gmail.com>
Date: Thu, 6 Nov 2025 00:33:57 +0530
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: syzbot+14b6d57fb728e27ce23c@syzkaller.appspotmail.com
Cc: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 luiz.dentz@gmail.com, marcel@holtmann.org, ssranevjti@gmail.com,
 syzkaller-bugs@googlegroups.com
References: <690b6df3.050a0220.2e3c35.000a.GAE@google.com>
Subject: Re: [syzbot] [bluetooth?] KASAN: slab-use-after-free Read in
 l2cap_unregister_user
Content-Language: en-US
From: shaurya <ssranevjti@gmail.com>
In-Reply-To: <690b6df3.050a0220.2e3c35.000a.GAE@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

#syz test: 
https://lore.kernel.org/all/20251105142251.101852-1-ssranevjti@gmail.com/T/

