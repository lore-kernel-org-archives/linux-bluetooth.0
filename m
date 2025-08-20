Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47A991DDC33
	for <linux-bluetooth@vger.kernel.org>; Wed, 20 Aug 2025 15:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755705164; cv=none; b=tpV3XQxTSvO6GRDT6aQlm+vAMlDFyUc74L0A83duHnB6bi6DCbFMOekQ3t9ocTzC6Z54YXWYYMYYQyQd9XYaiIeXQFQiF+dMpqAEIMqYAX5BDO1UGnezaB9Qa8pe29Ed28WDoh8g0ZP95y6jCWtPqtVDbjwn0Nx+6xQcZeB4+hA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755705164; c=relaxed/simple;
	bh=SHbUXEL/RsUa8OWxzgI4IjwEpfF2C/lLgD3bMSwH+nI=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=rnKY9YqhI1a/VKTt5jRndHLSuxo+lfXLhEqL4TuSA3uXM2tGPzfefHmIFb21F34Gf5G1eK5t0wHqDy9eBaexE+P4WurpSw5bV7M7ghH1BVWktX0iBFFVDJnnpfGUvuJPtgjaK777IUJ9aHL/pd5MKKxmQlAlxHI6dU9sBtiTCzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R6aDkI7w; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R6aDkI7w"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-7e870325db1so671356885a.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 20 Aug 2025 08:52:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755705161; x=1756309961; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=KT4lsFEjOojtJf4bV79yclX0N7rKJBi76aZLRnGX7MA=;
        b=R6aDkI7wnZUMXUqU+VFqupT/rafLHPaV4jJv8WlPDNovxR+QcFDqPKLViv/sCFYSQd
         RAQi1vglqok/9t1Me4I0hYcKKCBHLHk9V/K1FAMlYnhFsrV3+XFcQGS+WPQDMZdo0+Ch
         HwsHGVZa7l2BvMfkLC2GB1DfWyIcrKD8yD4hWr0DmljtU6tlwMEMyaJGfrWqli04F7Ma
         JVdK+vKAtIM+sknA/2p4fl0pSglVT+SWWBUVFNVh638EKz2FsbiTM3PdUt72YZeRZiSO
         2SUZKVuy/SjOTzePj8cEm9aGy+cDL5P5XPrPz+4gAU4Bei8HsPzKy2wmjAPJNhJFPpgn
         lA/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755705161; x=1756309961;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KT4lsFEjOojtJf4bV79yclX0N7rKJBi76aZLRnGX7MA=;
        b=jQBeVstJEfuJuAtcOVuMErjvzofJJPSxqwP0G180m3pzARw0o+XhgTWqFSb0f0mAUc
         zF0xv+lnwY5owibP04QrVg5kusIPZ6O+rXLyx+4krrt8onntsPqlulr0kUI5J2zoZRxW
         c2LGhMC/roYzvZcnQLWrW9ae8Yf09Z+W6Yz3tAKhVSarTUUEbs05qTSySxoAQynnZoKw
         rkjHE4jeJa4uowGWjv7qcnw19PdMFs46H3fsrnHvrWpzg2ykGyXxGD7ujTkCvnKPi+2K
         z+boLRVpXu89rit0s6stqOHRqldorlcu3SKkM6TpE7umyplV/ufyOdZk3MFxOkHTqD2T
         K6GQ==
X-Gm-Message-State: AOJu0YwR2n5Zd6vkC7quT9BygcaFW3LMztfciXvqpqsWSPKSQKW50Lb8
	lPjDCHEGnGPwzz69N+LlWaWLwrYwnGRcufGchkZW9tg+/wvAAXYcuk3CzODUag==
X-Gm-Gg: ASbGncvP8cXkE8rx/0uHc/xIg0tEkmvraFk5TpX3bhWDq9DsccmlAVvuTfZcPYTsavJ
	wQ3fkQg+3I+R4gw38W55oCRzIEMuv8+YTsMwgRkSQ1Q+cV6BqIkGtzGvmc58laFJecrDU/etrl/
	sPVDUfmOEmXWnumMjA8jNqC61RBnaXvHTHY0QA2Mzfd1LHhRMYVhuCFxZRytha75LC88/tkkaMX
	rJjnhBBJzW8CFXV/6DQvKarb0xAiF8jac2voZRBc7xjUr0NGjgvBE4C5Us6fynfwXFitvq5w2Mw
	YWDO68uUOOLQwk3fjg7CBf+yQ7pQyLi6qFrWoBEu1LcoWCxQJNB+J7wV6YGmSH0cGFcz3b6+dLv
	eD5Xw8nif3q8vzMcItlGoJOAU1jE=
X-Google-Smtp-Source: AGHT+IHjylDsOLlDKSwzt1ezA3aF0S8es8jlmpRll7YA4yX13zZvqYAj0gXD6ljG1YGn+Zg81WBDxQ==
X-Received: by 2002:a05:620a:4546:b0:7e8:38ba:fa5a with SMTP id af79cd13be357-7e9fcb0a25cmr429313285a.39.1755705160823;
        Wed, 20 Aug 2025 08:52:40 -0700 (PDT)
Received: from [172.17.0.2] ([20.109.38.57])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-70bae08c0f9sm83709356d6.11.2025.08.20.08.52.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Aug 2025 08:52:40 -0700 (PDT)
Message-ID: <68a5ef48.d40a0220.27395d.7ddb@mx.google.com>
Date: Wed, 20 Aug 2025 08:52:40 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0879364567260665911=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, hadess@hadess.net
Subject: RE: [BlueZ,1/3] profiles/audio: Fix uninitialized params.subgroup_data warning
In-Reply-To: <20250820141552.800720-1-hadess@hadess.net>
References: <20250820141552.800720-1-hadess@hadess.net>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0879364567260665911==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=993547

---Test result---

Test Summary:
CheckPatch                    PENDING   0.27 seconds
GitLint                       PENDING   0.35 seconds
BuildEll                      PASS      20.01 seconds
BluezMake                     PASS      2580.20 seconds
MakeCheck                     PASS      20.06 seconds
MakeDistcheck                 PASS      184.29 seconds
CheckValgrind                 PASS      232.98 seconds
CheckSmatch                   PASS      304.47 seconds
bluezmakeextell               PASS      128.14 seconds
IncrementalBuild              PENDING   0.33 seconds
ScanBuild                     PASS      901.25 seconds

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


--===============0879364567260665911==--
