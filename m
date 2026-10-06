Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E57B49DBA9
	for <linux-bluetooth@vger.kernel.org>; Tue,  6 Oct 2026 15:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791300683; cv=none; b=FA+jGhnrOhKHU/SPwHDkj++627MP3QmFKd4iSDJJwjcRBBdbAbldXYbCATP1z9VsAvXJrU4ZFGTGS0kZqq259cur+ye8H9+Ys7nQQb4KWZaXBD+Lfns6WWJ/AVu5/OZhNJ7JWYEkYDe08g1f8MOwUD4tcpp7HAWT/jI8hTphLh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791300683; c=relaxed/simple;
	bh=u6eDnCgM3Fww1ZZYo3aNEbwWf94Ns8GsW+yQDUGKpIY=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=MBht3uvXGOpIzjH7P2+h9jUKfcVKtpPWVHaSBMNXY1BOjjexUaZRwPz8Khb3aOUaH413gb/ThFxCJklot7ZIW6jlnXuAfYeBglLjvEvq9wyNJ12eWY9nQOdV0OKj+oS2lE+G73Pkzl5FGWS+ksQqyNDo4wz41OELPn4UwByiSNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=StSOMApg; arc=none smtp.client-ip=74.125.82.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="StSOMApg"
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-30b6dad2382so1683198eec.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 06 Oct 2026 08:31:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791300680; x=1791905480; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=5vq8bIyd7r2jaGHTa07BHtIGmCNCcxg9uCN6N3HV1l8=;
        b=StSOMApgUN3jmwRXdaBTeYQuGI0oTGUZkBz6YrxfcKSMS3orDgX1rM70UhlJOGN+Of
         P+e5ii4ZyB7/5Db0qyTXFAFhEq8U+TK1jQAZ8dOFCGAXSXEbf4CzDrV5ER6JfsebTVz8
         961DmYaDXsCKlnRiu3pIrLQOiB5uQr9T9V3NS11fjviZIDsUdOiQNzjjLDaRWYpmKxRe
         tBYkp3x1Tkb37L2iRrcYNdmdkLmFsq4NTGxmUtvTHzBkdil4h+giZDOYM5Wu4h3Z6hM8
         iVTCB3tC2w2F7SUpteMS7cGiBaHxg6VeUVEKIFfl/Av+v0l2/94HtSqpg2C+aTHq933x
         N7+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791300680; x=1791905480;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=5vq8bIyd7r2jaGHTa07BHtIGmCNCcxg9uCN6N3HV1l8=;
        b=V8QieGX581auzWwjXxpR9oYV4i9DA7Trs8QEyXghfzR0+NsFLnlSj96oNo28ytkJ1Z
         cWzcLJrKha9GURGVp9LLzjP5g0CLTzLpef3x2HWIY4Y5bATsYVjOWl1HU2KiZOkgBu3k
         zL9yn/ooZLZA6hqdGwaoJJUC94ulaUbFgVYcR4uClN9vcO2OGgduSu7+8318ixenjnAx
         +AsdxnixnjBPnCp4Eyc3aQTbzderk6/LazHt7P84qHXQnBuRaiuALfsMe4xiPBx1TMUt
         dJwS3pOb1iyCYF3fqwADf/A2kSQT0yiqDY92vyiXOzI0cb9IHG9TVP+WFLxZ5U2DMkYu
         QQMw==
X-Gm-Message-State: AFuF++kUSNOcJjtlY6xj3HTbxzKIYw4KNonmCelPk2A1ikCThpOQ1dJy
	ovaE3AOLLajN+kjxlpfcBAW/HkoOlUh+/K/2PAmuIpDl18s9/1qLS3PEiC18cQ+3dd8=
X-Gm-Gg: AYBFou1bd+7yhHjXhoaOIg4HSQLVetZ72+uNpKen6nCBkXYUm3/po+fFyWuQIeSigCf
	sEQ87GV136fZtHgBc+ZelP6EMMk4EfeEGvuJ7uuQqXmeR6+PYh+HP2Qare4JSpM7NGO1uk/M4FU
	g/h00ZTNGR1ke0b0XlCeTNBHLddikkw38L3Zxiwe+EsRE6OId/ClXdWA/paa6njD3uC8+WxEEpq
	mrCjnuqR73LtxcPU89wmtF32uAUJ5e92yL4c8BuuDFcufjrbH3hg8yXpGOpZZUM7aEtdDNmV57B
	zaJ5OnVT7faEqD1TwDGcnjMjKvhJHTASdkgbdO1xcaMJWx2S3VptHFX6CntcssnMns1NaZLLF83
	EDSgDOW5kEHuOOZGNzjhnCt1xtfKsaTLvobSBtKnDADFCouEcRE5v97+JrLm/oKhRHJmheEsxzu
	Ii5nZ6hO4wBYEPaqYmzGfc2zmffqDDJCFyQDWecPjoplvPO6LY0O11tsShfEVbH4j5M+1iEKYp5
	vpJvKbmwNKR
