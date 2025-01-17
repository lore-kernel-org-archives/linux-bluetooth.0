Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80E411A840F
	for <linux-bluetooth@vger.kernel.org>; Fri, 17 Jan 2025 19:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737141305; cv=none; b=kB0iSO58aMOdnKwLxV2haWjSxi0QpxgzxwVeCrZowK1MbDX0G2s4J2HEYiNji7OQgv/YDPg2J7pnSdmIFnDhodne23tI4dDefDi+s3ws/vvUHuITnkQNgNwNKWxT6qxwA2oWAqwC7HtEV2d4uLf8pNPHTK6hDo1aVxDBw63N0LQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737141305; c=relaxed/simple;
	bh=gzLHbPT9UDK2qwKLrM0gsaQxsXxtepKJbda266xZu6c=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=f5ll8m0Qetyb7L07sXRhEBd3+cRtLP1BnnN3ctEMgYbanxUBF+H4t6hInD535g7/+20E71EP9TImJuwEY+4AwqkIiOuFvLMOZUQSGJ3rljgBV6i133wARAGrY8l71LFqj4weZ9ac57wQ9132ammkIhpGTp0USU4JLhcKhXLQz2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hl4IMoDg; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hl4IMoDg"
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-6d896be3992so19099026d6.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 17 Jan 2025 11:15:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737141302; x=1737746102; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=z843fX/UOGMlC/Jo133fdEMS8nYxUg+UAQMQIOjLjds=;
        b=Hl4IMoDgSQGg2ytIQvhcNNZMSLvdU2RZYa3srWhNoxEA0qnfQ9F17iquguxqVPHkNd
         qgb12SRRr7bKKIcViIkT9Etl8HcxC0yrYmu7Ua4KpszeHEYIqmsHM1L9KSTumt4l166G
         n2L2R6NrU/BAXfpyDBAQ8K6KCZ+2Up5k7RmnNM42zIgd6jzeMJcfInY9QqIyMQXdggku
         TNbts5OHLUHD+T4JbOcGiH5wNvyDAtARVHwIK2JQtKXP7KrXV0CoBUCIGxpFqfgGWdWx
         GUcauRMx6FZMcWdetgnF6BcWaMpJluvFGk8D3eiAF4KRiT1hGTexcEDChWH8m9yJkYRQ
         rqqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737141302; x=1737746102;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z843fX/UOGMlC/Jo133fdEMS8nYxUg+UAQMQIOjLjds=;
        b=SzVLukU2J/fl+4q9976NkMdL2Rib+Wy/1u+zc6lgnVsw7jZuPGdBHP/MxgfLt6nYAx
         IGEphJGv0VFVVuoBFozxEMEvdpimI246N1lrbKuVTsIO0ANcxwWTZwf+SwPIFsBtg5Ax
         u0NASQT0TbHrFhMCy1vNQxIFZERh7DfPXWkXh8KXySXKwOqKrkhdkgFdTBKo+01kfmUc
         q6KHsdajRK73oYkMrN5G1VD3od9tj+aYkvCa09wb9iVH+7Lld2m1THuXS8R50bXsOdMk
         oPTqBCcUOnthj/1Y644u18Ig/JboW0q3m3oVIY2qxBH0uWemwG4m8+gRDXMr/MU2Ks0+
         F4Hg==
X-Gm-Message-State: AOJu0YxCjFSvC/p2WT4ZCcQbi4amZloD/0yi6eucfN9FJTAPcXRanrTr
	GJkE5eEqa56B6Fzl8qIKOKWGAaCcYzXvQ9eWNuLOAy3mbhKoE/yhH+/c5mOm
X-Gm-Gg: ASbGncvEjnjgcSSGfKGJWzfjI/q5T6FiodZGJNpAOJjemU4TaQvfKAzKhFXB09ZAf5t
	t3phf8YNHnag4bu7Cyk+f4pNA7A94wphb/9a6dMbMlXhLEvufS99EylOxIYkLdj+U7J3b4/olfB
	dtcxzKx716purf0ud21IHe9jDjPBlRTEQiMZzlrUBAn6Ugff2Cb4lX+LLNq8CYw+sgTEYbKTWwy
	iQ0H8Cj6vedmUjP6T5W+30MvwfNFuqkv3IHf/hx4cAOqY65mpWPMnrebaDYPw==
X-Google-Smtp-Source: AGHT+IFo7HKD6P8Z8gJKhHL9fiylUTBupCk4gWGX26ZMW3lHGyLTwUrpZldSqIOkNOQ8vJfve0DKhg==
X-Received: by 2002:a05:6214:3b81:b0:6d8:8667:c6ca with SMTP id 6a1803df08f44-6e1b220c59cmr68889696d6.32.1737141302121;
        Fri, 17 Jan 2025 11:15:02 -0800 (PST)
Received: from [172.17.0.2] ([20.25.193.13])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e1afcf7475sm14215206d6.125.2025.01.17.11.15.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2025 11:15:01 -0800 (PST)
Message-ID: <678aac35.050a0220.4a607.7996@mx.google.com>
Date: Fri, 17 Jan 2025 11:15:01 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============6320097169617024768=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, hitechshell@mail.ru
Subject: RE: [BlueZ] shared/shell: add proper line clean to bt_shell_printf
In-Reply-To: <20250117180611.14869-1-hitechshell@mail.ru>
References: <20250117180611.14869-1-hitechshell@mail.ru>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6320097169617024768==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=926556

---Test result---

Test Summary:
CheckPatch                    PENDING   0.25 seconds
GitLint                       PENDING   0.27 seconds
BuildEll                      PASS      20.39 seconds
BluezMake                     PASS      1474.80 seconds
MakeCheck                     PASS      13.32 seconds
MakeDistcheck                 PASS      159.58 seconds
CheckValgrind                 PASS      212.01 seconds
CheckSmatch                   WARNING   269.32 seconds
bluezmakeextell               PASS      98.06 seconds
IncrementalBuild              PENDING   0.29 seconds
ScanBuild                     PASS      851.99 seconds

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
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
src/shared/shell.c: note: in included file (through /usr/include/readline/readline.h):src/shared/shell.c: note: in included file (through /usr/include/readline/readline.h):src/shared/shell.c: note: in included file (through /usr/include/readline/readline.h):
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============6320097169617024768==--
