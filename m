Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4907A2D
	for <linux-bluetooth@vger.kernel.org>; Fri, 27 Sep 2024 15:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727449893; cv=none; b=RqwysD+TBLgDASH8+vNQj8y+GclPYVdiHpkgQS5MeAaEpPc8VfG26QeXRzl163fboz5gW6RwJ0Dqqqe4883ygqqTAi93vspcfodx+OpJrvLMpa2U4vQYAESwKTAtRlH6skRFZMO2kuO06epvZ0hMvGc6kOT1IypcoXISLwz5nkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727449893; c=relaxed/simple;
	bh=A1dmvR5ujCUrlu4UFasRKejvUVAAd1d5a5k3WRw2fTM=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=qZ6BqGAP6IUZosVlCkqqkxvzYWi2HlrKhTmZrxMUNLbjjStZDkHXLzG46yfqlsWHSjlE5GMwhjH25n0gIiqZY0GRAEivTYVLOlO9+qupKzu/gSxDlVRrjABfjCou4pTZ7hHp1Ee6vlYPvOYWvVbP+kINZ31EoIlaJXvjEmDYGXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VqZXvTqe; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VqZXvTqe"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-20551e2f1f8so28167215ad.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 27 Sep 2024 08:11:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727449891; x=1728054691; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=6rV/QydA9hsv+8FV2lXu8IFOuz4dobPRsNWVJNwxhHk=;
        b=VqZXvTqeml5mH64PxNNJfkStiVui5ph5CN7SJMzyh2cTK/pVxbCJou+XAbGmAMT3Os
         /QQqIpPK9J2wUJwckN56q4bEBzDtyGcYW5/ac0O/N5NciyBdkXfnpgwBaEV9/6MZ7KRN
         jkXEkEHAKknyUaHgvhV2SOlIzkHkhIg5wgwbzuoXkyy1M86tGQJ6h8/wr770V4/V+LG0
         lDlAj8CRUpKF6Am9gHgwqtCDk2qEBxTRME+K3xkY43eymEI7e3Yo6rQW1+aiJ+ZzJJXt
         kf0mh9I2PgJHlqrHRSgXUc3FS+I2rEOOMOCWUUC6ZwsXDMmknn6n3Zz4IRGPzfhqJH0D
         SQyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727449891; x=1728054691;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6rV/QydA9hsv+8FV2lXu8IFOuz4dobPRsNWVJNwxhHk=;
        b=UevI5BPJBKYDm09xuujNwl1GTiptHk1WiZprI9y8LcNaq3owNLUmDfz+emvGAx5BBq
         c95Zltvz+7TEGdzIAcFXxHEII8okQM8NsNY64PwaHYgmFhcHoO+OIZQt7flDzUHKF5Jg
         x7VhYUM5QwRjHFy+3llMZ4eVJaVdU4imJ/Pj46d/eW6SEiw37jbd3mtIU4HH3mykrMcx
         cQkMZ/yT6t2C17LjsbZxrNOaC/ZuwXQZdSzJmxhYD25qdpy5VsOth85e0w7bPTG8VD6C
         gXixdWhgdx/Qd3ajWhmFbOyO//3J6FN3oRgdTIwbfYAHK5KPqmdcLFCrazraaZOrv53n
         D51Q==
X-Gm-Message-State: AOJu0Yylot1j6puYGr9CG62oYyUg4ce3MGLphGi8nfIa/jG97p5fScsH
	kAfffBi4/K7+hZmqNOZ0uNJ6NtIuKMxo+oseCRi38l71vkMogGaPwGJljg==
X-Google-Smtp-Source: AGHT+IFkHnr/IIDMvP5+dw2OuITcL5+1UATyfpu6c3GsKePGcYANzV2ZXyrjnoZAJQ3Gt6ryi+nS/g==
X-Received: by 2002:a17:902:e881:b0:1fd:5fa0:e98f with SMTP id d9443c01a7336-20b37bb84d8mr55040725ad.44.1727449890579;
        Fri, 27 Sep 2024 08:11:30 -0700 (PDT)
Received: from [172.17.0.2] ([13.83.123.119])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20b37e32c98sm14699005ad.192.2024.09.27.08.11.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Sep 2024 08:11:30 -0700 (PDT)
Message-ID: <66f6cb22.170a0220.33f1b6.76d6@mx.google.com>
Date: Fri, 27 Sep 2024 08:11:30 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5888747292132079647=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, quic_chejiang@quicinc.com
Subject: RE: [v1] Client: Fix the list_attributes command returning nothing for a dual-mode remote
In-Reply-To: <20240927131441.2617450-1-quic_chejiang@quicinc.com>
References: <20240927131441.2617450-1-quic_chejiang@quicinc.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5888747292132079647==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=893475

---Test result---

Test Summary:
CheckPatch                    PASS      0.39 seconds
GitLint                       FAIL      0.49 seconds
BuildEll                      PASS      25.04 seconds
BluezMake                     PASS      1799.90 seconds
MakeCheck                     PASS      13.00 seconds
MakeDistcheck                 PASS      180.98 seconds
CheckValgrind                 PASS      252.88 seconds
CheckSmatch                   PASS      359.66 seconds
bluezmakeextell               PASS      118.95 seconds
IncrementalBuild              PASS      1625.03 seconds
ScanBuild                     PASS      1067.91 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[v1] Client: Fix the list_attributes command returning nothing for a dual-mode remote

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
1: T1 Title exceeds max length (85>80): "[v1] Client: Fix the list_attributes command returning nothing for a dual-mode remote"


---
Regards,
Linux Bluetooth


--===============5888747292132079647==--
