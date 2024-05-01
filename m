Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B84E0537FB
	for <linux-bluetooth@vger.kernel.org>; Wed,  1 May 2024 21:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714597470; cv=none; b=lRZG3o9JQpWYKiNtahcsuE/KtAHIN7Cz683OFHrerw20TB9m+7rnuGLixgWllj/1eKBHEwahHRKZwIKKiSCYG1GIfOBg73+rgaqRvScwYsbjeqyOxwTSQObApMbgEJiPNAItQPSnoL77yAEuECVxyy0QbpKlyvMGO7VZZQcY2kQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714597470; c=relaxed/simple;
	bh=jv4j+My8JtAZjFLHLLwUOw+s39ujQ1Zquj/V05IvEWc=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=iBU+2CwrxP1vkN1RFdfAbf7BSH1X6vM2yXHUqUVIV0xIkkykhDGMcdogDWENDBFQ6YfIIgJ5aE3QgpwyKUDqBTfGdT3WDCGSe7NBGlbyIKOHFULq8vK+ozMg4uQKKHZzysFVENMqQM6fMdgRGjNQY5fBGROL7LlnLzcxB/E/X6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ko/AWoNK; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ko/AWoNK"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-790f699eb2cso329958185a.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 01 May 2024 14:04:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714597467; x=1715202267; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=vSxmjdTEFo7y6HvAzt5BIuKncTQlK41Ce1zZkXTFkhc=;
        b=Ko/AWoNKOEuCvTmeOii5RwgsoKViGRz/gtXP0gpuJ3KOa8pyAOOhbC46Z76BwGDWva
         codSDwzyrB4f9CcEzOqBJ1qzrl+yLQTVHGbUiGciQpepT8EARrLZisbvZgIKUE9SxE/p
         lHcF+xZxNC7JOhz4pCl8qnLvB7bYV+mSm3lNgbJTwSnSbbdcFzNu99IJCzszWoshwmGc
         xpDlBZNnYGkyaz/vnQzFIA69tPJs26sl6eynXBvexkAHzx3Ee7lIJLuAFtgzYE1q+vXB
         ajcBPUU6bGwwUd/G/TydY2YJqmVS1Fpy7nl7C4vlUko8vlfbVFfB4io8FAcvjOCJQ2/y
         Ld7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714597467; x=1715202267;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vSxmjdTEFo7y6HvAzt5BIuKncTQlK41Ce1zZkXTFkhc=;
        b=HQ9RCQt+pKEllgAYKr2ASOTR1je8e9fncn/z/D1NEtxf4b7hN3YKQgwpmjhEH4XEUJ
         TemGE5cdr8QnYSaZh+XnyvntquVOC7rtnJHa/pdsY6oUFvEdZzTL06YASlNzDDTwUnkx
         7VYbbEA2zl0iH9Z/i74blcq/b/VzsTzf9onYyLccorY2nh1ZLsiXpyxoqPj6GQ1T4X+b
         cZRoOO9+7BQImA4Wq7svtmiOiqvW3YJHFOutByLeG6qaoEFqfZ4gJ9IEbLfx7TO3Jrf1
         DorPYr2/KM5B+t1L47odRtdzFjcr/SbvAgGYNSgLTfS5/IuYfuztlHQ+btsaaBA/shgf
         NyUg==
X-Gm-Message-State: AOJu0Ywlj1lm7R8gOau5bL7jUDGLe/z3iqyurXyZz2nM+aT6LFLYKDq/
	TDiAaJfvpwFj72SBy/ex1t1WwwxP7hg8uArG936mkgwYG5cWxvxpEj64eQ==
X-Google-Smtp-Source: AGHT+IGu6eRK1XbMa1R8zOGuTDDFKAL1slNglv6R1yR0UZ8zak5jhbhr1AoZtA4S7VjR6gsuXapUcQ==
X-Received: by 2002:a05:620a:454a:b0:790:f6fb:8762 with SMTP id u10-20020a05620a454a00b00790f6fb8762mr5061799qkp.76.1714597467505;
        Wed, 01 May 2024 14:04:27 -0700 (PDT)
Received: from [172.17.0.2] ([172.183.35.226])
        by smtp.gmail.com with ESMTPSA id o11-20020a05620a22cb00b007905e9c01basm11100126qki.122.2024.05.01.14.04.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 May 2024 14:04:27 -0700 (PDT)
Message-ID: <6632ae5b.050a0220.42775.622e@mx.google.com>
Date: Wed, 01 May 2024 14:04:27 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0875395954490530109=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v1] src/shared: Make default length handle EA
In-Reply-To: <20240501192812.3421949-1-luiz.dentz@gmail.com>
References: <20240501192812.3421949-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0875395954490530109==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=849727

---Test result---

Test Summary:
CheckPatch                    PASS      0.40 seconds
GitLint                       PASS      0.29 seconds
BuildEll                      PASS      24.58 seconds
BluezMake                     PASS      1740.81 seconds
MakeCheck                     PASS      13.03 seconds
MakeDistcheck                 PASS      182.12 seconds
CheckValgrind                 PASS      249.53 seconds
CheckSmatch                   PASS      351.21 seconds
bluezmakeextell               PASS      119.59 seconds
IncrementalBuild              PASS      1507.30 seconds
ScanBuild                     PASS      993.87 seconds



---
Regards,
Linux Bluetooth


--===============0875395954490530109==--
