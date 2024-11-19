Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE32814A615
	for <linux-bluetooth@vger.kernel.org>; Tue, 19 Nov 2024 17:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732038213; cv=none; b=iZiKZoh+53+tskXSyxKLjcGo+DrugvXvXMEplTt3kz3Lnr1xdxD/IN9yUvbZQx4Fv+l7rgnIVmZBEz/6lEH99M/04vp9vwDV9E8Ad6sT1a0/behExlHByjpa0OYCJTbkcNYSo41NMH9N0Crg316rbceQTO9VjzcTEscOaE3e68g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732038213; c=relaxed/simple;
	bh=kj/ypkJIc8kM9jX3fCZLPA1/ieiaEWptpSlynF5SdgY=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=kwITXfcz/y9ZGJCXEryyn1z5XJsOf3KTs9YapAgTglMaQEATt84lR3UVKno8FmUd7jecYgcHmPKmxfrTzG/6vrkMi24Gwqc+5prqNezm576++qDfBhectW3XXny1MarEFybIiCAlhfTCzNFcLfXcJi5spCLTdChl3JgEFGH7UL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LD210i7a; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LD210i7a"
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-71815313303so723900a34.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 19 Nov 2024 09:43:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732038211; x=1732643011; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=SOAZu8ehC88eXogTziWWCMmoJ4S235RNDet9BIilwXQ=;
        b=LD210i7ah+Ut6bciF3vVDfD5O0qgRnaath0RoL+OUEEsWq8WKuBweukS+HvOKHeiz8
         ZiFwNxAhqBg0S+E8NARLeAmS6axKVrbSctHrJKwRkQNBbYvOO5k+5JJIERjmrV2M6sdW
         8wfSbbbjeUo5ri3vtWXnTEl67dZuSV3A1/gaT27krUJg76RL1VuXCj1LIt0qqdRBWx+S
         uASg3JiSLLjmTEyPphabJtdiFVruLWP5awNWFkaYQhN+AfuD6T2FQ2p0JbqRDc2b5cK8
         CgXyujCu7lP+Tpnh4j4YeFts1f9ZK6ZcqaBAH6EuvTPgYjYiZi5yhFCEO3Q1f4x0L5DL
         RTWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732038211; x=1732643011;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SOAZu8ehC88eXogTziWWCMmoJ4S235RNDet9BIilwXQ=;
        b=tQ5IoY+LFIzORCiKK2PKGn1z2xPb3Fmdv26lRolivTGwbKPuRZ7IzRPnRla+sFKhNx
         qVBUi4HY3SVPIRwyJ7cnJzZKtMInvKO1LAPvNSgdtMhOFBKdtGlSNkOh3Hc6UYBkyZuk
         PN4U5iUg5YEIgAHU5KAB7yxhafm1bj4t9TwmUx+U7zsBGfyNZGxHzseDSTTWzHxWpo+p
         PKn6j7vP6q3S+XhVGzyK7yTrEX2/sytpLomxjfOvmwylvvgCb9KeXQPjzMQ7tV6pHpxN
         2DoIgLQMCSFeesbZNJFlmug8uvLdpdbzFXA+d42VhUeiiJHmjH8U4+6TRHf1sGm5/2Y+
         H7ow==
X-Gm-Message-State: AOJu0YxScZEzWPYGZO/rmSXuCgPisj7Kl9ZIBbYzry2LFsd0HRcQGbxG
	hLprlV2G6leZLqVWcrm5jVBKoyz94KmV82qiunYjaWNidHbQyfEzB4v8iA==
X-Google-Smtp-Source: AGHT+IEhj1YXFy76Ib2TGGaw4gHZvXDg8tJdtmitkZlhdwOauW3XxhAJ/srnf7WO9e+hsHCO5WDn8A==
X-Received: by 2002:a05:6358:ed1b:b0:1c5:e2f3:b9f8 with SMTP id e5c5f4694b2df-1c6cd205726mr795499955d.4.1732038210750;
        Tue, 19 Nov 2024 09:43:30 -0800 (PST)
Received: from [172.17.0.2] ([20.49.54.18])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-46392baa970sm13505671cf.20.2024.11.19.09.43.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Nov 2024 09:43:29 -0800 (PST)
Message-ID: <673cce41.c80a0220.324ef4.527a@mx.google.com>
Date: Tue, 19 Nov 2024 09:43:29 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============0646971901397682471=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v1] shared/att: Fix failing to set security level
In-Reply-To: <20241119163731.2767660-1-luiz.dentz@gmail.com>
References: <20241119163731.2767660-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0646971901397682471==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=911015

---Test result---

Test Summary:
CheckPatch                    PENDING   0.25 seconds
GitLint                       PENDING   0.23 seconds
BuildEll                      PASS      21.09 seconds
BluezMake                     PASS      1713.45 seconds
MakeCheck                     PASS      13.66 seconds
MakeDistcheck                 PASS      164.68 seconds
CheckValgrind                 PASS      219.81 seconds
CheckSmatch                   PASS      279.14 seconds
bluezmakeextell               PASS      101.44 seconds
IncrementalBuild              PENDING   0.26 seconds
ScanBuild                     PASS      878.10 seconds

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


--===============0646971901397682471==--
