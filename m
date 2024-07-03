Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57DDA18133A
	for <linux-bluetooth@vger.kernel.org>; Wed,  3 Jul 2024 15:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720019599; cv=none; b=RuhloczVu/FErPQh4d2QXRCM0TRA1eNrErASpAohCOe8NCx55u8gVnBaXofZpC+YeNXHyWL76AdktPLFntXn9LWpx6crAVwS1LPGLnRaQiNvne/Mqax1omu2XZqk2fa6LIR3koL1rESpQ4CV1nI1Rta1Fix0Ysuksui9YpjdEq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720019599; c=relaxed/simple;
	bh=FrzXLa+cyGRqjUc4LheCxDlfMkaLwJdUSvEieqmVKXU=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=l8LugVXXpiyg93SXSF5CAxTb1Vh0usvgXK4TiTJLFd8VGUP6qhD4bRv7YGaljE3xzIXsCDVRCyW2+hiCw3esZuSx+6AN25KYcP8uXceaZOdpQkDQnzeggBd97FlZD4uvUwvci0Ty1uZtw5u0+Z8x2zQmt+FixhZwPKSNOT8qiMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XPlkR/m/; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XPlkR/m/"
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-6b2c6291038so6761856d6.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 03 Jul 2024 08:13:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720019597; x=1720624397; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ayW9rtPDVw1hdzzW/hpfCkNArnmw6CrKCKMp2xtre+E=;
        b=XPlkR/m/I3OCUBQ6OedNaaOxt8u5UdbzTJQpxa9hmF7Ay8RCh/291K5gnAFu2zGigO
         iQoyRfET567gu5Za9WSyaEjVDys6X9SF4Wdv5Lc49NPsN1AcHXwjswNqREKopyvhvI8K
         5z4883cDCZQ55uA1jZIW+SP0pDjQmsA/tabfzpG0xDNbglOEqiqfCxAGF7B505260qt0
         XZg9sI5Av3KjCCOb0Yw5jMsAYpLln2WsXhrNWV7CVtFPA/fxm3heO9A9i4ltOqdWVuwE
         EUcg1tvVmGn8etnE9uAbU5TO4WecLZYDKhYmRrp/Xca2lfwR6UPx/mNqEyhNDVDYdI0W
         GmvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720019597; x=1720624397;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ayW9rtPDVw1hdzzW/hpfCkNArnmw6CrKCKMp2xtre+E=;
        b=F1FNwC9rXv9tpLMZE6/EdJCvuvzltXBg5/gfezZiNrj4kn1qCmDWQxAXD0UVbwHAPT
         mmJbuXO8nhW0dW5awYplvb3SG53boU5oye/0LICEdghW2Qoa9IcPrTAs6ldHm7FPY533
         nk+sQyUE8ZuU4fiiTLIi9hwv5qYJeJ/6lErNgkmo5XiB5BlzvlvmBLCd1LXMWGQ3noPh
         qf0vN1wCEbx4uVLUPpUKzwO5YOSZ7/g8a1iGPgLt0czH8HmP6zHKJMdYGS27kJDbL5hC
         pT/AikEgFIWGm3W/6cEAWtXaKI9JHD6JHd3NHd6JZpXyAuobnb8PhkFKupnxwvVG7ABe
         cglA==
X-Gm-Message-State: AOJu0YxpZ5TMRK0VcLjRqKrAqj25p0ZiQW4uW52hkk1wtrkf0SI9CcTv
	I0hk5yf+2zTeMjPWY+lfAE6UR8wbQ6kdrFBSSLQV+rjSOcpVd/MAFl+D1g==
X-Google-Smtp-Source: AGHT+IEbC9DHK8p+HxHwzx8bEs6I5W1Gn/Yfb+ffeXHCEzS4kB/537HxOhKDG2yTOcgRa76RpWbSFA==
X-Received: by 2002:ad4:5bca:0:b0:6b5:1d2f:1d3 with SMTP id 6a1803df08f44-6b5e15c83damr26643266d6.0.1720019597132;
        Wed, 03 Jul 2024 08:13:17 -0700 (PDT)
Received: from [172.17.0.2] ([172.183.51.113])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-79d890e99d4sm357077385a.43.2024.07.03.08.13.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jul 2024 08:13:16 -0700 (PDT)
Message-ID: <66856a8c.050a0220.192f5.dbd7@mx.google.com>
Date: Wed, 03 Jul 2024 08:13:16 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3178826404490895021=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, r.smirnov@omp.ru
Subject: RE: fix errors found by SVACE static analyzer
In-Reply-To: <20240703123745.56443-2-r.smirnov@omp.ru>
References: <20240703123745.56443-2-r.smirnov@omp.ru>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3178826404490895021==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=868017

---Test result---

Test Summary:
CheckPatch                    PASS      1.14 seconds
GitLint                       FAIL      1.02 seconds
BuildEll                      PASS      24.29 seconds
BluezMake                     PASS      1691.79 seconds
MakeCheck                     PASS      12.83 seconds
MakeDistcheck                 PASS      178.29 seconds
CheckValgrind                 PASS      254.24 seconds
CheckSmatch                   PASS      355.19 seconds
bluezmakeextell               PASS      123.81 seconds
IncrementalBuild              PASS      4661.28 seconds
ScanBuild                     WARNING   1010.11 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[BlueZ,v1,2/3] client/player: fix wrong argument order in cmd_register_endpoint()

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
1: T1 Title exceeds max length (81>80): "[BlueZ,v1,2/3] client/player: fix wrong argument order in cmd_register_endpoint()"
##############################
Test: ScanBuild - WARNING
Desc: Run Scan Build
Output:
src/shared/gatt-client.c:451:21: warning: Use of memory after it is freed
        gatt_db_unregister(op->client->db, op->db_id);
                           ^~~~~~~~~~
src/shared/gatt-client.c:696:2: warning: Use of memory after it is freed
        discovery_op_complete(op, false, att_ecode);
        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
src/shared/gatt-client.c:996:2: warning: Use of memory after it is freed
        discovery_op_complete(op, success, att_ecode);
        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
src/shared/gatt-client.c:1102:2: warning: Use of memory after it is freed
        discovery_op_complete(op, success, att_ecode);
        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
src/shared/gatt-client.c:1296:2: warning: Use of memory after it is freed
        discovery_op_complete(op, success, att_ecode);
        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
src/shared/gatt-client.c:1361:2: warning: Use of memory after it is freed
        discovery_op_complete(op, success, att_ecode);
        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
src/shared/gatt-client.c:1636:6: warning: Use of memory after it is freed
        if (read_db_hash(op)) {
            ^~~~~~~~~~~~~~~~
src/shared/gatt-client.c:1641:2: warning: Use of memory after it is freed
        discover_all(op);
        ^~~~~~~~~~~~~~~~
src/shared/gatt-client.c:2145:6: warning: Use of memory after it is freed
        if (read_db_hash(op)) {
            ^~~~~~~~~~~~~~~~
src/shared/gatt-client.c:2153:8: warning: Use of memory after it is freed
                                                        discovery_op_ref(op),
                                                        ^~~~~~~~~~~~~~~~~~~~
src/shared/gatt-client.c:3242:2: warning: Use of memory after it is freed
        complete_write_long_op(req, success, 0, false);
        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
src/shared/gatt-client.c:3264:2: warning: Use of memory after it is freed
        request_unref(req);
        ^~~~~~~~~~~~~~~~~~
12 warnings generated.



---
Regards,
Linux Bluetooth


--===============3178826404490895021==--
