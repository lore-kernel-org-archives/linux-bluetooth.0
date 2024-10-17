Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B58F61DF72C
	for <linux-bluetooth@vger.kernel.org>; Thu, 17 Oct 2024 16:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729183424; cv=none; b=X9UiAMukugxtPq90QgWbI8dX1ljKCrz1BO4tBpM3j8SecWaf89GFOLjF+iY9cga9mw54hzsXcydNFNlAQ/gZnQQTsBSibnz9Y5Z2m1N2Mg0uHeLjQo/S6OLJk4v5lYiqNu5cYCkfVE+moQk45XapuzgR9DVrVe7JsHLDKBTPZDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729183424; c=relaxed/simple;
	bh=lwIVRwEFQmB58AznZxKjgSPGiruBCVZZ3d4/yKNRQuY=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=uRznyR2lcgafvIXvHnXhFAxwxj5U8vHylJmUL+aM+w7q+WLL+17PVjuJeMtCyfGhwq0BA36PI5vgJUgki659iHoQoqTDjgVsKpdnCRUqtECX5G1s1snAk4xyFkO0PfF6GNdCWSH+ntut0VcmjCPf70YO7EUtOKtpxnC+9ztwohM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dLm6262f; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dLm6262f"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-20c714cd9c8so12542865ad.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Oct 2024 09:43:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729183422; x=1729788222; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=5GZOn9r7CYZNYUKpf7G1sCMSdl91lnxCf76cDD2+fc4=;
        b=dLm6262f+R2z65h2jI96EI5FVQPfqAxysl31H037MKkZYzAReK8XP7S+IQ1NjzgN/l
         lPS/EstPmSI/jw6DSpMlR3IqVxjrB8W6M94rq03HD/WE8zwAsopv7Xd+UAadhndYwkS5
         oPosomaYwlkLP8VaGIWC3OwGYeXK0pTG38SVA9y3BqOu973aZYoQC4utd3mtexFEWJ0p
         m9hvTaLQDDSkxygEy3N93L1lESL3JTMXUOfNZrMf2ngHfJdxx2O1S63fo1GBhebtPdnx
         jCBo1kOReieYfmvvcWoQC/qTgHt4ZfJhQkJrKczJ/+ir+odrR1C4mWkUOGeYzJ5Cs5Hw
         ZqsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729183422; x=1729788222;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5GZOn9r7CYZNYUKpf7G1sCMSdl91lnxCf76cDD2+fc4=;
        b=RXa8oVcLouj2GMzneQ6RhMwFngqqNQyIoZFjFO+6zVBubmo9V0wFMO2CCXUxrohSgj
         8V9n4SLj4iHaSXd34FIPQy4vovGIOpfUM35+ktiW3g980mSiDEYzJohhY4o+UpfhkB31
         2Dv1KzVjtD372eQ2VJszpDcU/AhAcdHuRv8hEvmjw8QRDyfOYM9BP/HE5PzQH+KEqZ6d
         qSyGRNdxW/ObxdMh6/tbuepN6rvxYJURQWHDvdNfGdfVITdsafMQ3eSb1I+DmlWJzOAl
         MswWYf4yZCT2dAwEX49FgMgy32o+lqjFbwQu3qbwNIZKz9flVzIYriOvSmwbkI2FG5KE
         FPCA==
X-Gm-Message-State: AOJu0YwFTSVNE71hcppf5eCiXWp+FIBtykVdgfpba29lOYbwBAmTkOpF
	W+6liS6waLPo+B50gCJ05hRVgN/3AzG3V3pANPie8vVRv8YWDgvTdmCmOA==
X-Google-Smtp-Source: AGHT+IHPQfcqAX4auCExDB84Yf1AH5p/GFOXTrq9g+YL+MR3jegoSER72EXSh7bjjcUcXSxQIBex+g==
X-Received: by 2002:a17:903:2447:b0:20c:7ae1:92cb with SMTP id d9443c01a7336-20cbb195f8fmr311049725ad.15.1729183421683;
        Thu, 17 Oct 2024 09:43:41 -0700 (PDT)
Received: from [172.17.0.2] ([52.157.1.131])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20d1804b629sm46418855ad.194.2024.10.17.09.43.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2024 09:43:41 -0700 (PDT)
Message-ID: <67113ebd.170a0220.8816f.40dd@mx.google.com>
Date: Thu, 17 Oct 2024 09:43:41 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3165274597331427428=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v2] shared/shell: Fix not handling prompt with color properly
In-Reply-To: <20241017144002.941979-1-luiz.dentz@gmail.com>
References: <20241017144002.941979-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3165274597331427428==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=900271

---Test result---

Test Summary:
CheckPatch                    PASS      0.33 seconds
GitLint                       PASS      0.19 seconds
BuildEll                      PASS      24.81 seconds
BluezMake                     PASS      1713.23 seconds
MakeCheck                     PASS      12.85 seconds
MakeDistcheck                 PASS      179.45 seconds
CheckValgrind                 PASS      254.07 seconds
CheckSmatch                   WARNING   357.39 seconds
bluezmakeextell               PASS      126.09 seconds
IncrementalBuild              PASS      1473.22 seconds
ScanBuild                     PASS      1035.53 seconds

Details
##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
src/shared/shell.c: note: in included file (through /usr/include/readline/readline.h):src/shared/shell.c: note: in included file (through /usr/include/readline/readline.h):src/shared/shell.c: note: in included file (through /usr/include/readline/readline.h):tools/meshctl.c:324:33: warning: non-ANSI function declaration of function 'forget_mesh_devices'


---
Regards,
Linux Bluetooth


--===============3165274597331427428==--
