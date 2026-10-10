Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B74832142B
	for <linux-bluetooth@vger.kernel.org>; Sat, 10 Oct 2026 22:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791672969; cv=none; b=nANxEPVrLcvRCJRojeZMs72m/jwKIFZwB3E01J2U52gQoHb5Ru50y42ufiuRg5HUQ6raR8O85Pq8ZqhFvY0j1OU2SRJZu8tBXTrSH8XMOxyTkhO+S2JrYrOlOqWqMakIkmD11Xo7kFVQqmDhKkLWykH/w3wShdj45Rmdk6Jb1ZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791672969; c=relaxed/simple;
	bh=JIZHBch7eFbPub8Lr29CQgIVLSuH2NmFpjrsmLDcmu4=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=eeWkRvNs/dyhFWoyaaEGOjXgf/767qiRmWCK2gZCpEbigPwJgucnDzlzmzur2Q21CJ1032FNUYCFO5LgtziTnL2cnKyo4zeEnv1SisfE4z8sDtF3aSJKVceF+pWZzExrsax0MVPC4BEIgvPOZuTlloTWHS6eAPIJpElTRelditM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C37QJlw3; arc=none smtp.client-ip=74.125.82.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C37QJlw3"
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-33bf40b0c8bso2646058eec.0
        for <linux-bluetooth@vger.kernel.org>; Sat, 10 Oct 2026 15:56:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791672967; x=1792277767; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=EcwoaZRdVm+IKbPYWYRlw0G99BitP78IF3br9d+aMSE=;
        b=C37QJlw3o3puPt7I8y8YQxfP6Ivp8f6QsTSXy1ex3VxqO0Vdt3Iwn9/hn4F+GoanE+
         jqRhf8DxwcP5uM4aJ/lekNnO379M1I57StRFIYb31DIM/MrGyNVBkM11txYzItr0f/Tk
         xk0m9pPMjbinHWzzPTesPgzFeN+oaLVIRR3Sp4PBxIg/Lz8/bH4ExW1253N+AXD/nVEQ
         nBJdKgDQS/8A/EN3pjNhtraklaOiX/EPhaytF0+TB3WlJ5j5HDJCbIKE6SWXZ7Yto9ou
         A8HtNI+kRV+UtCmoHUKYHWcDHByKMb20kVdL6Qm3eLMPa53yClSIQIiD6e2qDwTVbyHF
         88Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791672967; x=1792277767;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=EcwoaZRdVm+IKbPYWYRlw0G99BitP78IF3br9d+aMSE=;
        b=l9ZNmI0Yhzml7HY2u97AND0Lze4jC1FS4pHzd2gsrqCoagwEeTtY3IqKiZuxl4E3TR
         aed4xe/p9OWF9UC0E32dOSjGbFW05X7Kv3/ZI17ktS2MIq1/OVQhognPJnDDDxn9mOdS
         7Eece9GcKCPi6RW8u2D3zGdcRM8uPj6mnx7L1ogOnqxR/9ZRgPXIldh017q/ynbwgBba
         INpRh+6Tt9Y/DZHkiq0NiwywJwpT1NCCAoetV83/Nc2kA3pYcR0UMw8wimnwDkArKxvi
         LluueL8t62QMx5in8MhivQef/4nrEmxhVlmxfnJq7WBlKScHF7El5c+DZ2K6r+bJ93rV
         Kklw==
X-Gm-Message-State: AFq9FYJFWOYFhJ9B5EmSKvJotEJY9+E4fhXa5kPI+aV6MB99eD5u8wXr
	VgvDHu7n+pafAY2rK0y4uO02A7KlfMWtA+woa6aBRti40SLLR2yDb9UA1Papgg==
X-Gm-Gg: AYBFou07QDz2JyuaK2aQJIDJdvCoydl0fcAk8okL8gqWITZZOcrQ0VA29Sy8AnbQdys
	Qnu/Le0ikKg2n/9hDhkKq9q/Lpy/z7zawPUYIywer5DGUMhwoMkCRIWmAGDzHdUunRsZ5pfJf4P
	lx7sRwSJRagyzauPTFYp4zBo+CdVcvzNV1UuXj8jnE7vWBU1KK59zzQHzaRIfer+f4Jr9Djf0PI
	lBXaohomZy3BpA5nhc6so7V+v+H1qJKZsiyCaVeWDUzEqfw6Jj4DG/l7kVjGLL066NCe9+0cTAr
	IBr8kFDNsMZux85wTbTAXPl7bTbs5XmAmzbjp3Y0IKft+hpTxEzDJ3UAioMM2kkYycVNrDjdgXJ
	8t+vtmlF7zTr+Re1CTg2AiFq/Dlt4iGWHc/Y0C/gGoRT/78Yq//POShT0OrZVgpb4ymOdHg0j6W
	pqHcOlJmaGKn3YBNhu8HZ3Lyxm7BguXlA45lJbFuWGN6U1VlTp0HCLclA/OpgTR4F+ELaqgs2mt
	uCE8v4=
X-Received: by 2002:a05:7301:7d16:b0:350:2a5c:56c with SMTP id 5a478bee46e88-3537e08eee0mr8345936eec.20.1791672966923;
        Sat, 10 Oct 2026 15:56:06 -0700 (PDT)
Received: from [172.17.0.2] ([172.182.225.133])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3537ca1b53dsm17138705eec.6.2026.10.10.15.56.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Oct 2026 15:56:06 -0700 (PDT)
Message-ID: <6acac286.74f4172f.1bb12f.4f9c@mx.google.com>
Date: Sat, 10 Oct 2026 15:56:06 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4793906022400993834=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, aliamemis@disroot.org
Subject: RE: Bluetooth: coredump: Don't leak an active dump when the device is opened
In-Reply-To: <20261010194719.1364490-1-aliamemis@disroot.org>
References: <20261010194719.1364490-1-aliamemis@disroot.org>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4793906022400993834==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1183097/

---Test result---

Test Summary:
CheckPatch                    PASS      1.06 seconds
VerifyFixes                   PASS      0.08 seconds
VerifySignedoff               PASS      0.08 seconds
GitLint                       PASS      0.24 seconds
SubjectPrefix                 PASS      0.07 seconds
BuildKernel                   PASS      30.46 seconds
CheckAllWarning               PASS      34.16 seconds
CheckSparse                   PASS      36.86 seconds
BuildKernel32                 PASS      30.18 seconds
CheckKernelLLVM               PASS      33.76 seconds
TestRunnerSetup               PASS      800.12 seconds
TestRunner_l2cap-tester       PASS      13.01 seconds
TestRunner_iso-tester         PASS      10.89 seconds
TestRunner_bnep-tester        PASS      3.12 seconds
TestRunner_mgmt-tester        PASS      61.52 seconds
TestRunner_rfcomm-tester      PASS      4.44 seconds
TestRunner_sco-tester         PASS      5.60 seconds
TestRunner_ioctl-tester       PASS      4.65 seconds
TestRunner_mesh-tester        PASS      5.51 seconds
TestRunner_smp-tester         PASS      4.33 seconds
TestRunner_userchan-tester    PASS      10.70 seconds
TestRunner_6lowpan-tester     PASS      4.40 seconds
IncrementalBuild              PASS      31.52 seconds



https://github.com/bluez/bluetooth-next/pull/895

---
Regards,
Linux Bluetooth


--===============4793906022400993834==--
