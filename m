Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 818808479
	for <linux-bluetooth@vger.kernel.org>; Sun, 12 Oct 2025 00:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760230094; cv=none; b=Wf6Lu47ynq2pTP4iPmPKz+ZD3G61aP810+74tV8YjnT866QOaYFeXOf1KxBWhYgymFET7CA+X9jnPhcxWGCdWYsUR6pKbPMSz347flqGiPCJZWeNYuHAgw8pbzprswpAVtQEUJGhqpQBAj0xhTbaqSdpYG55W3yM6ddIcjtg9To=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760230094; c=relaxed/simple;
	bh=pVl8O5ptrj4mHBbMr7nw0FzikuywUNtLXuKdK260jXE=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=H2/ECngqa2R4ovYwFT1G9xe338tyfLn3Qq7N5siGKTgVVH/cxLuN81o8KdAlMWYKIWaps+49Zd0k5yhWwuG+Fj6BRAJsHoGuu32ZnMTVTrH//qOjxpPg1QdmZpdF+3VA7kjtQ7XyNOqrxIcbJZmPPPm197h2CMONU3WSmFgYrEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=idy+S37f; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="idy+S37f"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-8572d7b2457so448744285a.1
        for <linux-bluetooth@vger.kernel.org>; Sat, 11 Oct 2025 17:48:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760230089; x=1760834889; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=aMzh9pKpyzAI9fgkXE0PDoQvhdSlvccuIuAISiET8MQ=;
        b=idy+S37f2ekNqE7LuZuyPS63XbWLgA8sQCNFtkFjWwmTNTDpBPeTRleL7PHOpn8ATc
         qoRCs2qxTgtGMJl8YatLgT5tWkx13QzY2c6dyqaAGwYNEEBAsgErgZqmRgTDXw1jjBg8
         PVNt2pwPf+Nw+gIsirTlQlZEJ91TU5A+verCdNOC6wi85dp52kunOjDOnWZqpdlIOvxx
         CoUI1xtiur5fKLZB+LxEwMuZFET9GxgjipF2LElGy/d+iHQVw3imA+df3prf1/zSmxC2
         jqCEFAZqqCGuesb6qR5z1Ob6nnHr4S/Dw8vj9lZ6TBVocjlByo+D4nrKJd+4Fr6qmYqY
         JUzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760230089; x=1760834889;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aMzh9pKpyzAI9fgkXE0PDoQvhdSlvccuIuAISiET8MQ=;
        b=wi5WXmVROOOTun5fpEZ8+mTgNeE0x5QQxyc4CnrvvtHngSFjfLLiyK7cmyB5WYlCn6
         lsLfHMuGACCAdYyhI5RmUfN6dXT2ozT9IXS12PnhcD0Ovdf1lCQrymb2jg6cTzhcqsaL
         pLrDNbiNB79hbFTeykjQXjXmoT0VERhVcq+/1RImFUSDzUehl+en6jhWMZYATevtca1b
         nVpe2cr6lblIpfK7H0sJ9XEdvUecEKCkgnJ4dzkO/9ZzhjygAHz41rLAfWpZp60zsGVw
         mHq28B0NCnvFP4/BNZhpB2X704Ck8qCsp65zdcYJN8hiVf0FgqzQjmIdbVj1oVmDB8Fn
         mUbQ==
X-Gm-Message-State: AOJu0YwG6bGEF93ByPO9VXvWjm1XaCUiDjcAn07j51ArpPMKD+pnrf1l
	zMe5DS61t5GDMjV58/vG8DdySYKHEe3Htr00OZOfyBCRCpuqNnp7Ph3s2JnXtg==
X-Gm-Gg: ASbGncsVHTSCUCZ6y8XvZfxxsN+PWXIYxJIPfxPxz9vZbegdGFC1apBs/yIAadK0KeO
	IplcvtvN2Eo37Mf1sF+QV6yf3PlPURjIeg4a2YALz682F5wJq6e8TkuXB05btHrYOz7eYKhINN4
	0KeQ/Gd3s7dtkRQ1WtOJhpfOHnxOEciVk0VSmY3nNwXmIKo4Q6w1FFB1YIHQpG5vDba0xbNgCRe
	VJug2kax1FKys6Kolwoq0jpdzUw248fNYtnmx+95FLctrBSPTvCq8SyS2RE2dLo+5JHTLAfhR+4
	3T7YxA9skX2/KepMvnk65jrBnYkRQOElclSPyX415Eizk53y3w6YvsjLfla8FpfXEbZtUY72eeK
	hq+9ZTyoxHN9KcIJIGciTAeKdl59diyI49MzqusejPuw2s/JOTabLtKhCXL5pTxtfxSbJ
X-Google-Smtp-Source: AGHT+IFWQjj1zv+pkJeZxRkkbKJQty0FTNhKBcJ6gvyLzKNB5R/qfeCTAWc5J6WqFe4g4MFFVZfF9A==
X-Received: by 2002:a05:620a:4083:b0:80e:d31:1ea9 with SMTP id af79cd13be357-8836de0a5e7mr2350141085a.11.1760230089118;
        Sat, 11 Oct 2025 17:48:09 -0700 (PDT)
Received: from [172.17.0.2] ([20.55.127.226])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8849f3d8b39sm704053185a.8.2025.10.11.17.48.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Oct 2025 17:48:08 -0700 (PDT)
Message-ID: <68eafac8.050a0220.30de1b.36a4@mx.google.com>
Date: Sat, 11 Oct 2025 17:48:08 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0135234332147814443=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, pav@iki.fi
Subject: RE: [BlueZ] shared/bap: fix crash when setting initial metadata of a stream
In-Reply-To: <a2c50d6cae8f2c4a092172ac7dee870405954a7e.1760225372.git.pav@iki.fi>
References: <a2c50d6cae8f2c4a092172ac7dee870405954a7e.1760225372.git.pav@iki.fi>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0135234332147814443==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1010398

---Test result---

Test Summary:
CheckPatch                    PENDING   0.22 seconds
GitLint                       PENDING   0.26 seconds
BuildEll                      PASS      20.06 seconds
BluezMake                     PASS      2759.64 seconds
MakeCheck                     PASS      20.63 seconds
MakeDistcheck                 PASS      185.84 seconds
CheckValgrind                 PASS      235.65 seconds
CheckSmatch                   WARNING   306.49 seconds
bluezmakeextell               PASS      127.99 seconds
IncrementalBuild              PENDING   0.34 seconds
ScanBuild                     PASS      910.83 seconds

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
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
src/shared/bap.c:317:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:317:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:317:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structures
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============0135234332147814443==--
