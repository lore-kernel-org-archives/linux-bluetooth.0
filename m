Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793035425;
	b=NqnFEmzDu4arhdg+UamvRkD4U3GUavwc9FOWshktRuwZ9ECwdwDb/LcT3WD8zW49LvLc
	 WCz+Hygq8Np/4b9ghzfj4Dxcfj/TEcQukdwinthcj14zTFEAXUQaSCev8Pc0KBhKIXc7D
	 4wJHHH3YE+4ezWp6OpnuUAsBlsLQkNetkHyeh5LQf92kLBvM4Ixp0U1KfVMVIpNqsTRTd
	 GRmuCk88IQJ2s+JA2Aa2NdNPdYIR2U7GZ+Zl4mYCQBoh8OvzrrEf/Fn+IZeij1KU4rhR0
	 vzUv4qTMuKSJ3yd+ukfCehMPTbkbrL44AC0kkrDmAkGtEJUZmomAlbiSiyxddSdyQug==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793035425;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=n9exb4vZcYWMVOf3aUr4oVIyiH20r3+9cQjFUZ4KlXo=;
	b=ATmVezoVmchAt5gGYNVv3hx+5PwDK2QbVo52rdCCkTesKYujUv7cMe7GKvctCYZZJehZ
	 e1+mtY3xClpm44sJ8b7hu9Q7i7qaUohtuPXR+49/uolsnbTiUyd1e6gS1VHIFqTs/TPoB
	 c+ekFYIYBitF4vqk2uYD0tX80eUJlp5lxo7rmnL8c8u0BRfhmA/WtiqN9RpWNF9zz72C9
	 4LfnrNoqSxVBpl1crKuprpVyF0cbkVpz6lK0AT4JpUiXaNHY387j/mD8OaqL0VC0RRjhT
	 lsIZPwOUxVrf5MtNEnk3pP3pbbE/+o7HHCuqo0zUcvolOZgFbMLOj1jVQo+e8B9KqWQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=QAf5Oucm;
	arc=none smtp.remote-ip=209.85.128.169
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72BA5606A327
	for <linux-bluetooth@vger.kernel.org>; Mon, 26 Oct 2026 17:23:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 72BA5606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=QAf5Oucm
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-8871ada1a26so22334827b3.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 26 Oct 2026 10:23:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793035424; x=1793640224; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=n9exb4vZcYWMVOf3aUr4oVIyiH20r3+9cQjFUZ4KlXo=;
        b=QAf5OucmnfEUXMBw48XTnqTWsYa+xC3i34n27G2DfD0nMN3H2qCpvjCSLi4VT3mitb
         9KzhSvU41+PBjI/OeHlHs/V3XMFMYODP7FWWB5htf3vwVKfUbB9OwEk37OiF638Jb150
         biQ/B0XdNRc5yT4yvtY6PHcaM+l6BEQo5ZSl0Z/tQuiucLaE+DhvJUhQHfacVwAzeOse
         5ebheKVYsgfHYQ3pVKOyY/5F/+KCvvag5sSvrR5LkR4tS+8ofrvsVe1gUJahHpJPv5Gf
         t0E4uuAICHCuYR2Lnv2C6Jrt5FQfoYn4Ju/7nPoOmLAt2Mko5BtngQzYhf/jJCn2Gcef
         8MwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793035424; x=1793640224;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=n9exb4vZcYWMVOf3aUr4oVIyiH20r3+9cQjFUZ4KlXo=;
        b=oPHBGBeFPbMZ5qyNF1gTj2/xOsgZlbI6Wgd1CYMAmNMImZCDdDc34k4OQY+CPsd+3W
         cuNsLvbRONNb9qXNZ2N5uv/O+EqALdWkn1wNUYxExAHci+kaJcXb5wgAiCLMD16ZR5Kf
         lY2QL2H3W6duX4fGwRDjJ8rC4tATD/u1w5xOtuuna9+M+lnP3wfTZ6cemIXW08FwR0/i
         gubxJDceuRM1ikuO9Noa626ZJDgWTbTc8pdlS3xFCekaQVMwilK2NaK7aox03cES8Wma
         x0XOCvt2ZjvoyfQ7UwvxYETAmpfkh/HsDmcXvE/7//3OMnvlaJJjFxY3W9qa+/zq1wsj
         Fn1Q==
X-Gm-Message-State: AFq9FYITaCaVDZcQLuultiT62VDrOWzRZxRJ77YV9RvF8N/L9kxYsLyv
	5aZW7IiNgrjAV5dp5cU5oyGNYuTncsUsZ8WB8O1fBUV4OuqG8AGzLHkxXGFdQXDG1TU=
X-Gm-Gg: AYBFou3JgrHDjwiayWKZw02wMku5eTdeUv9iV1IDHlLk2EK/pjZrqqnrlN+JCrrA5JO
	sQeL5SlDdEsvBjqlSTtujesFOOtTDfWJDtvNWMpTomMImdZj3FncCt7jZKKjpXJqj3Jw1noloTq
	EGeLWb7PgOl/j8iNfcaLG707jDh998Bv1CM/KAn93zY9zN1HEzYzI+GygiozQV3BtO40k5PcfYW
	DGXJqQ9EnYuuUj3zHFkH37ucgzNtBVSa9m+3TMpLNit3CTCpxm83u4lF0y8yk/DYAAjfioujU1X
	atQL1ec7+/DnmqWlDNMMswXfWsDY+ZDWl0Tc6yUbEh+TPDoZnm1KKrBAHgRbYaXdIugE+tDXGxt
	4K+Ng5bNrVdqTWLumJ7HwjDhYsDyvi1PGaCQFOgeRe8eJ4U55f+vaX4MzPd0bMmN1f6fcaLmLiY
	VMBw7sbmYrqMOz6g9tH2NWXmm3cmKrAZ7kwUi3dKd9wi1ajApKq4fTJwcBVfSQ+i2OieweP3/+2
	VqjUuEqodGLakRFTK34ywhdWI/q4PST8OusFrOTRoDGeieDF5twST1x1YQpCzSfV3cs
X-Received: by 2002:a05:690c:5c19:b0:8ab:4989:bcc3 with SMTP id 00721157ae682-8b166be0e0amr38782547b3.42.1793035424527;
        Mon, 26 Oct 2026 10:23:44 -0700 (PDT)
Received: from WillzDenali.lan ([2600:1702:7a80:3c5e::46d])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b166e9fc27sm35090107b3.34.2026.10.26.10.23.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 10:23:44 -0700 (PDT)
From: Brandon Williams <turbine.bmw@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Brandon Williams <turbine.bmw@gmail.com>
Subject: Re: [PATCH BlueZ] mgmt-tester: Add LL Privacy tests for a device's changed IRK
Date: Mon, 26 Oct 2026 13:23:30 -0400
Message-ID: <20261026172331.33873-4-turbine.bmw@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261024004732.57922-1-turbine.bmw@gmail.com>
References: <20261024004732.57922-1-turbine.bmw@gmail.com>
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

Withdrawn along with the kernel patch it tests, please drop.

Thanks,
Brandon
