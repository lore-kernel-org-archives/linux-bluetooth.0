Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A6FF199FA2
	for <linux-bluetooth@vger.kernel.org>; Tue, 28 Jan 2025 11:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738063946; cv=none; b=JZ0y3VQsQcj6goEp3KFPsDc0WVygUg5yzN9C7TKnpMpE4WnManpSl/US0x93/fdQEsFcicMm5lQKf7uB1syTN7L0hJJ0gcBTUXDFlog6Ztw/5logsCUemkblFoNB12F6R6N4DqhjmcTE9LpeKP+2OZcsw61uLv45gqrRWlHVWmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738063946; c=relaxed/simple;
	bh=rtoGhUIHckXAbNrVuZ1PrhlEqE1dQ8MAQaebRoOYJ9M=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=UgAn/iipLekWs+dSe2Lw8Lgu+Jbwuo4YKcBUDuoE+41MAwFXYm5to7Vx9HlVXy9lQli5y6LvGrMNwuMQmRyhCWwWvvJg2gt7YRbofN+IvGplrysvUL1DTRMlcavEuDbZhd0Xaw1O5+yNLD0dxxl7vspu2dO7y5f4OaQNcYI6fQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ju639XXB; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ju639XXB"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7b98a2e3b3eso291257885a.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 28 Jan 2025 03:32:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738063943; x=1738668743; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=YN9wdLJuvmyu6xaF00wZhgKHMv8xlXPgoUtQDTpED3Y=;
        b=ju639XXB947kpdcCNB+xWZ7qkXE4FtbCENxIbQmEGW7NVHyEd22O911sngo7eHJo5p
         S3osYDxPdkdyvoPhRkoXJvRPaD6M2WFhSRowqUuf6FM7/tVo/tPksextX3qkETmxVHKX
         riX8CZMzgJSNawnI7ILvATr/SpeswxMDWREXT91i0KJXdWousgUxvsu0zfPneF+2XYQe
         ZonSPI40UzbZVV6dx01+bgeu6m3VAamZ8Tf7wxBKJs/tUXdHtethYVeysvEl5wj3D6kW
         9UDXTmXAIgGrlS6Ru59BvaU26LUtHNyTj6Z1mEjIR9a/sWjYYyZgC6QLhg1bqAOAQqEA
         NUvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738063943; x=1738668743;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YN9wdLJuvmyu6xaF00wZhgKHMv8xlXPgoUtQDTpED3Y=;
        b=RRnrbDWKE1KyxFcWtoFh+kyxrRiF9qAytlr7uDqpor29Dy3BDzluJnXvsSxjdoUUdx
         q11xCwVLeRS3bA0rhZnNLMaon2hF4EefKjZCsHwMwcd8/WwTB9a15rvBr8Y436juqokd
         SMmFAXXCUHBH33xjgEyNlyq8paG5fW4SUqRMFM+UYxDcpJrc+OK3UaAmD+1oJ5KWXjjw
         9lUKgYMIcew635omC2WALirfuCAmOgb/0e8NqF8u5AxfatKom+Tnw1wYYeI5r90GZYmq
         VCLjbvhwG/CRtnQs5NylnLqoJ1DrTlyoWlxjvKHxT9mtykoUOL3lO/AmC3jibcEKXyb+
         K9MQ==
X-Gm-Message-State: AOJu0YxYGNTzlx5I+2Rr2jObBPsrpp4O57yscMAXTzt7d4Co1HgVe31i
	ACd52TdlGmEWkWdRWemqUeQqMD2MkJzKbFZKVWJzO40eWjHo0Y5KbGGcHA==
X-Gm-Gg: ASbGncv7HcAEKA3zcNeV9NqfV/h8qO9yN1wokTnnu6/Z5kfOLA2Uj/qeVBjXaszmC/7
	eurIz6iMUwiOkvpD0aprg0wGqfkZPjsOvG0QLQfo+fAVHvMoWwAJugi5OrUciETTT83riSddrAO
	GVOB1i0+9FGTYPLyOrcWUCyxry62nTZC7Nm5XPgRjsdtGFIf14eXZW7VZ7UqYMZIKHzlgkxfFBB
	9PRYAOYDYg5MKLI/j1ypHWrxBbmaB6nY7+11378UqL+Shm3VoYpD/ITF1W3raTSWo5RIv8qHfZD
	bu0kvmwge9g8LQi35Hw/fOcL
X-Google-Smtp-Source: AGHT+IHbjJXVliiAlkJEKzzwhErcNIcNSvZiXjYZ9nxtl0o6F9zY+KWdl88B9J6uvknS3terSTkuJg==
X-Received: by 2002:a05:620a:2699:b0:7b6:d273:9b44 with SMTP id af79cd13be357-7be63202359mr7734718985a.18.1738063943094;
        Tue, 28 Jan 2025 03:32:23 -0800 (PST)
Received: from [172.17.0.2] ([172.200.181.131])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7be9ae7fe2bsm498101085a.20.2025.01.28.03.32.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jan 2025 03:32:22 -0800 (PST)
Message-ID: <6798c046.050a0220.105ccc.3000@mx.google.com>
Date: Tue, 28 Jan 2025 03:32:22 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============2876595795102552298=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, ludovico.denittis@collabora.com
Subject: RE: [BlueZ] adapter: Include pending flags in device_flags_changed_callback
In-Reply-To: <20250128102937.16215-1-ludovico.denittis@collabora.com>
References: <20250128102937.16215-1-ludovico.denittis@collabora.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2876595795102552298==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=928792

---Test result---

Test Summary:
CheckPatch                    PENDING   0.20 seconds
GitLint                       PENDING   0.17 seconds
BuildEll                      PASS      20.12 seconds
BluezMake                     PASS      1456.52 seconds
MakeCheck                     PASS      13.66 seconds
MakeDistcheck                 PASS      156.54 seconds
CheckValgrind                 PASS      217.32 seconds
CheckSmatch                   PASS      271.38 seconds
bluezmakeextell               PASS      98.09 seconds
IncrementalBuild              PENDING   0.25 seconds
ScanBuild                     PASS      850.71 seconds

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


--===============2876595795102552298==--
