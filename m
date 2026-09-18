Received: from mail-qk2-f13.google.com (mail-qk2-f13.google.com [74.125.230.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C68A4C0436
	for <linux-bluetooth@vger.kernel.org>; Fri, 18 Sep 2026 10:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789728020; cv=none; b=uFokn2hMf37U0EYSPUkfbYPdDy7LbjBBSkMNYBpTJqdbubyg510+pcxzBuQj6zha8M4OicTsIH5i5+TNG+D80poNHAe8cj5P0BuZEK/3vbDx5Hc+NdzHs1gJ04bEfbQ7SbaTHZM2svTUp92kCutf7kkR7/dodz/w/elTQ0os31w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789728020; c=relaxed/simple;
	bh=i3HtE6Ua9UXlh6u7Ld+CEMr4eR7diEptXLxyRcohizY=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=gqnrgEf1LlG7w4l+z7WtIuPv3+x/dn7fqMPn8GMqb1l4Kb8XrhH7JgT4T0SJRWDJRw4+7pV4iZs6+KuCR/MEgjP2gcCT03YLj/tpL08buipAvqg2e5L79rwbg9YHzTPxhJlTtljrDllC+MopvPpCUuRIbhdp9z4GlqkUuBqkGv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kx7ctYa4; arc=none smtp.client-ip=74.125.230.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kx7ctYa4"
Received: by mail-qk2-f13.google.com with SMTP id af79cd13be357-93910cadeb3so43298585a.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 18 Sep 2026 03:40:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789728012; x=1790332812; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=bUqbUwSsvOL28QK1kZK8KqDze3L3gkYdRaw3v7Jy/gQ=;
        b=kx7ctYa4pPAZvDE/q0l2pfsMD6nu+SZ2RLethLoE3jOdu/RveVL3ZgaNaGHVjHG75y
         EinjCarkutTeWCX4PZazqOiNxUnnnkflm/Rrcil9Ed0jdWsvYFCuhunXr8o1XZQxCoVy
         iARNH/bu06D+LJrC2PfL74i9lHMxsFdLKjMieq5ZjmFCD2vb40KRYq9tNk36ITlIPqBQ
         xbcVwlzl8yr/gRuqXmgeNBUFLeHSfY8X0m6/DbrXyoclWxpaww8T4tSIHsrKD6kFcEvm
         BfjFj97I8E1cPzKnLOrnsClmE48Ors8GsqM+QsQmm/M+qbhg3I6qWp7StlYGLZxm8KlF
         L3DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789728012; x=1790332812;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=bUqbUwSsvOL28QK1kZK8KqDze3L3gkYdRaw3v7Jy/gQ=;
        b=e5G3DEymIU0ovRTWpNLEvBJ3CM92kkVpeAQGkKh40kgVQ9FZIpPit9sDWV30isHnQd
         yPXLdKoxNzm/x8kwYq65IM8LdKbHGDEgdV9k2GnWn7l9kNF5nyZ3UauSN+mmE5o+ffnC
         81/Mhtl3EzuTjmXtBzmFjOQv6ZTJToljAo6YDofcqMtFNiNwks773+0vhWGveqUnxBTu
         Op541/sX/FG+s8eBnpZ0V0GPWnJrGKBQuV5Ofl2055j1EMAMjCK7YLt6+TGGZyKMTHyp
         7ZZCSQh7AW1zlEMX1EKQgxr5eD+41ZjnCqeuYMwVxFBsMl1RRmCoB05ZNOeo51mUFK7Y
         mU1g==
X-Gm-Message-State: AFuF++kxXMG/37EWX2d2scjewzMUwF8ppYQ8RCega2+80mZ63DAD88rM
	aYNm0CaIRoLnxELgDjGjewR1iKdfNo6red+wczpedBu2fW4y6TqJsQ2JwB12CA==
X-Gm-Gg: AYBFou1o11/Nto8c4ZexdxL/bwvs+JTCrOPGdyrlnA0+e1oOKNqvPP3e1HoW9QdYLEe
	BNO8DKlDjRmO4xwNaJFjmqaKkRCqn0eYz7GOYW65awoPuAZzNCpa0mFv33vyEy7KaV2G+gp1LQc
	p0NJFZ+f6fsQOfr6ocOLJcl4ZfcraD+wJgB80ljFtLza1PPXjwZp1t18V2jXWcs3xevYmvnhkic
	0ivZd6TWs1Lg6YkficbhfpKlNkBApw+aT4cGDn/2QE2dwsBzzUj2Xh24K15AwnhpnZyh0HDeES/
	vxn0q/+bv3cTTwvlY7FW23xZKsqgtcHfakHbmDV6xAJi/2pnbyBtzI73mvGIGoEuft1bBry11VI
	yu8WVRt37WfrzmgZXNrQMn2XNsNmv8UFr3ej4rJ94+U2DQ0VXTvATASQfbhMhtAqxTHya6yICHx
	9hUAHSiTCG4eucN5IPg4ssKFE46DqKRh+MozGi7InBYYHKjAsidWnyJIDZrRXgo49a1kaxZ3SIu
	cmabJc0
X-Received: by 2002:a05:620a:45a5:b0:93b:d7a2:dd2d with SMTP id af79cd13be357-93bdca2b558mr269111485a.61.1789728011948;
        Fri, 18 Sep 2026 03:40:11 -0700 (PDT)
Received: from [172.17.0.2] ([172.208.125.200])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93be0e90276sm104689585a.21.2026.09.18.03.40.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2026 03:40:11 -0700 (PDT)
Message-ID: <6aad150b.35b683e3.141a3.015b@mx.google.com>
Date: Fri, 18 Sep 2026 03:40:11 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6584136137850217278=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, benquike@gmail.com
Subject: RE: Bluetooth: RFCOMM: Reject short EA=0 frames in rfcomm_recv_frame()
In-Reply-To: <20260918075829.2203887-1-benquike@gmail.com>
References: <20260918075829.2203887-1-benquike@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6584136137850217278==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1168411/

---Test result---

Test Summary:
CheckPatch                    PASS      0.73 seconds
VerifyFixes                   PASS      0.12 seconds
VerifySignedoff               PASS      0.12 seconds
GitLint                       PASS      0.33 seconds
SubjectPrefix                 PASS      0.12 seconds
BuildKernel                   PASS      35.12 seconds
CheckAllWarning               PASS      34.78 seconds
CheckSparse                   PASS      37.09 seconds
BuildKernel32                 PASS      30.39 seconds
CheckKernelLLVM               PASS      33.67 seconds
TestRunnerSetup               PASS      817.14 seconds
TestRunner_rfcomm-tester      PASS      5.67 seconds
IncrementalBuild              PASS      28.93 seconds



https://github.com/bluez/bluetooth-next/pull/788

---
Regards,
Linux Bluetooth


--===============6584136137850217278==--
