Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E349277CA4
	for <linux-bluetooth@vger.kernel.org>; Thu, 10 Jul 2025 17:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752169198; cv=none; b=MxuyzYf1QfxEz0MQpgzQjiZ2QoBW0183Wd1M3NdH6ST5treAixvIq7HedZL9vnX6wNP8Ne25Vleokt0uqDlJ7+9MJOqmHvL301BK/EiJZDWVxUX2jhV1uKYq+3dxFSUKHKSImO4t+DKa06ySbkt6hlnJwLoPPMUS5GIBPl0YJKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752169198; c=relaxed/simple;
	bh=QNDlFwQh6lf5zv4o8zLRW3nFKDHcLU9Yc+LFVXqCR1E=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=L9B+mGI9xeCRIrjIWnSsHm10QMseqN5NgyciDgCAQWlogxXr2k5I+sH/Ma4QMMR1fcF7NVSPEI7WNTTQictTao6RrFyj2Ij4ghJlCaeGQ7N5vDqHoD1JY4p1fXzyMqz7yEeA7va/J8Ch9oiWavPufekED/WMSHZJ/pTh8oKsTaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RXLASJRr; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RXLASJRr"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-4a585dc5f4aso15590981cf.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 10 Jul 2025 10:39:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752169195; x=1752773995; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=qUBY6BCJ/VzXWC69hs7KxISQCSFLsIa+2VPyalOMVw4=;
        b=RXLASJRrpiprtVFKx6emTmO9iYwfdazhKE8BsgVw1xjVZPha8E0tpPbCb2wb2QTcLM
         C5Fr0Ymyp0fMwthez2dPdzUPwpUYIGoIL04roji3lth4oi9eipOV5ty3Jzg+rsOtnVWf
         RrPKQdtgSzM8nyWZnpiZvNufZCaiHUWwGfWSDO5TXJH6k52iRvw8yOOS0AYwe3Oo5Ah3
         d9RcUmEHxLGVTGUHTCFGDVtxLTzWOxLGCOAbqrVGQHtoHGs/TD9XnQHpTKAKtFdXNpLn
         vdPdK5OLdE/QPETI+OfjSgyCrk6bG2zabxvLFZjJhMOLPylBCsQZaYmWqAL13Tkqof3r
         riQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752169195; x=1752773995;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qUBY6BCJ/VzXWC69hs7KxISQCSFLsIa+2VPyalOMVw4=;
        b=J16gFl/iulPY6bFMWa4wJCLo9O39wcwktjM8wky/RIGBBUgozuf1JDKn6c4ZIuRW1f
         rfoNNQye/l9LY1yueBxpNGJqEtOlmwB1GKpxEaiXd6B57mfjbdoZ3VmyIue/kjOyF3Ss
         /piw1NW6Jm9Ti/EVZ5L3SZiD9SXpoHzfkBwH+YghmIQwrnJ6+FSYKoPm8QvBkoHlt+Ej
         r52OM3CSpYBKgm54N+Ez/oyA9zG0feMvhwlAeqcokcBI0G43Kkn1jx87E3P1tpRC0CnH
         jE4q4KDA/sV4eNz8J3l73VUQUYX89iKVA678sng5vYYPYNKgllh9hMlvqeXQaZ3FE1jP
         YiAA==
X-Gm-Message-State: AOJu0Yy49ldZpm9ar0u4J5djpNcyviZOr2Xgtw149c/lZdqlGtzNEis+
	IVFwo7LdXXBryH0P4hpS5GRvzwtfeOQfdqxcQhVwt6sGAiNxI5/78xXdaifyNw==
X-Gm-Gg: ASbGncvTMlkgY8zuYat2NTl8YVesv6zLWANYn1FrEHzeNHzeaj9x7+mtpA0lQ5Aw5Ri
	exsDzgMmZsR7F7IEayaY7p88fIKJstBF/YFz/UQV9Fy5tYsf2GYTh/ZN95JEtjNv3zZqVt80RGc
	V9V1qFdiEZgszVVW1CC60ZVnISmg4Q2Xi8FAoqxPT4g7Dy1pUEftA6/IAlKxVxvVkJjifqJSOO8
	pXxFEgCud5+l8yEvGaTGpmVMeEa87ctScqKa8PYItGXL4TzAbkPCvEGU9MOGzBvhk9JUAZ3h1YF
	hUrjXb6DQgXGBpigK7K00/NPf7vU7fMuK446cG/R6OB9a4xF7MqVmvHyJ0sdxgaEFbY20uA=
X-Google-Smtp-Source: AGHT+IHr+5AJ+HpMiuOr9ZTuebHlRXziC+QlJ1J5p/m8XZPwhaNex7FrisBJt8UDJB+CMXQv8oEc9w==
X-Received: by 2002:a05:622a:446:b0:4a7:5c21:d4d with SMTP id d75a77b69052e-4a9fb85bb79mr4789161cf.3.1752169195510;
        Thu, 10 Jul 2025 10:39:55 -0700 (PDT)
Received: from [172.17.0.2] ([172.190.169.222])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4a9edc18cacsm11186841cf.9.2025.07.10.10.39.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jul 2025 10:39:55 -0700 (PDT)
Message-ID: <686ffaeb.050a0220.9e76f.4bb8@mx.google.com>
Date: Thu, 10 Jul 2025 10:39:55 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2522722796674062231=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, frederic.danis@collabora.com
Subject: RE: [BlueZ] doc: Add new telephony related profiles interfaces
In-Reply-To: <20250710155956.884934-1-frederic.danis@collabora.com>
References: <20250710155956.884934-1-frederic.danis@collabora.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2522722796674062231==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=981119

---Test result---

Test Summary:
CheckPatch                    PENDING   0.23 seconds
GitLint                       PENDING   0.25 seconds
BuildEll                      PASS      20.60 seconds
BluezMake                     PASS      2976.86 seconds
MakeCheck                     PASS      20.60 seconds
MakeDistcheck                 PASS      189.67 seconds
CheckValgrind                 PASS      241.26 seconds
CheckSmatch                   PASS      311.14 seconds
bluezmakeextell               PASS      129.81 seconds
IncrementalBuild              PENDING   0.25 seconds
ScanBuild                     PASS      934.76 seconds

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


--===============2522722796674062231==--
