Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02301225A2
	for <linux-bluetooth@vger.kernel.org>; Mon,  5 Aug 2024 03:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722829851; cv=none; b=c3pZjpXHyr7r0G3IiI5BJZ227Y3bfiMZklG8DViPje3HK9vbuollHZqfDqyN6NqvgRU209Kdh/S3cOyQVKgJ39w0ZRTOUekDWvNcYs7raLLUImtkx8rYiQaxAIyW2C0okcS25Lg3hoDeMGOnvoHyUovAE1IbGZ4wfMxeY8QtEFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722829851; c=relaxed/simple;
	bh=q5TmUhQhh4p1Hq3cbsVJSVqymyFAP9PusE9RQFz2DhE=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=hS6Ks9BQMfPKy0LLbdkE6mgC7S8tg6xm6L0bUpnyeNoPNjdXhkDYCV+EO5JI0GOgxs7rSO3NFiMgRkUVaZElOiblp+eTMuxkjg+qApLL72s5vVYSzkKb10uyJ5wEplIpo/kvDX6EBnww8SkDnIxrJ1W4c5dr8+v1ERyifils+6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KIOm5gwq; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KIOm5gwq"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1fee6435a34so67469755ad.0
        for <linux-bluetooth@vger.kernel.org>; Sun, 04 Aug 2024 20:50:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722829849; x=1723434649; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=k3aa8UwArmWNI1aJZnP+jFGEX5dMJ8joBKq7RI6LHm4=;
        b=KIOm5gwqGk4mi5wGWiKHVJ96jab8ZfzxiKxvKFXPxxgGwFaqXWGCR+wKupEjiRfBF6
         2C+Jx48Zo50ccgBixrD+6YS3chweKQ/qWHedko5Ju0BCCeDeqHWgsPx4I1/UvKlr511D
         MTFM2N8qCwgsZiJ2YHTQ+1y0CfHkiVMJ9X1CUh4CWY7xvjWveEFi3JsgZkvb6WHShPtc
         DxG0ZcvS8SAlnmNiv4gOE2miv2Ik7DONfCrgaWtdf1Ws1UIqT3k/SdNUBjKyMqZkqoaN
         dvvLyJYBgIJbTyDgH2r+p2oZfIZlfVlm0tZOtg7snffRWOJN9gH+slkVTjk9ynZQMpFN
         rJbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722829849; x=1723434649;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k3aa8UwArmWNI1aJZnP+jFGEX5dMJ8joBKq7RI6LHm4=;
        b=pLI3cKtF6pvVUw/CEMksdMz2hTo4OfEZ3gm0PJutK+7+VkpYr59QPfU1jitdFEEqac
         vxahjgiQvkYoPtTaiAAATE6CsDuyL/auL9+x+qGYlGmQYuFpM4m9zh0N0lbqQ8FrvzuV
         t/Y7VNHVqUuG1iq/1IWXmC9hUtsDCSdM3/ZHIV3bRfX8FEzvaePExAoZ46cgebPvVyc+
         CAcCRs7LkJ1lyEW/GjdvetNIdjucJhnt6ojLcKldiOojO8+CabgCWrb5fNPG7nx8uvUd
         SJ88MQaqxhz0eYNYw5caviiXliX9nuT9feTOa9+QQOlmeIrbI0/oraMVBtZKiDXykmbk
         y6hg==
X-Gm-Message-State: AOJu0YyQGiyJzFMmRw4McqXB3k2jspmzSYOv9vXpIOUefYO5mHuhhbvO
	L8/OA6bYjNyTba2O6Sq3p+A5gnuLPRUaTTGTXVTE39TvajOvCckDKhQBPQ==
X-Google-Smtp-Source: AGHT+IEaZWQzEwDRqbKoeiZXkWYarcZ8pk6bgFii25WJ2XX7HE0fNFxRg4GVMVOpnI4WWx2396u6hQ==
X-Received: by 2002:a17:902:d4c3:b0:1fd:9b96:32d4 with SMTP id d9443c01a7336-1ff57459864mr107458855ad.51.1722829848952;
        Sun, 04 Aug 2024 20:50:48 -0700 (PDT)
Received: from [172.17.0.2] ([4.227.114.149])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ff58f26f4bsm56767255ad.34.2024.08.04.20.50.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Aug 2024 20:50:48 -0700 (PDT)
Message-ID: <66b04c18.170a0220.d077e.f5c0@mx.google.com>
Date: Sun, 04 Aug 2024 20:50:48 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6978099822602430095=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, clancy_shang@163.com
Subject: RE: [BlueZ] adapter: Fix execute "LE Add Device To Resolving List" command fail
In-Reply-To: <20240805020126.903959-1-clancy_shang@163.com>
References: <20240805020126.903959-1-clancy_shang@163.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6978099822602430095==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=876563

---Test result---

Test Summary:
CheckPatch                    PASS      0.53 seconds
GitLint                       PASS      0.39 seconds
BuildEll                      PASS      24.58 seconds
BluezMake                     PASS      1690.32 seconds
MakeCheck                     PASS      12.79 seconds
MakeDistcheck                 PASS      177.38 seconds
CheckValgrind                 PASS      253.01 seconds
CheckSmatch                   PASS      355.96 seconds
bluezmakeextell               PASS      121.27 seconds
IncrementalBuild              PASS      1461.63 seconds
ScanBuild                     PASS      998.60 seconds



---
Regards,
Linux Bluetooth


--===============6978099822602430095==--
