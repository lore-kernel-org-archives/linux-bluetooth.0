Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 455585F876
	for <linux-bluetooth@vger.kernel.org>; Wed, 10 Jul 2024 15:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720624574; cv=none; b=SnzxguXFzL7bGHdOJd/z5vq3mmui72J5b0K2TM7gQy6PEXPSOaMUgW0A5PGyzfQ7QprGXZJqV6Qruqw1agMfrWlbtPx6X9/3My4bM2aUv2EZYBn/0+mgG9d9dueR1IPuX3mr42rO75HaViHkLOWRwfBASVpngpXdZm23SQWPxgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720624574; c=relaxed/simple;
	bh=ZM15VDbAavtcUXHPShbQ/WbwhGYtLw7Yoh8ITowPWws=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=r8sCHglf5b013jH1vYmxfBRT4cpzl9pTUDkvPQOotfM/tN2tkWQtJC+zXNWzehRaPTS1K6dc07NVaHkVn5ME8Q3aehW8m+x+IP6vgIYKTl+Fdh1PpZlJFTrlc32UiE9kYeSgycjGt633Ww3jzc7BuFUagTq4bDzl46gnb/TJzLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gh46zZbE; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gh46zZbE"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1fbc0a1494dso11980525ad.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 10 Jul 2024 08:16:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720624572; x=1721229372; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=KRvL1GA7ov0xHuCOlpMg90Bbd8WXL7DZ4FZAULQalx8=;
        b=Gh46zZbEey8KymDR2+byWZmxTwgS2AIqx0fGUfn7rKVs9U+fRrYoFvld2JWjwm04/u
         VgFabu0lQa8QlBQOUxUcpTPFSVfSvQ+vcbJVe8u53rGHlEGeF2mou7GWPO4iT7D++a1x
         xKQ6/px6Rjh1CVn+m/rB1zyRu8KbF79PYxQOqfG4ZFDF+vAfroJ1ZXN3mK0JbyNzUr4m
         UydEU+aLrosMI9NCA9tW4WWPyCTVmh+hV6lX/ki95yfpJhX1ioUqVlF1L2kBRLF3pIBz
         2g49uwsDCrsXDZ8YW1eqV9jQgSi9dkO0cdaVINPBbref5T06OgGoAkql4S5cd4Z6sEbB
         o99A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720624572; x=1721229372;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KRvL1GA7ov0xHuCOlpMg90Bbd8WXL7DZ4FZAULQalx8=;
        b=Swln4I1TejoRPR65/gLYcCFl8Hp31LGMcTp3I+HrNj9OCoFfmmbAlb9b/lCNSmPby1
         Q0NBttPY4udfpxwQ5+gfiXxtP6QYsZFa/JJeMFCWmr+GvxpxDxLKAA1oNPXwe6UUpceI
         iAv6ZnSZvZxAB/SN/R3gLBFLkEFAWrg1fFcrSEMhxAHmtoRSxUie9eXRjpi+4vKi3HBh
         kaAptrzyglr5lsqR/vCUZuSmHgY9BLNdlc6u7SM5uIdX22Idqsfy8A1Se4POmswAyrI/
         k9vrQJ/zO6w0fxmR8v1bUuB8bSLQbr/w+pWqqGYt5ceEqxIvTkueJjCKfvjTP0MklPeZ
         p35A==
X-Gm-Message-State: AOJu0Yzp3TuZWeAPWc+zZGmmHNs6rTEzITmO7TsPDZPiL4eMJk+8eS+Z
	1EYq83DYcaro2dsDvMciVsEgXGVpG+Np3kV0nZZoGFowCPL450XFHk8+HQ==
X-Google-Smtp-Source: AGHT+IGntZDM54f4xCmxNH6Vgj6whNgBuXTnj0UK8OzQah4rGjORqgET90adJexcWHCTi9Qmonlf4w==
X-Received: by 2002:a17:903:2442:b0:1fb:9115:bb61 with SMTP id d9443c01a7336-1fbb6d0b6aamr55474545ad.21.1720624572123;
        Wed, 10 Jul 2024 08:16:12 -0700 (PDT)
Received: from [172.17.0.2] ([52.238.27.70])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fbb6a12954sm34997155ad.43.2024.07.10.08.16.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jul 2024 08:16:11 -0700 (PDT)
Message-ID: <668ea5bb.170a0220.ec312.f7a6@mx.google.com>
Date: Wed, 10 Jul 2024 08:16:11 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1186288692447587011=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, r.smirnov@omp.ru
Subject: RE: fix errors found by SVACE static analyzer #1
In-Reply-To: <20240710113151.49296-2-r.smirnov@omp.ru>
References: <20240710113151.49296-2-r.smirnov@omp.ru>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1186288692447587011==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=870085

---Test result---

Test Summary:
CheckPatch                    PASS      1.72 seconds
GitLint                       FAIL      1.62 seconds
BuildEll                      PASS      24.86 seconds
BluezMake                     PASS      1676.91 seconds
MakeCheck                     PASS      13.44 seconds
MakeDistcheck                 PASS      177.44 seconds
CheckValgrind                 PASS      252.49 seconds
CheckSmatch                   PASS      354.53 seconds
bluezmakeextell               PASS      119.97 seconds
IncrementalBuild              PASS      9386.66 seconds
ScanBuild                     WARNING   1001.44 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[BlueZ,v2,resend,1/6] gatt: add return value check of io_get_fd() to sock_io_send()

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
1: T1 Title exceeds max length (83>80): "[BlueZ,v2,resend,1/6] gatt: add return value check of io_get_fd() to sock_io_send()"
[BlueZ,v2,resend,5/6] client/player: fix the order of args in cmd_register_endpoint()

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
1: T1 Title exceeds max length (85>80): "[BlueZ,v2,resend,5/6] client/player: fix the order of args in cmd_register_endpoint()"
[BlueZ,v2,resend,6/6] shared/gatt-client: add NULL check to discover_secondary_cb()

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
1: T1 Title exceeds max length (83>80): "[BlueZ,v2,resend,6/6] shared/gatt-client: add NULL check to discover_secondary_cb()"
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


--===============1186288692447587011==--
