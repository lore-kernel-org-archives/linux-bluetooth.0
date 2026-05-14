Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C98DE36404D
	for <linux-bluetooth@vger.kernel.org>; Thu, 14 May 2026 17:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778778016; cv=none; b=DcvuaCEvOVZif5bGdM2TxbCQRzrMd2fpsSNht+nwZCH+dnGAvdQsdnNKOVKo9URxXTB5ZYPWEe+AYH/0vm0mLEwg1zSwUHOaXj9VE8CM1xZXGLF4/eywa7Hm/ODoMz3gk2dV8lmpyv+U8V1nIbTgC65GCC73sAmd1mxoMYgmT88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778778016; c=relaxed/simple;
	bh=ybft+WP9k/LcgSj0mM5BbqQmNp27SKN2kJLiKr66w1Y=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=shRUHpsqWOH6SPAM2USa8FtoU++4fuWFwssb53fkheVq+dZby+oI5VhGJ7xGqHwUc73wQ9GrpEQ0TLvbL7MMus+rE+XreKrRXw4YHjMZXdbP7F4zistV9UP/jHSaJ/XQIaYgA2xcN1/lc6h/NDy6G+AFZwQAO6J4OtdHGxcXr3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WUILjDrY; arc=none smtp.client-ip=209.85.160.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WUILjDrY"
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-43496e6a964so6119832fac.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 14 May 2026 10:00:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778778012; x=1779382812; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=La6cUY/moh4rWtwHxqW0cnHDp4xW8M80izM+lfXr6e4=;
        b=WUILjDrYek73LtN02kcsv7uXVE4SIX3zOfdPzcQ9w1XDtw/s8ZeDBoQbGqp3pHmRyA
         Ag6B8sRwXnIGF5GYvcVUE7OvLwZvJcKBJvs7zGXbUrdFnqTyM32GCeltVNvo8h/5FJdT
         +g2xvTxWiR2yKnLfXuuGv8XdrDMZtuBIEnItE7o2QTTP8eD5uW8fAvfSQC+1xR3raIY+
         uD/GQLBU4HYXKBhAJNrBtXr4MxYYwarCxMJwBP3KDYWSBiFzVHLqLtbz8SbaGdrn4rTE
         N/MY+zteamoKfcQKBJJqRzLrPUIxy1gzDxWuzCVakDwXLmtBgtYYGQz7ughqzQjHXoYy
         9sUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778778012; x=1779382812;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=La6cUY/moh4rWtwHxqW0cnHDp4xW8M80izM+lfXr6e4=;
        b=O5N+Q2+OyBxgHqQFVRZU0cRgMovAHB1+AUp1UjDF9ragujd9ia3oB12D+CRQJOblUH
         tDnVni1sxvJFKEeC0xCS1HE1qCD4vEoaw4EMmLNI2pwPLOEDGN+aucUZXFZ1mcsNj/KU
         t7jm7JE9Z/T44kl73BfnMPdIkev02hppE8UJjVUlVQomQgFl0OYd0SvKbDICFNSTtFwk
         u0/v9IebrI2qbTWse8uAHUGHNTuE8drxqZ+GwrP/Y+EupGsEmsyWJ9+/qK1eahJcfxH2
         sLrCH9Cs17EsikpJMxymoSJJI0KbW06EK3X59jWQRP32m7BFLmYM5Ikpe+6Lk4RggxBK
         autw==
X-Gm-Message-State: AOJu0YyZFu2kgOz8PNRy2/oT5PM+7pu9z4PNloOL0FbPRVGR9pNQ4Css
	s48TnePpNWhwxUJzTxoKkrC+5JmgSE1FEYvm1MqJe0nxoaa82lizdFGl4kPErQ==
X-Gm-Gg: Acq92OHjnNpR1PUVHc5YVW6t28jQw9gEfChXAy+DN0qQ4vok4Wlk4upUjtdsKTl9G9n
	rj3FppYoAOKgFQcTPYGt40rqTNw6k7COy2JYDjzPal2i0ZR+7LULoChmMn3GI9EPQPQ5FxXH4Nd
	87mVbR8MeyCozcpY4NA04d5w2dOHtBm3Vgw1CCCHL/HFFymQm23kxaKpD/SM/X17OkTAxSexcbm
	I+YYKzxSpYghJl9RaMySYYl//9VkrV3+NDD5ePh9YtByxZDU2fXbI+87YwALsDdUXVn9Fg8mG4T
	YLXkrzYiHtcWLNSAV82IfDnhn9PigBYFryBaXKxwrEsA/2IIyC3oxPGzzmG+cFAu/2UvvDpgNsz
	nfXwUukzxV80sJiYgfLy0+56PRvhCyNRoMEmVIzp1LmbQQbMTOEKAJwue0lNvr2zp39/2LL54w1
	gjCk5Z5b7atuDL2pxz/oXa9IPH3kMDjIs=
X-Received: by 2002:a05:6820:221e:b0:694:9a0a:6fa9 with SMTP id 006d021491bc7-69c94319189mr185665eaf.26.1778778011810;
        Thu, 14 May 2026 10:00:11 -0700 (PDT)
Received: from [172.17.0.2] ([52.176.138.177])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-69b8cce2817sm1594905eaf.15.2026.05.14.10.00.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 10:00:11 -0700 (PDT)
Message-ID: <6a05ff9b.cad722b2.1885d9.3b7c@mx.google.com>
Date: Thu, 14 May 2026 10:00:11 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5571887068750363845=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, w15303746062@163.com
Subject: RE: [v2] Bluetooth: hci_uart: fix UAF in hci_uart_tty_close()
In-Reply-To: <20260514151722.382161-1-w15303746062@163.com>
References: <20260514151722.382161-1-w15303746062@163.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5571887068750363845==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1094870

---Test result---

Test Summary:
CheckPatch                    FAIL      0.64 seconds
GitLint                       FAIL      0.27 seconds
SubjectPrefix                 PASS      0.10 seconds
BuildKernel                   PASS      26.17 seconds
CheckAllWarning               PASS      28.47 seconds
CheckSparse                   PASS      27.00 seconds
BuildKernel32                 PASS      24.99 seconds
TestRunnerSetup               PASS      556.38 seconds
IncrementalBuild              PASS      24.51 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[v2] Bluetooth: hci_uart: fix UAF in hci_uart_tty_close()
WARNING: Prefer a maximum 75 chars per line (possible unwrapped commit description?)
#85: 
  ODEBUG: free active (active state 0) object: ffff88804024e870 object type: work_struct hint: hci_uart_write_work+0x0/0x940

total: 0 errors, 1 warnings, 21 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/patch/14573255.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[v2] Bluetooth: hci_uart: fix UAF in hci_uart_tty_close()

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
16: B1 Line exceeds max length (124>80): "  ODEBUG: free active (active state 0) object: ffff88804024e870 object type: work_struct hint: hci_uart_write_work+0x0/0x940"
17: B1 Line exceeds max length (86>80): "  WARNING: CPU: 0 PID: 338273 at lib/debugobjects.c:612 debug_print_object+0x1a2/0x2b0"
55: B1 Line exceeds max length (104>80): "- Added explanation for the absence of a standalone reproducer (highly timing-dependent race condition)."


https://github.com/bluez/bluetooth-next/pull/190

---
Regards,
Linux Bluetooth


--===============5571887068750363845==--
