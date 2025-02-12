Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E017B214A8F
	for <linux-bluetooth@vger.kernel.org>; Wed, 12 Feb 2025 16:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739378413; cv=none; b=rHma71a+lzPhJzmeNgB5Ry9XAPgZXiAUWKpnb/cIYkH20Nzez3+ZRaspN9amGGdjiUtP4O03x6qxwZ+vTwmRlXWcGfhbK1I+/ZHibFKzOiNXzwYDSU5cor8UhcqOsEIXR8H/6dYVftkJ7ITEmLhfKGKw2qFfEhgNv2BdJHktepg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739378413; c=relaxed/simple;
	bh=iufr1aky8HOddbrcF1IW5mj1a6dd9GYMMJTY+MhYo/E=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=osfVxGZeY1f270jaaE169cS4lkHilWNZDhjsPyUCPqlAMXe6VceJLxvHhZ1YSoqCfoI1lk4woEPFdpKe7Zx40XQ1h8tmh/3Q6oFLNJnjnY0o9t83TH2dzaE37pz/j8ZLeGPNBMZPHZv0gy5Q57uCqXlT+I+SABabwswbS4C+F8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FZ9NSpmN; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FZ9NSpmN"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-7c0771a2f3bso40966685a.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 12 Feb 2025 08:40:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739378410; x=1739983210; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=WLzf0ENNcRKABPgL5k/kzHB7/pE8HewAELCawN+lMj8=;
        b=FZ9NSpmNA0ZSQd89rbhqIosAL0ObVThCNyHTYQ0iwZQnrVo4Gc8pgpqeVxQOjXuVTb
         UOEVPR+KLKCOjr572gBDv56sff2Xlp/bnc0C0lI0+b5TZ6eEPZqRadcO3Hdbn9qt4Mg1
         kztTnTNVryxsPa2W+PWFt1wgPZVY3vZL7LXlOv+NqR7yKzJSf591vAnHL9UG1GnJEv81
         zqiejHTAuKscrKYVbDRGHzhY3ZfAiX7VHoG2QcOSsylLWukEgxydnip00S3qh+jbeoVA
         4H/u9Lw4pSbjpH2okUUUZuCYtT1X8F5SV2Baowkyu37ORqxZ10lAnYLRml5RpckJOeik
         nrGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739378410; x=1739983210;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WLzf0ENNcRKABPgL5k/kzHB7/pE8HewAELCawN+lMj8=;
        b=evcpMuaTa+4v2PBiaogzHPjt4NfYvKNJPoCoyrCeAPC8do0Ze6l37rL7f+2VgyzDiX
         wN0gvvDkH9Qtg6cgLEhx7kSYC/5k+kZwh7XDcbDk92IkUZTVTW/IsD8C1kdYrxepk1uc
         6YVTp4U8nhQGj6cspBCpuhp9ulwFhB5wScBjDo0lDfwo/smSUqJaNl6R/63cGXJSRqxs
         c1UkfGfQnyDd8w4asCfY358n1Ue9BlQ5ullGGBOU86VQFc/MQOip3N9mu7qfp+f/INfK
         cxXoPOyPK1kp8QGVB0VZ3gwm25T7yVpmqdJjnoCx8nw3J7nybeAl+MfYRvA5zv9T704O
         bKLg==
X-Gm-Message-State: AOJu0YzLwc/e/F3cfOvyC1jNyMvDJcjaraPoI7s1nRxbR4UTNLRrwiX1
	yPRa6A/VK/7EbUbb9LFVlqhKhvGn1V3nvioMTQl7L68+veQBDT9WeKG+Uw==
X-Gm-Gg: ASbGncuM4p3ZXJ/juEfeEvQzhE+SD1qNBb1vYRs5rBdljqOiCSx1cqNKrUoxnX92PgA
	4SMG4qHVv8zEDKOP1jRg9VYc7TpVTLeSLJGEjO+k2yCo0Z4Qv8ik7PlWQMq6yGYKZLDCX77q+2I
	BUHO19sMROi7gPs8vmT0+sSfTAcLRFM5ByIFeOBeHqB8zaUSGkzhxo88Y8eISEUx72Pda5G3DS4
	iF83yFdhiFbLBhWi67SPNNCgFKgTmPyzvpwkKVofTG9MDVVeHAMu6pDhz231vV6Eernw6ahivuz
	FAEHFt65hZUHU4ns1mh3
X-Google-Smtp-Source: AGHT+IEs072cIRrwU0A+RTY21udh9g4PMY8McJbP52dMfcbfIYTMzEI7PNk7WgkQzRL77UM/gkIjuQ==
X-Received: by 2002:a05:620a:839b:b0:7b6:e9db:3b19 with SMTP id af79cd13be357-7c06fce29e6mr710323785a.47.1739378410535;
        Wed, 12 Feb 2025 08:40:10 -0800 (PST)
Received: from [172.17.0.2] ([20.57.78.118])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c041dec31dsm869347585a.1.2025.02.12.08.40.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2025 08:40:10 -0800 (PST)
Message-ID: <67acceea.050a0220.3c0353.e72c@mx.google.com>
Date: Wed, 12 Feb 2025 08:40:10 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============8423174820413097132=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, quic_rbujala@quicinc.com
Subject: RE: [v1] Audio Profile version upgrade.
In-Reply-To: <20250212090553.3775-1-quic_rbujala@quicinc.com>
References: <20250212090553.3775-1-quic_rbujala@quicinc.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8423174820413097132==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=933151

---Test result---

Test Summary:
CheckPatch                    PENDING   0.27 seconds
GitLint                       PENDING   0.20 seconds
BuildEll                      PASS      21.89 seconds
BluezMake                     PASS      1821.59 seconds
MakeCheck                     PASS      13.96 seconds
MakeDistcheck                 PASS      167.55 seconds
CheckValgrind                 PASS      223.88 seconds
CheckSmatch                   PASS      295.11 seconds
bluezmakeextell               PASS      102.27 seconds
IncrementalBuild              PENDING   0.31 seconds
ScanBuild                     PASS      916.20 seconds

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


--===============8423174820413097132==--
