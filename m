Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2B3A4218B2
	for <linux-bluetooth@vger.kernel.org>; Fri,  6 Mar 2026 17:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772817161; cv=none; b=q+eggnD69PVU7EL4RARt+7719vkZ3/o69MLXC5pCJVX1eAptSLixOON4YbUJbo/zyamT/OifZASitp4ZU58IavVEnnKc6EgLAKCrfzLAyAVMpMjjH6MZLpbpE/WoQi3hLuGy4Ce4ujQjwCmo3KGfr0d9OR7aVstfFqTDZm8OoN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772817161; c=relaxed/simple;
	bh=MbKNXFwINYNTMX9Pg+rKx6bOwi0XEFSXnbNrieOx/gM=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=LKXvkDLFBMg4GOsOfe0v1RbcGpUk8GVl/l0wgi9CgXiaaKziCZLPl20SxKomQkZSCR9yBxrnhfMuSn7SKSMHGtUCWZqt5HsgRKGTqTgrVctVGKr3nK/36i3ntRdEzfIZx57P6J21F6u0p4ATQnKzBegNkJlFEAZGZmUf7JgPlAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ltdi53Yc; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ltdi53Yc"
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-899f79df682so66090276d6.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 06 Mar 2026 09:12:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772817159; x=1773421959; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=m712pcnNaYIkgJj12jgagcQIjlztUyrv/gh3i1v9Llk=;
        b=ltdi53Yc45cs0fTPAu400B7qdiimyMGvEcMEkwmXo0k94d0JzeQEYESwn6lW06tbqa
         OhHApSJyrsGg/AdSn/+n2x7oqLZoCaFbH5RmWnN5dKS7cplq2okgzLgu89SFj5JPX9G5
         QDzjstyv99zDBt1rB8sgdRxBzxc3aACha0DcIwC5sSvjiStEAHwlXPO+DqCMA7O8RWD2
         vypDlRCR+ACpf2sJaE7ki1PoRAk9zbP4SuL56lTdPzMrIScU4gDpOCH8iuJuoLicU98C
         fGCfTbiXwx4fckGuIUGPCP5rcU/n7Qc8x/+Kq2p/A2SoUX2bG8mDR42IDpwW/V145iQ0
         JrNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772817159; x=1773421959;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m712pcnNaYIkgJj12jgagcQIjlztUyrv/gh3i1v9Llk=;
        b=otGA16vrrN7+DvInFf6dyF0vnU8ngSdj8NHTKh4SzO70beM85xoTJd+mrdbFQU4g0J
         OIkdXXG30NoIeCxxupIuT/TQKpIikgu+pmSu7bKUBLUNL9nFePs83LQR+mVzsLRULBtf
         PRi54eJsQAjrvYk1HC/HvLHvS8x0fW8n0VShMAb2pb0E1qdD0nHl5SMg/TrfDKq8bV5l
         WjiLCK+D6LHv22cI8FHX2PCL73yH9bJqtPp7lVezaeAMOU6/423eKWbW1XgLnsos4stW
         qjicVVnicf17a7zuj88DbwNL4Y9Bi+i+xfyZqiilPYQ7Ef4sc6BV18EBw+BOf/stCvc2
         0BDQ==
X-Gm-Message-State: AOJu0Yz+9RL9FbIIbOMk1JHDoTvZHiOGKKMt/AkD4vU0JDSzaQoadFbY
	sXWBtzvaew42AlrhCRbqXgi8xsg/sefcOBQry/wXVjk7NGmXda8woHBCN4/gWA==
X-Gm-Gg: ATEYQzwZfVck01GMqD9QCZDobLXr5N4Gnyn1L3nbeCRd0sPTKlLqxaWwkxHTZqe5kQG
	YKMwNzG0qh3zRxTgx6c6UOYYUl1oK3IXgJJSTkbEVYr7TNW7wpidbP5jVW5Do3U2vjHDk5ce4XF
	lBJ11zGG5oGGJadW+655H0vDJuqKnE0TeCoR5EvbF8QN/hrkfZ08hipM7do5K9GvbrPh8Rl2Ol6
	4sn+3H6M1XxkhaxJJkI8pMR5A2gz8VSK4ZOtZLPwUEIYVu8LCi4fh+kaLMU7JjJ9cl/oEc/hDfy
	Sxsuo1BJJSWDLUS7fId8WLcpLH3RaWj5I7afli44d1R6QRnR5hM7tDbypwcF8GikFCQYYT2WunQ
	OWGXdHrHKQxE2ZbkK7Ad3KCLVZ8J+Qv3lD3BFSN0BhsrCfg3mUt+49/2edreweb+vgZff8gFHxw
	LvJtKmmaBNJ0emcFJIlrBJy5qDKAYXLTc=
X-Received: by 2002:a05:6214:2523:b0:899:eea4:4715 with SMTP id 6a1803df08f44-89a309860f0mr36564596d6.0.1772817158724;
        Fri, 06 Mar 2026 09:12:38 -0800 (PST)
Received: from [172.17.0.2] ([145.132.101.198])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89a3171955dsm15377136d6.47.2026.03.06.09.12.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2026 09:12:38 -0800 (PST)
Message-ID: <69ab0b06.050a0220.d0e01.0610@mx.google.com>
Date: Fri, 06 Mar 2026 09:12:38 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============7505588696345338342=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, ceggers@arri.de
Subject: RE: doc/qualification: follow up patches
In-Reply-To: <20260306162058.15154-3-ceggers@arri.de>
References: <20260306162058.15154-3-ceggers@arri.de>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7505588696345338342==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1062730

---Test result---

Test Summary:
CheckPatch                    PENDING   0.33 seconds
GitLint                       PENDING   0.37 seconds
BuildEll                      PASS      21.04 seconds
BluezMake                     PASS      658.92 seconds
MakeCheck                     PASS      18.98 seconds
MakeDistcheck                 PASS      247.49 seconds
CheckValgrind                 PASS      297.93 seconds
CheckSmatch                   PASS      362.92 seconds
bluezmakeextell               PASS      186.11 seconds
IncrementalBuild              PENDING   0.35 seconds
ScanBuild                     PASS      1043.78 seconds

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


--===============7505588696345338342==--
