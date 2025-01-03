Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E8D81E00B4
	for <linux-bluetooth@vger.kernel.org>; Fri,  3 Jan 2025 13:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735912451; cv=none; b=NRb18Rqs6lAEqCRoTM91otNpJNy/Edwtbz52sKek8hIh4TqPRIfOGF87FnF0htYTYlkkfKUnoPQCcFpFleKmK3JqA2BHHxi14pHfkYqaJH6mxPvuEMtJ3mAos720lZM8Rh7e6dgbB7lPWpIiAReBWI0n6xBfoZKksZ9niefsZFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735912451; c=relaxed/simple;
	bh=5wRAPVpO7NUag44rjiV9b5aBvqhlXfmsnTVsA3nj5yM=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=h4eGduJNxCL/wkqhyAwcgO8kcLWqrYYJpcuQlGXssgWuyxgLiAj1apcxBCuvs1xkIFuhA80evomEunn20UPtz2eStZ+BEXwuLnkU+QfxOgIjJcan8uOA7288/uTrJRMqVqKTss8Qwdb1mx10vM9yo9zPOhSMc9XZru3oiu3ntek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XcbwJQ7E; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XcbwJQ7E"
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-6dd420f82e2so71306846d6.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 03 Jan 2025 05:54:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735912449; x=1736517249; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=41F1X2deD5LQckzOS2XJMbG68dSvlR34NfhqqXHClhA=;
        b=XcbwJQ7EFBOB2soxmYxfQoIAj06UFYkNkgjCvjskUjrln16aX7mAax73OvTa6EXfu9
         hyxcddQIbVOwWgDARhsLIC2clFYO/UhJwqjEr8gydCCkx3JkS/2i0S6a4Od3yGUP+kP4
         YSoY+gX4igtExgu5+XyDEEyY0p2o7NJDliH6BqYiR7YoI9mt3YmTKRM+UxNXfnkMq3Qk
         suNI48Vgjpc0xyORvbqzqiCdlqYscOcFjFtfFVpkfq+PMfb+HAP6AsUURrdJ4E4KtjhC
         8c/S3SHNzdqKT6jMhurnZPwxahKH3mv5eWvYvXjOmbkwqGKS1azduvYF4n38dXOsa6Pr
         7Dng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735912449; x=1736517249;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=41F1X2deD5LQckzOS2XJMbG68dSvlR34NfhqqXHClhA=;
        b=YrbomePhXdCIbqiDPGzpsakpCXOZPOe2UZdZhPxSJj0SsOIZkn9qUOYcluXVomnoC0
         lV5d2N62OrOzmaWZa6CMJFqQAmC62sra/FSLwzcU286lHJR3tmepcQuTMDDuiB5O7rgU
         D8yj47XfG0K3ejFcqbB0m7dVwOxKRzWuElaCTvilTDf6Po4iAJ9gBvN67/ot5yZrmouN
         Lg7yIRiXp6Sm5ATvFsgQeGmPq+P5wEzhl0rRCqs3ZHsN6p2+mv+e5RMnCcZOH85/y3o0
         aEL0/2DsNY6ILORkplm/7xv5bnTDvzWi48OpVVTQkul3HwdS2zIbzUh6fIMtcXjkkXo2
         FKYw==
X-Gm-Message-State: AOJu0Yyz5c1n6dqUpg3MoTNATI7csKgB3tbezY61zho8S8pwnEzmdr6S
	4H1zZKMeeCiA9uq9PoJJ9Yoa1Dviq3r9DDc7xCN9Az5m5fKU2CiJouFVRA==
X-Gm-Gg: ASbGncufNb6zoV9gDRNYLgLOA+jZ5T3x6XuzYBeJcuMtcD7OMEkJsdV9iG8+dWepCo8
	F6t+sw6WBCkTpGjSxPS/c5ildW3DsTz/c12sobeUd/jyJj0MW84DOFQ0BzVuvfdXWcCP1EFiL12
	xsgRQL4aNq+9jZE+ygAmnTZJ8seecywp9muOyIacgu7M9uQBnKCl4pnIs7Br3i+eE1mEBX046pz
	AMrLkktrZEkOJc4pdLOalCOdJaMfkBmcZOpokLZq9Kq7n70L2/Ml0NQLB+g3PY=
X-Google-Smtp-Source: AGHT+IF6S7fS/lb9LrLLGzCLQpCS6PiznOk60HSwQradPzWIj8Hzqbt9ctJ+hdWedIRf6wOB3vnqsA==
X-Received: by 2002:a05:6214:5298:b0:6d8:9124:8795 with SMTP id 6a1803df08f44-6dd23318c75mr821733286d6.1.1735912448826;
        Fri, 03 Jan 2025 05:54:08 -0800 (PST)
Received: from [172.17.0.2] ([172.183.39.64])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6dd180ea74bsm141608576d6.25.2025.01.03.05.54.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jan 2025 05:54:08 -0800 (PST)
Message-ID: <6777ec00.d40a0220.d9fb1.bc34@mx.google.com>
Date: Fri, 03 Jan 2025 05:54:08 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============8974635944042238885=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, blaised@gmail.com
Subject: RE: [BlueZ,v2] plugin: Order plugin init by priority
In-Reply-To: <20250103125833.58396-1-BlaiseD@GMail.com>
References: <20250103125833.58396-1-BlaiseD@GMail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8974635944042238885==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=922047

---Test result---

Test Summary:
CheckPatch                    PENDING   0.22 seconds
GitLint                       PENDING   0.25 seconds
BuildEll                      PASS      20.62 seconds
BluezMake                     PASS      1508.95 seconds
MakeCheck                     PASS      13.33 seconds
MakeDistcheck                 PASS      159.48 seconds
CheckValgrind                 PASS      215.26 seconds
CheckSmatch                   PASS      273.34 seconds
bluezmakeextell               PASS      99.30 seconds
IncrementalBuild              PENDING   0.26 seconds
ScanBuild                     PASS      853.33 seconds

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


--===============8974635944042238885==--
