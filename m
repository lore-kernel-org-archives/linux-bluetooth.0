Received: from mail-oi2-f42.google.com (mail-oi2-f42.google.com [74.125.231.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7959E353A6D
	for <linux-bluetooth@vger.kernel.org>; Sun,  4 Oct 2026 18:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791139563; cv=none; b=YPKAJb51Z3NwFPS0Ghxt5nXMkgnp+dGaDBHVRytBuiFYhCM+4Y5IE7doI6m4BvDjidG9+uoDlRUq+tLA4sN9yAt6QCMLSdqUKPb9gAf748/CC5CpkXEQGryUc4snp2oqCRp3ZIKtsv3mTh+FOSy5pRxHThPLbnaExTy2A0mO7dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791139563; c=relaxed/simple;
	bh=z/+I+g+b+2cUA+jU/ZsmjBoKbaZKifZ1DcshLAukbIo=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=UvIiHfykK8DKiwB/swBpZmQUP7P1I9UOdS2ZyMZHxIFuz/0mXgoh9UfDWVkuy2teom6RQtr8y857Ick41zluirMheQXk8rZ9deqNIc40d5g1ZJwhCHVZijLVci56O9qYmFNDyQZfQspb/BHvcV1ZIDC+LZxwzfqWDb3yZYDzBp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aD0SspGn; arc=none smtp.client-ip=74.125.231.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aD0SspGn"
Received: by mail-oi2-f42.google.com with SMTP id 5614622812f47-4e47db1adb8so347017b6e.1
        for <linux-bluetooth@vger.kernel.org>; Sun, 04 Oct 2026 11:46:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791139561; x=1791744361; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=LF/ygJVlDYrpBvQNSPN7AV/b+Am/dHkvfisFJNFnjZI=;
        b=aD0SspGn+dCKWjkPhapqYhVqjva+r/iIcRHNuhHYOX2hTdb/0JTwNHZiEJONWMkHzs
         moeO2fNkHbFedtIy/MLLnJNIYD+UN7vACRini/klTBRaUSJ8tPtGptIXILUzkYjghdwi
         up0jEAdqQ8XIekiBLN0SPdDZC1A8OtstRXHmfPQdnViQyZE/06Yg8TzoxTt+omDM6azt
         aeaTRDgSsPsWYybmU6EzX34wBSqkTUBTfRvwZjB1laakL5Dd6sv9HNiICmAPNHZfHUYq
         kPNV3Mwq2E8sNxah72S+I+MaBr8CCdIYK7KaYnmYc8Swu2dEMe3GJSf1GNRmKmopbSod
         pH8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791139561; x=1791744361;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=LF/ygJVlDYrpBvQNSPN7AV/b+Am/dHkvfisFJNFnjZI=;
        b=jPKc50DzRG8lZANDOduARusYIeqauo5xXHbinOr5SDvfg/8/rxldrV4rH0p4w3JYOK
         CJqAuvX5G2t/CfA7FWavV3Siq+Y7UiOGr2BNYIU95hNXRAFykGOmknWxMdvfpWf0+J60
         Pb1vgUBE2vlYVKkJH1trbmkniFukoTuCENU6eqqCj5MMnZvmWvYi9abyd4xNLp6UZIsg
         7hYkWBuGgGRfrFhQ9A6LjUeydSj8w8gyyMpIAqtbNLPGWDbGTfR9bWO7YIewyJCSvvFn
         qmSsg+copKwQh/Z0fw6FX/3iqKf/aYCmxeczvS3gnU/kHa9+YegmJ+ZSIcuuQMHJ0xhS
         WGwQ==
X-Gm-Message-State: AFuF++mVrXkAQb+wOHLwHYz5bhWYzRupsoqrP5/0m3vGUgvki3Kj6vv+
	nL+FVd4hRDn0aA3MgOyL/6lX23WHE7qTSfyOTn4lCeHuvDFKga7ftleyHGSe/w==
X-Gm-Gg: AYBFou1Po9jszLIQKmdlGFcLIq4RYlky2sbPEANmvvODXFIxyUU1X7vuIrK/ivEsfCn
	+JKnYrNpQlAYR+gS3b/RVxsUxCRlgLTfxtlhC0pI6r4r+IN9CJK7K4PdC4SE7JkdgyJaaApRW3x
	z7KzU+hoWKbRPmBY6PwsxCFA9Y9Tun4rq+xZNXZjOv1yz0jDjnW8VYNrxR8gXLk5fmZ4E/fnvKN
	fwZd1nHLadU6OkstDmXBDrW6z04i1xjLdQdt0Msii/8PuzWe1mPyz2UVBoifLJURstdELvivNIk
	vSZ5v2oty6sPNPLJaAekK2hoOb4fa0koOPixr0pYyvbXUj5zNo6kMgDJhMYnXs54d/beOzueMEp
	vsYAZXKgZ8YSz1dEd9c3S8+gTtMLRCayWiTBmx9l5uY8C/ZMgIhhXukHSfQAhXjEwOpmfWHUDiF
	h4BL94Vt2MuyWQGKpIRSRh6yLG8Vf7TFla71OdamYhqx/5DlZZyPteOoFZTGTJC5YW4mSdXwIO5
	3EUu2Q=
X-Received: by 2002:a05:6808:1998:b0:4b9:a88b:8892 with SMTP id 5614622812f47-4f52970df2cmr9219395b6e.40.1791139561331;
        Sun, 04 Oct 2026 11:46:01 -0700 (PDT)
Received: from [172.17.0.2] ([132.196.54.233])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4f523d9ea7csm8226881b6e.4.2026.10.04.11.46.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Oct 2026 11:46:00 -0700 (PDT)
Message-ID: <6ac29ee8.d4759c36.1a4cb9.d91b@mx.google.com>
Date: Sun, 04 Oct 2026 11:46:00 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0064423562458240450=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, nicoyip.dev@gmail.com
Subject: RE: Bluetooth: ISO: Serialize concurrent connect calls
In-Reply-To: <20261004162458.3968546-1-nicoyip.dev@gmail.com>
References: <20261004162458.3968546-1-nicoyip.dev@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0064423562458240450==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1179169/

---Test result---

Test Summary:
CheckPatch                    PASS      0.54 seconds
VerifyFixes                   PASS      0.11 seconds
VerifySignedoff               PASS      0.11 seconds
GitLint                       PASS      0.25 seconds
SubjectPrefix                 PASS      0.10 seconds
BuildKernel                   PASS      17.71 seconds
CheckAllWarning               PASS      20.39 seconds
CheckSparse                   PASS      21.54 seconds
BuildKernel32                 PASS      17.60 seconds
CheckKernelLLVM               PASS      18.90 seconds
TestRunnerSetup               PASS      430.23 seconds
TestRunner_iso-tester         PASS      11.48 seconds
IncrementalBuild              PASS      17.02 seconds



https://github.com/bluez/bluetooth-next/pull/856

---
Regards,
Linux Bluetooth


--===============0064423562458240450==--
