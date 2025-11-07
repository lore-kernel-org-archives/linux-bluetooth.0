Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D70F2B9B9
	for <linux-bluetooth@vger.kernel.org>; Fri,  7 Nov 2025 14:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762525125; cv=none; b=nRpX4rn+neMWKHVWNGpO2XX7Q2LaFCQaere/zEBLM9HkxpQMzw6Y3LT+c5xmpdwsfpOqG2ARuzWHDYT5nwpTDnaa6Ciz+nLxw1JnA1yRkVvh1fkRWIKsl/0RQnW5GUJ3P0W98DsWVXlDd7Ypn00bJx1WJVabOhtTlIFeETMboA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762525125; c=relaxed/simple;
	bh=fuNtn2rqdn3YyK5sp2PqJYSPX1Nmh3Z9i16w4izeOts=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=NPlR1ywrBKd6hLo/0gYP7MgHmsLnepnU3PiTkkO+gtKRSuo8AuJaY+BmYDzRAayTn7HoGrIRKV1fuSmZVu/8hZYTgLjiBtc1Zwx4tiHZRX/IKnVO4ZwUr2jA2bAiN6ZcaPGAuBYNJ4g1Nh9f+IzETkrkixB7kY4D8AXrGGEOrDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XmXVTOzY; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XmXVTOzY"
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-81efcad9c90so7638426d6.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 07 Nov 2025 06:18:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762525123; x=1763129923; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=u3rg/gyTLeppYrmVqB1XQiD2T7i5K+sSrCk9VHL80Qo=;
        b=XmXVTOzYkRuu75vx3YoRI2twi/8LXZibHny+9G7A2RUM9vWkbBW0DN8OSLW87mxGWo
         e1r7idDgA310fFAk0ZhbCEhIDYApaj9/HU6hyvOTQCeipQhHRisd72gTsyimjN+ghF/W
         ZUFvhcWFcTF28+lsfyHEmjda9O5kjc5RaaGGhhbSP544JfK/q7iW4cBo3RFKHbmREe8x
         njJzNaqfS0bOjewoMqNuHbTHp/vfkJ0QzxP1EttRHcsWdtkFS50lSmD8KHClXDkhADbk
         XV209ejZAbiKqlbXxMvIZHDdWLarkK012Cg1bKALpaeA2HuDl01YHnsWr8O5PNm+Gk0m
         0fRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762525123; x=1763129923;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u3rg/gyTLeppYrmVqB1XQiD2T7i5K+sSrCk9VHL80Qo=;
        b=xUM9Q/Y8lkjyKny0NMbwwZQShujlA8HlMUOqQ/rrJjjZIfjpTK5D287u/Lhw+OpEnk
         oHGOuHE7f6LT8gCa02j+pgcRqNylqavjgflDHIYvjZeURFwfnCoOeMbgA9UzPBSYWEm1
         Yw1BX2+3JM+dksLuEkV+lEx47RoyQVFMoUb87W5BBvHUN8wiOrFqyTH9iajA+nWnf/YJ
         79XR5vDuHB711kmSHDli59Q+M6fSmf0lsCmQ98hx1kTvUU3BtGumwlxwvYyCtvdoo0Fa
         q8SP57mXF5tE1yaKuBn8No3ES/SVS4BqKCxHAIHk5ajag4m6BFTat9fMz073p9cs92h8
         v1Og==
X-Gm-Message-State: AOJu0Yysz7Y2tApJRt7PxmsejwDUy8Qe+We4s9UbLdiJT68uI3Es9Q5j
	g5uEFGyUmR6JbxO3YG5cp/5/KCE3uSx1qSjXLhAsDhD9dZKwLdbgy5ORo6pqBQ==
X-Gm-Gg: ASbGncsUICEhHRVigDkegO4h+8R4iFy+6e2jTAJvLQ2Bmw5LrvTL36c09+s3oPbf7U1
	VeRIS0uuEOP3SwPhvcrgzMRBOH2kqiGiR6T5+m0A0iLX4s9cub2BmR8G/O0l5CHoUJh8TbMnoNy
	Dwu+dZw4t9WyPmLRtCAiU76Umr1V7h1Afv+L9IZGP8wZkxR4UOqRgsBJ5sW8Z23REuZuazwZsdX
	I8RwNA9ijJRDqdKL+yMM7SCoGIc+5BYffCLzZZwrzP7ffk87Mj9pEub4nWVng1ovtre7J4W0Nz7
	P/igPGSuQIrrTIqn1iJF4KRHIn4cDryZW8IZxMTqL0zhTJZ2XGN3zgeeeRSoDspo23Nu5FjDAro
	QO5Ck6zWAHul6tNZ9ZC2PKCzQNKwBp8K6ZDVRqp6CV34C1iSKoLeY4/redgQHgl1lDjFOlmoqRz
	hrALW43A==
X-Google-Smtp-Source: AGHT+IG6enkd7vVVfSxYAkB9qCHSlqFtV7spDZjzXu+9tOwqY7hsMHFyhdSMGl5Qhei6JI97DVIgHg==
X-Received: by 2002:a05:6214:3018:b0:880:4f63:321d with SMTP id 6a1803df08f44-8817679cc38mr40882856d6.58.1762525123024;
        Fri, 07 Nov 2025 06:18:43 -0800 (PST)
Received: from [172.17.0.2] ([20.62.207.242])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-880828c457bsm39650906d6.5.2025.11.07.06.18.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 06:18:42 -0800 (PST)
Message-ID: <690dffc2.050a0220.33b55.a098@mx.google.com>
Date: Fri, 07 Nov 2025 06:18:42 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============1136728453005403416=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, pvbozhko@salutedevices.com
Subject: RE: [BlueZ] The GATT.Client option is in the wrong section.
In-Reply-To: <20251107122734.228-1-pvbozhko@salutedevices.com>
References: <20251107122734.228-1-pvbozhko@salutedevices.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1136728453005403416==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1020865

---Test result---

Test Summary:
CheckPatch                    PENDING   0.30 seconds
GitLint                       PENDING   0.23 seconds
BuildEll                      PASS      20.34 seconds
BluezMake                     PASS      2653.27 seconds
MakeCheck                     PASS      20.32 seconds
MakeDistcheck                 PASS      183.30 seconds
CheckValgrind                 PASS      239.04 seconds
CheckSmatch                   PASS      313.07 seconds
bluezmakeextell               PASS      127.65 seconds
IncrementalBuild              PENDING   0.24 seconds
ScanBuild                     PASS      910.29 seconds

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


--===============1136728453005403416==--
