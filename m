Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CFBE2D249E
	for <linux-bluetooth@vger.kernel.org>; Fri, 20 Mar 2026 22:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774044902; cv=none; b=U5LiBkF8813hzNxxCdV47kDQxv7oIXg/er2mec4HtXERw3gPrunSvz8RP3PxyEZ/TMP2L4KXqaVFw7CmE8c13CCEMZJjnkaNX3GWhEm6xse8pM0Aj03LOSE6FvAEVIF1nZefRgHH+EXdxM4dhSFm2Aq1bk1foOG4u8oJILn7tnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774044902; c=relaxed/simple;
	bh=wQzM2gc9DmW9dpcOVyAo+6cCGYybnK469v5twk92r8I=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=boiSB50V+BL/sftGaRT8tPpExZNCa2FOni/+V+Cd+TXudALFcMIBxPjqVDsjlgLTofVyskNL1FMvEAI3p885FETLZnPNnGWVO987CvoFW5tYP61dSDOPhBbgJCwSfe2CEiJqlhuKF5JoHms2Rtd1ScKl597gG2FXPlTfV4YfBXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cFPTDdtM; arc=none smtp.client-ip=74.125.82.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cFPTDdtM"
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-2c0d36f3888so1241013eec.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 20 Mar 2026 15:15:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774044900; x=1774649700; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=wWymKiGSV6OrSJG+vATmmPS9n4KThA6qa3rMX+nuX68=;
        b=cFPTDdtMpoFUdvNZ4PHvc3TloiA+qeyGun7AYP5AFXluZhFqm59PBAgOzmnKizlqm6
         pIxyoG/8whSs94VbBrvXcJkrpuaRwvA03NQQ2gFhjWT7xJyYT8zcQNVU+QFvraQs3i6o
         jxIoc5B3Ag2u9z3rWb6O4jpi26Iq6lBWp3eksEy4N1BcHxtde5HFiw3mBtKBUOShYLTT
         sAClpt5C4A7pYvpu0hWd6/WnfkOrbVLoN7Ae96c3VytvYPXZdzP1oWfCcI0m7y2oZtaE
         YrSvrOI/tgR+1qLHUu/k8yTNIubhK7qNIPatdxmGZzcSuyaMikqnpNnrvV+dRS9TwsHR
         pRIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774044900; x=1774649700;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wWymKiGSV6OrSJG+vATmmPS9n4KThA6qa3rMX+nuX68=;
        b=nnXSgyCRLlYKG3dYl3MyHX+Ikg4HjS6Y7r5+SL2ZguLx4KyzzfEG+1FUEndQ5h56rr
         zf2j+JBGA4T6oNKYL3S6AqF09p/FONf2/OP50x9JMmDtsX+P0n1/NzunykVUuxS9G60M
         V2Fm73K6dJCg2FGK1FgynTV/BvQwjAI9TvfNwTx1YlTtYNkg0ZaD+nptF2HytvjObte7
         fV2TDTl9CXwmpdUrb0r5U9nieHQKcN7J+GInTgULMEyRodvjGGKh1egrPhY9raCmcsL0
         +e6OiM23gNxa1nwkCRArrOCXeD4NEcyk8NKB7X4kKyy66EkO8DbLE9rIWnXUOh3Mp3gv
         pF7w==
X-Gm-Message-State: AOJu0Yyo6Id/a5MRoNsztJXaxaV0IDczQ0/iKgIva8cw3KOrof32ZQiX
	kpcAzb3w3OjfMrwaa7yGNZNbsAdVgDwPdTczX5Db16CaRqiHEFJcXGjswcC/0w==
X-Gm-Gg: ATEYQzyoZQknngLaX5wLCadnygpHM+B01Nlxai3S090u7Y7OcYUdvYYAy3VC40+ju4v
	soAa9Db0YNlGdgTqP0S4F0iSJsdkQeGakyCVnGgx7aVnOezHBbiinVPkOl+AeJocTDQd35j/bOp
	9cR8wCH+NBdYga7VwSaG4WTL0f6smP98BFz2h00K+utVWpS5LS1+FrSFW0jxecjzf3FubCM9J57
	4YPwXEYm+3NgCfkMsnlUtUZx3zWxid8TuGmtEra7qAw5lZCkq7QSK0r6YKKx8jZ7ZETGGJHu8SF
	kuN4FINVwlae4Xq43I9GyzC2sD4iKsHqIhIFG/VBuH+ZUQx+bz152pJBwkAtLqBjnU8HaYXSR2E
	quuZ82uY8Fk6lISHiYAsuALvqy7S+FMj/sGRNK/aUbO1cLj6/a+zCzWpcfqT1JDZ0b0SKBYCS68
	iuinSNXO0Aj9raVpjxQXsXWhzo+L4=
X-Received: by 2002:a05:7300:2382:b0:2ba:6aef:6959 with SMTP id 5a478bee46e88-2c1097c0938mr2111378eec.27.1774044900081;
        Fri, 20 Mar 2026 15:15:00 -0700 (PDT)
Received: from [172.17.0.2] ([13.83.161.21])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c10b17b8f2sm7496498eec.9.2026.03.20.15.14.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2026 15:14:59 -0700 (PDT)
Message-ID: <69bdc6e3.050a0220.272073.e056@mx.google.com>
Date: Fri, 20 Mar 2026 15:14:59 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5788410513243591893=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, pav@iki.fi
Subject: RE: Functional/integration testing
In-Reply-To: <c2a503373330ebcfa8f8a20f8378cfda5d17634c.1774041047.git.pav@iki.fi>
References: <c2a503373330ebcfa8f8a20f8378cfda5d17634c.1774041047.git.pav@iki.fi>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5788410513243591893==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1070106

---Test result---

Test Summary:
CheckPatch                    PENDING   0.50 seconds
GitLint                       PENDING   0.40 seconds
BuildEll                      PASS      20.67 seconds
BluezMake                     PASS      637.64 seconds
MakeCheck                     PASS      18.96 seconds
MakeDistcheck                 FAIL      79.18 seconds
CheckValgrind                 PASS      291.31 seconds
CheckSmatch                   WARNING   351.20 seconds
bluezmakeextell               PASS      180.73 seconds
IncrementalBuild              PENDING   0.44 seconds
ScanBuild                     PASS      988.84 seconds

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
Test: MakeDistcheck - FAIL
Desc: Run Bluez Make Distcheck
Output:

/usr/bin/ld: tools/test-runner.o: in function `start_controller_forward':
/github/workspace/src/src/bluez-5.86/_build/sub/../../tools/test-runner.c:989: undefined reference to `openpty'
collect2: error: ld returned 1 exit status
make[2]: *** [Makefile:6062: tools/test-runner] Error 1
make[2]: *** Waiting for unfinished jobs....
make[1]: *** [Makefile:4148: all] Error 2
make: *** [Makefile:10668: distcheck] Error 1
##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
emulator/btdev.c:480:29: warning: Variable length array is used.
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



https://github.com/bluez/bluez/pull/1979/checks

---
Regards,
Linux Bluetooth


--===============5788410513243591893==--
