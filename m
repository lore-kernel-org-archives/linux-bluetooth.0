Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2055154BE7
	for <linux-bluetooth@vger.kernel.org>; Wed, 10 Apr 2024 16:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712768049; cv=none; b=qQUb8WCDAN6wqklZljj9pCk6FSY4j3+bUYc2DTOKWvqBtD6vDqnQodTgphWI+6U8FrHsjnQJKJHDPm1KDQ4w6Sf6rnAVmECq2eE5k+5qKWOshla+o9rmdDukizT/D4Wk7Tioy03mT9OUVy7IjjkOmHO9rV+G75FhYkuUyzeX8Q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712768049; c=relaxed/simple;
	bh=R9+qpdy5X9t6f4WksUamEoxFmP12fJNO4QwHYo9ZL9U=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=TMQcn87AvL1k+ZvrrIp4tYcpQ+2dsabAlwUN8jqNGCEEaYyQ6SqMq2gq7hPt6iHOPqTbQuRip/WXMrbpYprYfbSFZhqckmdxdPirujN3sIRpW2p+Nh2duk20onxpQoJTha7XvSo24couAWoD7yT7iZBVBqaBHIDAmKKDBx/ssms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I6uQZODy; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I6uQZODy"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-78d543db3a4so289769685a.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 10 Apr 2024 09:54:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712768046; x=1713372846; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=f20g+BGQOJwH8LiDRHTsZFTMpwapGcV7S+Is0HKsHwY=;
        b=I6uQZODy4sFLa6ztHLTDr6ogn1wMPjn/BuEYP4HMTY6waJ0IhOue50LeAVaJ08r+cO
         oiJxFmE/42JiJcj0k2mv/0kY3DZDbMnaab793kVeu1r71brP7u2sOsd7BirfZPKNlV0G
         uYHtCMRPzsM/JtFV+/DsIGyk2iR8DixCEON+qPc5m5/xOKgOTY0i/1LdvERUJhx6dWD7
         hXX+CMPwn1un+ctMdTSYod0Pcc0U8Ed+AgPcKUMW3g9OBGGRucByRsY9AkHg6fauo1la
         oEvkKPVvruNJoKkoKG8r5xgIDlW/+LPNO7L1zATESnqVp/rErKkUdpOIo5/HpwiBmuDW
         Cl+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712768046; x=1713372846;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f20g+BGQOJwH8LiDRHTsZFTMpwapGcV7S+Is0HKsHwY=;
        b=iryNA0KhCtmqXUj7HGfGSt4hvF89+e7xI+Uo53WD427SGTMgXiDYAd+NYnWEJ3QwPi
         AAv1HxMfWsnPmvw/pjgRG8aDGaK2oXqvF9XccjIVHcFGvhPX+2lpPUaCvz3hQ5pQ14D+
         vqzxwBrx3ypV2oVVF37S92fMeZSbXJ4WbVEzth6VOpVBbUru+tlXsmEswy41qIAxriso
         owh/xqsE+z6JD37RjMqI7/Or3HBg8EliNWBjslhfGQRf0RheWqM/c+OaZyc1RSGeMNSc
         wdSzynld8P9xampz+EfsCq5ZfGk2+Q1ZbO5yHHlzZW7pkOeS6plcy/6q4bqmq7sEpc1h
         aiQA==
X-Gm-Message-State: AOJu0YyTyOYFqIz7Q+SnTLa6U+c8/FH3dFTPKIsWf7w+tuvlDW39FrFo
	zk0jt+xNYZTKnQtbv/0YncCJmEzgSm5qI3f6rWGKyphhXUnN+Qs1vRCDl9kj
X-Google-Smtp-Source: AGHT+IHhaCaY9UlxER29IyFPzP612NYcNczjsOV3n1Aeghn0f98DrNDfg0mF7vhf1eHb/JftsB4Rdw==
X-Received: by 2002:ac8:5a03:0:b0:434:895f:1644 with SMTP id n3-20020ac85a03000000b00434895f1644mr3508254qta.30.1712768046535;
        Wed, 10 Apr 2024 09:54:06 -0700 (PDT)
Received: from [172.17.0.2] ([20.55.214.251])
        by smtp.gmail.com with ESMTPSA id o23-20020ac872d7000000b004348d54a873sm3724286qtp.57.2024.04.10.09.54.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Apr 2024 09:54:06 -0700 (PDT)
Message-ID: <6616c42e.c80a0220.96ce6.e7da@mx.google.com>
Date: Wed, 10 Apr 2024 09:54:06 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0208305433897416709=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v3,1/4] shared/uhid: Add support for bt_uhid_replay
In-Reply-To: <20240410140205.4056047-1-luiz.dentz@gmail.com>
References: <20240410140205.4056047-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0208305433897416709==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=843276

---Test result---

Test Summary:
CheckPatch                    PASS      1.87 seconds
GitLint                       FAIL      1.47 seconds
BuildEll                      PASS      24.39 seconds
BluezMake                     PASS      1644.01 seconds
MakeCheck                     PASS      13.61 seconds
MakeDistcheck                 PASS      175.33 seconds
CheckValgrind                 PASS      244.98 seconds
CheckSmatch                   PASS      348.45 seconds
bluezmakeextell               PASS      118.19 seconds
IncrementalBuild              PASS      6108.40 seconds
ScanBuild                     PASS      976.83 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[BlueZ,v3,4/4] hog-lib: Destroy uHID device if there is traffic while disconnected

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
1: T1 Title exceeds max length (82>80): "[BlueZ,v3,4/4] hog-lib: Destroy uHID device if there is traffic while disconnected"


---
Regards,
Linux Bluetooth


--===============0208305433897416709==--
