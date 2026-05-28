Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2DB53B19A6
	for <linux-bluetooth@vger.kernel.org>; Thu, 28 May 2026 09:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779962126; cv=none; b=Dd8afoj6NPJP8EKu4jBRYG8PYmL+jCzzxkoAAVk/uL2ZgvcTnhemRtcbvpfkfVi7D7BS/oafTa+3HzXcVM1UJUV6rGFh4swaAW0y5JQBpULTxz24dN2EqbaZNerpoujMy0SiF+0oUEUb3sJd+5OYvCuPyrYEE+Xvkyt/riFfd8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779962126; c=relaxed/simple;
	bh=mtjactAJmXoK8u+hc0WsfYrD6tf+rR8OsTy3cfKkhzY=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=CQQG8PqgycpoCqKFe8HLb5X4Qd3ljIKUuNABkBYbMtAfnDxZtu0jDxt2JfU4K/4Zrg8icDSbBUDcp/PSkD8KCQWnMdG6UlxBhaL7itLKGVqf12bn3XuF7jKoT5LxgY+yw/zHfB1ei6qOSwEGK72XJP/1f5zEE+ltOJGjCFeVo34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ntKt1O33; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ntKt1O33"
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-8cc9f97a124so58536026d6.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 28 May 2026 02:55:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779962123; x=1780566923; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=30IfwEJA+yDaEBRgEBo04Z7qG+LmfH7VyDJexW+yhd0=;
        b=ntKt1O33K3r5XnqVyJUCIfAAt9w+A1W9GV1vtlc2MmFANm22DL7Rvp39YfBv1uZquq
         PgWp4nyxPaP/ydA6VAB//x4Qvr7+kdymbLFuA6XSv101dwh7zQLQPW2u04t6JrjAt2d5
         h8Oc5tlEP2ORWjUdNSMG95QCSyxg01qIXLMjPu99tp5pG3EXdKvQz2RnB3ctpIe5LIWh
         7yyd8zDBe16Lnmxa3isp7drHM69rqtg51BtPr5xsQ5CzD5UfYVh7L3XezMRL/riv1mUJ
         ZNbe382GtOqtKAImhOUZtPi9to4Ql/o1It5Rkq5tb5QAcqRd/N/TntiK/lIWNhwQoFkW
         LRPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779962123; x=1780566923;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=30IfwEJA+yDaEBRgEBo04Z7qG+LmfH7VyDJexW+yhd0=;
        b=K4iTLqQBnx5b9lAfqoTvnRV58Fw2rxAf3PupekF9xmM9ZCnfUi0H2q0QnaL/C/xyLS
         q7M5rFveN1tmsADnlMhccRGAf2zA4YvpARV/0Nl3gZUi3VyiXq0oFtm3dgKRFBFurrgc
         c41lL1wuiQsvqQv3rlqb1qDqDvg8uaqmq+ghCG58pqaaNuYBegb8pjp65RzUnwXGx/gw
         rIDkzxxEV5fccirDYLJ7DfTNl3gBGq5Tdd9grawMeaOgPN7Ry3AYKMQanzh0K79hhBSH
         gxZOVtAaArAh7AM1LLrlajdav9+Pkc+uwJraH62S7w7Qq9/rVYRVap0Y0WuLi4MygthP
         oHZw==
X-Gm-Message-State: AOJu0Yz4Oa0LZmkOx1Rc7ITF+uGVlY08abXr2eo4fmqFolHIa+tuWo30
	SmsiV+dny8kh86/C1hrf1C8mdOfrzDdwX2OXmnAYSMJzdl47bsX4hLh6tgu27g==
X-Gm-Gg: Acq92OFmPCoNv/jMhtwPI1oAp0l3gXnR2IgJ2fiTTZLGi4WZd1Fb5u7bIQka9X8Y5jm
	NIAMGZen94qkoHdg2f6HN1M83O7odrxu6xctyPWN7Nr7tbB7RCfmvdNcbJBjlV0NCIHK8xBMSeH
	CwLUCBUhvlrdJe3AffvfDBoxr/3b8hMjngNbm0V2Jr4TPjoO+LLsGvd1wICUo2qQ8kUW8gS2vAW
	yBOUW5dzhkou2cEqQBMr1JhnHPcqa8KGj6wXPl6vI0wvm4fxnE8qtd4MRnFLzwD7bOWJXEUBuhd
	pLLejwILisAuYILYQkYrYfSejS1r4KQSZW4HBzJgP2+3tB/gSiltWcf54Wc5KlC9Lqy4XgdeETt
	zE0ZTEyiF+bwuLVNKVMymafUIDpbuw8iOxgoN99F6DIY+sBK/UkNnyYeTv4Qi0vPRu/0IuDnIJi
	k3WLKfTooXjQpf3uA5nGHwuUk7ZjMjPkM4wpU6/sMcPy0=
X-Received: by 2002:a05:6214:53c4:b0:8cb:e81b:576f with SMTP id 6a1803df08f44-8cc7b584477mr421456096d6.5.1779962123478;
        Thu, 28 May 2026 02:55:23 -0700 (PDT)
Received: from [172.17.0.2] ([172.171.254.156])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8cc80ffca70sm195195836d6.22.2026.05.28.02.55.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2026 02:55:23 -0700 (PDT)
Message-ID: <6a18110b.9d661370.4410b.521f@mx.google.com>
Date: Thu, 28 May 2026 02:55:23 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8984715560194979546=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, frederic.danis@collabora.com
Subject: RE: [BlueZ] mgmt: Remove mgmt_ev[] strings of undefined MGMT events
In-Reply-To: <20260528074938.385847-1-frederic.danis@collabora.com>
References: <20260528074938.385847-1-frederic.danis@collabora.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8984715560194979546==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1102048

---Test result---

Test Summary:
CheckPatch                    PASS      0.47 seconds
GitLint                       PASS      0.34 seconds
BuildEll                      PASS      20.18 seconds
BluezMake                     PASS      623.08 seconds
MakeCheck                     PASS      0.98 seconds
MakeDistcheck                 PASS      241.62 seconds
CheckValgrind                 PASS      207.90 seconds
CheckSmatch                   PASS      327.54 seconds
bluezmakeextell               PASS      165.12 seconds
IncrementalBuild              PASS      615.69 seconds
ScanBuild                     PASS      947.64 seconds



https://github.com/bluez/bluez/pull/2158

---
Regards,
Linux Bluetooth


--===============8984715560194979546==--
