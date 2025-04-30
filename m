Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B2D025DD0A
	for <linux-bluetooth@vger.kernel.org>; Wed, 30 Apr 2025 14:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746025138; cv=none; b=nEO6bIVBFX1svOxgfzu78YrmuGo1y3fPOUe8j+SQkcR77FnFzp0rxtRarT2WXMpv/i9u9/xPeZcEHNCNsXc6bxYxkpbgcnT0wBF7QIHlofRe/i8F2odFg9WKAtWZ3ZjsLEPZGRV8GO06aaFDXBk6SuhpRq7XXxjkHGRQ+iCBpbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746025138; c=relaxed/simple;
	bh=DVCP8tXvcw/9WZmTI9TJZ8yd3vT+XniAWmt0SZetmXk=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=IX5EphybLpLpL7rZ8OHcV0/Au9cNh3OlEC7TEULv4xJ498dAyQjXIFQmrQKxQ3SK5cFvYNsCnx9lvxbxVHqHXazcx6EZ1YOr1pzmt4jMBfDrjfRjoa4bRifG/8Ct3lmplfZoshEd1xAMGZVV7meQhd5C+8PmnYbd6uM0atDYXjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jVUzQBb0; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jVUzQBb0"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-7c5a88b34a6so732605985a.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 30 Apr 2025 07:58:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746025136; x=1746629936; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ImIG5Vs+DQqy9JIGpPxlE78q9K7XF+bWlbW/ipQIbZQ=;
        b=jVUzQBb0dj6kgwk9VXOOJDnyeeFYm2nYFtYyXqLI2a/U4PwYvFQOPXnLsUgfixhDCN
         Aa64x4fHyszRjNj6N2dHGstP8UOGnKKqZxLMlZ1uZpudQK2ORqtqzfmyCFL0RXq+GTvU
         +Wm/rwsLFgCbvm0xEhpvY9BDt5Hm/D9A16fxEqaUT8LXHz+hrdJkHyd4ezts81dSdZSH
         UwVWWOu2tyW9ROlRiUXYaG7eEo46ZdujOb1AmMaqPeDd1yBG91nDhIC9uFOf4qHbw1o1
         mapSxOTVBcvtadK6UtAlHpwEP94xpcgSSqI0KdGoMmVlJ9g3pLPmkwF2N9hcnijwg6+X
         dtBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746025136; x=1746629936;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ImIG5Vs+DQqy9JIGpPxlE78q9K7XF+bWlbW/ipQIbZQ=;
        b=YfQ23QWnbLthem1qmnfBv2vZjLwADn9Q11B1l6pzIgG3enpqnc3EkXxxDcU9MkEPfB
         rWx2gPGZF+BN+t+4xwgo5VabCGF/cKQfckcmHK4jXNIvQFtkQvqscf4/5HGyO9oSmT5A
         Aefch666bBBUQ0Ist1FFsD6kIbXkC/lFeT5kcfpuvgQmySQxTQJK7IrjC4UpoAzXLXCC
         hCPflVDy4o0T6BJZddOyXMiITGIXiHNQcTOgjW6bXHA7IpKi4lFoya3R9Rqk0wfVRgLf
         oBVt+FyUvcE0ny+ypS7N+X81mOrvPS/7JJQF3xeihEu7qGASAqcOgXwQKQqikfQEMxAt
         uQ9A==
X-Gm-Message-State: AOJu0YxwxGunYnJ4OYE7vBzPAo7rowXYKusWv0CB0J41vLEbaFm54Vjb
	9V49rSn2MY8F9zpzbBrmSB527FqHfNzFxj4R+IDclDlc0l2hg52yN35Wog==
X-Gm-Gg: ASbGnct2l4r5nQsYBXE7hHWLxX3g3p79Tb5QAf1TqCk0rBOpjt6H49h1Y1m28TV7JmV
	3d7dND6tkVVW8s01wmZ1PL7KaqlpBpwJKaGoPvsk6j0Z+PXm/ZiMeWrNlBmFljbjuGFYmf8Y6G8
	wpaX/sdtxCCmYz622GmyL9U1WWegW7Wc3wiKhc1r+4lWQtiCOxo79KwRNhX0EmHI+mgmy+FiBUY
	VI29QmX1N1dtgY7+ideIk1/Y4iHYQhQfXXNWRtDJKCtn+wMdm7A/wEEyxi1zOfw4JRnG2Ucvp66
	G3rc6puuuSHHc6KWFKJRqFC9xncz/yvJJR69VHGifIREzPU=
X-Google-Smtp-Source: AGHT+IHhYe95CnSGqMqEsWXpiZ4ZoOQNSxCjxL0OfKKGJfzRl9RvvekdhLlRVy2elfEnalkT/cIoKQ==
X-Received: by 2002:a05:620a:4694:b0:7c5:4788:a14e with SMTP id af79cd13be357-7cac7e97b3cmr386060185a.39.1746025135816;
        Wed, 30 Apr 2025 07:58:55 -0700 (PDT)
Received: from [172.17.0.2] ([40.76.181.251])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c958cbca14sm861595685a.41.2025.04.30.07.58.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Apr 2025 07:58:55 -0700 (PDT)
Message-ID: <68123aaf.050a0220.1ccf73.b9af@mx.google.com>
Date: Wed, 30 Apr 2025 07:58:55 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4289591401854420804=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, kernel.org@pileofstuff.org
Subject: RE: obexd: unregister profiles when the user is inactive
In-Reply-To: <20250430131648.1291354-2-kernel.org@pileofstuff.org>
References: <20250430131648.1291354-2-kernel.org@pileofstuff.org>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4289591401854420804==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=958531

---Test result---

Test Summary:
CheckPatch                    PENDING   0.33 seconds
GitLint                       PENDING   0.22 seconds
BuildEll                      PASS      21.34 seconds
BluezMake                     PASS      3010.56 seconds
MakeCheck                     PASS      20.59 seconds
MakeDistcheck                 PASS      207.85 seconds
CheckValgrind                 PASS      286.19 seconds
CheckSmatch                   PASS      317.67 seconds
bluezmakeextell               PASS      136.41 seconds
IncrementalBuild              PENDING   0.25 seconds
ScanBuild                     PASS      968.58 seconds

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


--===============4289591401854420804==--
