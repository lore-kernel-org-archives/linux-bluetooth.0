Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEA3B15E5D2
	for <linux-bluetooth@vger.kernel.org>; Sat,  7 Sep 2024 23:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725750305; cv=none; b=PKzjJBacsM4HvONJrwhmypE2V5Pz7MoyoqTcpuqe8cLCgJMrIei8p1amnq7/hOS81MqGGyisx0cWIy+0fhTY+qkHO0hJIfOuM4Dv4nuSGK801k8iudXvmluSjuRPdi+dYMJ2yjhm38j1SCZgoUu9qEIS5jMNViVERX+btSrTQKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725750305; c=relaxed/simple;
	bh=5T+I56KZAMz97k4OmsAKGPbd4ssNFpxO1xLZfJLxI7k=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=VZ/tcTxwF5iQZ2dpoNDWzGh4ts1cFStEELbGwK1v/FY29HcyfSKAQ+9nyoQgI1fKT9nJw8tz1cVIZ3JdIxQS38upV043brUoNKBxPXbawJnHQwcKnBndJfqUUfLfapA1YtPPxOfSF8GTkd8lJ6eMZfDZCrgYhvouklqCnZadfmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F9b91B/B; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F9b91B/B"
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6c3567a143eso18413376d6.2
        for <linux-bluetooth@vger.kernel.org>; Sat, 07 Sep 2024 16:05:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725750302; x=1726355102; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Tx4bPuTTq9ro8q8OYTA+0l12xXEKgJtcmOJ+89v/KVI=;
        b=F9b91B/BcjC5UAvUqm8DzMxGWXtvHbYMIU71slMbBKBmDfrSf9YIcgdtE2AHoIS40y
         19+T/EI7rj/i/IjzshIDxgJOJRuBJnwyfQ5qek675YLIn75/lK/G/4A4kqWjqVTvAomQ
         T/EamjkupD2MpRjsFnu02Q2geYlPn2UfnrmAhyqhb1gq6F0MNMw8gQkOXG1Z4xH575Tk
         Yoj0bFuw2tOmXG4W670m7ZCFXHs8n4MFDvXkhCdSOBu6Fli0F8FEJnLh9HZRp1dTdlNL
         k2eXdcTPpz/uI5EqKuXJ7aSIwNE9GYsFEMmTl1TPHzM8kthKcsH6OU+50Un7NEPVAKfX
         dUxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725750302; x=1726355102;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Tx4bPuTTq9ro8q8OYTA+0l12xXEKgJtcmOJ+89v/KVI=;
        b=o24IC9FS94+Bs/8htLdYOmuZJ40UuK1kgFhaiCDVwfS9gb7lOat3zvGbY+xhPxi48P
         jYL8Zh1n/x+QyMe8bZ8JWVUkBYS6uB1GUJJaRgocxybkpvzQGlCX6S0N3+ugc70+vSos
         Cv/CFk2Tj9Vwi2ItD8aptuOnauWp0ZEdGyF1UOaOG137FNu5DGd3KsSBrj1aa26KbbCk
         L5OLotDatwvHh1/sbTx15upwSRXkWUCKVANjY1WVrkYsRkeJ5tFq0wuSEnwQLAHPtklR
         fDjQXUGOo3TUvoeHKYPmXJs7HfN1H3JnsJoctzM/0meD9miLr5YMtEBuj6nzS0dLb8B0
         15vQ==
X-Gm-Message-State: AOJu0YyT7txxSsDEIalu5plrIgia30dKxP8YEWIvmxA3ogzYl89JCknK
	RuSojVzzYc6pl/KpnIeDVQFq6kj/VsCweu4GbmQumv5hfZcGobs5RswWXg==
X-Google-Smtp-Source: AGHT+IGCmRRDcVTQEZuM2yt0rrl8QdczFvo8Jzf3URxwHGm4TqDJI9IBYPTrV4w3Rtq7QGpRI8tlkA==
X-Received: by 2002:a05:6214:418b:b0:6c1:6bf9:8fea with SMTP id 6a1803df08f44-6c52851d078mr71700456d6.50.1725750302337;
        Sat, 07 Sep 2024 16:05:02 -0700 (PDT)
Received: from [172.17.0.2] ([172.183.132.93])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6c534786b52sm8171226d6.142.2024.09.07.16.05.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Sep 2024 16:05:01 -0700 (PDT)
Message-ID: <66dcdc1d.d40a0220.393e5e.2990@mx.google.com>
Date: Sat, 07 Sep 2024 16:05:01 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6233905939941956695=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, vibhavp@gmail.com
Subject: RE: [BlueZ,1/2] device: Add ConnectionType property.
In-Reply-To: <20240907204941.8006-1-vibhavp@gmail.com>
References: <20240907204941.8006-1-vibhavp@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6233905939941956695==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=888046

---Test result---

Test Summary:
CheckPatch                    PASS      0.79 seconds
GitLint                       FAIL      0.75 seconds
BuildEll                      PASS      24.49 seconds
BluezMake                     PASS      1648.94 seconds
MakeCheck                     PASS      13.72 seconds
MakeDistcheck                 PASS      176.37 seconds
CheckValgrind                 PASS      250.72 seconds
CheckSmatch                   PASS      353.18 seconds
bluezmakeextell               PASS      119.16 seconds
IncrementalBuild              PASS      2921.19 seconds
ScanBuild                     PASS      982.22 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[BlueZ,1/2] device: Add ConnectionType property.

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
1: T3 Title has trailing punctuation (.): "[BlueZ,1/2] device: Add ConnectionType property."
[BlueZ,2/2] org.bluez.Device: Add documentation for ConnectionType.

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
1: T3 Title has trailing punctuation (.): "[BlueZ,2/2] org.bluez.Device: Add documentation for ConnectionType."


---
Regards,
Linux Bluetooth


--===============6233905939941956695==--
