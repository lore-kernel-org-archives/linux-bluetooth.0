Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793546422;
	b=vMlDY6c0yfGkHTaCiYwzGQ4UIz13I7bqE4DCQgaYoh2xWU/TSLsOJRsHtZCx2ZsUDmqt
	 EEFUasb6PP3fUFjIxWPvsUjir2AI4KeRUcaEViKxljrwQJlsgjRDFXBEAZFM1SpwPIT++
	 FMNV+GcpMKl0lziW9c0RZnby0ZgwCpCqsyu5FvtNYz2SUIYb44OVLoCPh8+I2bXH+T6/e
	 QuG0fChd9Do2YkmHtwg0JXoV6c2PPsWyPcbkJmt+EUgBtSFPRiKs0a+bIPvCdbZbsP+xV
	 0agN1S/9ztjpcpfoiO7qbc8eGynYyUSolweaclPeOF7Tv+MCzo9jbupNm1xURLJwpOg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793546422;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=S2P8YnXno7u8KXa2ReVqkeGcIeRF8zHDT0PIGg9w/jA=;
	b=JFIpej6eY6MbAr6j8PS0qpfU9NiE1Z1XBfay/8FvugQYfHnW7k0DkPwQ6wSzmiKfnTlm
	 Rnww1nRJgFi6xXwIBOgpe3D3F3O9BDnmhmPffY8bHopK3BRYxi/90rqdXx5uh97a7lyDe
	 pp4s94LSRUE3UheYU5Lqa7LxyHgaNW0t8iTsvrCuTojFFR9BeSs6QGORPFdttwNASqyl1
	 t0NrkSBLwWNWRsXGtb9o3BVEXe4bx52bvX0BvjTpjM8HYX3im813gbw+kWMezzptFMW5D
	 Q8Na2JPgusR8Yv6fPfXjYhA/5qjo/Dz12CcZ8XorRPRo32F0DHs/zl887ru64KRVR1w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VRytou4S;
	arc=none smtp.remote-ip=74.125.82.182
Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C647F606A324
	for <linux-bluetooth@vger.kernel.org>; Sun,  1 Nov 2026 15:20:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C647F606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VRytou4S
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-36661f953e4so3470476eec.1
        for <linux-bluetooth@vger.kernel.org>; Sun, 01 Nov 2026 07:20:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793546421; x=1794151221; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=S2P8YnXno7u8KXa2ReVqkeGcIeRF8zHDT0PIGg9w/jA=;
        b=VRytou4Swbf1lj2eWfOmk0AEhQiMb2lRlrHZYaq5gJd4f73kQq90DOO1q34YYWWQe8
         +//r4h2bNHS288RmtSStvsNDWc98wll7TFRkZ9JB2Ao+hqIrxpjGnp1M9JlM751Qnfc9
         sw5+079P5AXBC8XvOiuBx11jtjvMDMzDVgWhLsiYp50bxOQh7r9jo42uDnu9+hoVYPaF
         hB+V+UHWpbEch2ocJsTp9inDyADCtC7qnjAyQlXN6oplC64JzQfchxoofyQv78yvQGNr
         YYE/zF+O+XZqTlblytyRlmf2guYiPCO79HcZwBVw1ZR5IH7wzoIfJS6zT5PNr1FZkxg+
         epTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793546421; x=1794151221;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=S2P8YnXno7u8KXa2ReVqkeGcIeRF8zHDT0PIGg9w/jA=;
        b=zxZt5u7oH9Opd9oT3AOz/+ljnxwJpZuVDLBbdu4/nHzvfmzAGuXgUl3YtpCt8KIox/
         Pqor3yqfqX0rLVGuPJn6ZLnqhIeZwOxdWN5uW7G/1PZ9DwJuaDS+qWhGLHTVG1CpP6lT
         rt96h8Vx46lS47me27kiPU1l1jmpiMNm6v5n8VsGSWGA3KxgZZEVIBcaqUD744WZRJv1
         MaZpyXTUp8AePa9VyRbsT/2x+bkLz7P2zZi49EAo0yLrZ7YM0wR4zZ0CSQmPPCoaSMwk
         Hg3cfhZm2BumSGLw3S6RhGdpt2jRUCzqwXz6BbspXVYU9SaYdHfU9O9P2b/MjL+VJdoS
         q7Tw==
