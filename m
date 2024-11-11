Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E72F719D080
	for <linux-bluetooth@vger.kernel.org>; Mon, 11 Nov 2024 14:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731335719; cv=none; b=mpwXeCdNhyrjHx/WlGOtvr10Zijjyt4ZT/TTupFUWg4zQVG9inYqGda4aoEOhy6JuJpqg34jz69J0ZrgxVKm2ZwR+dzNb9+mc+1eLAod1hoiI5OP8vOO0Y2U4ae8C/xSkysi/kqmpa/PczPblNRJq+2xFoQi6YedLu6dVm36X9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731335719; c=relaxed/simple;
	bh=uUP3u0/obX/4GsOAeo66zLpTB2vDmdUkKImypLYPdZE=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=eCPoyWSNx/txwARvT6CdUnECVVLyB+EX3fA6allrgmzm0oK0EhSeTzB9RwqqveRGDgvHUe7peqwFk/9BicIATQN7vLs/CKJl5+phlOZUZbuOiRBeKxqf7Mz+psvhYplnBlOBD/7IHnK8Dk/XQdxaZyr8p09L/wrsS3m3eJAr96c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D2+/isOb; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D2+/isOb"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-20cbcd71012so52905805ad.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 11 Nov 2024 06:35:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731335717; x=1731940517; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=zKKZLT32gT1I0hdmOmATJU2RraYYhBnDcJtVM7VU8TA=;
        b=D2+/isObnoqlZbd/+Ub9ph95P85zhsCKxKCVLW8RWJGI/wOpXTGw8N3x/Psmxed7do
         et4wKjVdeYY54adczj+fa5RJHmrT0Y4P9s81ek5viWp2Nk5e7yjJspDOmQsEM8nhrn4z
         WQ4+aIJ9Qg91cZBlRB5AqYqZZPjBAP8PyEYZ5+NSnJacgH49gVZHVZ7RQMADl0Q/fGMc
         3QLZdF6p7GVrK1lXg4yZjfPaYu7VxAjnAoqRTawx6NWN6t0J1IRtIFPaXZu80Cbn4EIE
         1dWTUztJHbb2Q1Nug5yZQqlS2daDIR76crSmJ0HKjXLx90eavhxzjVVWMcCyBXwZhzM6
         EN2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731335717; x=1731940517;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zKKZLT32gT1I0hdmOmATJU2RraYYhBnDcJtVM7VU8TA=;
        b=F9xtGPfh/kFC2mIoeVkP44+21QcWkCjjabu3/HDBmIsdvYTMdXMH3ekJepvHQCH6a/
         LZHtIsdZHLdeug6kzV93h+qFZ4UQeVUi3EPTBOalTSQ2l69aDBDDUb2yuHjlK6NEkJIV
         xrvDbZMiKMQk/XDOGp27g09yEEkbJYFgX7mJ/xPN8AnsW0yJGbCp3ERBkNvjMcqT82rC
         bJhDY7stbPMkXsu9+/zmWq+s2MV+jsekF+DPuuJNDDkNzY92kwDdpv+rveufmddSFjjq
         kepkVC0kFTMU5kxpH86B+q+0lI857+hEn8h/lKABV0AIGBs1aBNk1mDMPFAnYMyM5jh9
         RVUw==
X-Gm-Message-State: AOJu0YyQpTh+3G5iUokic1dLxlIcqp1GGBktuSBWuIeUr08YyWyI3dSy
	+4186rqRxRwnIEHB1V6Q2y3zeeIxZ+A6qp7sh1G1p51WwKuiM7/z8OupnA==
X-Google-Smtp-Source: AGHT+IGOu/fdkhFi7Ne132kHLlLEJ/ExYuEycZFmxE0H+FnuNoFvHJcvzlrLE1NUbBhQLZ+/WR1j8g==
X-Received: by 2002:a17:902:d48e:b0:20c:8dff:b4ed with SMTP id d9443c01a7336-211834f9450mr192828025ad.16.1731335716940;
        Mon, 11 Nov 2024 06:35:16 -0800 (PST)
Received: from [172.17.0.2] ([52.234.26.91])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21177e5853csm76192945ad.186.2024.11.11.06.35.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2024 06:35:16 -0800 (PST)
Message-ID: <67321624.170a0220.2c65fb.edd4@mx.google.com>
Date: Mon, 11 Nov 2024 06:35:16 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============9045524425153275789=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, quic_amisjain@quicinc.com
Subject: RE: [v1] obex: Add Newmissedcalls tag in PBAP GET response
In-Reply-To: <20241111125518.2039073-1-quic_amisjain@quicinc.com>
References: <20241111125518.2039073-1-quic_amisjain@quicinc.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============9045524425153275789==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=908402

---Test result---

Test Summary:
CheckPatch                    PASS      0.27 seconds
GitLint                       PASS      0.20 seconds
BuildEll                      PASS      25.99 seconds
BluezMake                     PASS      1841.69 seconds
MakeCheck                     PASS      13.19 seconds
MakeDistcheck                 PASS      189.67 seconds
CheckValgrind                 PASS      265.82 seconds
CheckSmatch                   PASS      374.04 seconds
bluezmakeextell               PASS      126.17 seconds
IncrementalBuild              PASS      1611.11 seconds
ScanBuild                     PASS      1107.04 seconds



---
Regards,
Linux Bluetooth


--===============9045524425153275789==--
