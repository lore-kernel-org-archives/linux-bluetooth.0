Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795504117;
	b=qJo+r25EfdP+lNXrMfXX7iLMfK+ZzOgt9IKFyp6wIKeEZKN3vwPg3MpIeiD0Hs2fQ+fO
	 SmvhK7BX3i/grZJhJ263DTtNJqOSjmIEQCYkV9zv5UPZ+4jZt+kLCxN2EfdKpVUxT+5bJ
	 p3dwuo7ND7onamF3f/ycQoVFSVyRaa1Ju/2M0BFPtGlRUucAhiM1Vl1T4P/2sYzAuanrE
	 +Z4Az3VGL2a1h/MhKYlG3N/3eZxH+Xm5Xd4o9gekpo1kiRnivvKvWWzf/uPTkHRpHtpQE
	 gxMqxeMl7WBn7v8xhh+SbyXNCpB1RENFx12liH+scqR0FW988bN9jETytv6AI+IqgCA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795504117;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=Q/KqFuZgAOp9RfdyVEkhaZjphafrBjp+q/zFTf3VTZc=;
	b=Gq+fqTeeugj3UUz/V2sPfgEXJnZF3xPCUQU+bjp0jZFRl5ZeBUJm/am/wImsUcf/X07D
	 y2kWrjf7x7DaCn/P0ZZY9uw0wHN85qRUVmp5Vr+RaxOWF1+JTMzSNPio2LhEgAhr8KJKV
	 i5FOUuZDQzmI3ELp64+zVbcXxUyIE44TOulOQVNFgYicb4BKz4v/ekJVosJuFpfeTOtmH
	 ZaGTpOBDQv5oTTfo4pLmNen2rgvqLP8SuU3VOWir5RctoA3raL+gykgG1w2nVj+3zLvWv
	 DA3ysPQCsnmIXiuXD6y9s9lv8mSs9D/icSJ1GqsfYhy0fOQiv5lbxztWNRmrsbeTenQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WXkEIAql;
	arc=none smtp.remote-ip=209.85.219.44
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AFE0606A321
	for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2026 07:08:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6AFE0606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WXkEIAql
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-9213e130a16so23703936d6.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 23 Nov 2026 23:08:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795504116; x=1796108916; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Q/KqFuZgAOp9RfdyVEkhaZjphafrBjp+q/zFTf3VTZc=;
        b=WXkEIAqlGz7gI7VAsn20Tqj4xTxqItXiSuuEvVnmvPog/eEuIcKAw23iTkLCE7OSEV
         L8CrrAd7mDOtvMihrOHD97TOT9hDfmJuXXBCKW2KzAQKtQPbFsX8psyvDHfwtLyQxJJH
         YpuDC0qEM0lBZ43MMpIVo3ecgx3YnfuKdhee5W5M4dDHfBjVPI/5lp97IHhZJ2UvRWcL
         NJlB4ob0aymHDNnCFvTHN7Wsmd9IaRlfmrodmmRhu/v5xUYtZhNE4P54BJIhFOZRI56J
         282OwJhV79s3uZjcuqSks9o+gaO4wElx+qsINcu/gylvMyl+M+CltzFHWnlEpcT0t9yI
         0xfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795504116; x=1796108916;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Q/KqFuZgAOp9RfdyVEkhaZjphafrBjp+q/zFTf3VTZc=;
        b=ugtad63SQy7zifPvkjuh1/U5TPLOoUlsC/8UA0PiNIlkbvO3PuN4w0I3HtTejrhH3U
         V48iIQZjg68E0YYZz6zkQrLNfPKrMSdLpIkSyk4l/HAtRQNIGUIwYv+FEkxvooxogxLw
         B9OlIBzFq1hW+Cs2loOovfDPW0N7VZvsLXzSvqcneKQzsbRTchOAlKAFeD54Od/SmmHG
         61iFVRkwaf9RM5MYi0BTLAT7QDylPptA/itu6HEEnW+PFsXQDnUFQ5QcfIv4Nd2Hswdx
         rAcbFaVnxJu1S+HQGZzZ5haekcBKIzTQ0xoO4C69sYtayAmXc4QXo0WSpZwRE5jwsgVh
         ffDw==
X-Gm-Message-State: APuU4Z+by60565VJW8wOIXuXllpIXA2/Fuwd98lUCCFtvzZwQvbboX6v
	4rHoViL628hovBnBZ0j5l1U5Y6XhcYZAlGwroEgZ9DBkdwFZ5DSNp1S6x6bBJg==
X-Gm-Gg: AZFdTZfAQIFA1tOV7pRE2fnjDn5dnlOrW0Zp5XqgHa4++0CM4g7RE8PCWej8m/wgMyR
	AdUva2L4+9cKDNGITObU5+5vXKBJTRoHWVgP5ze30By/RSrPFdLCEarxfIf0Vs7NHMR/a7pE24G
	Txovja8E/wJG8/x8VuEDNkllv8oJKWwqSnZR/pKU1KTyZjqpmT6NGb1wYwvbPma/MQjSJMbVYIe
	8VzZuxClEMheg9PAfABiuTj7JAFUxW+lNLbRWLJ9YXp21W+1AgfsEsJCzKUgKdJ5maFxQ748LPQ
	CDBMwJIQAtlh/o1lIlmfMynJmu4PqZc6SEzBxNO7Wo5UHNRQ0J5aJB0MJU6nuVvTCQXE2BFwvEU
	tRHj7XbhdlZdBkidqbM2wA3mUrwNE2u4/H3lqeodmY/wrtZOhrBtdl1bA5a4kBMbKAM0CEaObVP
	LXYLFmL1Yh1KJpOOhZG0YA7ukCZLG+PplYsH4Np8TJKvhUeJmoYuk1x+GfV/HfwlS4t3BuVjD5H
	F+FJoKJM11r/os+4RpKBXtpoVjc7Q7oGoBkJi4f2gW+IJuX/4fHV6EDQNRtSSA=
X-Received: by 2002:a05:6214:6012:b0:921:2569:3a61 with SMTP id 6a1803df08f44-92134ab82b1mr205525976d6.10.1795504116268;
        Mon, 23 Nov 2026 23:08:36 -0800 (PST)
Received: from [172.17.0.2] ([172.174.127.8])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-92134bfe82dsm125198756d6.0.2026.11.23.23.08.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 23:08:35 -0800 (PST)
Message-ID: <6b0537f3.2a8138a3.4b484.3208@mx.google.com>
Date: Mon, 23 Nov 2026 23:08:35 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============2682855054517401072=="
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, catherine.l@intel.com
Subject: RE: [v4] Bluetooth: btintel: Add UEFI BPMO support for PeP
In-Reply-To: <20261124055627.250718-1-catherine.l@intel.com>
References: <20261124055627.250718-1-catherine.l@intel.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2682855054517401072==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1220386/

---Test result---

Test Summary:
CheckPatch                    PASS      1.05 seconds
VerifyFixes                   PASS      0.12 seconds
VerifySignedoff               PASS      0.12 seconds
GitLint                       PASS      0.33 seconds
SubjectPrefix                 PASS      0.12 seconds
BuildKernel                   PASS      31.30 seconds
CheckAllWarning               PASS      35.48 seconds
CheckSparse                   PASS      37.93 seconds
BuildKernel32                 PASS      30.88 seconds
CheckKernelLLVM               PASS      34.76 seconds
TestRunnerSetup               PASS      746.05 seconds
IncrementalBuild              PASS      29.73 seconds



https://github.com/bluez/bluetooth-next/pull/1212

---
Regards,
Linux Bluetooth


--===============2682855054517401072==--
