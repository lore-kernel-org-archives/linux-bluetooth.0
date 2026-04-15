Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3763262FC1
	for <linux-bluetooth@vger.kernel.org>; Wed, 15 Apr 2026 09:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776243663; cv=none; b=Xn3vxGzvrflUMJXONzdqisy0vb0aVP7LIsAq20WGMT0tj6COyY3rbNNmZUsUPgrtjly2J2zMVRlUZBhdO31tw2at7O5e6x/lFzgFhOjIUE9QI9Io4Bc/12mpw1zt8pG24NPeB31e0QZh5PPTzSgaCg/dKU6jFTzyakBHjgD2SIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776243663; c=relaxed/simple;
	bh=INZe0xn3sSmHiKD3eRTFrJxurngYNIVTv61fZhnU6rM=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=fZliLdUiHZnDp1uscwJdF2lSX8Q+VprGSTHKW5lxUIplhNsy5HySMPeUw1bOpyDURO2Ju3RbnVZVWihi3QAlgO74bToDukSCZeQkRobBjE0NS6EVvhuixwB2mLE1jHx8+B4AOV3BPlfbPdrrAGX5kipyh9rJJH2MqQe/diRVujo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nJwHVjn/; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nJwHVjn/"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-8d428da4300so714707385a.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 15 Apr 2026 02:01:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776243660; x=1776848460; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=5jrK+V1C+kHYlUfpemnuUjDWjJoLpOV2bkMfQnuspBU=;
        b=nJwHVjn/WVRkSnHbAd3BqwzL4Y6dFE9KsCkYqhkq1Nzt2YU8TOrAGKxQLJoo+5cmC3
         DuYOd6B74DThQLa+BijvTnPeTo/imD/pvk6Nlq10kYDo9UmMzhJL9kZYjLPE/FT+Dz03
         h90mREEFIOWN94LsNwfD+CSobNWBE85OCxIxbaYaUkNtxkIXiLytRV0GP5xvoCyRKLKE
         85mQgdTXvT5NVsaNLrkkPpeyUn8aV7XtBFtSTieL7T7JlyZXQNXu7wb5ETbATlKq5a/4
         KxkG4vPMeJG2dFAfwHzi2qhKxys3iL0Vy9sOQ7yJuk47MMkWnIcZH0NnbcIfVxpJQ4cN
         R6KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776243660; x=1776848460;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5jrK+V1C+kHYlUfpemnuUjDWjJoLpOV2bkMfQnuspBU=;
        b=kg43/Nxy3DUZYWskHpOQrN6ZZoBADWHb0FPylsrZjnEuXW2JH7/ihxOlmCxQ/vKB9G
         yEPUcy+j1CDSTO4bIpV+ZatjvuwupvwV29PaKk8SXPx0ijD/i85hkFIJoMd/2Y7F1LwQ
         b37ENWr21dVToCNzKcqgDFMGGCx5ofRrHdgEy2p4ugl8hFQ3fvzVXhfSpMhkkbNbt3CQ
         LMwgPiEFBFo/TNALFv4oog6Q/3yU+lmK3ygKj2RjcdLHqIDK+oSo1HzDgDt1kdu8jU+W
         u3IhSHnRSTn6YZW7ydFYmcVkkAlk4JG6Dnv1F9nGAlixgRanrzwdiFsX5sg3xc5GeykK
         9GMw==
X-Gm-Message-State: AOJu0Yzc/oaXT5Xpf+lGNy+H0EjU2JSYtqHPfkYdE0GxGbNaBp6i8S2r
	Bj5yaAhqVxN/4oWbQhrkkTppItSlc1y4R02XYcEmXXC46u1c5LuSa99PpZJUWw==
X-Gm-Gg: AeBDieu9S/JNpKhkfEpPYik+87fSo4AfByado233bfFI0WvndMm7jc6lSgw/E5Ou+hL
	jFyidhYdxo+qsUXYAAxgu/z9sZJTvn4qcZkk+3Yn/Vowq/NXVbDH/pMcod309o62tR8F/HJu8NC
	Qw9ogfMdDnpvoAw97d/nt5MdbL5gh6/zfZJObU7v5t8M/TgUjl70mVazXWw/ykHmSdFwoAfbr4+
	/Zko5GBNjbJAhWjPTJ/Z6/crPO1afEibSyAKIHYlcg+MTjMGuuqYOVECDSytHi+quN1501h6pMG
	2C2W0xpEdOCcwPKgF2Y2QXTInv02Z+/NEUw9cmINHsJgWm93bP4VL+dKYpstDsLLmXmBkFT2NUS
	8Z/kQVEqv3NxazwjfgoH3QMk87W9nKnXjIClinFCOXXJAcX5lpHVRW7RIWFkOrNoTkVzAWrzJGh
	FuQX2GWMvaZ84a2s2yEhflnKlIjMMhiFTGKs4mlbPcIfQ=
X-Received: by 2002:a05:620a:bc8:b0:8cf:ff82:6dc3 with SMTP id af79cd13be357-8ddcfea0c55mr3073805085a.51.1776243655960;
        Wed, 15 Apr 2026 02:00:55 -0700 (PDT)
Received: from [172.17.0.2] ([135.232.177.195])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8e4ef33b5a4sm72328485a.19.2026.04.15.02.00.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 02:00:55 -0700 (PDT)
Message-ID: <69df53c7.050a0220.219a9f.7c69@mx.google.com>
Date: Wed, 15 Apr 2026 02:00:55 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6514615599756233560=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, apusaka@google.com
Subject: RE: [BlueZ] monitor: Add decoding for Microsoft defined event
In-Reply-To: <20260415073940.739683-1-apusaka@google.com>
References: <20260415073940.739683-1-apusaka@google.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6514615599756233560==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1081435

---Test result---

Test Summary:
CheckPatch                    PASS      0.48 seconds
GitLint                       PASS      0.29 seconds
BuildEll                      PASS      20.08 seconds
BluezMake                     PASS      641.53 seconds
MakeCheck                     PASS      18.87 seconds
MakeDistcheck                 PASS      241.59 seconds
CheckValgrind                 PASS      287.58 seconds
CheckSmatch                   WARNING   343.47 seconds
bluezmakeextell               PASS      179.33 seconds
IncrementalBuild              PASS      659.52 seconds
ScanBuild                     PASS      999.51 seconds

Details
##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
monitor/msft.c: note: in included file:monitor/msft.h:88:44: warning: array of flexible structuresmonitor/packet.c:2002:26: warning: Variable length array is used.monitor/packet.c: note: in included file:monitor/bt.h:3866:52: warning: array of flexible structuresmonitor/bt.h:3854:40: warning: array of flexible structures


https://github.com/bluez/bluez/pull/2038

---
Regards,
Linux Bluetooth


--===============6514615599756233560==--
