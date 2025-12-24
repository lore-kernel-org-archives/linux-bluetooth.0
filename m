Received: from mail-qk1-f193.google.com (mail-qk1-f193.google.com [209.85.222.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9616A2C21CB
	for <linux-bluetooth@vger.kernel.org>; Wed, 24 Dec 2025 15:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766590592; cv=none; b=BmPgJXHMz/hfIXELX/kX7cvW1ki40qjqtwE1XybGn5ojhUHZOx6cnn2uMoWc12RQn5biwnVLZTrzincDBRxkDZtbV09L5niMNYNilu0mVQc5aw3WpJ0ZJWQY9gDzE2KHJUtT0OpkMcn+gbb1UJloj92OiOU5i1CS2L9qz+g+KIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766590592; c=relaxed/simple;
	bh=axXgdBliU276CXI7OjJh6DPw24cGI+8DGzfgV1MKkmI=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=QTBswZaaE8E/oh331de+PzLIuIAPRz0pyGN+LoPirIcKP9mx8dJO9EZSAtXC0UmbYe3uPc+anWGhBW9qurd/J5b8SwRTgZHxP3yqPgV+9+gx+Gei3jW/w7pYGCX3sfJMr6KTnPEkkfDPrEeFEAU/CMkldKR7pllJSO+ZzPpE5Kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a6jveb5Q; arc=none smtp.client-ip=209.85.222.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a6jveb5Q"
Received: by mail-qk1-f193.google.com with SMTP id af79cd13be357-8b2d56eaaceso723633785a.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 24 Dec 2025 07:36:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766590589; x=1767195389; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=N4PM55mCTVf6g9rBDy6fp78YEMZfuAhQlMtLtTC6xmU=;
        b=a6jveb5Q/eX80qOkGOYMlXpZPfsvYoi1WdWK+dOECjk18pKGrSzHTcw1QsXEEtpIHU
         Zh2EOWU5oEAWizCypPPnHio6ujZ+0mQU4v25flRzsmfDZSgcIsOQ3r4Z5hJpHN4wbV03
         12beX5dqN3prFshadxpg5qOib9TPPetSaeQ7Gi58+E2pfsNYIV736iJHzXxXPCxQOIxy
         5mjRn9ABmJVLt8PgzD8fOyuucbHLYiWrXi8/r8/5a1SozIXHCV8VGsBiQ8uX3EwojcVl
         y6IOJcpZQIiAs++in077pDtAk6shmiNUHy0qaFCo5bVa18Ox6tvGQYgfNXKPLmJBrFWO
         f56Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766590589; x=1767195389;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N4PM55mCTVf6g9rBDy6fp78YEMZfuAhQlMtLtTC6xmU=;
        b=tc4Mo7GY71XHOPGcKOR6D67i4T7LuI6nsAOueSMRHQ/WS/3Zv7R/nXc3/+JrtmXdyv
         gmMFUtA1kvhdoxPd8WjrF2FbuaAs8hQ/J1z948HYKkOmG4DudYF61QoJRs/V6aGGu+mk
         yeJvPes+mpTCNMJysJYeaFo5E+aMG67fwsRVFiIecEu5MS4S5tXYpSnuGuR5xtoyshUa
         v2tAhN1AzDaLfVSWLmarqB61vXXCIjBtZorq7dJmw9JeFZkzesldPlUvIAaqe65keZiZ
         Rpz5MlBVPnSi/zgPuA+IpXBOfuZUSdzpfmRCJ+Py6wkwibASNB513yxshzGvw5IZwBzY
         UlZA==
X-Gm-Message-State: AOJu0YwmAcFYjQZVOKEb8TT18r7qtTGtpCHBj/EgTtolud1roba3jy/N
	pH7kMyeH9lf9xSDiol7E/I27VhqKaHEviPFmyA5l+f8dx/VrhFldZKECKoH2z+Fu
X-Gm-Gg: AY/fxX6R9OPxrFSh3c1A4FX/EkYG6jg0CUyKvmkbVBd8bK1zNo5SkC4FYE18JotFWDn
	SiOUj9DFuld/cWD1ETLoBgeU9ysDoDL2AVZqzZKOynZnDwd3MfY0zIgKQ7CO115qQCIFNH7Vl2E
	VUhlcd7HrltTDV7NwSC3HZ/k+tU0xZGK54rjMhxZHnsXlHR+gmKFlYYWB4BcgmzHHEJUUSJPoep
	wZdphJrvbwyG+CI7ldoL1soRZRTmly1u2S8Sk0zhe/Xc1BOTLqKuk4ySHxNDFUA0RowktCShTX6
	GpEGUfvw86Nf4W/f1ltX9kTXt+Nl6Kgb8NK2pIWT0NHBNK/45Dk0WTGSpnu9Nb4QzaLKrkQZc2m
	WilGfn/lSymCxDd+RxDI5/BxMsvwy8gIFU1gbaT/OOjT7OdtozQur8t9v+xcdakp8ZF9HHTOQ8w
	Su3VKONsRRzBhsAolhQA==
X-Google-Smtp-Source: AGHT+IE7OFKy1ldN+xO7RETgCw1iIKghSjBCo7SZrhig1FVAHo4wWWn0lKZMLoHIOSSHeBwoBWJHpw==
X-Received: by 2002:a05:620a:7102:b0:893:1c7:4b with SMTP id af79cd13be357-8c08f672adamr2802958585a.31.1766590589249;
        Wed, 24 Dec 2025 07:36:29 -0800 (PST)
Received: from [172.17.0.2] ([64.236.142.227])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c096a8c758sm1345798085a.24.2025.12.24.07.36.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Dec 2025 07:36:28 -0800 (PST)
Message-ID: <694c087c.050a0220.8b186.dfd5@mx.google.com>
Date: Wed, 24 Dec 2025 07:36:28 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============5409621599703129091=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, frederic.danis@collabora.com
Subject: RE: [BlueZ,1/2] shared/hfp: Add function to get multiparty call status
In-Reply-To: <20251224144545.211533-1-frederic.danis@collabora.com>
References: <20251224144545.211533-1-frederic.danis@collabora.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5409621599703129091==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1036434

---Test result---

Test Summary:
CheckPatch                    PENDING   0.29 seconds
GitLint                       PENDING   0.44 seconds
BuildEll                      PASS      20.70 seconds
BluezMake                     PASS      661.62 seconds
MakeCheck                     PASS      22.17 seconds
MakeDistcheck                 PASS      246.01 seconds
CheckValgrind                 PASS      301.10 seconds
CheckSmatch                   PASS      354.87 seconds
bluezmakeextell               PASS      186.35 seconds
IncrementalBuild              PENDING   0.32 seconds
ScanBuild                     PASS      1077.16 seconds

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


--===============5409621599703129091==--
