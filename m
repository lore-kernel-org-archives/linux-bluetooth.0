Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 425BD2D5C67
	for <linux-bluetooth@vger.kernel.org>; Thu, 13 Nov 2025 17:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763056061; cv=none; b=brT0R9mDDyj+jARM1Rl6kqgspI6+mR6uDEO8+CHwCAp2h0HjzyFQpfgKfEroXEjMUHinMcUgB8Q5p4eVyHPJ8gYbeVU1jaDQRGu6xRWzxwIlCJUSPosEaSt8dkQxGS6uIG7R7fqGAOGQAyIJJdZBVfoQMHsf+BXwMG8LK+ZT/Po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763056061; c=relaxed/simple;
	bh=FcuHoa9EKv6W36dHde28kohe6c75B3aDeQKTmo1Rq0E=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=K8c7Y+WMgDoeA+t/Y+eNRZziAiFgI+HjxV+oUVzr114ON1iCTk5+iXYuuCmWpy+WD4KeRf9D7y2knbkphRlZIe8m4F8QyjFpwZEJNuiwv55UJ0bRus54V2RrWWFslpjWgJlWgAYiBX3wMqZvlHCAgsVa4wWOMjz8MmCLqxjF5aQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BwmIh9Mm; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BwmIh9Mm"
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-8823cde292eso12017616d6.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 13 Nov 2025 09:47:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763056059; x=1763660859; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=LfXtq7ResJPVcUk6kkSsWmBKGXqdP5cwXpuRdR217Zw=;
        b=BwmIh9MmY2c3DZz7yzhcHxL5xIwD2qM6lJuBiIIBqV56/sV/4c8O0t6MFQH2aW4f2c
         kSqXjx6wmzAiAoiwHPUKZ+fj1bOQhIr9RCh0z7t6xAktYKhQtKH4VVeXSqaxlI12qeYu
         eRs2OZPCFEGbiw2hiH0bB+TOay57+Rm2HILQngJUiqG+yNJhwDUCFo0p2Vh+7pmPU5Dm
         V/Z9H0R2k2DyZStXHXY0MtXAOiPltKZoMjB0Xfk1pB169G381vZ3dWhaINV78WGyfgJv
         ub+5MVdWuUKvjNfQ25XT8xupXEGXf+S9JQtWP+34Cf08ajWh3oeAz0hc0xO1mVKPIK2U
         L88Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763056059; x=1763660859;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LfXtq7ResJPVcUk6kkSsWmBKGXqdP5cwXpuRdR217Zw=;
        b=oXpsrYwuBUIH77AKbOCFms8X5HLQAECi1geb4eF37vT+M+jUnrQnVwED+DfmZqJsGj
         3kN+6BT7znfEnbOnYIu+v/e7r9p2388rEw01iAs98GWXATNMKTJyYN6Rm8ZoYrLmZ7EL
         8hZRQ45DZE/scZiyCMrBvfjUNl0OfaC7zifYVkFQEAFksYKcGoO/8tC6B1uAzkpZ7dxE
         57xmqTf0rVqAYyU3ZBSPEWMjszxIn8PJRUfjUblEdBfIssBuT+9hnfDTt6YWVNcU5ITO
         n7g50PFq49nxmj71CcFSllyHVdFQFQxTnVBuB523vXKNC/qL3Oyjn8IkHsVbCusgF+0m
         MIvA==
X-Gm-Message-State: AOJu0YyWcC8hm0fIlEXsztWeofZ8zZBz5c49mV+Se1TaGccODVzdjnCL
	znEQxZIYpcaS9xdzFOpyhg4gApa7o6d/eGVj7hfJRFn46VAMW96Vk0Hx5zi0mQ==
