Received: from mail-dl1-f65.google.com (mail-dl1-f65.google.com [74.125.82.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6BE0248F72
	for <linux-bluetooth@vger.kernel.org>; Mon, 19 Jan 2026 15:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768835775; cv=none; b=mdsVNmZeSw0qWYqKSCUQ127HJdpA/L5y6rG+N7yGSAdmpLTMxMBE/mfmxQk1mvTsoZx5YZNTKpOVBGssuSqI4LdHMy+w6+3a9H4vS0tLOsIL2dWR1KqsoTnDgAZqnq/moa/bdPQFf31XC/4V2UPvn1Tj5FF5bESwc56RIuhJdjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768835775; c=relaxed/simple;
	bh=YjglGS+bgu6q4MB6TTj4qLAI10peZ4PxeCIHa1JFi68=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=Ouar4ZNBGRa2koo47yS0RwOwqugv/nrvBtt1iXlqlEqit9mFhQ3Ei6cKiZi5NrhYF14x0mLt7iEmjc8uAM/fMgtsjc45RTIl2FirFkvbUoCscPNMK3PVJ9hxGS/WO/2ufc/RNAwI8By4zLHaGfr+RzoJt2xfifKKqVCJDiiA91g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FQwglB6X; arc=none smtp.client-ip=74.125.82.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FQwglB6X"
Received: by mail-dl1-f65.google.com with SMTP id a92af1059eb24-1220154725fso3349074c88.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 19 Jan 2026 07:16:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768835772; x=1769440572; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=UkU60bAKA8HemRrmK+A4Lve+DXIKUnXPkeDeyNa/dzU=;
        b=FQwglB6XZnduL/k63bmG7ZjeWSyVYznZo4Dborf2BuVlS7p1W5UQtUgJfOCxufdnP6
         ZLlo39y+yGw4RmODFxj0uOmKt2PiGeSNWmoKGvIKvcyUJzKlA628OfU02Ra5pKfuwmXn
         0SFSjwKHclj9hDrmyoMhwCJaxFRrNPEp6lu78HI9ovrenn++5ZFctes2fEi22RUYWki+
         N47pvYgVFHyXUkOS+1m9pt+E88z/YeUG0BDMzccDVGEEnsJ/o44EEFwBYSz85auSO0Tl
         8LqKEbsajEwL6+9bPitadgi1kMo4L8vrFlBlZ0r4H21JthcP8QJL1jIMlR9LqFCCxHZF
         926g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768835772; x=1769440572;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UkU60bAKA8HemRrmK+A4Lve+DXIKUnXPkeDeyNa/dzU=;
        b=utg5CYymIKsfXu62GxZOe/huNz/x3KtmfdWiOJWKeiO564XeSvQq1zQjJwaWCEkNfP
         0ie/G1uq1WsdPzhXsADHG4O4jZYdSfaNp2sYYfd2ztPDiAtXGeGOarAw+bHoTuhD8IYU
         DisGF2EVKEjSJLsZzZNpXzCZxfH3ySZBael9u+XnH0KdsMZ7vP1lHPgLTbt5je5NJb5Z
         hldpznsje/2FGtnmyISp/8cnddCH28mMCinMciSmf6EAlujsWFaIhKw+O8RgsoIM9vec
         I7TmwrV194NRxz3lZ/0EQYLm++ZGJ1LEkbDFY6/v+OpVrWYIsEK32ex32QvXMp4MsJ9R
         cRKg==
X-Gm-Message-State: AOJu0Yxz6eRPIUbo7Tude4QuXzo43PoikfuPSCht/TopEfEnS9eDUR+V
	NOIYFNvcAoNVKC8z1wqWwAgid3bg8uJ+cRRDZGzuqyEbYj3uRvMZhNxrZz3p95Jc
X-Gm-Gg: AY/fxX7zTiFG/NDGRGOvd94sV8zMGYyBKVUZtqX2paISiNhaaymgUtDEH8nvbjvGc7J
	lNFu1YOJWrgvoNM1VFYOKjNXyj79WndYd2RknXay4DmQ1JmfvW1U5op5wUFmXw1uO1E/2NlHCH7
	cs/RWO9hnBtG2ENzYECN+UreYNW9KBPTKBAXJgAMOrty+va1aLHREYfo55beoIQwva8e/pGvSsb
	uSD31yf3H7PpB154nisKHYHYKcZ8dADlxf8rplApaYqEuGhWU5BDnMjyS3oDk3DRsHuzjusimj9
	+SOmg+0UU62Z268jAUc8X1u1obsiUiSAY20LvUUI2k+JAn9NQEinvOeidtg0DQFayYAFj0isfH4
	hQ4qQKLfJUfdS4v4Y29WzEXpgYMHaOmCLSxbKhvdHifkGBU31BQPrug1FKhPZIEz4f7cFXAOTP5
	dhxRhG1o0ARy7bTbl8lfU=
X-Received: by 2002:a05:7022:258c:b0:123:3c65:d724 with SMTP id a92af1059eb24-1233d116ce1mr12192911c88.25.1768835771705;
        Mon, 19 Jan 2026 07:16:11 -0800 (PST)
Received: from [172.17.0.2] ([172.182.226.208])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1244ac6c2besm16838336c88.5.2026.01.19.07.16.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jan 2026 07:16:11 -0800 (PST)
Message-ID: <696e4abb.050a0220.33bbd2.9ea4@mx.google.com>
Date: Mon, 19 Jan 2026 07:16:11 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============8915121190570098413=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, hadess@hadess.net
Subject: RE: API fixes to make better bindings
In-Reply-To: <20260119141239.2683954-2-hadess@hadess.net>
References: <20260119141239.2683954-2-hadess@hadess.net>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8915121190570098413==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1044175

---Test result---

Test Summary:
CheckPatch                    PENDING   0.41 seconds
GitLint                       PENDING   0.34 seconds
BuildEll                      PASS      20.41 seconds
BluezMake                     PASS      663.07 seconds
MakeCheck                     PASS      18.31 seconds
MakeDistcheck                 PASS      244.12 seconds
CheckValgrind                 PASS      299.64 seconds
CheckSmatch                   PASS      361.08 seconds
bluezmakeextell               PASS      187.26 seconds
IncrementalBuild              PENDING   0.41 seconds
ScanBuild                     PASS      1035.64 seconds

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


--===============8915121190570098413==--
