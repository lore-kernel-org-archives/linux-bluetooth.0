Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0F328C07
	for <linux-bluetooth@vger.kernel.org>; Thu, 31 Oct 2024 05:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730353752; cv=none; b=t/jdEKMQGfk981IYBLfwy+jvXG7594OF1IIgEnPzHP4zOwXeopUtcKQOWlBcnfkEk8NStpFKw+TssDBhLz/+Y43OHpM23SM70sI6A90rjPoMLWE/uCWG0PBqkzBKVVDgNoLa5Fy/HJWsRSoCCB7mAQxJWZkfpQOMiDDYx1qZZao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730353752; c=relaxed/simple;
	bh=r8Lx2USjf3F+XJWl05ismdlMjmPLXSZ0bQx0uhHBxf0=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=Q2votAK+lrtJZs9cKqMgYk/A0YqZQG1c5c2Z4qWAAB99dktIXk34pyvXXB4VusbGSpwaBZnv7W1doNS8cmOfs7k/xUqKBK+oLYU90MUT64TqUD60elHVKRkgsFmXFCfvKI+YVvco34MqmTcLlfsdviKCAcbWoV8um8q4Kii35v8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WT1hBoxa; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WT1hBoxa"
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6cc1b20ce54so4520506d6.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 30 Oct 2024 22:49:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730353749; x=1730958549; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Cz2nHTuuBh3eSwkJyJFHflTPFg/AMBE7hs/5pwfiNc8=;
        b=WT1hBoxaWkH7XuDit++I5FHhvpCKnebfeVlfkbhcMbYy1hTd1AnfPWQHyneXVkR8KN
         3pS/pP/OA3kWFpejVCkHnQ3HA3umBREUgDGujmLm+/522Kd0SrwuGC4K5zakK1iSYPNu
         30FulCLkNgSMFJPI3STEu/2ah6IRSsFYjC9PJY6sUKBs3Fre8/Iis95fumsh9mxe6B9b
         lvnYYllSMtJeWn+4LfO5NIQBOL/+Xal1hlBrvjrkuPHW2cLSMgO2Pkieqy+t6aO+HjJp
         XwMefvHMJF3F3QZE9mzpuHb0RRmg6jIPG9LAeUel9a6rQU7ybwM8lHOv0Nae13rcCCIy
         3LWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730353749; x=1730958549;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Cz2nHTuuBh3eSwkJyJFHflTPFg/AMBE7hs/5pwfiNc8=;
        b=mElEG30UjtN1nlm5cZ78wktiD008cJENOrhrFv2mGSeNrcT2A0CcZjg2T4R9aJ6TeF
         LNHOJURx6WxP3PI/g+cBkBLg5c3Tsld/Nqa4UnSXjrjduSXmoNSsHQRhIBNiDCZHgwPl
         uEWIkU/0k/yeOHRXxxbkaBJyZn1p3xMKxD+oq6+bh1hfx6SRoueQN2KmQ/H/QM7+KtqP
         tZUrHxcCat8W27D9UEn6NVmXZrTgkn7wa5wcjnZ7ht33YdOGkvYkZ07gqPpkUgdwfF4u
         wMaquw4QJNnxgSqniMkP9TKICLddhoAiJYlWV7mesj4dkQUDOKHgw3xlQvuFha+iAC8z
         ib6Q==
X-Gm-Message-State: AOJu0YyH3b6ceKKx7XzBRLppFbWnrM7s8WW4Ui62fk2+b3aiLy1KlsT9
	IypG3qgQfsmupmyfDmDLrNpYMug51GdEHREpr3GRIUStGATym8eqdMM8Zw==
X-Google-Smtp-Source: AGHT+IFGiZth2BS//yuDXyEJoTbongAGwUvs9CFeK6ACfJ/lg0fwzt7Bh8cP0bftf0AORgY7mLK5qA==
X-Received: by 2002:a05:6214:5984:b0:6d1:7aa3:afc with SMTP id 6a1803df08f44-6d18587f917mr273721996d6.52.1730353749583;
        Wed, 30 Oct 2024 22:49:09 -0700 (PDT)
Received: from [172.17.0.2] ([172.183.112.119])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d353fd8308sm4226166d6.57.2024.10.30.22.49.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2024 22:49:09 -0700 (PDT)
Message-ID: <67231a55.d40a0220.ca2e1.0fd4@mx.google.com>
Date: Wed, 30 Oct 2024 22:49:09 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5643469424730392580=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, howardchung@google.com
Subject: RE: [Bluez,v1] textfile: Fix possible bad memory access in find_key
In-Reply-To: <20241031120259.Bluez.v1.1.Ia122d85386d6c2fc69f5b3d7ea7a7169f73756e4@changeid>
References: <20241031120259.Bluez.v1.1.Ia122d85386d6c2fc69f5b3d7ea7a7169f73756e4@changeid>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5643469424730392580==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=904898

---Test result---

Test Summary:
CheckPatch                    PASS      0.37 seconds
GitLint                       PASS      0.26 seconds
BuildEll                      PASS      24.71 seconds
BluezMake                     PASS      1781.02 seconds
MakeCheck                     PASS      13.09 seconds
MakeDistcheck                 PASS      185.64 seconds
CheckValgrind                 PASS      256.05 seconds
CheckSmatch                   PASS      361.03 seconds
bluezmakeextell               PASS      122.27 seconds
IncrementalBuild              PASS      1493.16 seconds
ScanBuild                     PASS      1038.19 seconds



---
Regards,
Linux Bluetooth


--===============5643469424730392580==--
