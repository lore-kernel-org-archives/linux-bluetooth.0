Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE0E3155393
	for <linux-bluetooth@vger.kernel.org>; Mon, 10 Mar 2025 13:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741613365; cv=none; b=d15cf5eXwtRo3+8eRG/KRcKHEvEA93YDjPF+fTnSO1ytN7KwrKz5cnchE5yXeqGXg5LiHLd0RnKJOUcKfqjNIF8KyVFiQa9pbY4u4+9AMZFlL5G4lkVU8mv8BBNdJGWxR3I7MJCvVXnbhZvKt+1r36VHS9VPqTM+1g4AzkvNdnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741613365; c=relaxed/simple;
	bh=XNA6Uys9ILF+AXdnU3Bcmzp8YZpYS/4Wv3I5sChnJ7o=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=DrRaEppJdwB7mmSk47fcW3wqZM/rUx0nGU+I6zavQuiSDc4CqEKwLxX1byo0JF57vmRij1t7Vt9nBl5C7BrLUyNFBoDn4Zn2hZNeSY1XPal2g0hPzUdx67OgfoF8Ux0zQ0EakqkxrFkGLQhAxTPkhIc9hlrSp8/TgAoefqwTiIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OkiFGrZs; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OkiFGrZs"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-7c07b65efeeso405478385a.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 10 Mar 2025 06:29:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741613362; x=1742218162; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Q5MWOFvj7Nn3G1meG+zQNbHTR3eUieUl2N5VoVlAwtk=;
        b=OkiFGrZsBHJv5qkOeHnZm2okpB7WlvvdVGIBk7U92GQsAo6gPFUsShbI96HHBS0Mjk
         8Tt4xq8OGQtixyAnfZ6CRF/7uu1SPETlTKXVHfXkclWhbeSHRKI5QnVGNpSc/e/S5Xao
         qZFvun2G1w5sAecDxnNVaPfhdl6JQGdt8iVoWV6Wb02UXftTQ1cJvpCaTFid5o1euFdD
         0xpdHmfsEdupN4nCzGo6gmz+8KIPbRV8JqD4dJWAmVdCixH0WluTt2mjs7xmFMPZqIB5
         C9LEykHsLhqpvjC84IGO9v/o1sd7DCRVoF4YPh/A7EMuwiAz2eEdVBw7VINWwZ1Bdc/L
         //5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741613362; x=1742218162;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q5MWOFvj7Nn3G1meG+zQNbHTR3eUieUl2N5VoVlAwtk=;
        b=uT2mA/thQAw64XtMk0xmhR8fth8YwVkulrhzx/+D2I/ocMYvvYpuGzLsCr2AGo9LpC
         AHZ+Q3CBbTxAoh+SZstn8cgaG39cIST24qZ8T+q2AAAPXV8bk6NBSBaiBdCjDD/Tpyeh
         /oxBdKEORbeRKvq/lEbgUTx3qHQ/v6OstFu5DiuXIHWHIZknhpjEGQ41kCPZO9FHfYfN
         EyrfWixpjdHww4mBKlBdsDMNP750djBKlpSACzZdQczgI2rnk3WeZanaFvmIcnw5tZvo
         NT+qRX/wII5uNML2VjS/YfbP7QbHmGCYQ97ylEhwiJwoxS3Te+VhBbm45o+Kz9KZb4L0
         kiyA==
X-Gm-Message-State: AOJu0YzyZ7HRBIGC9vDQ37CrBoHGJEKe42y6eQBM+O0j9SPGejU4zqTE
	vXSO7F0dC41reMOm1WLVJV+SCe/wK4Xzfqa7sISmC4FjW+3a50KAwOmG9OEU
X-Gm-Gg: ASbGncvOrQQ3lcrH0vKaI2PRj8SsfQEWnzpL0J4DvwpXG0ksg7tdAQMPHHjjsbB6mfg
	l/xb7PPE6qZhd2qn6en7Oohct2SqwVbGMMSo62UKf7ggtpx2rrFriwtWbn1aaDSNVifvNMV/fTS
	XR91KZ97zr7b/QStFemqvJtLxYOehnm3SLekEDJnmSMdQCBt06ZcX8aBgt9mQkqriCy78lpHbtJ
	rn9oeBpc8st9+TIKLvgTKs3FqNNymWRP7J0/ZMXPbJE+WUtGBxPNa8Muci8fVQS7yOD4x/uE0y+
	2suJQlcf5ZpixOqGSQdzekqOQK1nESB6JQy6l7Dl0Vk/96Ai
X-Google-Smtp-Source: AGHT+IE9orn0LA/OBzVkDhv7oRNeSGQ5y5AGM9eEKzlG/QFY62NEfBmh24FEr5lav8iOxRMA4Hp6zA==
X-Received: by 2002:a05:620a:801a:b0:7c5:4750:9303 with SMTP id af79cd13be357-7c5475093d2mr973790185a.22.1741613362476;
        Mon, 10 Mar 2025 06:29:22 -0700 (PDT)
Received: from [172.17.0.2] ([20.39.60.62])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c5559f006fsm162400585a.100.2025.03.10.06.29.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 06:29:22 -0700 (PDT)
Message-ID: <67cee932.050a0220.179168.2f50@mx.google.com>
Date: Mon, 10 Mar 2025 06:29:22 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1202679240076161473=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, quic_amisjain@quicinc.com
Subject: RE: [v1] obex: Add base implementation for get_mas_instance info and set notification filter
In-Reply-To: <20250310121240.1731654-1-quic_amisjain@quicinc.com>
References: <20250310121240.1731654-1-quic_amisjain@quicinc.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1202679240076161473==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=942240

---Test result---

Test Summary:
CheckPatch                    PENDING   0.21 seconds
GitLint                       PENDING   0.19 seconds
BuildEll                      PASS      20.80 seconds
BluezMake                     PASS      1569.54 seconds
MakeCheck                     PASS      13.15 seconds
MakeDistcheck                 PASS      160.47 seconds
CheckValgrind                 PASS      218.67 seconds
CheckSmatch                   PASS      287.82 seconds
bluezmakeextell               PASS      101.65 seconds
IncrementalBuild              PENDING   0.26 seconds
ScanBuild                     PASS      891.86 seconds

Details
##############################
Test: CheckPatch - PENDING
Desc: Run checkpatch.pl script
Output:

##############################
Test: GitLint - PENDING
Desc: Run gitlint
Output:

##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============1202679240076161473==--
