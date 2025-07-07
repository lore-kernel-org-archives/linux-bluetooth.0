Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 375A0EEDE
	for <linux-bluetooth@vger.kernel.org>; Mon,  7 Jul 2025 15:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751901264; cv=none; b=IgwTlgmpNVZ0/RGtPtzvQ+FOSRMJrEnSgm+VlTPN0bOXejFvD4+iaT41K+Dm9Lx6HxtveqM2zW6k0IYBixZ1cssbKL/5hxwz1cYdH+UaXhJc4iTMVeYIrP5hH3+5pTS6WM30vUi7APJ/wcw/q9SWKPDX+0hgehHE7g0atKpzsqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751901264; c=relaxed/simple;
	bh=O+IYeqt1QV1Ltn+gV/YWbWpuFSE68FjyCDGcAT9eHD4=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=RcbIuIv/n1s8vxMcUOk+2qHGFFq2LpmArdhnOI0y+r60Y1qzcjpwZkfheZ0GuPtvhCrmFqhjA3t5tS5S8HMcXG8NDwMEiGV7KC629OCvA+aOmmtaFHhkr1CA9fFGhIGNKsNEf2rmCBubvQ3qMjhh2XQZ+Eoqsq5dXc+hCUXKCbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sd3Qa+mo; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sd3Qa+mo"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-4a77ea7ed49so55728731cf.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 07 Jul 2025 08:14:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751901262; x=1752506062; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=QbnV8BKtEmVxkuqFzjG7LP4hzvfi5IJ7p3YLUDq5cJE=;
        b=Sd3Qa+mozQB8l5PMUBbnmS2Km5dPabLG2NzHHHIpD7uNokVY0QlU1muRlEruyIIdD3
         ZlBlJMks1/7Y+t+Xv0vRoaJLO1kBQqk+Qdg1sfGp0QAO/oy+Bkt1pZfP8ab+hm3vMkYk
         BvgyirLofJh43Lr2OB6EaRAUZnyq7KJXNjR/rjWwu+9u2veOYBUBWN8Hi+fGOiR6EXal
         iFEqWgW0jq5/9RWTBce72xtsIQcx76gXsXMt+jYgCDElSOmvB9H7x0blsBBxhcpYGObm
         9rmRc6jU6PCDABTfRvfusj4+c+LHJ6PReYwnhSgYi3aT+uDb6iqYpQZeOgseqQWyOQzI
         wbBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751901262; x=1752506062;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QbnV8BKtEmVxkuqFzjG7LP4hzvfi5IJ7p3YLUDq5cJE=;
        b=PEloVFFeYgazxF3CCAkAIaKO14Q80ePPB2V3z1WrsgTlCS3nWi8H7H9Eg4n+day22J
         sBncIUldCcpMHTYrQN4WngoLtRggR2ENuR0no1k8MbAjMTCTg9/5cMKf/PtZKekwDOIl
         rfPH7lWfsUqKPwOHgk71sa+g04UZuvSiBC7dZWfwNQmgcgTLGYYn6ILyfmQHCW2L+oLl
         /4tK0tQksXdHKhMYtLhFVk/3164+F5b1+D1Az4fLcAP+Rh80jZeI86i3T5ReqRcIuQNp
         vZ1Lr/qVifHVtTFjXGowGNFms4K2Cdf82m7GUkgLaBEwUMkSOiZNRp3YDz81p4FaDLW4
         4kog==
X-Gm-Message-State: AOJu0YwRLo81u06gN0o+vcZzAUOmT6K4S23S3G8PsPz3iCN6jXHXSWbe
	rK9LP19bxrAoqi6nGkYrrl2XW7+rUXCwoXr8jPWzvoq5zqnr+qcNmIAvkg5Dkg==
X-Gm-Gg: ASbGnctqjTBIih03i5YFvoCmoGY561rEEoGql6xeTHo3qy4gfR6cWDPmx9Rfdkvca7r
	Kt0aPL3fpYuvSJD2RWDtibrXigXHhTaBnsAAsP8fKgpmirWR3c3sAVfsorp7UF7aeBZu8+q1t8s
	e2U076BceUaFedZvIv8rK61E8JO/hMEO85EQH/uLxQqd3AAapwosw5k2acvtA6AJN5c26N8rXz2
	9rvZZqmOynD/cZM3Y3X7fspxvYKeBf+qVYuMR23VftTQt5lxDlaJJrd3MJS6aXWNuzgY9sTMRvf
	dU29fe6ti8nwKTz5O5E/5HV8E5OPs5DhKwu7Yo6pTSRLo3tVwDMH00V5iMnDHQCNDp0=
X-Google-Smtp-Source: AGHT+IE/jyQsRJw3+7njmFldtNZkUGILDtHJH/5F9cwvm77gRNoIjPuurrmtMaZq/jZyzGlpj5i/QA==
X-Received: by 2002:a05:622a:418f:b0:4a9:8299:4e00 with SMTP id d75a77b69052e-4a994cf0d4bmr210998551cf.0.1751901261810;
        Mon, 07 Jul 2025 08:14:21 -0700 (PDT)
Received: from [172.17.0.2] ([20.12.22.176])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-702c4cc73bfsm60525226d6.25.2025.07.07.08.14.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jul 2025 08:14:21 -0700 (PDT)
Message-ID: <686be44d.0c0a0220.2d709.405e@mx.google.com>
Date: Mon, 07 Jul 2025 08:14:21 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3212741953886119675=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v1] shared/shell: Fix not running pre_run on MODE_NON_INTERACTIVE
In-Reply-To: <20250707134950.2395216-1-luiz.dentz@gmail.com>
References: <20250707134950.2395216-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3212741953886119675==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=979695

---Test result---

Test Summary:
CheckPatch                    PENDING   0.27 seconds
GitLint                       PENDING   0.23 seconds
BuildEll                      PASS      20.38 seconds
BluezMake                     PASS      2795.32 seconds
MakeCheck                     PASS      20.02 seconds
MakeDistcheck                 PASS      185.07 seconds
CheckValgrind                 PASS      238.18 seconds
CheckSmatch                   WARNING   307.34 seconds
bluezmakeextell               PASS      128.61 seconds
IncrementalBuild              PENDING   0.23 seconds
ScanBuild                     PASS      925.88 seconds

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


--===============3212741953886119675==--
