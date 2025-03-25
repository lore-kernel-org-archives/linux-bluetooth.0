Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E482B1E7C2D
	for <linux-bluetooth@vger.kernel.org>; Tue, 25 Mar 2025 23:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742944296; cv=none; b=tU145WAjS2Y0utT5yFtjCZz/XAllMJDSZ+G4xsE6HvQk/BfM1LLyklrOzD+eaI/oTJ6CA+Iwi0cEqNIQPNu6gkT6jTdN69PTaIMdzU4iED6yEd1enZV8yWY9lxVelQTAXet11AexZ2vnHJUs/7zpQe2DVxwhrJN8OSWnqH+6Vk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742944296; c=relaxed/simple;
	bh=NWJUgrq+guf5Kpd49Ayp3iCgC1UVwEG/+h7MhBen6Gk=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=F6wUFynUFTMZzTbOZsk1SscFdlVixZv4XiMuH3fvazMzbRjcfOtHNS+lpAvw9ccuZF0fI6WtVFntzTN4vkdl9kYv5LDf2tU710lPSQDgRqk8UTUHHJzwVM6MAUihNtqfqMwU22rOB2GV1IQ7L+vSRsADKw6nSaI5gjTG9+7N0P4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aCkPktIf; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aCkPktIf"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-47690a4ec97so63527371cf.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 25 Mar 2025 16:11:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742944294; x=1743549094; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=5LdNG+w0LzD0zFWv5OizuJ/MDNn5trrBQJta2Hp3bK8=;
        b=aCkPktIfCcAN6LIv7hnixD5lr6eW0HSJEvZ0Xaj/3vzdzOrCP7g6IiKsUs5nR5HlVw
         crKSBysPthS6D5VsxbHi4JWEVGd6zTNk4mwBgtNlkU3kNNAjpr5Lhxiqvrg51cwPL/gD
         fwIYSOALksQHTJniqHiCIhfep5Al4LbtU2Sl7+OtmY7uokDUfGyCQv35/uFu9ST8Rfsl
         BbBRQ5UM0m9sg/H5hFV9WZM/H5mYh0gr70p1FHRI3jNBwvilD5kLEFjVOwxDCdlwNncq
         ygl6xZiT19g0+b+9hx085VJjMwvi/c6/6h7IoIqx7iS2ULQiWpn5dgdUtUnc664LitN0
         /Ojw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742944294; x=1743549094;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5LdNG+w0LzD0zFWv5OizuJ/MDNn5trrBQJta2Hp3bK8=;
        b=i3pkPZfMdS3SPzqY1Q1NvzWrhvTvHHfEa8zLdAw4qGFhDTDpnwF3I1xfjy9/atoRA0
         P240cp0DM0ywisDO45HCaDhcf/x/7LiV+Gj7GZlSDvy8Zk7CYoY22UXgbnfqF+2REwEj
         MQPt/YIO2g2OOSliq0rkr1LswVk+r5fXKaSiHQQepvxcdhWOqmQLomWELE49QTllfhBB
         MuHnZYNakontf0tuveXYkFC+CsFFSn9+rynNGiCOOlhBaUcgD8XGS2ViYFwll8VYI52Q
         gyprIWE5qoM0f/ZBblYmbRyIQcPuBAvGbtJcy2BatBLIYXijGBhG4Nd0YUm0Y0mFRQ6c
         6kbg==
X-Gm-Message-State: AOJu0Yxe4BuKt5aH18eGSu8sf7uoruJh46mic6lnlwBppsugo/DuXMdh
	vjXnt7TL4xH/ZRiP9T/cZHx8AprpyDlvyfQylp4IdUQS1YdWdXmZHGNz8A==
X-Gm-Gg: ASbGncvfhUyKkEfIuxdRXGmmyhp+VkAdAA1a+j+FldDp+7ua17QlPBmOrSo3pf8/P+i
	rn8yddwashnU4rrz8UZGpPJkD1Kith6NEXqswnJC5S4QTjmLbxaG+wKX85V6jgnCSK/I+jIuJ6B
	VcsYZMWwU9ajA0DevuQzm0pTx1I6nEWwpxhnmIQsXkKPKZXyhoOonavx8BTZC0Np8DAh6yhGzIO
	Y5g3eDTbQCSHH7ZOX8VkQddwIDGCzN554mmouJUa6fKmBYA8rjZixjJXJsccezc5Qocc56mxCs5
	Aziil/6ykjBe+WvGuB51rQR2IJUj86ZRG9FVFMiLRX/h1sR7
X-Google-Smtp-Source: AGHT+IEbCJ52W3ClEOd5MqMq5DZXSVZIXmmHSbmkCAMB05/bWK3xmiMKF8qXc2Xt7V9b6EFe2rvL+Q==
X-Received: by 2002:a05:622a:258f:b0:472:133f:93ae with SMTP id d75a77b69052e-4771de7e5e5mr332189011cf.48.1742944293523;
        Tue, 25 Mar 2025 16:11:33 -0700 (PDT)
Received: from [172.17.0.2] ([20.42.43.81])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4771d159a35sm63982931cf.15.2025.03.25.16.11.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Mar 2025 16:11:33 -0700 (PDT)
Message-ID: <67e33825.050a0220.1e278d.bf31@mx.google.com>
Date: Tue, 25 Mar 2025 16:11:33 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4011747037618667426=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v1] main: Fix handling of legacy experimental LL Privacy
In-Reply-To: <20250325213230.2513331-1-luiz.dentz@gmail.com>
References: <20250325213230.2513331-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4011747037618667426==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=947309

---Test result---

Test Summary:
CheckPatch                    PENDING   0.19 seconds
GitLint                       PENDING   0.17 seconds
BuildEll                      PASS      20.69 seconds
BluezMake                     PASS      1528.37 seconds
MakeCheck                     PASS      12.84 seconds
MakeDistcheck                 PASS      161.08 seconds
CheckValgrind                 PASS      216.07 seconds
CheckSmatch                   PASS      286.94 seconds
bluezmakeextell               PASS      98.93 seconds
IncrementalBuild              PENDING   0.25 seconds
ScanBuild                     PASS      878.71 seconds

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


--===============4011747037618667426==--