X-Received: by 2002:a05:701b:21c7:b0:147:a685:9125 with SMTP id a92af1059eb24-15ebfc0fef1mr2038735c88.2.1791300680086;
        Tue, 06 Oct 2026 08:31:20 -0700 (PDT)
Received: from [172.17.0.2] ([20.172.6.70])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-16101e555acsm96623c88.5.2026.10.06.08.31.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2026 08:31:19 -0700 (PDT)
Message-ID: <6ac51447.c02443da.c755a.558c@mx.google.com>
Date: Tue, 06 Oct 2026 08:31:19 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4289874628491393643=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, zzzccc427@gmail.com
Subject: RE: Bluetooth: msft: Lock failed probe cleanup against feature readers
In-Reply-To: <pm-bluetooth-objects-candidate-0233-v3-004a766561f1356a1b14@gmail.com>
References: <pm-bluetooth-objects-candidate-0233-v3-004a766561f1356a1b14@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4289874628491393643==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1180370/

---Test result---

Test Summary:
CheckPatch                    PASS      0.69 seconds
VerifyFixes                   PASS      0.09 seconds
VerifySignedoff               PASS      0.17 seconds
GitLint                       FAIL      0.26 seconds
SubjectPrefix                 PASS      0.09 seconds
BuildKernel                   PASS      32.19 seconds
CheckAllWarning               PASS      33.73 seconds
CheckSparse                   PASS      36.83 seconds
BuildKernel32                 PASS      29.44 seconds
CheckKernelLLVM               PASS      34.96 seconds
TestRunnerSetup               PASS      831.76 seconds
TestRunner_l2cap-tester       PASS      12.72 seconds
TestRunner_iso-tester         PASS      15.67 seconds
TestRunner_bnep-tester        PASS      3.09 seconds
TestRunner_mgmt-tester        PASS      61.35 seconds
TestRunner_rfcomm-tester      PASS      4.42 seconds
TestRunner_sco-tester         PASS      5.58 seconds
TestRunner_ioctl-tester       PASS      4.64 seconds
TestRunner_mesh-tester        PASS      5.50 seconds
TestRunner_smp-tester         PASS      4.29 seconds
TestRunner_userchan-tester    PASS      3.17 seconds
TestRunner_6lowpan-tester     PASS      4.40 seconds
IncrementalBuild              PASS      32.64 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
Bluetooth: msft: Lock failed probe cleanup against feature readers

39: B2 Line has trailing whitespace: "    "
40: B2 Line has trailing whitespace: "        CPU: 2 UID: 0 PID: 532 Comm: mgmt-read-adv-m Not tainted "
41: B2 Line has trailing whitespace: "    7.2.0-rc6-pmb-bt-functional-v1+ #1 PREEMPT(lazy) "
42: B2 Line has trailing whitespace: "        Hardware name: QEMU Ubuntu 24.04 PC v2 (i440FX + PIIX, arch_caps "
82: B2 Line has trailing whitespace: "        Code: 48 89 fa 4c 89 df e8 58 b3 00 00 8b 93 08 03 00 00 59 5e 48 "
83: B2 Line has trailing whitespace: "    83 f8 fc 74 1a 5b c3 0f 1f 84 00 00 00 00 00 48 8b 44 24 10 0f 05 <5b> "
92: B2 Line has trailing whitespace: "    "
106: B2 Line has trailing whitespace: "    "
123: B2 Line has trailing whitespace: "    "
128: B2 Line has trailing whitespace: "    "
130: B2 Line has trailing whitespace: "        page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 "
135: B2 Line has trailing whitespace: "        raw: 0200000000000040 ffff888100042b40 dead000000000100 "
137: B2 Line has trailing whitespace: "        raw: 0000000000000000 0000000000100010 00000000f5000000 "
139: B2 Line has trailing whitespace: "        head: 0200000000000040 ffff888100042b40 dead000000000100 "
141: B2 Line has trailing whitespace: "        head: 0000000000000000 0000000000100010 00000000f5000000 "
143: B2 Line has trailing whitespace: "        head: 0200000000000001 ffffffffffffff81 00000000ffffffff "
145: B2 Line has trailing whitespace: "        head: 0000000000000000 0000000000000000 00000000ffffffff "
148: B2 Line has trailing whitespace: "    "


https://github.com/bluez/bluetooth-next/pull/871

---
Regards,
Linux Bluetooth


--===============4289874628491393643==--