X-Gm-Gg: ASbGncsMYZg5q8tJ9tNkx6tdwXvTwIyNSavxwCClBtnsASFJ8VLMcA6ii8qO7FgBg/B
	QuS/vlTEX9qH2jz1EyQns+N4sU5Z8sATi8/Aa2jnphz2Btt0BF+uOUXiBWzNphJ7d0mRJWU/XYJ
	GkU7PmlXFmG2FrQ7rwS7/JMn1rCDComUxi5O53Z6YsQX8rvfJjE7OBVFLz+GxkOVbAHu8i2w8z9
	jWWqvghitjHjM2px1MyrtGIxYG1A2fSfC+4au4g0HVd9nPtgSHp9jFgpZ9rOEqSGNEhipihQfVP
	DECuedCdHaVhPfmcCvueD/6NQQf27LWHbRhkWN1q5pYZwiMuZZ3145KE45MdTXdnUDSA3hn2XVc
	3vHo0F1C0eRiMDbbTVaInu4ON70GYEK+hlGeA0uGdwmpu25wfd8NiT2D5Jz89KvQQgPNAc+jflB
	b0N7rNTVgC1vLdTJRw
X-Google-Smtp-Source: AGHT+IEfMtcBcmWVgT1n+kbdowTwEo9Ye7bV3kckWnxmg9zB2C6nskC+rlWdtgBAXuQofysulOz6ow==
X-Received: by 2002:ad4:4ee2:0:b0:882:3156:6180 with SMTP id 6a1803df08f44-88271955d40mr119575956d6.22.1763056058778;
        Thu, 13 Nov 2025 09:47:38 -0800 (PST)
Received: from [172.17.0.2] ([4.246.135.160])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8828631454csm16396016d6.18.2025.11.13.09.47.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Nov 2025 09:47:38 -0800 (PST)
Message-ID: <691619ba.050a0220.32f3e5.4f1e@mx.google.com>
Date: Thu, 13 Nov 2025 09:47:38 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============8919015383555450159=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, pav@iki.fi
Subject: RE: [BlueZ,v2,1/4] shared/bap: fix channel allocation logic in bt_bap_select()
In-Reply-To: <69ef74b5d531804f4f793f42032da508d1497d1b.1763052876.git.pav@iki.fi>
References: <69ef74b5d531804f4f793f42032da508d1497d1b.1763052876.git.pav@iki.fi>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8919015383555450159==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1023092

---Test result---

Test Summary:
CheckPatch                    PENDING   0.28 seconds
GitLint                       PENDING   0.36 seconds
BuildEll                      PASS      20.20 seconds
BluezMake                     PASS      623.12 seconds
MakeCheck                     PASS      20.71 seconds
MakeDistcheck                 PASS      232.37 seconds
CheckValgrind                 PASS      287.39 seconds
CheckSmatch                   WARNING   334.96 seconds
bluezmakeextell               PASS      173.51 seconds
IncrementalBuild              PENDING   0.30 seconds
ScanBuild                     WARNING   974.58 seconds

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
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
src/shared/bap.c:312:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:312:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:312:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structures
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:

##############################
Test: ScanBuild - WARNING
Desc: Run Scan Build
Output:
profiles/health/hdp.c:644:3: warning: Use of memory after it is freed
                hdp_tmp_dc_data_unref(dc_data);
                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
profiles/health/hdp.c:800:19: warning: Use of memory after it is freed
                path = g_strdup(chan->path);
                                ^~~~~~~~~~
profiles/health/hdp.c:1779:6: warning: Use of memory after it is freed
                                        hdp_tmp_dc_data_ref(hdp_conn),
                                        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
profiles/health/hdp.c:1836:30: warning: Use of memory after it is freed
        reply = g_dbus_create_error(data->msg, ERROR_INTERFACE ".HealthError",
                                    ^~~~~~~~~
4 warnings generated.
profiles/health/hdp_util.c:1052:2: warning: Use of memory after it is freed
        conn_data->func(conn_data->data, gerr);
        ^~~~~~~~~~~~~~~
1 warning generated.



---
Regards,
Linux Bluetooth


--===============8919015383555450159==--