X-Gm-Message-State: APuU4Z89U5FR+cP5Luot1MkKKFGJEWyBPbe/D6Jw53iljEgAOi4RZpqd
	5GZ1F92WQaQwioQfY3Vu3sJY4TYNrB66BphaYn7unriQR4TNn4+xAPcCAuMsgg==
X-Gm-Gg: AYBFou1odRKoLvh6lKlDQpIq48CeZQQYUnkG5JcEfsoxXSFYrV+EMI+Nj6xg4V3XfWW
	F3KZLcAGCi5kjDBbKgtXsyNp0GUa2fVXiiwj//dVYnwP+00MfMgI+dvMS43/PRJj782cYSrofMG
	35R97HIvaBsO+rmA2MuRHX6WI5pd2OYaAlZK4KDewHzn6A3MhZ2XCVwrjplJtKDi97cPnRXDv+k
	SA1crWoJXXkZP27IDyFxgqwqHkYhEPbuPvtQvH2Mx9gKPVLa2MsH0LV+xKuwNf2tiG7o6dpigIk
	sPD9sNERj70StNkQMwlcXbTtr/DAF5y7t6v2VE75A6Lbm+IXGgihO2SO6sfdYtsfDA34Czt290X
	19cJ+msY5qDekw6x2pbJJDaHdnqUdoN7F77I+0vEGX8JKUPVO4D4XdmkRcspQQKZL/jnA3X7541
	CocMTiTp+po3Uv6ARTiK7k0yAU99AlLzNM0XTGOoyxDHZmURKuVay0dNqX/qcsppdtYwVqsx+WS
	KvEjpl35OnEVTG3M6TiEZRkQbhLoL5+URyXKL+TuoTjLPF2ySkwXMS1JzrBzJ7lag==
X-Received: by 2002:a05:7300:f281:b0:369:f64e:7feb with SMTP id 5a478bee46e88-36a4220128dmr12215904eec.2.1793546420675;
        Sun, 01 Nov 2026 07:20:20 -0800 (PST)
Received: from [172.17.0.2] ([172.215.216.197])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a42935b4asm38610637eec.16.2026.11.01.07.20.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 07:20:20 -0800 (PST)
Message-ID: <6ae758b4.be2e0958.1578de.f8eb@mx.google.com>
Date: Sun, 01 Nov 2026 07:20:20 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============5010258700336894388=="
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
To: linux-bluetooth@vger.kernel.org, ingyujang25@korea.ac.kr
Subject: RE: [RESEND] Bluetooth: btintel: Drop dead !skb check in btintel_read_version()
In-Reply-To: <20261101135324.2192752-1-ingyujang25@korea.ac.kr>
References: <20261101135324.2192752-1-ingyujang25@korea.ac.kr>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5010258700336894388==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1198111/

---Test result---

Test Summary:
CheckPatch                    PASS      0.63 seconds
VerifyFixes                   PASS      0.09 seconds
VerifySignedoff               PASS      0.09 seconds
GitLint                       PASS      0.26 seconds
SubjectPrefix                 PASS      0.08 seconds
BuildKernel                   PASS      30.95 seconds
CheckAllWarning               PASS      35.33 seconds
CheckSparse                   PASS      38.44 seconds
BuildKernel32                 PASS      31.77 seconds
CheckKernelLLVM               PASS      33.42 seconds
TestRunnerSetup               PASS      736.54 seconds
IncrementalBuild              PASS      29.20 seconds



https://github.com/bluez/bluetooth-next/pull/1036

---
Regards,
Linux Bluetooth


--===============5010258700336894388==--
