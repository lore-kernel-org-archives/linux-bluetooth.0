Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13B39F513
	for <linux-bluetooth@vger.kernel.org>; Sat, 15 Feb 2025 00:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739578165; cv=none; b=BXTGrIxOoZ4uVhIa/Af/TBR/N9+N+/VnQ8fnKd/spsz7VDQgEcy/UC/ilARE1OpKoajqCoGGLmfRl9GCnJ36vaXVQKYoYsIi+VUvqo+55spzGMFY/iuwHWf/9E3V0Z85UpC7wP/mdyKyZpr8QnMB3zkqkRBlMRYsluro3M4gutM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739578165; c=relaxed/simple;
	bh=Y753/1E9eK5YK0iaDuXA/peVz4/5LueNJmsXwNzPw9A=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=XawtksSalv+1+7daS7hbCYTzY+2FstGFAOyQr47PocKMk+zqR8cLMxqei1ztMKJw0hrJMMV2arznm56MxUQVsKlNi5/O/yF/2eGWe22J8tRlIoBNg4Aa4smq3jKXnXIxgf5UfZAwJo5QhNs13FHV0O0Grc6Jd6l2M/dINK+Nph4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J2gWq3A/; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J2gWq3A/"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-7c05c22d32aso451891785a.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 14 Feb 2025 16:09:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739578163; x=1740182963; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Y/TynzcgL9n5z11h9norQ+5ryuAYNerp++kisPfZu6o=;
        b=J2gWq3A/6KOEeqNn7rezwsD0ehazLCcbCogE8iIcuokY6E3CMtS8BC+lU7mW81Zmaz
         1/J4ih2XrssTBfuTF5IH2YXbcl4A1N90BFWbBm70TyVNyLgzGp0Hpx22ilGF+/JDk6wB
         JF4Ro+zzFhnHs+56kPhjJAxAr5NvGIMEtfLzPD+LJ/SKU5sPxODzFSImNXAstEn2c27B
         zT3Wjz2FJGIiiSnb5ANoyEqKLNJGwezUMMoZXlIdYef/v0QIupZrBtJOcV5UGhKqNwJs
         cQIhFiHHW4WK9hkUI19A2j+8JDjDPt2NGn8MJqMz2+8d4ne2rVPuMUwszJMehuZcThw9
         +v3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739578163; x=1740182963;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y/TynzcgL9n5z11h9norQ+5ryuAYNerp++kisPfZu6o=;
        b=cBLg2VrFwQJxEAN/Ez8XOXj8Lh0z1bNLfTRiBjfT+S/Qhr4DujQZQ1FiUZKs3uHhxp
         Z9YK7Uk6qMIHh9qyZ3flm/jluv9caodRnVIlzvi7vLlE+AO5cIZ6ljTg3QxozBzAVL4c
         p/pGB8tYW+yPTZPpVoSCu+2jIOwL8MjOztnun7CyAkLgrI3v+FWRE+w83yMzIgKyb8Hv
         7wcLimz+OUb/VAW2jJFH2wLwCZeDdF8LVVr/77Rrt4gnZHz7IpMFhboVJixyVTWUChV7
         nC4iEj4t1A3VjG7Fq8jP+ob/ou4QxUHHYa2T2MrzZbOccngCw+AFdTYAGs5srQ+DMDKL
         /RhA==
X-Gm-Message-State: AOJu0YwcYDbtJVUFf3T7iCUIv4ppdtJQkPO1ipp8jgSWbX3gHUsbBdqr
	POcKn0+BfPRiVgQzop6JkD9TKXHrHjmLCd6NAI2h7TVcuBhoDopohzBKOw==
X-Gm-Gg: ASbGncuBPk7fW6wAo0sIqlXED1E1tvCoOjfdWeKbPvw2IUFIS6tuo7cWUj6chAS+rJD
	jpKbGpP5BtiH4YahPkc4/kHnfiBZlVE2mpRQU8C7BqI9WtfhCILdtfUxUBzySUlpJTVUiApUkjC
	1tUA5rH176FhWiWwn6cIaFVP1cz56nvXBXf/eC+O6WnmeMB1l5btwFB77TsYjze/VrnkRQTJvv3
	jVI977Fi6QaB5oVi2fW9z1/aS3d1sy5GNKgPU0gseLkTM6okdAOupDbuEnQwPfocoHbWVxZIA7O
	Wjj9nFikQV+GUT0myrM3
X-Google-Smtp-Source: AGHT+IF8scdZzIvL3kncmhhcI4bdI9Emb04jIL4y5rtKYuRzXyy72d7qDdYKM//PGPxISWFrMpkvDQ==
X-Received: by 2002:a05:620a:2948:b0:7c0:7935:63fa with SMTP id af79cd13be357-7c08a8a9521mr172227085a.0.1739578162721;
        Fri, 14 Feb 2025 16:09:22 -0800 (PST)
Received: from [172.17.0.2] ([20.88.39.178])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c07c60885dsm261603185a.44.2025.02.14.16.09.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2025 16:09:22 -0800 (PST)
Message-ID: <67afdb32.050a0220.1b640.a4f5@mx.google.com>
Date: Fri, 14 Feb 2025 16:09:22 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============8524446600411907235=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, vibhavp@gmail.com
Subject: RE: adapter: Fix unnecessarily enabling the connectable property.
In-Reply-To: <20250214224149.135458-2-vibhavp@gmail.com>
References: <20250214224149.135458-2-vibhavp@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8524446600411907235==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=934207

---Test result---

Test Summary:
CheckPatch                    PENDING   0.20 seconds
GitLint                       PENDING   0.20 seconds
BuildEll                      PASS      20.45 seconds
BluezMake                     PASS      1546.46 seconds
MakeCheck                     PASS      13.56 seconds
MakeDistcheck                 PASS      157.94 seconds
CheckValgrind                 PASS      214.45 seconds
CheckSmatch                   PASS      283.28 seconds
bluezmakeextell               PASS      97.91 seconds
IncrementalBuild              PENDING   0.27 seconds
ScanBuild                     PASS      855.36 seconds

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


--===============8524446600411907235==--
