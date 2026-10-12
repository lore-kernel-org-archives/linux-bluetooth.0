Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ECF3351C1C
	for <linux-bluetooth@vger.kernel.org>; Mon, 12 Oct 2026 02:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791770415; cv=none; b=LNLbZsyueLC+PSPDIW8JK63RgdZR9gC2Y4a7mrE17dTIYohhaY8eZNKhD6XQQ6tLSEa9ISCJQmlQiqOXORqH8uXKgFEM4XMt0sxytkg9rKWGnyhW/RowMnz3lOTyNraPyuiMHFAOC1Lm/vRK1Z1F1+sGKBh32Cq6h+nbGv+TCzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791770415; c=relaxed/simple;
	bh=qhkyoOYa+sKXwQ0ZeuCoQruCrTV5mDxGOlxF4M6yGa4=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=Gvp4gh3NTxD5ymQDY16TZstXoSoW/hU2+0EeXit9HtkoiTw9vCkLrGN4dAw+kcN83nnlW/dxC07tMxHCwyHVUGYLjwmHhFDXcYfDCawOYT80lQlc8XMVviT8Gkaq5u5JydgGU3cAfthVZB8sgIQ2FRhKYump9lxsf0ygMXz0KWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DVZMzv7o; arc=none smtp.client-ip=74.125.82.50
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DVZMzv7o"
Received: by mail-dl1-f50.google.com with SMTP id a92af1059eb24-15dd124bbe7so2846820c88.1
        for <linux-bluetooth@vger.kernel.org>; Sun, 11 Oct 2026 19:00:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791770412; x=1792375212; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=ysfH7Z7c6P2Lzt6o07MeBszxNDbaOqmtdCSlvmOoOhs=;
        b=DVZMzv7oCPdQy3pLHQQ+wjj5zvbeGYsWHMdtbTNZg/jpdkXhYgzAvq3Knmbyl7eOs0
         wswBvz4iWjRYfx6AQ+BYdumcdvACcspv/C5KQZFplH49Q3v7sUr2jBEMlZQ7G+cbSdgc
         DkzXBCBZHLisFiSSE4SxQHbtoX0XqUr9SdqibtfrvFzziTMBMiyci4SUO5mAsSlBQyUy
         3oTddEvKdIryNOmOYVBlcNcnk+gyv1GKCO4jn/GEFPZ/uTQOYmJStPjfRgqL7hxgFF9H
         Z+P4UItanWPfAHtxMCnu1/zjYNKBA+rSMGa6L/OF15s3gpg5KrSjaFei2B4Pbr/QIB03
         /5JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791770412; x=1792375212;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ysfH7Z7c6P2Lzt6o07MeBszxNDbaOqmtdCSlvmOoOhs=;
        b=2YGc5MiB/t/D4CtiYN1h231em/AdlicML1m1buEEebUMMfQ7436Hpd+63o3MX3utgW
         15HFvJyEt5typirYN/UEz00Kpf5KERPNWySPc94+kvkzWU0Gj4BdjLNHDKVVIy/pshq7
         9mC7AYJ6bEtGtRDpblJXxw8O5m01PNxZpOiJlHAKESoG2iuAi+oKYZJ9xRpvNn5zHS/0
         y39VvX7ab9X+YCSsyX0vhoSTyfNv8z5LdbG2QwQUT8BrK+bpjCDyF0P2WLJH56Jc88kG
         MkCd/ct9j41F0iExiKfbNGF0ydMBgXsgcmKaKf5ULBn6d+w3CVPHzprkKl5xZZUogFSQ
         NxEQ==
X-Gm-Message-State: AFq9FYLSDVpFZbyA+KqZoVLvlo+UMmDB2zjfwW4x9XjnwIB+lhWrV1eW
	zcLijSyRmgP7XlRHi6VRopsnUdtXnt8oRucHlc5oTFa1/3cbjFZj3Ij1Zbi1ng==
X-Gm-Gg: AYBFou1HYCAvYjHkTy+BHxIQagZVc4as3XrmcZUWhYZvHcA5xhqC9GnEzQUX6sn5YrR
	3/86guJa85CBsxBdvQN2ok76yMzrnDWIGSjf5lS1sszt4Agq41kS5LuDy4rVKrYmZ2pwx7L0hm2
	d9sO/nMaDoyOySuYNolHtZ1BvFlvYRyOSsaknjvZfhwLmbLdfgT2fvlcStrYC28DJ/+FAHVIsA3
	smH8oFfxp4XOmhr0RzBhw1YWUIBLgWaejby5R3dnAq2UTHjHVRdUf76zeH8mVN+Z3Wo/54raHoa
	Pfz3SZXKGDQPmpgU5FCQrwYRnQBJfe/jVgE5ojiNqU6shF2TVcyFdNKQCvuap0fPjmSw15Fk4DI
	IX/OXVQoJejwMGdOo8WrNdcbARLdvJ+0zWAFwBaHvtIUY9rkRXeUUhiL9bk5F4bSfTtlA/TDQ2B
	w0QvaEXFaUB9JtWkZnTILOpd7zZHNm12zB9XzP9/B1YFfTqtVx29h8uyYP3lwve6upHBfUjIMYT
	esC
X-Received: by 2002:a05:701b:42c1:10b0:151:2068:e81f with SMTP id a92af1059eb24-16a5e873912mr11598355c88.27.1791770411948;
        Sun, 11 Oct 2026 19:00:11 -0700 (PDT)
Received: from [172.17.0.2] ([20.168.111.82])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-169a567aef5sm24888207c88.19.2026.10.11.19.00.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Oct 2026 19:00:11 -0700 (PDT)
Message-ID: <6acc3f2b.0b8a6e6d.28374a.a720@mx.google.com>
Date: Sun, 11 Oct 2026 19:00:11 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1850972014219217022=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, me@andrei-z.com
Subject: RE: Bluetooth: hci_core: program a public address set during auto off
In-Reply-To: <20261011220813.1815075-1-me@andrei-z.com>
References: <20261011220813.1815075-1-me@andrei-z.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1850972014219217022==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1183485/

---Test result---

Test Summary:
CheckPatch                    PASS      0.56 seconds
VerifyFixes                   PASS      0.08 seconds
VerifySignedoff               PASS      0.08 seconds
GitLint                       PASS      8.82 seconds
SubjectPrefix                 PASS      0.07 seconds
BuildKernel                   PASS      33.63 seconds
CheckAllWarning               PASS      33.49 seconds
CheckSparse                   PASS      36.74 seconds
BuildKernel32                 PASS      30.47 seconds
CheckKernelLLVM               PASS      33.96 seconds
TestRunnerSetup               PASS      707.44 seconds
TestRunner_l2cap-tester       PASS      12.45 seconds
TestRunner_iso-tester         PASS      10.43 seconds
TestRunner_bnep-tester        PASS      2.86 seconds
TestRunner_mgmt-tester        PASS      59.78 seconds
TestRunner_rfcomm-tester      PASS      4.20 seconds
TestRunner_sco-tester         PASS      5.31 seconds
TestRunner_ioctl-tester       PASS      4.42 seconds
TestRunner_mesh-tester        PASS      5.22 seconds
TestRunner_smp-tester         PASS      4.08 seconds
TestRunner_userchan-tester    PASS      7.61 seconds
TestRunner_6lowpan-tester     PASS      4.13 seconds
IncrementalBuild              PASS      27.48 seconds



https://github.com/bluez/bluetooth-next/pull/898

---
Regards,
Linux Bluetooth


--===============1850972014219217022==--
