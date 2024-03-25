Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7E4C5490B
	for <linux-bluetooth@vger.kernel.org>; Mon, 25 Mar 2024 16:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711384875; cv=none; b=jJWyrW9EFY33Pq8ytV4ciOvcgCFgRyXe+KltjmjOdo805nLi04+vAjy1XJ3T0spTztxZBLoruCSZu6AAXoqq/Adf3dgMbnLQgnOT1PtLQEwrdGvwDDHtnSUJKlG2IxI2AwmY13g1QI/fGZGJgUiMHF42bXmPZ0+3xfLSdzBGWh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711384875; c=relaxed/simple;
	bh=/PXEvJV6YFN4IC/JKYOBkDmTXiE8hGHQdrLFKiAUUW0=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=Cj/1cVWJIYo4o7mARBwId2TRzUCNUhwfGiXDVg76lSeWKA8/07ndQa8uSRIBIKyHbfshVEARMLzsJoWpe7UuopZGrBNc1jxIpNLjSxYBwo/Vtu1rtD5fijmCzsc6roXqueIHuwhM3X01hdMSVhjI1T1DYhy1EBVMZTzknI0la5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m1dCUZMP; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m1dCUZMP"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-5e42b4bbfa4so2579474a12.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 25 Mar 2024 09:41:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711384873; x=1711989673; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=brjNZcvhWhUHVrjm86azbAqVHUuukvUz3igtHlzghzY=;
        b=m1dCUZMPbXfqL2AYfHvULjUvfF7f15fnjv2Hi5MgnmEodr+0ug+o8izdL1QhUH7f+C
         rbcn3vv/OrUOKdzvPEueexA+h1ZAMQpTO3+jbOlu6nTUIv/y8Vllvr1fkP9yoZR7qdBR
         C85NeDFqUEqPglAi7DAtvyiQ9TY1YHnG+4mZfFbUCMRulUo4Sg/4WCKoCqxueCz6bxLc
         QFWEq+thORzC3POEvtwyqTWpM7i80QugHPql6d/EbZwhqe+SalZnCQ3PbM9s6/3T+ZkR
         B8iNXznB6hQZy43rpJVvbCleMajqXsDu3QqBnrE6U4NB9pEXejpMshmf9LygR38ttyEE
         GT5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711384873; x=1711989673;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=brjNZcvhWhUHVrjm86azbAqVHUuukvUz3igtHlzghzY=;
        b=F+zO7sPnFxXGUP07SVWoBMa9JQSo5EE+k5gr2Nw73kGhCM5WyOFlfLp0A7CAd4UE7j
         L/lxIo7FTKlcm1E8KIo1UcSA2Ihmn3K3EQln9vV2B2csWoLapPjFW6kXU6KNTn3aBybg
         jvMQuPSbdLWAfw7qlaUws8tTcn9+YOwde4u3fJulEbTH1khWVmhtM9EQhcfnFtnm3wd8
         bXtXL1NiSfdlATW3sf7v78IUSsdmw6Q2jWAVreV03CWfc9zaczFKBNmo7d0t6tv+9oCz
         KPgsX7OZL8oPdVKSAd3L0WWv+LyEtjk0YMzQqHFq/JOPcFL/50DVIU/8hAwpssTwx5UX
         HPUg==
X-Gm-Message-State: AOJu0Yx2zg3g/XV2i7gMRjw8/caHip1zMmISg8weF3yLc/68UPvdoYQN
	lqwnA3ToGeLMQ5wneuGWthFSk7DTj5yr28qJJL2v6pSxB/uGoW/bnTB3swI5
X-Google-Smtp-Source: AGHT+IEBGkO+a72yCVktmaR3sfsmqRVITId8SE2tf0X9pPJjcbfEvuSE0Eb8IArYdILrmaOvCrZOyA==
X-Received: by 2002:a05:6a21:998f:b0:1a3:466d:d33 with SMTP id ve15-20020a056a21998f00b001a3466d0d33mr10477775pzb.9.1711384872755;
        Mon, 25 Mar 2024 09:41:12 -0700 (PDT)
Received: from [172.17.0.2] ([20.172.2.101])
        by smtp.gmail.com with ESMTPSA id du12-20020a056a002b4c00b006e6813f2301sm4326611pfb.56.2024.03.25.09.41.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Mar 2024 09:41:12 -0700 (PDT)
Message-ID: <6601a928.050a0220.d70fa.ab86@mx.google.com>
Date: Mon, 25 Mar 2024 09:41:12 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5278147457006865656=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, vlad.pruteanu@nxp.com
Subject: RE: client/player: Fix transport.send command's transfer of packets
In-Reply-To: <20240325144031.335354-2-vlad.pruteanu@nxp.com>
References: <20240325144031.335354-2-vlad.pruteanu@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5278147457006865656==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=837924

---Test result---

Test Summary:
CheckPatch                    PASS      0.34 seconds
GitLint                       PASS      0.23 seconds
BuildEll                      PASS      24.69 seconds
BluezMake                     PASS      1710.49 seconds
MakeCheck                     PASS      13.72 seconds
MakeDistcheck                 PASS      173.11 seconds
CheckValgrind                 PASS      247.65 seconds
CheckSmatch                   PASS      344.68 seconds
bluezmakeextell               PASS      116.81 seconds
IncrementalBuild              PASS      1507.39 seconds
ScanBuild                     PASS      988.72 seconds



---
Regards,
Linux Bluetooth


--===============5278147457006865656==--
