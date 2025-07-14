Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD818254845
	for <linux-bluetooth@vger.kernel.org>; Mon, 14 Jul 2025 14:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752503831; cv=none; b=c/EnOnb0wrT0wPp0RFqq8vJCHF/Z85G7JFI4F1k+4M+ke2HT4yr9QQSxYoLiCP/9d+u5xIEkpiTuUj7xO1zbM7HdVH1be5Ht4erO2XEyxjk4mPlP0wbE3B0EY6F+K8ouUw/RNB5ohc/U7YTUEj/6sI0eZ2TGs8sfMtIAK0SEv0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752503831; c=relaxed/simple;
	bh=Hltk0ea9Qs6wJipoBQXPpUZVi4ijOkmpib1QSCtBAS0=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=cVdRNf8RLZ+F2H1PoEqVpgZGB0kyVNNx2YoP4yZ3EOkgIALxzynRgkxtEQB7349l2YEzq6/eGUSaa/oJoUtQsk2hoSgZVN3+3fYjbuffpkyTEs8WRAW0Zb2iKLnkR23nY4POTt6ivZ+ft+6iyukXI+GXkGvEmsr1hAUzXWu5DKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jHOoJuCZ; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jHOoJuCZ"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-23aeac7d77aso34643175ad.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 14 Jul 2025 07:37:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752503828; x=1753108628; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=XgRD/vXwzDM57KkDZPxbQ8NTuOaAvqMjGA/fMboGDkM=;
        b=jHOoJuCZnRQh2sTbfzvZktxkcbswBxsjPR2lKOHTXepbiFGOaEsMH6Z4pGJ8wCFdqE
         tvIlAV6UljAIDd2Rrjd2fleBzKGVw8ccHiHp0e46VqIwWaC++nNTlVlcCySFkfD6r0KJ
         5G9C7G+X4IJaSrMzlUZG7l2t+SrPvR0Mew/+GGiIiy0BHTrcCTzsLleFSJXFaXZQplaW
         K4DlGvUIyNmdkEGDbIXM6BvHv6C/ZJwIE+CFdVSThrQJ4jfteY1Xs2Y3ztSJ1WC6HJRd
         iAqLcQduI03sYEssgCzhIQ6F2Wzc/avII3NidfKOFeRjS6C6N0JaGtdiPHu1i/GBuIjK
         JJRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752503828; x=1753108628;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XgRD/vXwzDM57KkDZPxbQ8NTuOaAvqMjGA/fMboGDkM=;
        b=O4yKr+Rw1JYz5wpOI92E4hvwKex+Qltxbg8eglra7Dkbv0EzTrfUt7GAlTASHyDJW4
         djVwHY2tAjglY9ARJbXURHaw/Pl4+A5cENhYyjQKybK+hx+8J2v96GdCJuknt2cK5DNt
         1Ob5CfKZGMRZXqdlsS0C7X9nZ5iAxsUgAmjlDVvfGJUGhkVUE6U/f3LYVy4HNz3m/LOe
         ylra8JlpEGCdApiDWBjsbYa0u5zjScn2hxYFVCmUA0/sgco6cwTGhflCd0z9o6PDGaEF
         EgTPTHheCUvXY7M/Vxpyj7qr4mG5GaAqMhpeOvFDsjTZRtrC1F2rNhsMAxD4dYOEkQAK
         ZzCA==
X-Gm-Message-State: AOJu0YzSfYPH9hLy8ZzoZcVmLJfBhVlwPFHTRCRZbksOCndGl9/GfgiL
	jykn+iCYKGawEnw3Ae0mx6qCurCtBYG3EIRRI2WiI7SQ8lWnpwmblqhuqcJ2gg==
X-Gm-Gg: ASbGnctWEylHsKLnDQOkisJWYJzeJHbh8DxvcC/D64wSzOGMN+vD0p7b0XzRy522+tw
	A+36Tj0FE4gTRfu2CV8zd2AX+bZq6zahmt4xl8QahXMY+GOuJ0lIejNpAwtEe7RTIK9oaMpv3jx
	4cRlcbBASv8zf2PbvnfxBHnsZsspqKC0Y9V1fsHjd6HvdaiY663n4mxOcA+10h/AbuAO03xs6gs
	g9VGGWA5lTOuAJhalVD22ILOt1+YVS2/XrzzLlUd7b2HZqyCNNiIG0pSdNzfnQjxJI6blCtaVZJ
	pQBMhhZcyVDFXdZEh1JkhUkP+N01U9E4QWdqkuaezA6QYGbOsCCdc+aNhkXzPbUtzSyO88L+K0r
	/SzLizWwufuhmzNSbgbh5FpYzILc=
