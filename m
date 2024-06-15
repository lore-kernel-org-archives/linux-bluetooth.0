Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECA8E1DA32
	for <linux-bluetooth@vger.kernel.org>; Sat, 15 Jun 2024 15:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718463865; cv=none; b=s/dr3ZLK7i/4BSAZm8zHyWVUVvbA23kL0k2T5F8w79CniGh1dDh5c+u5Lc6Vs//MoIbEFruSya0s1NXzbh5nLsWIeF+LNpfooU2k41FiHwyFeW3+vg+EKQ4Ms3I1N4J5GDQJ9x3hR6Qdq2JJQS0XyxI+S/YJnUpuu+6KGm9c+Po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718463865; c=relaxed/simple;
	bh=qzi4NYoQGLaL29HopX88x3QwggojE6u91Uva7f5ptH8=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=UyJOunMJC88ZP9Xyx+l0FzUGXXUNba7Lv90k3NCQxH8eu7SevAeZ8PrhPgGGpOIgq1q+uxmEdpD4qI7ptvrTQgPrS2XmiDimTiegVdukwBwy3r4VBC6w/kAIV/1qW9j0MYoWanBNbNYMLJov/3CsZjDceUDOSiI9eLJCCcymkPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HDgQRS6d; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HDgQRS6d"
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-6f96445cfaeso1660857a34.2
        for <linux-bluetooth@vger.kernel.org>; Sat, 15 Jun 2024 08:04:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718463863; x=1719068663; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=zGKIYB3/3Q0gAwmGyefvoP9qxPake3d3A5MK/WM7d08=;
        b=HDgQRS6diZ/xUZZIv534Z06twKhyAaMRAkjCFu5ZJy/ANZWaSHbttBDuxwDwzelwqu
         6u5v5a2Ooww7jBE0cw6wmDxnPh2T1eY+Cbe7C5BgrMiBNjsLX3Kx4ymFTKEs1vuRuz7n
         IagoNXU5Mt8W6XQd1p3FxAdbfpCk27qa74BlHTchUnzxktiKTqfpYVycoj9KVgY3sguv
         kx2ni7EChFoKQCn03w4Pcxotim6IwAgjUkY96DMZqr7+jB6qb1IJ5f5jbGMpiCIT8c+R
         poTtafdD2A5Wqz4/MRU+BEzAFiqe3PK795YzQoXJc/E3/xZG1AtZnYK1c4DfokwyA/mD
         v3SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718463863; x=1719068663;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zGKIYB3/3Q0gAwmGyefvoP9qxPake3d3A5MK/WM7d08=;
        b=idlYgwOCEmtxneeVBOUzdZc6DkScLrhMFWEfGtjt+7RUaCdjuO/UZHQX78V2WO2kOa
         buiZF5XpQyYgmFqtLuveKXmUA/AIMU2rCg7zgw0Ml1XJXxQ5Fb5tT7h8lCbCCinWLg/C
         /lXxMaQnqZH13nRHhrPF8w1KZW0R5rpxhd5Nkc3D1f9Zd942jay2apPJmhpjK7JKoZGu
         LiRyNEzW05V2c1eF5hDqP3aR2/o5gjvvQOsEY7l5LFf8b7LyDPYn4Y2wdDydSpqCgtGI
         JZeI8NZm6kLKz8xgWA97XUdEUq1bBCm8mrbUfgMZq1OmRYqpNwyOnRb60gjIUijrpTlk
         RH6Q==
X-Gm-Message-State: AOJu0YyKRuzMVvb+P5xtvSgYoXlP+EcVJmhF0yeKYL3wbZNyOokTjxlB
	X9L/+jCext6H+iWLGKBCvnpBkMe454IBXuOz1ctLLWAr9gPUie/E9Ah7zA==
X-Google-Smtp-Source: AGHT+IHiz8WC++vXNxhOMJ4obHlOI+E31/3tLbZG31IrCitzmHAExzQlne1C2NOSlHv7RTaiQ4F5Zg==
X-Received: by 2002:a9d:7519:0:b0:6f9:61a1:aa73 with SMTP id 46e09a7af769-6fb9375d094mr5937535a34.9.1718463862675;
        Sat, 15 Jun 2024 08:04:22 -0700 (PDT)
Received: from [172.17.0.2] ([172.190.111.160])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b2a5ee04f2sm32542996d6.114.2024.06.15.08.04.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Jun 2024 08:04:22 -0700 (PDT)
Message-ID: <666dad76.050a0220.96c02.b212@mx.google.com>
Date: Sat, 15 Jun 2024 08:04:22 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0677468859830090272=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, pav@iki.fi
Subject: RE: [BlueZ] shared/bap: make BT_BAP_* direction defines valid bitmasks
In-Reply-To: <70a822d15a7e82ec6dc83c4b42e54799c3e45e05.1718457098.git.pav@iki.fi>
References: <70a822d15a7e82ec6dc83c4b42e54799c3e45e05.1718457098.git.pav@iki.fi>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0677468859830090272==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=862280

---Test result---

Test Summary:
CheckPatch                    PASS      0.43 seconds
GitLint                       PASS      0.31 seconds
BuildEll                      PASS      24.74 seconds
BluezMake                     PASS      1719.34 seconds
MakeCheck                     PASS      13.74 seconds
MakeDistcheck                 PASS      180.21 seconds
CheckValgrind                 PASS      253.79 seconds
CheckSmatch                   PASS      357.19 seconds
bluezmakeextell               PASS      121.15 seconds
IncrementalBuild              PASS      1470.74 seconds
ScanBuild                     PASS      1034.61 seconds



---
Regards,
Linux Bluetooth


--===============0677468859830090272==--
