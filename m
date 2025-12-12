Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB97627056D
	for <linux-bluetooth@vger.kernel.org>; Fri, 12 Dec 2025 21:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765574906; cv=none; b=mIT/G7MPDKtVJBey2uJd1UnIsW+ygB+xzCnTxM/nfRSTilmqd6Gotk5ECR75SOS5nqW/9NdL4/ZElL1F7uQ0hxkZVp8XMsbF3VHkNQfHjSVRmhf2YHJaaOrV027wy9jLHETdqvnMKcjXt4FdmoSXaWjuQ8RqnZN6XRvIFLJXcyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765574906; c=relaxed/simple;
	bh=ADybB3XYsAneKgNUG/JwM0/XdSAkl4gRjpoiKWhmP3w=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=OtyEojSPdAJiALEcpAD1lCQ1X9sBDE4Whj2/Ka/jtV/w7N62E6l522wHC6wtLMrdvD8cxXvP4nl8kQsX9bbgEdQJ3Fcc1JWjE+FmDmJ3u8rS2yaKz1EDNy67hp6SH2vvpUmjUXQ0xXy8PBMqJRPT200sGjrYSXWc1Q+0MJywX7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SDm7Omy9; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SDm7Omy9"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-bea8b4ba79bso1311467a12.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 12 Dec 2025 13:28:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765574904; x=1766179704; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=X5Xg0dlVEDu1RAhRKhN42pyraPSIU9dEdWRe66k59VM=;
        b=SDm7Omy9JyqZlWwvLg6xGjZcGivpMW3DcRqON0BUQVxRqoDCZD2zT6Yhg71v+d+jFW
         TLulSplVjDAaj5R+i5bVoubu1f736uEMdok86GVrAANDqBX32riQqk7jRMLSwGO/so7W
         qyta1+ex1yjTkH3bFbXQjnqKNQVRB86E7DU7I7yDcqesvcvjgutuWVK8T50COjNFBvLt
         zAPzWRg4ty2B2PRwRK+dCQ+b8XOpzwIf71hhajF+QqreSdIV66c2rXCackW1sCRt1GRZ
         JTaB+hR2/7ZrKb1LnccRtj3nirF08uQCGsIb28SE16+N+pv5lcNc3hiUkFA4EIoG0DaL
         u8tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765574904; x=1766179704;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X5Xg0dlVEDu1RAhRKhN42pyraPSIU9dEdWRe66k59VM=;
        b=bbKP85Gf942WYjocEcybWDO12Gti5gVv6WAD9BtUWqlaypKF/RKSXuNpJrYQI+3qWc
         96eBMiMneX0IGpht+3VofR9vXDjnnus8pvq8BdIoVOIayBXFCfJ+JqxYok0OLIIV97uh
         P7F/DwUCWCK6drmzcQUlGhFRWizqiIcJET+7PB8Qzm9Ynt4d4QOHaFTb0tLjPMcaxE6i
         Qrm/OXptBYWkVMJKR9PLibwn9Ut2PKi9mhTBDix6Ga/Kp4z/XfUxKgFTh1cy1s4zu3/r
         jWm4fjswSIHqHbtslzLMaBrD6GQ0V+vF6pURVeQTKipYxOWRPMwzYTuomHovfGXAcRQv
         es/Q==
X-Gm-Message-State: AOJu0YwJbZxbeGLh35k594msi+sGR9v/olJ7qstMK2XpA7idm/ZYTwZ9
	vkrDc5uSlNv5ndTJvvs96YX/Hc2ay1yOL+pBUiAO/wSnbbuU3FPRASpObroU8A==
X-Gm-Gg: AY/fxX6C4v4gARD6psrq5uYiJZY3xfa64dCEn2HkBbzDIqk2PUKcDguWQ2wEJqOxbua
	YFD5umYvJpUQ/6qU1nRUBh9hsn3dOKIi8/F3Fwz1jVR3dXIPbenfOaFuewwsyzXq1f/5Zz9782O
	GywqvwQDEtird8skr6mlkh5bzsmNnWlbEjhPzSsxNS1zAj8SsDqMzBXSanTLYUdf14OsFwGuJ8G
	cPsmXkQfrXVvXlZ8GnPbaoU4AWldnQI1qkyx4VRulhTLlTd7A1t2+yLZIZtfjADjvqrTv7bOxsF
	l18qx3AZU/MnK8l01Ye+TRBaC7lNQ/wTwKj8hBk6K0wYrgSePQPvrTHiNLdkjYc8pTE0Ze4Suc3
	b6ZXHmsfF6QLLNzAjJ423xPsLRuYvBYLoe1N2TkvHu/yh1//Dzikm2y9F/viV5heFgfjUlLlRQ/
	jMdUecMLDdfb3Z7XsJJko=
X-Google-Smtp-Source: AGHT+IHOsT6CuqsNuelYkfQqDG9UA4ct8/O+Vf3i9Pa6cdSrREjF4DjyygmNdaTOglk5JhzT/3k3Kg==
X-Received: by 2002:a05:7300:3aa7:b0:2ac:2311:813a with SMTP id 5a478bee46e88-2ac322fa423mr1991756eec.22.1765574903533;
        Fri, 12 Dec 2025 13:28:23 -0800 (PST)
Received: from [172.17.0.2] ([172.184.219.170])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ac3c13d60bsm3441034eec.0.2025.12.12.13.28.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Dec 2025 13:28:22 -0800 (PST)
Message-ID: <693c88f6.050a0220.1e080.5453@mx.google.com>
Date: Fri, 12 Dec 2025 13:28:22 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============5775076037442898835=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, mafm@igalia.com
Subject: RE: Support for config fragments (conf.d style dirs)
In-Reply-To: <20251212202240.4057163-2-mafm@igalia.com>
References: <20251212202240.4057163-2-mafm@igalia.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5775076037442898835==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1032731

---Test result---

Test Summary:
CheckPatch                    PENDING   0.39 seconds
GitLint                       PENDING   0.38 seconds
BuildEll                      PASS      20.27 seconds
BluezMake                     PASS      653.03 seconds
MakeCheck                     PASS      22.32 seconds
MakeDistcheck                 PASS      244.33 seconds
CheckValgrind                 PASS      304.69 seconds
CheckSmatch                   PASS      351.98 seconds
bluezmakeextell               PASS      183.84 seconds
IncrementalBuild              PENDING   0.31 seconds
ScanBuild                     PASS      1045.35 seconds

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


--===============5775076037442898835==--
