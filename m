Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73CA4188715
	for <linux-bluetooth@vger.kernel.org>; Tue, 27 May 2025 08:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748333593; cv=none; b=MmWIgMhznVuP9elw7SUGQdmLc+3YXsfZr3BHYfz1afNEyn9hk6M5Ul7DkacyOidWsXiZsatF1oSMganTFg4hrcP9AZtTvdzyJUUPY2pp0DwaxyDSZdztaJO51WiEitL+vto5AYcsiLePz9YO7OoOtltWPFDy8jtvYe7RWc7MBoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748333593; c=relaxed/simple;
	bh=Xaxm3Rhg2WPrXBeOi9YMg/STT8La8PEGkxrC7K1VXpA=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=juBMJHIHnl5XEzC1P9o8rUBGtSz9lnQyyTUh/w/5ePfCvkyc3O2im8P2UQbHwO9ypMTfBRjRXiteif9XwuqKn8l474ANZXPQYgj9A6X4iR7QNQDVaBa9xBCy8tdciWGzKVP8jTy+0Po9jOgcS+9P5Zc4VsihOZfHCZ2aM023mGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SAHM2/ks; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SAHM2/ks"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-23229fdaff4so33269315ad.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 27 May 2025 01:13:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748333591; x=1748938391; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=b8PsQDoUK0u2puVaMFDgYvaVKhUM7SgGVNKZ4QbgSx0=;
        b=SAHM2/ksy0IdBk7IKXVuAGPifUVEN3rIwdtFhBn5p9O2cpOihuIOqYm9YQwPViELB6
         5ROTuAp90h7zl4z5KgKPtKge/33tkIPxU1wG8P7snXUKzXtW4i7rMQTLQWT5DkQfRtwW
         nLGuO5oBICaRJgLWlQrfhueGLLSljBcjXykkl8B2IegYFRE2a1kUyjH2YVhQNxUnsElW
         /oOnJ1oEF5vzNrUCLjUfkzn+/q2tgxbf0n+YSsZGz5pBZhxPxQR+7ki6Q5bwx8AN9SsX
         Ohx5ZfOiQ4ti4tj/T4NWRhKnl/ImeV+5dUvEknxiezKRmE254kqBRpJ3OJA68hH0szlA
         FvJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748333591; x=1748938391;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b8PsQDoUK0u2puVaMFDgYvaVKhUM7SgGVNKZ4QbgSx0=;
        b=hUMT3HC8bqykgggHguGddSSoSzJgSGyvucD03Hf319hIPZXqQENrwg/rTqvWryzv0f
         tVFpO0UZYu/viiFKOYAoEc5KovyKzPdcsLqf5AhOpiLTKJux/Q2pwPgJdWFZ9DH3vf4D
         TXlRFF0hF13xp8IF4lt9RaoYa4JaQwvLzXaCUJbLdEAbcs/RzMo6Sc4ND899EOQjZDHL
         cjBcef8jiIndfemNCPy1FaW0Z8jZE3U76QlEpx0rFlVg59QnQC4KNdxoT05blMh7LP4U
         Gr2LZZeZwsV/iDkPpXmJgCLu6bzBFC/dyUwTRtHTAl6OfSGXqATIRKeYLaUpaT+qnFDu
         5UTg==
X-Gm-Message-State: AOJu0YwGFJ2ii6JW2ja6NFUnjZr0wE+AYTmAHGQ3KWrN7SR3ZYrp7ECP
	t+8ftYzVZwczgC5D1gHK1IS3BXJWEf/743gNPTa4tKAuGOmuENJwnM8a+CKtG8Xs
X-Gm-Gg: ASbGncuir02P8KM1YTF9J7hjYrWz6Ab/MHeV5pLok7wVnxbrFj8LydpVLf4vmx0sH08
	Q/B5DvFjNcLTtNW85Hlwa1LGdYKNC+Cs+KB5LHMkUQd29gZcxOeOf3oRtSU0C5F+HPY9d5QV/3f
	kZNlwS2O7bHRYgYCCl2NU4ME+wWw6p8/pOjFGRvQLwTVQ+f3hLKTs2WeKC2M1M8DCcXjnI5Wb4i
	VC4zy/0p8+pH0AArCtFp6oSyNK9oFSyXQGo0T/svUBe7aQ5ldNdMj8WsydRcojSmhS84mkwoAxT
	BO48x3ih1WW6VQlDuQrv5ccRV1nyPwdjik4GXx6m4Yj6X6B5jfGgRGrquzU=
X-Google-Smtp-Source: AGHT+IFxNMK/rKmmDj/tO2jX+D103HB231RWB4diRxarG7MRjZjO7SsoSb/CEDqRpcKwlLKs7eNAfg==
X-Received: by 2002:a17:903:3c2b:b0:22e:3c2:d477 with SMTP id d9443c01a7336-23414f9127dmr199157105ad.25.1748333591409;
        Tue, 27 May 2025 01:13:11 -0700 (PDT)
Received: from [172.17.0.2] ([104.45.228.246])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b26eb084980sm18281676a12.58.2025.05.27.01.13.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 May 2025 01:13:10 -0700 (PDT)
Message-ID: <68357416.630a0220.20f56b.b523@mx.google.com>
Date: Tue, 27 May 2025 01:13:10 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4288350778650026200=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, frederic.danis@collabora.com
Subject: RE: [BlueZ] audio/player: Update track duration if previously set to 0
In-Reply-To: <20250527064615.125970-1-frederic.danis@collabora.com>
References: <20250527064615.125970-1-frederic.danis@collabora.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4288350778650026200==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=966556

---Test result---

Test Summary:
CheckPatch                    PENDING   0.36 seconds
GitLint                       PENDING   0.32 seconds
BuildEll                      PASS      20.56 seconds
BluezMake                     PASS      2736.73 seconds
MakeCheck                     PASS      20.46 seconds
MakeDistcheck                 PASS      200.00 seconds
CheckValgrind                 PASS      274.75 seconds
CheckSmatch                   PASS      301.36 seconds
bluezmakeextell               PASS      128.05 seconds
IncrementalBuild              PENDING   0.29 seconds
ScanBuild                     PASS      910.76 seconds

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


--===============4288350778650026200==--
