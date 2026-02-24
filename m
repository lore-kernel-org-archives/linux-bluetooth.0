Received: from mail-qv1-f65.google.com (mail-qv1-f65.google.com [209.85.219.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A5CE2DC789
	for <linux-bluetooth@vger.kernel.org>; Tue, 24 Feb 2026 20:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771964400; cv=none; b=s4VYu31DR6ULPZ5bWfAEHhfpi68mu5QJ5PzVSGq7yDTadr8VxzgSbvibu8qkapf2CGXNyIlSS4JpFc4ZvfwUtKXkjHP9T2SWqHge7HRYIPqCecJexSzwWKgDTTSZWEVVruFkq5PDIiCFJ1+WSKRsYlQof5uZ+hGdSy/uLyN7/wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771964400; c=relaxed/simple;
	bh=4h0h3/YUyWAS7qqFG4xXLycz2zU1XsQBlhW+29umTB8=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=DJbUpKG8pmCkjubl/zIXvdrBWZMKnvwoU7OL46psVXvptxOMNDcXOrjpQsWN926Poj3J5uBtrSmB+7JSUshCntQ/kuZo9SmmVufeMA3MTfCtlWIBrDETaUvO1QQkxs3UF4d3aJDjDZoLppg8eqZNyUmDXzA+apyo5roiCJc6F1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MTkI/DUM; arc=none smtp.client-ip=209.85.219.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MTkI/DUM"
Received: by mail-qv1-f65.google.com with SMTP id 6a1803df08f44-896f4627dffso79357726d6.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 24 Feb 2026 12:19:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771964398; x=1772569198; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=gwn08aiZc/uaaCCHYYlyxEZxpREPITVCKLXgszJtup8=;
        b=MTkI/DUMGv5weGWlTN46/R3TzDPhw4JVlFMTR+hTyh8RU8u3Gzzb6I9py+j21HXIQ5
         QbujVzQFTwD79GE5YYmr3AwnBdRvmhkVbLA5kQlcQeMJ/MTiWjfB50+8zDwV88OAjBri
         AqzJr7PJOFa7pKN04H7POsOPDRRbryfKjYOkNSj1USvOOnlEmy14ohVbgkr4vvG8Q3bf
         jD2JNrDQgtfYEibTnnLtzJpTnrKJqEQ4PjBGKASCny6TqSWS2k+z4RFA3w9lCXnn/xLc
         AKqltQtcxeyrP2OgS9xOKngMLNot7/0sWS1cMCrAMB4yWSNOyEF3RTgnD4CpHyEq5j8t
         EkFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771964398; x=1772569198;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gwn08aiZc/uaaCCHYYlyxEZxpREPITVCKLXgszJtup8=;
        b=r2bbu1c4OYl2V6U9rEjWuHGXDQUNQgeH0leHjsbtZbOBRDGIjApSou2CdxPTQkZFJq
         K2OClKLhFmgRpccwnQSbae0Rj1Novo/pBgnEuWFUbbCF1vOjbIQyMR9yrcRJJ9kL8Vds
         dfbFwsfw1uS7gs5aNkRCbCJnMdzGPINP8LFbn09CZeaLP6jxOLtf3RUyr2v3VZ2dPdFJ
         L+x5Rw9PG7CAJNGTklA56BFHeCHP3OrZThdnzDGB9nbm7V8bU9c6k2JpafO6Lduxd0O7
         6COcnghELSbwj/oBCDJJgQy+X6H5xmij9cCN/wapdu2XAdMZMWBGnMDwWseQJtjS6p3+
         iKNQ==
X-Gm-Message-State: AOJu0Ywgb3x0ywS1JUlUc3ysOsnNxaA+QyvIe/bnWvtZE7j9V1OK78Rd
	0RWSfkJCJj5LWhzw/Vww1WSCJQEERiKRxx3vFesd9Q7YnDE+s9rymcnDY93Z4GCv
X-Gm-Gg: ATEYQzxJLHjNuevkP9O9hyEyvv+GCthFG6OtdzOvkgLgZP/FyVtstlvXkf/wHpQlqfe
	SrH/iPIngerLZIXLC6zntBcudsOMng+z0Df8ASgiI039zZFb7LxwWtF0PJazbCuBphQNn9u1Aa5
	yWcy8I3dWbsZlMW3lOalB3/gSd3ZH4TOvpvRujXAlPUrrHyJBptFSxmUfVwt5kuF2HTDr3o0Bdc
	vAs/j2u0wQGMgkgvni/DEDp7drJgZkkShVCTNu3Bk9S/DG4uMMRVoHrV5Z0Ishdjk9DdBLJJPjE
	3gajJW3K4Dir/xtd9rBoRQxsFU1545twyJdanmSzJxq9nMvrtgPFIjUMlhmzPTvzL+lxmYfgjSU
	rnfOyJ9LBw6b4KuLAmMCyOXNyhCqaw5fsk6E0j409B6z3nm0mhObOWm7Mnmhb04vdLgKZmQ0EL+
	p7FjdZOmT936mNDK5hMxZmDP3C2kGrPQ==
X-Received: by 2002:a05:6214:1311:b0:87c:28cc:9e69 with SMTP id 6a1803df08f44-89979d64379mr215081966d6.55.1771964398178;
        Tue, 24 Feb 2026 12:19:58 -0800 (PST)
Received: from [172.17.0.2] ([64.236.141.179])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8997c6b6af6sm103887026d6.12.2026.02.24.12.19.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Feb 2026 12:19:57 -0800 (PST)
Message-ID: <699e07ed.050a0220.215a0e.0371@mx.google.com>
Date: Tue, 24 Feb 2026 12:19:57 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============4649535442109551317=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v1] shared/att: Simplify logic of DB out of sync recovery
In-Reply-To: <20260224185524.4044679-1-luiz.dentz@gmail.com>
References: <20260224185524.4044679-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4649535442109551317==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1057371

---Test result---

Test Summary:
CheckPatch                    PENDING   0.31 seconds
GitLint                       PENDING   0.33 seconds
BuildEll                      PASS      20.67 seconds
BluezMake                     PASS      651.10 seconds
MakeCheck                     PASS      18.39 seconds
MakeDistcheck                 PASS      247.57 seconds
CheckValgrind                 PASS      295.74 seconds
CheckSmatch                   PASS      351.00 seconds
bluezmakeextell               PASS      181.56 seconds
IncrementalBuild              PENDING   0.35 seconds
ScanBuild                     PASS      1036.62 seconds

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


--===============4649535442109551317==--
