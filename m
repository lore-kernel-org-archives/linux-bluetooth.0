Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C87024293C
	for <linux-bluetooth@vger.kernel.org>; Thu, 24 Jul 2025 09:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753350057; cv=none; b=YT1Ep03R4JmmH9EiLqzgfBj+44UahcjkwJfJQ+4JLFHPSM0buFI/j2MF91QzGDBiL0sVLb3PcrVPMJCS6Bg1//XrRycDc53tkbIG06Cem/UMlPncll3ByIPChyrmeJF1ouRwgslyb6eDCrtCKKZ5oL8GKQe3kj7QslYASymncRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753350057; c=relaxed/simple;
	bh=yLobeko5t2aleoSrdB32PTXVkRweDTeKHMBOGTOW5zc=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=XOYIbfp8yvGy1S+SN5PLrsM4OSj54EQCm7dh8KtRy8ZZ+09yqIH2jXxX8+7iEcO9bqayXTRzZJf+2j/8ZOGfhfT/TVAkGB1UHIzYGe8GpqyK9L4gPT529FHtyiRIi+GzKEZWJqpXRNmOznS4gjVPxi2tzHSF1Y9aHu1T3jUQ4OM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cHnbIfOO; arc=none smtp.client-ip=209.85.166.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cHnbIfOO"
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-3e059b14cb1so9051855ab.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 24 Jul 2025 02:40:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753350054; x=1753954854; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=A3Ejt6+f78HXZ3kRCDgsKDG8Z6+F6eWUfnq/cYp0xtU=;
        b=cHnbIfOOq7h7yxby7CiyioUD1+Kv7PrAyz4NMVYLf8m+ULiCQZLhK1aEXec2KWAcUa
         QHRtCzEGF4dtVDhkD7fQYiRB24BAuoxHuO8v9UorRNYg9cNh+6O9grmPnNPLA0KxGhHm
         vOq8UFB2wSxkMjRiHQ/tRaqKLx9mc1gx22XWLBxicve++rXXya3ffqvLD48t+L3qf2iE
         47KOBdxOKLUgzvuVwcUE7Hp3N1BY91zPl+AZJ989YWD+i0nQVUH9S2PBIkATQAVCpEP+
         kxZA8il4jpJSY/KWAEnuv9SxJC74NboTqMakEFONEiC5x5HJ3Ez1OMzDaRQaEpvehkss
         vdwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753350054; x=1753954854;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A3Ejt6+f78HXZ3kRCDgsKDG8Z6+F6eWUfnq/cYp0xtU=;
        b=cm8097LIGnIAk4+X9jdd8pS/MUKRJjiNR2Ndy3Bisjt4z31t8ydk9jVLSgM8gcaCZU
         jckp2ikTl2TJyW91OA539jh43/YX5MYshCCRwQNy2rJtZCyqU7+ovNg5xX5HRB1NC/vC
         9v/byqCH7hg3uywbZoqQOA0ax8oycDQ5ahObX/DK5YVK12/C7sz3pHvSfRwBN4bPscJu
         aUVWTlHa9TgQHLqQI9wxBNR2z5oPf15JlGDgP7i1dZiOu6mtQp2tTVWVWmjsATS9SMAo
         Qs+It7kzJHNXDfq/Tf5eYEfgqT9IpfUbrb8cmS3ruDscCOT2mAfJKtZEbiWjshaDgOwI
         72CA==
X-Gm-Message-State: AOJu0YwKZVL68AU/2ATvvDMENZKVWDpjOub54W1iQq73iVt5QdxAmRNX
	WrsJ4lfHRc6xz31CHRP+SEGyR+3h9m6wA86ny573yrqOJDm8Ls8yt2GmrfY6bxi+
X-Gm-Gg: ASbGncsXritmjmkkResy7tTUV5xm+IlpwgLkoaaUqXSeA+kgSvu5HKSnP+Nm5gAqAUr
	Z0fRAapM+BHUtZsx0+h5c8rf/7VZbuGURbMWbXhqZEQu9xDt4VqhO8qARnyX+NRAUn2PCLESKfk
	6GCpgxC8DjsXIzEB2yAibH65XFllT13wM7BF4pRPhGpk+Ew4xQB+Nv4eNvaSDuymsAkOtyj9dmg
	UHsCo9LOVVP4luBFzRKzZKM1DniUjrMrTk6cGRInIJ6lxfoEvEdIVwvWOFZbdCuFuWxwF2cyAJG
	0IvcGOOluYKeXCmUJk0XGSUUrZDx+M+Yzd3v93KPxhjcyHOhUwjmQmpZeN8MpyXl12fRr1u/eFx
	bmn5lg3y+gsd3WYOn9z3v0VqJtIDP
X-Google-Smtp-Source: AGHT+IFQqR7ujrddhwqvhrODGws71d8Ce7NxAO6GqpdLjorvIteZQDHp7ccp/N19NSy0bfl0yUwQjA==
X-Received: by 2002:a92:cb01:0:b0:3e2:c1ba:79c2 with SMTP id e9e14a558f8ab-3e3b97ff440mr14360315ab.7.1753350054338;
        Thu, 24 Jul 2025 02:40:54 -0700 (PDT)
Received: from [172.17.0.2] ([64.236.160.22])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-508aea6173bsm310933173.4.2025.07.24.02.40.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jul 2025 02:40:53 -0700 (PDT)
Message-ID: <6881ffa5.050a0220.15d198.0550@mx.google.com>
Date: Thu, 24 Jul 2025 02:40:53 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8003839762654216610=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, jiande.lu@mediatek.com
Subject: RE: Bluetooth: btmtk: Fix wait_on_bit_timeout interruption during shutdown
In-Reply-To: <20250724085117.2678313-1-jiande.lu@mediatek.com>
References: <20250724085117.2678313-1-jiande.lu@mediatek.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8003839762654216610==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=985445

---Test result---

Test Summary:
CheckPatch                    PENDING   0.31 seconds
GitLint                       PENDING   0.28 seconds
SubjectPrefix                 PASS      0.10 seconds
BuildKernel                   PASS      24.29 seconds
CheckAllWarning               PASS      27.69 seconds
CheckSparse                   PASS      30.17 seconds
BuildKernel32                 PASS      24.25 seconds
TestRunnerSetup               PASS      484.61 seconds
TestRunner_l2cap-tester       PASS      25.10 seconds
TestRunner_iso-tester         PASS      37.82 seconds
TestRunner_bnep-tester        PASS      6.45 seconds
TestRunner_mgmt-tester        FAIL      135.54 seconds
TestRunner_rfcomm-tester      PASS      9.59 seconds
TestRunner_sco-tester         PASS      15.07 seconds
TestRunner_ioctl-tester       PASS      10.21 seconds
TestRunner_mesh-tester        FAIL      11.46 seconds
TestRunner_smp-tester         PASS      9.03 seconds
TestRunner_userchan-tester    PASS      6.34 seconds
IncrementalBuild              PENDING   0.75 seconds

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
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 490, Passed: 485 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
LL Privacy - Remove Device 3 (Disable RL)            Failed       0.245 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    1.863 seconds
Mesh - Send cancel - 2                               Timed out    1.996 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============8003839762654216610==--
