Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A87FF101DE
	for <linux-bluetooth@vger.kernel.org>; Fri, 23 May 2025 15:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748015621; cv=none; b=jLpTG/a/wyE+SG+TRT+Qi2IhKGRUPktaL9ZSgBGdGeuNo8J/rAejCnLJQatj1pMCZC5Rs7wO8/Z490YnI2RTredJLgcDOgH6/Y3xZt6DBhRkstSvM5P3mbkClpO1wBIS5VSvm9uFhuj7jYYxdsvVvPFOoZwg833RtlDOyH7iq8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748015621; c=relaxed/simple;
	bh=h2DCBtMwdjWR21+X2WICoJHc4h6t2Zdn6PW5k1Vr1XE=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=smxHXKJs2l19ZB+dC4KmzZHKbh9eScl8rpJKJ31K95P+x0AOO8cjA879K1X8gykwzlLrpX8T9W70fGO2vgyYgRPpL7XKfbH9+0e3709ibN1e9RLE/yYlzACXUS+8ajYJAjecqenRdlKgTPtq4Ph3lu9XoZMuOb4XAOfz0SaX/NM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YiN0fBhV; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YiN0fBhV"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7caeeef95d4so957381585a.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 23 May 2025 08:53:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748015618; x=1748620418; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=iDRnmOS7YaT5uPbwId+IAm48j4hcxkG16EaLsYRSCjA=;
        b=YiN0fBhV7GenyOPcm+2dXmg3z2wSq2b2k2cp0GuVCzA8xIfHc2X1UemmWqLaCAAI3q
         Ebu6na2FXfwHnUDb5T14nC6lSeSy4ddlol0oeUdxzNQU2KVpNbConcAT2sA8Qu/mYfbu
         tH+wRCHt8mhDNy9DyYsPInPMEXvbBEGMq2gGFx+LlLthYUckzXlqYr/9XWP2U5Lt/9fP
         zMFdnu+Letc6i7dLP9BoEpIkY6HGBcMcV/WyyKzTPaAxf2fTfNow0mmmHfhS46Vi6S4k
         sHBBbhgCXx4EtppjY6r2huv2yx59IF6uhN05uRVEVS/olMyn2MMCMafBJ05cRrAFtcse
         cZeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748015618; x=1748620418;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iDRnmOS7YaT5uPbwId+IAm48j4hcxkG16EaLsYRSCjA=;
        b=pW3hDPfk6XIt3Q7Y/Jb69l6R94zNpwWHPSZrygAUEfKItnXw8Fxvd0ZE7anNU/MBdR
         IkAnhwW0qLAlx4nmh3DdeZZtCw84l7a7fTyswi+E+uQfgFG9B47ww56XISZCPT2O++lA
         wZN7XrtqAsPviBPfo1/U6i6UXVH6rdQ51Tk5naRLuh4a296o2b0eCNYbs6Z6CAzuYaRG
         DuBGRwx2gjF+H1qrxXIU4ESMCdJzP91ArvXE9ITTTno7OZPZ4Q+UXSWqhtVK4qZ4Kdsq
         bSUbWWDd/OoWiDO3PyEKkcqKgTjvpnuJdPrEXMwwAI1cfe/NDM0/AtblX/C6hlK6cksX
         MapQ==
X-Gm-Message-State: AOJu0YyltveooMAc44ca2OVu++iNGgXp/rwF4tJLAvatpXnYyBmJVsbH
	hOlGVtM6ak1Y3Z2JYdCA8h0ReMd5oAsY5FY7OTaFPdINQxViIQtxrLG7KdOK7w==
X-Gm-Gg: ASbGnctSra7gHfVUPkTFN605mg9bj0vmoR/mZcNl0N8Bhs5tyLu6NOV0naDXpI3YYyz
	+tZ6mNGW3+yDqLIFFUEs6gdqvSgAe6mZdQUcRxEq+nVK0A7SKHOgSjWkQUjsrX8ZltAVsdJVtio
	cxrKCTpr1H8zyntIfq/c5H9+zmMPVHooe5q2s2X+bhZdss6t7mlLI2AcWKgb7EssE9P9XiN8rIw
	w1P3iWamhFOJxehdP4dTXwYfpoHnqf/ej/HNbIYpjIoqWpMxWD0z6KM3B7Ah+Sm1wetwhZHjY1l
	nqn/KB63v/9EjUTHiS/vByjvOwL2stXMOeoABFAtcaBf6DFeB9E4Yh9Hpw==
X-Google-Smtp-Source: AGHT+IF7COISzEaEztCpCBAocBNmHr5Px+FC/DAeUmUKthmHTqYu2droe68NDYlp3VwUP3yDxb2JdQ==
X-Received: by 2002:a05:620a:2586:b0:7c5:5692:ee95 with SMTP id af79cd13be357-7cd467b01eemr4437486985a.51.1748015617942;
        Fri, 23 May 2025 08:53:37 -0700 (PDT)
Received: from [172.17.0.2] ([40.75.115.155])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7cd466fc2afsm1202489185a.0.2025.05.23.08.53.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 May 2025 08:53:37 -0700 (PDT)
Message-ID: <68309a01.050a0220.5bebe.d965@mx.google.com>
Date: Fri, 23 May 2025 08:53:37 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5541795338965768149=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v2,1/4] org.bluez.Adapter: Add AutoConnect to SetDiscoveryFilter
In-Reply-To: <20250523142505.3476436-1-luiz.dentz@gmail.com>
References: <20250523142505.3476436-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5541795338965768149==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=965873

---Test result---

Test Summary:
CheckPatch                    PENDING   0.31 seconds
GitLint                       PENDING   0.23 seconds
BuildEll                      PASS      20.13 seconds
BluezMake                     PASS      2841.09 seconds
MakeCheck                     PASS      20.62 seconds
MakeDistcheck                 PASS      198.80 seconds
CheckValgrind                 PASS      278.24 seconds
CheckSmatch                   PASS      301.87 seconds
bluezmakeextell               PASS      127.98 seconds
IncrementalBuild              PENDING   0.29 seconds
ScanBuild                     PASS      912.05 seconds

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


--===============5541795338965768149==--
