Received: from mail-oi2-f12.google.com (mail-oi2-f12.google.com [74.125.231.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02C7D50E5A8
	for <linux-bluetooth@vger.kernel.org>; Fri, 18 Sep 2026 17:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789753184; cv=none; b=lxbbmQ70cPymagsqYsnGids+eR5R5NFVX2BSl8ADaVvxFJoDAP7v9ltdQOKwLGOwfDMpSgs1mDHy+NKj+giGQdoVXBbCZmuee+cs7esMwnL/YeDibFYl9wli6urKaqbp1cTNtDk9O9KhAhAjvYH5LvVxGSK6Kx+abionHAhDY14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789753184; c=relaxed/simple;
	bh=f0NEW6Ofsg8fhJ2eD0GiX7jVhXto4BKLfGQ6yvauaTg=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject; b=SW0ZEur34IgR77Si58N5oD5rJI02pSNRFbeimg7EQ7XVGkHJnVenhzO8DATAdh2d6Nv65AGv/wENtUXNG+7uXJlWOG+3fOqNNVqmjBEN0/bpEAgmxdFV+5a/s/oIUk+nnHHg1zIIbHJoAl65PsaTU4dVgbZtv4sAmnGNRCtVzvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XRTIINoG; arc=none smtp.client-ip=74.125.231.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XRTIINoG"
Received: by mail-oi2-f12.google.com with SMTP id 46e09a7af769-7f4f0dd550aso301066a34.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 18 Sep 2026 10:39:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789753180; x=1790357980; darn=vger.kernel.org;
        h=reply-to:subject:to:from:mime-version:content-type:date:message-id
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=SMiRzgQvAGysTc/9jkdGPjjtszceuEe7qb6poFw6z3s=;
        b=XRTIINoGAYIGh1IKBC6z97qq1ECobsaOJAyPoPUJT+GwDhkz3Zx6DM33H53XQAAR4L
         5durr+jSpicYpDuYvp9HgnHbFUxZ3nHTek+KT5FDNAdUT2FpOvrP2LBOHHgoYlfJlg66
         OVDhzpv1OG/S9ZmfefjUO4PrN9aqEys/gluqs0+xISg+TxjCThw9cJGeUxncgW3xhbj4
         jYkdUMx8C1/QiROJXc663LfQTaLlZLpAILb79V1Lmn5fMCX3oP6qYh+dic3uEOrBHDU7
         RWMlM8bEqFtzZXoO+1YsvN4us/zPwmZtmi2qk/gikkHoSmO8ssVkqXp9h00z5kgUh48H
         1aww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789753180; x=1790357980;
        h=reply-to:subject:to:from:mime-version:content-type:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=SMiRzgQvAGysTc/9jkdGPjjtszceuEe7qb6poFw6z3s=;
        b=WQsIJV8P/0Vzi7bOdCCJ64Bt7gQCvfCUp+M1Xg3cPDQcsOsVEJDEIydgli+phspukO
         TZjyUX6Mm8QtPxNlWyeMZKkmTGjVuLlQOShmcKcN7CZgPMfFCkDpFE6ZbVlGgUSn9UH8
         f3maDlGrfGYGWGf/sj8+ldDVz/qnd/M2Nbjhm6TriepuohQJMHomzi+t9YKGLCrJ3cxZ
         lHPjs6oRltkj+2gkPa8xSZgXLC/5PntTkRnklr+TDHuyrsUbcg3KuME9u6+MrVRkem7f
         7/zp2bCpZHLwglyflrcSNxPM0R7y5/CaXWl/mUU86vqoS0+cGpyD1KDVtZv32gwIqfsv
         GTnA==
X-Gm-Message-State: AFuF++k3hJiHxaF53uW99yCqhPKTqcu0/pdlnLG+q++iCrXAmQhLoUhq
	/qxh0Zg16iRjsFuJtqFv00rlqyohLljP1Yqp8V4QJ9B/OaC79j959kGTPLxMHA==
X-Gm-Gg: AYBFou1N3oET7YoYs+WLe0KVXi89yW8CR5KIR/uMH73VDYIOgoMpYEiCNbppfThECSW
	P24GlP9D3IlrF7dY7vJ3Yes8FxG8KznZM2YA+j0D8zmVmYi6QCR0PTj7MgFaa+PJp70Xq+NLg0v
	6s2tXhXbdxFnZhDcvcZ+B3TpPegqmJldhlB+rILP4rVQHw+apl+jSC6W9n9+L/dX2QGPmXoy1k5
	uOYqcDFQfjmivrgwkYeXZ6nzHQ9orzi4/yabFkn7rfZLQH1gyBVXCPcVaMW4rV1p30R+g400hcg
	jNATtPABNvjGthojlMZYNQIiMO0KEUNt9KvxoCOQAKjMpCPj9M9pnbOJ1IgzEIQ+VYpvDFzaRlS
	k6rR4sVEc0QehvXpQiGT8dkOfe/vd6fDEleobwwpvy34nMgGhSsYHYYgQgqHl3MPyHv5MbgXg2k
	uA3/UCC8mh/HGjU0dGbiJlqZq0mNjxTK73FkAGIBcw90CB4kqE1SCVW7C9w2fomXhfkj8RqvpGO
	oEEsTE=
X-Received: by 2002:a05:6830:4885:b0:7fa:ab72:9e01 with SMTP id 46e09a7af769-80de3bf0ccemr3894466a34.25.1789753179617;
        Fri, 18 Sep 2026 10:39:39 -0700 (PDT)
Received: from [172.17.0.2] ([20.118.221.216])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-8107e38d32fsm59336a34.12.2026.09.18.10.39.38
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2026 10:39:39 -0700 (PDT)
Message-ID: <6aad775b.37cdf815.e6742.d926@mx.google.com>
Date: Fri, 18 Sep 2026 10:39:39 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3921203860058170876=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [BlueZ] Pull Request #2482 was closed: Fix Pebble K380s multi-host reconnect on 0a12:0001 adapters
Reply-To: linux-bluetooth@vger.kernel.org

--===============3921203860058170876==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

The following pull request was open for more than 2 weeks in the BlueZ
Github repository and it was closed automatically without taking any action.

   Pull Request: #2482
   Title:        Fix Pebble K380s multi-host reconnect on 0a12:0001 adapters
   Submitter:    yannynz
   Created:      2026-09-03 16:19:23+00:00
   URL:          https://github.com/bluez/bluez/pull/2482

Note that the BlueZ repo in Github is only for CI and testing purposes and
it doesn't accept any pull request. The patches should be sent to the Linux
Bluetooth mailing list (linux-bluetooth@vger.kernel.org) for review.

If the change should still be considered, it must be resent as a patch to
the Linux Bluetooth mailing list (linux-bluetooth@vger.kernel.org). Closing
the pull request doesn't submit anything on the submitter's behalf and no
further action is taken on it.

---
Regards,
Linux Bluetooth

--===============3921203860058170876==--
