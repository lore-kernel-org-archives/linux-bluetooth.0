Received: from mail-oo2-f41.google.com (mail-oo2-f41.google.com [74.125.231.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFCA3416872
	for <linux-bluetooth@vger.kernel.org>; Mon,  5 Oct 2026 13:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791205290; cv=none; b=lyJWlpByCPt/0vDPyQPxrtA3qb5T1/CK4BI9L6O21fJfBxyeJEudoc+paWr21IQ/Kl1sh6xJzhxG9ra849n5WKyuwQsiQ+Di2BEsAOBh3Ce85ylbacMnvPE5d8YEakgE43Sz7/EOKh/EBzvQOa9ZfPbiN9TGSwB1e+TD9ZWwLyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791205290; c=relaxed/simple;
	bh=lVshLPpmSUSYbhw75aJ4KdJt/1waLLpLWpQwMbQVD6k=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=soeavzR9k3ZS+w9dbqXRPmOR60ZB2phAZyq/a7rll2ASHp2Iw/WUAn3SRkyXf38YP1BfRFYdDRyl/EooDdoownlKffxi/AIMeK4vszvCth1TY8QT661LVX+uyu7amtGFWqHGfhMr2uv3Bf3IX0VdNYdoayIWEFpgVNSmEgMrgI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RLUYiPHk; arc=none smtp.client-ip=74.125.231.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RLUYiPHk"
Received: by mail-oo2-f41.google.com with SMTP id 006d021491bc7-6d33d80855eso1377782eaf.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 05 Oct 2026 06:01:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791205287; x=1791810087; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=0qQTV1698xF//crEDMErei3Wp5kt0tcpurxklp/nRFg=;
        b=RLUYiPHk1oE1HsJk2ygAf5HOd8Y8DIaM5/wMjtL9fqWfds2a94J8YU9+lmJstAH3bV
         qsd0q7GYshhVMOxY+ZlMhj5ivzqVIoDQtZ8kkrAcOlWAicEsZS6ikvH0dY5ZlwhMXELc
         VkTVwiXo95+9Q066htVYnfT62jyZMTck2KNjbOf/3kHRT0+GdXJ7Gm703+vOwOLi9Uew
         Fl2U7i0MUm4yfSdYxgual5IkMXqPeywI792mqPe+ii3zhWRVkAEgTqDQu2abnPlfRD00
         sztu2vWy88e8VzEhOYGdgPlbXt9pQDiPJQ9hmqZ1akW3mi82cPdi89Tnj3qL0hJNehSI
         8C5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791205287; x=1791810087;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=0qQTV1698xF//crEDMErei3Wp5kt0tcpurxklp/nRFg=;
        b=r+cUFB/HMrMa8OCfckFCEO5kbyHgqpIrOXHgdtnigpBds4ChktdSThtOq6jmcbw0zh
         ZJFewYpuCv6h17bCNypckfQ79LAbuHLEL3jraHdwDWyqOthdrFIpvhEKSobQUy+lnxjZ
         nnfsdRzkmn2CjrDvmljsTgcFUWKlHeanQrKep2BgjBED+9DdWG1JJrN6bLzRWWXO1tuB
         AForS6w7xucysSzk1WlUdIf6OFxBhYI+ynkFAmeJiEOFDYtnDlB5YBsK7F9SAGKqI4BT
         I8AYPEvLTLUwTyfQSjWuEpSTIg0uUBibGPgGuRDCkSd0DOKqvlXu0NUOmnyarsWRiX1i
         IL2w==
X-Gm-Message-State: AFuF++mfyQ5nVJ8beQgzcZmo6JStAZYclhBB78H12WdgYYJhvbcZv1ku
	5wJgEcq6JnsEcNwgGFxcMbFgcV/E2GNACNeBRev+qKPhi6ioS2qpdW56M2/JRlu+
X-Gm-Gg: AYBFou21yR37krOZbkqrSWMCy1DYGUfpup8la/Az5iWVO+nCBmsm3DB1lJL/zMO7l6N
	Wh6ZZBbFKpXQe2aex2kDIwiIlVZgzrF7oS17Ka/61BtzFU2Y7rVw6Pc+OHXqfLtZVWtlhYZhUHW
	SsATxb3H7HnvAVlTIARpiFppEi7iipNeM76sy8GMNyDTr1Wu6U7TsDZGcR1n8+UJ3IqQGDCTO3h
	TuIRAvZnkA6Bm9YeqK4m9jAydRG4I5vFMaoeA3rMNTuuwiaEie4o92lSswS6drbo9l8F2KIMG9r
	MiEvCU8B4mElraAgWg+7S5+0xG59n3Fgazaj6i4FohrHIveysBcTRyKeTqx9NPCpjdHhkCc97dZ
	z3kiuGP2HBFqZwL1cUVSuWQFPCJ2+hbLoyzXjojytA3QUzTghwRxmZt2jBkITqD7ZizlTIrABD5
	UelHaI9JSSyRuf3Bpx6XEHwzpHF/IuRyB7wjnexJYBP2A2WVkrEYi8GQ10pC9ohxDRI7JbwbIWU
	2fFIqY=
X-Received: by 2002:a05:6820:c0c4:20b0:6b1:b33a:db69 with SMTP id 006d021491bc7-6df336b00bcmr6516586eaf.15.1791205287563;
        Mon, 05 Oct 2026 06:01:27 -0700 (PDT)
Received: from [172.17.0.2] ([64.236.133.177])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6df3b6a4f72sm10046392eaf.13.2026.10.05.06.01.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2026 06:01:25 -0700 (PDT)
Message-ID: <6ac39fa5.2259051f.13e189.3d73@mx.google.com>
Date: Mon, 05 Oct 2026 06:01:25 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3174617437588156437=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, nicoyip.dev@gmail.com
Subject: RE: [v2] Bluetooth: ISO: Serialize concurrent connect calls
In-Reply-To: <20261005075031.868260-1-nicoyip.dev@gmail.com>
References: <20261005075031.868260-1-nicoyip.dev@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3174617437588156437==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1179443/

---Test result---

Test Summary:
CheckPatch                    PASS      0.75 seconds
VerifyFixes                   PASS      0.81 seconds
VerifySignedoff               PASS      0.51 seconds
GitLint                       PASS      1.29 seconds
SubjectPrefix                 PASS      0.99 seconds
BuildKernel                   PASS      29.85 seconds
CheckAllWarning               PASS      35.42 seconds
CheckSparse                   PASS      36.27 seconds
BuildKernel32                 PASS      29.66 seconds
CheckKernelLLVM               PASS      33.80 seconds
TestRunnerSetup               PASS      809.58 seconds
TestRunner_iso-tester         PASS      13.85 seconds
IncrementalBuild              PASS      34.19 seconds



https://github.com/bluez/bluetooth-next/pull/859

---
Regards,
Linux Bluetooth


--===============3174617437588156437==--
