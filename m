Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D02239CCFE
	for <linux-bluetooth@vger.kernel.org>; Fri,  9 Oct 2026 21:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791579695; cv=none; b=r/RKGf5pdmjRDpiDOwGgW5QXck5qQqLr8N9zm3FbVjQxesVAkm5QIy4LtqtcqelzZihNSgZb5xFcSRrOz++yx4fPIUvdyeVR6rP2JbdXVUod9brRZHDyZRnOev54E9mnogp/W/TO5pIJbihcaO+jd+eWLyWSN5CQrAQaalStWfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791579695; c=relaxed/simple;
	bh=1r/ci8qKhAH54fHcZTAKcAslBQfRJxklNwHxFyjVeeA=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=HlBoP9QNUY06BaEtjloMuP65bFrU5qIVIza/nVJdcceAAr5eyIsvXHmBglzR9hKXiRQmSzNnTUTD4ss/S8VHwg++zn+p8zLVMHICHNFO75Oi0LAUpKLGtrAXiAuF9E8tPoK+cRy2I1zWfrt8JlwYlNvkLNX/oztMrYnoELVYaws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xwj0dul3; arc=none smtp.client-ip=209.85.221.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xwj0dul3"
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-5e3e525cf4bso110536e0c.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 09 Oct 2026 14:01:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791579692; x=1792184492; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=CZaZBEle1j0w30EYfQOHnRbl09ELOJsYUuewB93KAXQ=;
        b=Xwj0dul3XSi2Ot20Y8wf4A3BRNTDlcWemidtYkW5y5v3MBDplOypb66eyPjmMi2rMI
         iTG2RWbHvVLv42fFViPGsdJOO+Wba3yOjR+8j/YTQIPuP0hVo0HMWN+u7oiwIOynZYFq
         +3g36y0Ss+2+JkVxsgS+J6PGx9I4zrOSld3g/SPl2pOI/dGbFngUcWxEIa+pj+bByLLK
         93cZY/AWraeOnlLhYMbT9eRjvg7Y7Delzzxv83VXPdeYJ24MEcmN1o7Wxw4TU9qLZwSK
         6eg1Z0ihVq4xh7UImqcenFA1RgLdsN7DXT/BVi2F6w/q1yQC3r4aKj+Ibbs0D6hCQDZV
         hnZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791579692; x=1792184492;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=CZaZBEle1j0w30EYfQOHnRbl09ELOJsYUuewB93KAXQ=;
        b=oh3I+CMXnUHS8qn4b34ETXK+CBhxmUJzdSk2WwMMplZiKOaCeVP956aU0ylK/dutOx
         jDHZ5GxQUq9+cY0BdZGtMleHWe29NTEQVhxtnGfsDLjUTYEwYGjzz7JGvfRJKUHR/xX9
         A0geZneLF2ivXX/9ynmKqDxAUI2BJ941xZU8zTj8CvqNc6EnrsjBq42vq3VNsWiqwvGG
         YePs0z/b9S5S3lYGEnrzquClTXl9OgQjru0ZwmaylxJcow40z+OkPIXyZCq3+oScbzFr
         0aqGicMgG9ukH3O5Q1baXO/dHkkFjicx/w/WUpRDFo2vA8E6yyh2Vl7LfehBsmspW4RB
         HjBg==
X-Gm-Message-State: AFq9FYJ8/YY7S8+XhO4Emqm8DsS/lAIqdZnq/WKBRHqkmCGhYHUW/PoL
	kq2S0Yk1UvRN7oRk1UcXrj/KiTUr7l4WhgDroQJULGE/pRjRR2orTsJdopyjPA==
X-Gm-Gg: AYBFou2ZpNn2qYCtwDmX0VLYInxp4vziXvSsCOiHmZqf3pkBGyiSqLjLMzYGQHOigwf
	iVJxUeHhbHO9E3ZjvhIW2OOTzwmOJ9udb27aXPnQvMulAIC5q7R1csB5daDBSxXHFcWqPeMf3WS
	qVQfDSvBGHuC0fgHbXri/M+7eXwX3b+b/HjiXhuog6RzVm5ZUcfnxctcG6BVMzGZVVT9B1eD8/p
	ywsCLBsuEA/aB1ecFnFMEL7bPtmYCSce0pkwWarnLj1fOiPT83U3n89O5X5o3anWyI12erTcGjc
	rOiL7cCZaOySoPWf1lRZdhtdHfiIrJGw4J2kVdMS/OAE057w+N6j7I8pqN6jU9BKwSOEHuPbtYJ
	Bt1qSSAv3Fj08Ehfb4OgBcUpe981un7v2dQtAMhIXJiVt2XqzMc+xMOaS5IadeCpx4oqEJ3lZ4/
	nUg7/jkc/EfL9kCyqvc723t7Wr8UhhZcDUAsPgHEUAZuTFQiidMtV9cZXdmbpMlt40yfTxH80EH
	qqY
X-Received: by 2002:a05:622a:418c:b0:535:a5f7:d585 with SMTP id d75a77b69052e-535a5f7f25bmr41126681cf.63.1791579680643;
        Fri, 09 Oct 2026 14:01:20 -0700 (PDT)
Received: from [172.17.0.2] ([20.161.69.70])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91b5504de42sm27917366d6.24.2026.10.09.14.01.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 14:01:20 -0700 (PDT)
Message-ID: <6ac95620.a4ae4f1a.c0f8.b3e7@mx.google.com>
Date: Fri, 09 Oct 2026 14:01:20 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2370043091216412931=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, kevin@simpleble.org
Subject: RE: Add Role property to org.bluez.Bearer.LE1
In-Reply-To: <20261009180448.29117-2-kevin@simpleble.org>
References: <20261009180448.29117-2-kevin@simpleble.org>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2370043091216412931==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1182613/

---Test result---

Test Summary:
CheckPatch                    PASS      2.34 seconds
GitLint                       PASS      1.64 seconds
BuildEll                      PASS      20.03 seconds
BluezMake                     PASS      388.62 seconds
MakeCheck                     PASS      14.38 seconds
MakeDistcheck                 PASS      145.70 seconds
CheckValgrind                 PASS      234.83 seconds
CheckSmatch                   PASS      296.08 seconds
bluezmakeextell               PASS      95.20 seconds
TestFunctional                PASS      1219.26 seconds
IncrementalBuild              PASS      440.58 seconds
ScanBuild                     PASS      1152.57 seconds



https://github.com/bluez/bluez/pull/2645

---
Regards,
Linux Bluetooth


--===============2370043091216412931==--
