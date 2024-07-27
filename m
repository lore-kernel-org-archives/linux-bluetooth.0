Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB13E26AD0
	for <linux-bluetooth@vger.kernel.org>; Sat, 27 Jul 2024 08:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722069419; cv=none; b=owhjLmJ3j2u6Xxed7oYccpSpDjNUmbIMjhWhU21CdbLQRe6AncGbzZ+Fl8XxWOqTbrVwOyDxQUR8I+1ubC9EDQ+Td71c3tTUxGsYzmn38fg7yuRrugCPubqgJAndcQL3Qc8dNaxsC1YdDwbCF4pGXf7flsns+Aiz/NSlMErxm7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722069419; c=relaxed/simple;
	bh=r/95UVBmataYhslJUlcSDGQcbNgq9K+sYaGwy0cBMR4=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=V/HXAKk8+w9idZSq+MOQZ4Oe2/KYnxIqy43LGvjPiETS8LQYaO5mgPGJPQ4ZII3HdYHfds0JT9w+lcgioxpOY0oppjZc4eS8O8SvkUg0VheG/P4P9gzlLBpdNAQj0s43ex2uCt6GlW5HeVoPScJl+96W8lROkuJmJxnvgOzbWB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZRhnL6oR; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZRhnL6oR"
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-6b7a3773a95so8212946d6.2
        for <linux-bluetooth@vger.kernel.org>; Sat, 27 Jul 2024 01:36:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722069416; x=1722674216; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=+6z4/LUqND0qHSJE3MXZPcjxqozyOF0aWFGMlXaPrk0=;
        b=ZRhnL6oRMgHeryXMigDbt6VKlrx3gVUeOqbIvFdnME5bPQmfuclfA1upLChMLqQTJE
         xBjnYse1H5uJQk/SrJdKII0WykpN5/pjXVIpLnD1461hYr0zSoTQ0DKMa22JI6Mqtn66
         S+VBNKNJfFrzmwoawnF2lfTd/Ncdv6JlP6x3or13kPxQ/B7EUL/CJn2b2u9G5JkK1FLS
         Mb9QstntaO4Mmkm1RNESBVTp/0uQQ7eAUGuI3/6cqEUIoeLHVjbFb0dpvxYhztxKjIxm
         QBBpQOeWf/+14zKa25eWtn1KNIe1P/GHOWenTuBxrqHv1K6lkqy9P9NqvjOJRP/MeL1F
         Rhsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722069416; x=1722674216;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+6z4/LUqND0qHSJE3MXZPcjxqozyOF0aWFGMlXaPrk0=;
        b=KUBnXhVQQzDU/Wc1F9mIshYMN//TT+XBA03OMVMTiOblRBYY0thT4M+DRDDEZ3Ymut
         ipF/jYIkM5UomiG9msPkBLcN18AmqMg0/3lS4RlAWh+rB/qhkPS8XtTgPHZbKN6vBMIO
         D3ow879KVEp+6Oyi0K0iibNVypZ8lL8xF7lHqoayqcUSF/h6LtCZ8/hD+pOvcNkQHL9j
         6QIo/Bv+gFIKM5Gu/kX91IXuhTU+fWDpM8myNaeBwiI9sL22LiNtZX5z7Ixsnqq3FnFY
         2sUzzwvhvnyDrz+5DKJCuO/+e7FJsOm6XvJe+Cz6v8pZLPCjb26tt85Odcee78UCW69A
         sloA==
X-Gm-Message-State: AOJu0YxC0a8gYj/lMhDvFq+4Wd0UBj3ndD5C0BG0023i55PthmQhwWKJ
	as8e+yzc4A1Kv9O9krNP/v9uMMqt/knvMvY0y64M7ENWBd9fsgpzloxlfw==
X-Google-Smtp-Source: AGHT+IHo6khoxbVrwLPJE8HV06F4sqAjcQzc8NKR7jVAZSEpRE9Ge94+fdU5JYl+EBv/DYieaQhvRg==
X-Received: by 2002:a05:6214:1c43:b0:6b0:71c0:cbaa with SMTP id 6a1803df08f44-6bb55a658dfmr26240156d6.33.1722069416151;
        Sat, 27 Jul 2024 01:36:56 -0700 (PDT)
Received: from [172.17.0.2] ([172.190.111.148])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bb3f8f77b8sm26023116d6.42.2024.07.27.01.36.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Jul 2024 01:36:55 -0700 (PDT)
Message-ID: <66a4b1a7.050a0220.12c792.8f9e@mx.google.com>
Date: Sat, 27 Jul 2024 01:36:55 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8836264317829040410=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, penguin-kernel@I-love.SAKURA.ne.jp
Subject: RE: Bluetooth: L2CAP: Fix missing unlock in l2cap_conless_channel
In-Reply-To: <7f815a56-34bd-4aea-9072-312cfdd0d80a@I-love.SAKURA.ne.jp>
References: <7f815a56-34bd-4aea-9072-312cfdd0d80a@I-love.SAKURA.ne.jp>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8836264317829040410==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=874220

---Test result---

Test Summary:
CheckPatch                    PASS      3.28 seconds
GitLint                       PASS      0.61 seconds
SubjectPrefix                 PASS      0.26 seconds
BuildKernel                   PASS      30.30 seconds
CheckAllWarning               PASS      32.67 seconds
CheckSparse                   PASS      42.00 seconds
CheckSmatch                   PASS      104.04 seconds
BuildKernel32                 PASS      29.17 seconds
TestRunnerSetup               PASS      533.89 seconds
TestRunner_l2cap-tester       PASS      22.18 seconds
TestRunner_iso-tester         PASS      35.03 seconds
TestRunner_bnep-tester        PASS      4.90 seconds
TestRunner_mgmt-tester        FAIL      116.36 seconds
TestRunner_rfcomm-tester      PASS      7.61 seconds
TestRunner_sco-tester         PASS      15.08 seconds
TestRunner_ioctl-tester       PASS      7.99 seconds
TestRunner_mesh-tester        PASS      5.99 seconds
TestRunner_smp-tester         PASS      6.97 seconds
TestRunner_userchan-tester    PASS      5.16 seconds
IncrementalBuild              PASS      29.91 seconds

Details
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 492, Passed: 489 (99.4%), Failed: 1, Not Run: 2

Failed Test Cases
LL Privacy - Add Device 7 (AL is full)               Failed       0.202 seconds


---
Regards,
Linux Bluetooth


--===============8836264317829040410==--