X-Google-Smtp-Source: AGHT+IFAWrsdJSf9P8MWg37YaVsT6gtt9MmjfZ9VBU6WpChOG9VfVUuKGFORA513hhHjMHnoWWqDbw==
X-Received: by 2002:a17:902:f70d:b0:234:a139:1206 with SMTP id d9443c01a7336-23df093ca68mr175329615ad.40.1752503828315;
        Mon, 14 Jul 2025 07:37:08 -0700 (PDT)
Received: from [172.17.0.2] ([40.78.91.184])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23de42b01dbsm95249405ad.85.2025.07.14.07.37.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jul 2025 07:37:07 -0700 (PDT)
Message-ID: <68751613.170a0220.216844.5d68@mx.google.com>
Date: Mon, 14 Jul 2025 07:37:07 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1113269001394424523=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, pav@iki.fi
Subject: RE: Bluetooth: ISO: add socket option to report packet seqnum via CMSG
In-Reply-To: <474a5321753aba17ec2819ba59adfd157ecfb343.1752501596.git.pav@iki.fi>
References: <474a5321753aba17ec2819ba59adfd157ecfb343.1752501596.git.pav@iki.fi>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1113269001394424523==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=982088

---Test result---

Test Summary:
CheckPatch                    PENDING   0.44 seconds
GitLint                       PENDING   0.34 seconds
SubjectPrefix                 PASS      0.07 seconds
BuildKernel                   PASS      24.06 seconds
CheckAllWarning               PASS      26.92 seconds
CheckSparse                   WARNING   29.90 seconds
BuildKernel32                 PASS      24.59 seconds
TestRunnerSetup               PASS      482.03 seconds
TestRunner_l2cap-tester       PASS      28.08 seconds
TestRunner_iso-tester         FAIL      41.16 seconds
TestRunner_bnep-tester        PASS      5.95 seconds
TestRunner_mgmt-tester        FAIL      134.62 seconds
TestRunner_rfcomm-tester      PASS      9.35 seconds
TestRunner_sco-tester         PASS      14.66 seconds
TestRunner_ioctl-tester       PASS      9.96 seconds
TestRunner_mesh-tester        FAIL      11.50 seconds
TestRunner_smp-tester         PASS      9.74 seconds
TestRunner_userchan-tester    PASS      6.10 seconds
IncrementalBuild              PENDING   0.59 seconds

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
Test: CheckSparse - WARNING
Desc: Run sparse tool with linux kernel
Output:
net/bluetooth/af_bluetooth.c:248:25: warning: context imbalance in 'bt_accept_enqueue' - different lock contexts for basic blocknet/bluetooth/iso.c:2322:28: warning: incorrect type in assignment (different base types)net/bluetooth/iso.c:2322:28:    expected unsigned short [usertype] snnet/bluetooth/iso.c:2322:28:    got restricted __le16 [usertype] snnet/bluetooth/iso.c:2333:28: warning: incorrect type in assignment (different base types)net/bluetooth/iso.c:2333:28:    expected unsigned short [usertype] snnet/bluetooth/iso.c:2333:28:    got restricted __le16 [usertype] sn
##############################
Test: TestRunner_iso-tester - FAIL
Desc: Run iso-tester with test-runner
Output:
Total: 130, Passed: 127 (97.7%), Failed: 2, Not Run: 1

Failed Test Cases
ISO Send - TX Timestamping                           Failed       0.233 seconds
ISO Send - TX CMSG Timestamping                      Failed       0.236 seconds
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 490, Passed: 485 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
LL Privacy - Add Device 3 (AL is full)               Failed       0.228 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.061 seconds
Mesh - Send cancel - 2                               Timed out    1.997 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============1113269001394424523==--
