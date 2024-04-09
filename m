Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 915A512F593
	for <linux-bluetooth@vger.kernel.org>; Tue,  9 Apr 2024 14:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712671955; cv=none; b=Rm4MYcWJbrVNqTZ/J2FarE6RjrJHKEWkhnF8Cr/ixL2+QTQeHXH/WMRNGiJ+6UlZveoaszHhydQCBvFZ7c7zJ8GbaKNFz6iqyRH0VOkEaz2EacTvbzgk0+AqesexXvKoJJWl+ujoF/rXKMTB4xJipNfiCmJOUYevXPD3caKdr5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712671955; c=relaxed/simple;
	bh=yrQvIxDpcw3J0hdl1JQh5xgRAZL9IlW8g+YJX7k/704=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=RQerrk7CgvjNqpiiZK/Xwx1zb4kvTGuazdbBlQF4ITL1pDbUV0HzE5sMftpaP41rfA7ICIWMIF2VXiNul0teR647vxoCRE6vJ8n+t+qg83fWJZgETP2ZE8CSJCXyuqoRryeqK1jODMr2WF4anVZl5PHvebTgKnfQPKVhDYqwFi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CjU2aq52; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CjU2aq52"
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-615019cd427so48194077b3.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 09 Apr 2024 07:12:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712671952; x=1713276752; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=yrQvIxDpcw3J0hdl1JQh5xgRAZL9IlW8g+YJX7k/704=;
        b=CjU2aq529oaAijlBNgTEq6lVpBGMKOAxlgOjHVHI6/ZwRBhBIwu6W2rAPUM48wPrmD
         t29h4R5I0tpmE4fbFVmfQgW4HMRtuyEql1CLg74iKInKNgyACD1zkFPQ5DAJ7mv691cY
         mdub4LSbQVb3JOmxM2HAPZd6xsYnHaOLrsA6iGJX4GnJOcOv7sqw1BtL9m6AdcEcc7WU
         gOtFF7aahrVa7Cal15pr4Ndlb2WyDvMke/IRmj1zrBJEE/yZfaJO7xypRR6HX1WXXMKt
         jZoe+G86aRGS9Pyi6mNZBHd8WvGWoYWiq4cbhiObd5kVFegrRhAoshCwC6t7RSBWGRxW
         FIlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712671952; x=1713276752;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yrQvIxDpcw3J0hdl1JQh5xgRAZL9IlW8g+YJX7k/704=;
        b=qmFYYQHtaxmocKVJSzviJEcR9RBnkC7d0LiXqxpbVIo/2Np8IKATpXNnbGTyweqouF
         S1eR4dAKHtaA4qYxhduBGsDiT1yunIuPXQ40hnB32xEDWUb09Zd007KM18qhh1r0CNRs
         aAbPsC3yy3msimmDInqUUei7cCVTtTJTjfziy1uxvD6mHX7wkXhhDw5hOX4ZgIrhRpLM
         kdewuXr4Pq5vcsUMdfyxL0mC0YphFc9iQipu0L08ruraEkE0ZPMHNN/RRVK1jgFRyk++
         Z3FaxreGI1FDyN0e9li/KhN1YFC/5DGKhyZL1N6JuxzgPd9fBfsr6basY3Gi8Up+ktj3
         X+Hw==
X-Gm-Message-State: AOJu0YxyRMAV0AszTF9BElI7KR9IBb3C7+AeFe73q2Eu3bkcZJ676068
	wmodebGFsuV5X1ZQ4YxHABXEFS3cVra8aFUSEsa9efRw1hQnAyvAZaWuJqPT
X-Google-Smtp-Source: AGHT+IHNKqksO3a+QpkwQdL2BXuySq/fsU2NZiR+JayCajXknyK1K76BvcwyOi8cmNtnx5i/kk+0eg==
X-Received: by 2002:a81:83c9:0:b0:613:f61d:cb48 with SMTP id t192-20020a8183c9000000b00613f61dcb48mr11188288ywf.33.1712671952205;
        Tue, 09 Apr 2024 07:12:32 -0700 (PDT)
Received: from [172.17.0.2] ([172.183.54.147])
        by smtp.gmail.com with ESMTPSA id db9-20020a05690c0dc900b00617f34f6794sm1462059ywb.121.2024.04.09.07.12.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Apr 2024 07:12:32 -0700 (PDT)
Message-ID: <66154cd0.050a0220.54151.710e@mx.google.com>
Date: Tue, 09 Apr 2024 07:12:32 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0730641654874667524=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, eadavis@qq.com
Subject: RE: Bluetooth: fix oob in rfcomm_sock_setsockopt
In-Reply-To: <tencent_FE3C6F369E968237444B7E74BD7625670A09@qq.com>
References: <tencent_FE3C6F369E968237444B7E74BD7625670A09@qq.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0730641654874667524==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: net/bluetooth/rfcomm/sock.c:629
error: net/bluetooth/rfcomm/sock.c: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============0730641654874667524==--
