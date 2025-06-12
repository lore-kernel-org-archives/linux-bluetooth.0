Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 938742222CA
	for <linux-bluetooth@vger.kernel.org>; Thu, 12 Jun 2025 07:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749715086; cv=none; b=LUytz4MPlOX7cLUc7BTEm0TELJwPDXnf43HKMMlu5DwSdXqc5IfWXesWhvlXGTy2qgXj4OFuB9HPBMG4hhu0UJDh12imYLPw7h9unBHAuJo99rU3MaYki4GBAXU5HzEYgu5o1kbQ7boER7+jK1k5bXO6dbYAYiBrCR6qPc/qFTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749715086; c=relaxed/simple;
	bh=lm4m62htmQGylXuYlNgMT3m+8BxQpFj8pZFU8jClyDs=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=bTxjtV43+4ywYP4ymvwNasrYwwEDqcIkjJ8hNvIylZaG7FAb/jqsQPb6mjhw5tCUjwKyGKqUC5DpqAw6v0w1TAYVJVwu5rG/7VptUzkeokIKobSFRia0vleHwYq6PhbFBGZnJ8nmUdXHsUMe9iAEhTFBYnmiDzU95Q9xmPvY1FM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=POlWwI/U; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="POlWwI/U"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-4772f48f516so18445551cf.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 12 Jun 2025 00:58:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749715083; x=1750319883; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Y5YBvqQDz22M2l5ryxNQ7I7KKugp4619hoOUwIjZsLE=;
        b=POlWwI/Uv8XXCxNXG3gZzvsQAp1v/fte0IW53saS7cJzM8dodz7C2oDhncV4LZll5s
         pmNsnydeDkn9CbsKuDRYkYGp/t7HRtkxLW8fpTZJN/QVfCuxCNEz289jFUitmt3SJPzf
         s33Q7+DV7eNSfjr/7EEZeSpc6PG9A7tk1B538e9nhA5gbY39RhiIqNImZ1cAqljYDLBJ
         D9NUdOOF69Wj4vqPnVNcW1DmNYC9EedIf37JmJbxeOohZFaYnG/xADF5TT5L0kiRP6D5
         3op/LNmHlG3xv/MqPUKF90avEK9FyHRUQXy/P2TOpdEKTZC42vOpdiTmjceNToW2xmAL
         FA9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749715083; x=1750319883;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y5YBvqQDz22M2l5ryxNQ7I7KKugp4619hoOUwIjZsLE=;
        b=Wnv+HmDH/B2F5JQq18QsLMQKjaNYIWuFyo3giNf1M+VTXJ5D4LQX5Czq4w+3OvB8PM
         P7iHA0PH7uiN3tcala0N7qB0a4MDtKNEbVuJX5mJfdG1i/mWA8xQS0VMFjqo9uSVBDYq
         YFHZDpKERJiB96fDIVMtFIZJPrIf2krwk4/IUpShqC9obZMkwB6FbSRqr94pXshqFMRv
         G6xi1PZXr7BQgjpyrCr3qM+e4/OPhWkqvHC6DzBp2eXv/ZQlT956unEIGNMUOBXCsp0G
         MZH9icx+Lj0/j2K6oI6RDCpFCessAMZzlNHzaOa4dOkANDsSK5GcgBL18z98Swt9+gdA
         nCzQ==
X-Gm-Message-State: AOJu0YzycORViMPdyHC2fzoe+unz6WHY9GRKon091d1LBlTbaexIDYEH
	r0wW8hqpEmwGwLcHVLX0g1QzsQz7Q5EYCfeX0QDKiafSmyx8u3yQN1wgeW+CGQ==
X-Gm-Gg: ASbGncs7xWK+urbQGZ8mRkkVizZDGsb08otVnjTlX8iA9zNoBRaEUhVVFSvNcR4InHN
	Qu0wGaqET8ly8xRSSzCzggxjNX/CWAjrZs2HWHWpQ26rU10cQrZ+AzLHbcg68bX2EoO3LBfAodE
	0noYCfpK+SQ1bEoPUKrgk1oL2jn2JI53zeqHmp4nK+WS2xC8j0W0pDIT6q+fkFEW11iLx2gP41t
	hlzJUtOykBD5nAP69lgFIBQrk0r2OAJw35I8AlXjghEpimpGlPFXA5H4BME5lTDu+AhYt6xGvz3
	d0bpHUFJvlRA9JgOm+vxnFLwK7pJWUpC9k+jRhhCivm2ngcjpBpuEYBXvtrg9ystEp/IbtEZLw/
	myDc=
X-Google-Smtp-Source: AGHT+IEQnxFkFQ0HNHwjoU2pZH5Ljm90eaG6War3kN4CO1sX1+9ZRvFckOj17/PYgnYKg23sUKdwPg==
X-Received: by 2002:a05:622a:1c18:b0:4a4:31e0:c824 with SMTP id d75a77b69052e-4a7235c3b19mr36734581cf.19.1749715083209;
        Thu, 12 Jun 2025 00:58:03 -0700 (PDT)
Received: from [172.17.0.2] ([20.109.62.130])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4a72a5201c7sm1355601cf.77.2025.06.12.00.58.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jun 2025 00:58:02 -0700 (PDT)
Message-ID: <684a888a.050a0220.1f42ca.0255@mx.google.com>
Date: Thu, 12 Jun 2025 00:58:02 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2218027225819548739=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, ot_zhangchao.zhang@mediatek.com
Subject: RE: [v2] Bluetooth: mediatek: add gpio pin to reset bt
In-Reply-To: <20250612072230.12537-1-ot_zhangchao.zhang@mediatek.com>
References: <20250612072230.12537-1-ot_zhangchao.zhang@mediatek.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2218027225819548739==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=971187

---Test result---

Test Summary:
CheckPatch                    PENDING   0.23 seconds
GitLint                       PENDING   0.19 seconds
SubjectPrefix                 PASS      0.12 seconds
BuildKernel                   PASS      26.20 seconds
CheckAllWarning               PASS      27.87 seconds
CheckSparse                   PASS      31.47 seconds
BuildKernel32                 PASS      25.07 seconds
TestRunnerSetup               PASS      474.83 seconds
TestRunner_l2cap-tester       PASS      25.41 seconds
TestRunner_iso-tester         FAIL      7.90 seconds
TestRunner_bnep-tester        PASS      6.04 seconds
TestRunner_mgmt-tester        FAIL      135.58 seconds
TestRunner_rfcomm-tester      PASS      9.31 seconds
TestRunner_sco-tester         PASS      14.85 seconds
TestRunner_ioctl-tester       PASS      10.02 seconds
TestRunner_mesh-tester        PASS      7.36 seconds
TestRunner_smp-tester         PASS      8.54 seconds
TestRunner_userchan-tester    PASS      6.12 seconds
IncrementalBuild              PENDING   0.85 seconds

Details
##############################
Test: CheckPatch - PENDING
Desc: Run checkpatch.pl script
Output:

##############################
Test: GitLint - PENDING
Desc: Run gitlint
Output:

##############################
Test: TestRunner_iso-tester - FAIL
Desc: Run iso-tester with test-runner
Output:
No test result found
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 490, Passed: 485 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
LL Privacy - Set Flags 3 (2 Devices to RL)           Failed       0.200 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============2218027225819548739==--
