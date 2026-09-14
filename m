Received: from mail-oa2-f12.google.com (mail-oa2-f12.google.com [74.125.231.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B7E4403E88
	for <linux-bluetooth@vger.kernel.org>; Mon, 14 Sep 2026 11:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789385017; cv=none; b=pOlBhHT6XL25LA8PSvAXavjg/ZgVnLvHzLVuPANNuEH81h/47t6HyRrCn/r93P8om5T4FwDE+b9DfDnycoiZyWuhEc+clXJvIy9GUhnid1VL2f+y0sKtzGtZI+CTEyot3FXL+zBx1l2qcFVoj5Z7p2QIJBX/mu85SFbqEX9wLXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789385017; c=relaxed/simple;
	bh=GXE2TkPsRFVWmh6x1t0GmrR3lsxbW6SqdxTtURP8Lso=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=ATBsAnqqJQZC46CZ0D/YFiJ8BBZwWJmbPbyy5seUhSlt7yGw2qxk5Nhpc7tKfkUJtdbSrqJBjRKevql9uJQfFzSBTDY1HeZ8rNtOwsunVZsvSe8nt9jraG3qm81L9/noHid8aWEhNOqasNyG4lhLEau6+HawkByP2Bc/vEeSZSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RctMf49Q; arc=none smtp.client-ip=74.125.231.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RctMf49Q"
Received: by mail-oa2-f12.google.com with SMTP id 586e51a60fabf-4693691fc81so805246fac.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 14 Sep 2026 04:23:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789385015; x=1789989815; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=iTD/ToPqmdbmEQGC86Oow4Ql/PCA5wmWZW0oR8LqiUI=;
        b=RctMf49QLgD9urltDIFVpHj93ernYhqjubgaKZb5ya6GzBNExrZCim7VR5iVB1yvnO
         333oXIF8gcS3ktv/MEkeG4ZVgcqQiiTucPGX8v4c0Pzf4++9w1g73grxAXvttBCVfT2F
         8eXwyq/8In1MDmMl6AU8214Li+sZLd7UZ721yesYloPtBvCsKtIsCO/7FrWsSNSVRjHU
         4yy1WpWfuvJl1VDtpN8jBagP+ulm/HoetPoBg/XqsnbwIR/XZhlRdmhak50X4shrPlka
         E8O87XPnx0/qD76NQ0lErdfxl6FkNeTi/48sivQGsN64pfOuKfdElYlR/h5XXKxolU0f
         f6ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789385015; x=1789989815;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=iTD/ToPqmdbmEQGC86Oow4Ql/PCA5wmWZW0oR8LqiUI=;
        b=T3Yd0S0YK+QSYuIuiTc3pP2VA1qREBRuUNvW0ziS5mgxuNgHsDxLTpVgxYq4i1B6D8
         FxueL/lIHo/PwvAvprqAQOmQ1//GXiq1HNGc+uHIP2kDAPxcpS6msa2p4SQ1zwLo3pMZ
         D10MtJIEOA3Nt70gyvsadgzNasRyVZOzn/Wg2iMPe9/3C8nEdcHFUDamLyW/ZAvEdYzR
         Hx7HQgpC6Io4VXmEhqby7ZwwjtzTfnQ/kQYicMwMr/V0mRm3eDO6nZK00sEulaRGTQAh
         B7VzG/FOTecuRnu5/iVdkCBhBTL/mUo1EBONWoRcVoEeVtefxKra+ZFJnMgdxfDdCqUP
         31vg==
X-Gm-Message-State: AFuF++nMeaZaOOyqB/keYakwFegulVNgYiH79y0mjNJAeO8Fbn9Oy/1c
	iFJq0nClFk3bO9n1by8gNYRUIr/4qwm/bS39jw9QCNyyndVkvMqCp5PUUVy0uw==
X-Gm-Gg: AYBFou1rwlXg+nCcRAWwQK1tXZZJhaS0K0VkprGy5mz+4c2F0TWK0UUa7/7pwbInsl4
	LE5pz5rYhF9FApXNQk5aAmhJaZ6RlpqCd96IjOg11qp/dWz0AlIationprgM5gew0jBDUnhWU4u
	JbXqwLPxKCNt39GgfrAYw316rH9cLw+0kqQ+A62g8UuQCzxD25d2QI3Wtz/vT8D90Az4ULBDHiD
	I+RvOM5eNYEuJWj0cjHv01yQ1klK6DqQ2AOadshSh0FRC0zlskViaO+c3dPp/LDlEygRPJ2zpr7
	COkImy8uWuY1Z4t9MG3iXHkytKp5VyF0QjMeN/n53xH0u2hv2Q3QQxuaJZaxGWcd4ORnprznNOH
	5d6ySHBQwjnPIqnYtN6VFAk2uZ+yLGnEKyBB8wwBJRHDnxn1yFQuVaVy9NsOHeNRy3fUJRMKf1u
	66z5mGHA/a9oLYXzpZtWle9fStEhu6V8O3GUph9650YvbORP8uciQ14Q1HMOkpzmsBu14d0E7nu
	72imFo=
X-Received: by 2002:a05:6820:f06:b0:6b7:46fc:1c4 with SMTP id 006d021491bc7-6c54203f0camr861028eaf.35.1789385014898;
        Mon, 14 Sep 2026 04:23:34 -0700 (PDT)
Received: from [172.17.0.2] ([52.161.180.146])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-14365a59b18sm24354146c88.2.2026.09.14.04.23.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 04:23:34 -0700 (PDT)
Message-ID: <6aa7d936.8e75e0cb.126d4f.aba3@mx.google.com>
Date: Mon, 14 Sep 2026 04:23:34 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5324657965525724823=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, chris.lu@mediatek.com
Subject: RE: Bluetooth: btmtk: firmware debug event routing and WMT FUNC_CTRL status fixes
In-Reply-To: <20260914065654.102916-2-chris.lu@mediatek.com>
References: <20260914065654.102916-2-chris.lu@mediatek.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5324657965525724823==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1164217/

---Test result---

Test Summary:
CheckPatch                    PASS      1.85 seconds
VerifyFixes                   PASS      0.07 seconds
VerifySignedoff               PASS      0.07 seconds
GitLint                       FAIL      0.66 seconds
SubjectPrefix                 PASS      0.21 seconds
BuildKernel                   PASS      22.19 seconds
CheckAllWarning               PASS      25.34 seconds
CheckSparse                   PASS      28.47 seconds
BuildKernel32                 PASS      23.14 seconds
CheckKernelLLVM               PASS      24.55 seconds
TestRunnerSetup               PASS      571.14 seconds
IncrementalBuild              PASS      25.67 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[v2,3/3] Bluetooth: btmtksdio, btmtkuart: validate WMT event length before struct access

1: T1 Title exceeds max length (88>80): "[v2,3/3] Bluetooth: btmtksdio, btmtkuart: validate WMT event length before struct access"


https://github.com/bluez/bluetooth-next/pull/763

---
Regards,
Linux Bluetooth


--===============5324657965525724823==--
