Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA11C1DE2A0
	for <linux-bluetooth@vger.kernel.org>; Thu,  7 Aug 2025 15:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754580429; cv=none; b=MLX8WsntMFGqUWMpfaLFaAO5otEPZJCGM1oB6rTvA9EHuCRoCK54k5jMHvWID6O5sd487c/ZtSrGMawMQ3tghPM+K/dpG5Q4rlqzvxta9ukDbp8PLWlzUKppjRfdjgafG6HwyHe9mlPM89p2NULKLGBYzbeO+blUVK/zhNAOHuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754580429; c=relaxed/simple;
	bh=RnXy0wvBG74Ea7no0miy0VSaOWZvtiWvsr03Pm+oNMg=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=sYxmv5pSAtb7z+/KtcTfK51GemmLWxiUKjrm/SqD2Ynshcc+aKsaGr6nyIIG3KFKrDjAw4YXqPK/A5nUmNEiDxT5mzZ+hhrAzN9zORJd8JQOrkX6dQeG5gTemF2FTVZuzX4J9/LjGBrD8R9bAwXRS5/NLSkBtrEDD8GPpJfrERM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=loygy54F; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="loygy54F"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-b4281fabee0so780311a12.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 07 Aug 2025 08:27:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754580427; x=1755185227; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=HX54yChOSigbdieUEaXiYoRg39aVOQ443o/Z44nM6ZU=;
        b=loygy54FPMnjyWBnfHKSepmhyLtawwWRhmjMnLHnAyF7bZPn6gmSK69UZUh8wHpoZ7
         fltaiGdIjPMHiuVNXNKddTGE8B7ASWhaO/GbYI2IrFllmhGL1nFJ7T8pDllwJ/s7X0TN
         Sjw5ZPjRxMKE+S+G0RmHhLXd8GXdQLqZL7+X9gS6LCqnJvPcmsuXbXgsFYS/OgyE6chZ
         C1L96lhJOAUlknRWvfhSVmkOitY3dqdvPRd3hDUae428eFV587UxmJ56IR6SFALCkqIN
         PtaKB9yI9juvnFvb1j+EdXZrj/t3uGK6K8L8rzApWZPzBq2iQc1C29H9K3SB6rMroAvl
         5QZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754580427; x=1755185227;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HX54yChOSigbdieUEaXiYoRg39aVOQ443o/Z44nM6ZU=;
        b=gvFUnq1OhPnx+DFl1X7FNCJpmFLUazERgUJSehlQRdSoSeSVmJaEIRtyuspBv2kK+b
         xOc2kZyY126Q4wCFRI9J3KxnckLlNGyDRrozqFulyC9dezJDU+ttSrsWoAas6+r5qAI+
         26iF8rHBRYaK6dWnXq2PmTw4fdgKdQfOt8JjgIFqj0CrujSk1OYaOEf/h0oL5jmRI+Bc
         /OPLxMBICXhcXBQcDH5nJkGCnt7T+olRJ0XSTyJzlJ1hxYKf7JiOWCVDjA9HmItWrprT
         hDgVEdsRNM4TNXat0mj81oAPmy9KwlNtyROC/mEtq9WC92pROqZHmDAMx9prxQB3BBVk
         cqzA==
X-Gm-Message-State: AOJu0YzP+1fcv5jPdwB1p2ucBkSiC3NCjPUmrmGMcTJ+CF2lsIW/+FIq
	F8F5yya6+XtRyXe/fNsx/ZNk3BF3GAp69eaMKp6oPPWqERtLNHwwf6rWcBlqSA==
X-Gm-Gg: ASbGncsROqjIQXB/6SOTR06GUTHzUi12nG4p7MX8MV9Vb+6QQc2YQDy7lO0MBtkKbSM
	hcrMyoQidUfbq5fZ0Vf8idnTHH0M4jCJg7yEMVw5ysPXeLIRcwB+SY+60VdAM7zPEKZgYw4SXxT
	noe/GlIjB3CQtkSlLHk5wCPMeXRdgQxOh7uacqfqjw/uUxdfnNNbMDJKUUSXRVvlCxujku2o4gh
	O+XInZe/tz5jNE/zor92rjUlqHLkNthjBRyT6nJ1nzeA20AD6idIOeAFGPF1g5tnO3w6tRLFv9/
	7xOeOv/cPGB+IinpjSWsgI+FKE2BmMOov+eXMqWKK/iKfLzQ/iGBiqsbTltXp3wDj6LEbBqqNSN
	C+VFzo2DEYisOxjzTKxRcHs3p5NNC0rksXzfaKy/v
X-Google-Smtp-Source: AGHT+IGb3xMaM9nRamQl/lMY8nTUWRV1ez6dyv/eQxHpePfPGmhQV+sdYT6ep1hBimjGoAqP0Pp6sw==
X-Received: by 2002:a17:902:e54b:b0:240:7fcf:ced7 with SMTP id d9443c01a7336-242a0aa6bd7mr111322395ad.21.1754580426834;
        Thu, 07 Aug 2025 08:27:06 -0700 (PDT)
Received: from [172.17.0.2] ([20.171.123.131])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241e899a814sm189456045ad.117.2025.08.07.08.27.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Aug 2025 08:27:06 -0700 (PDT)
Message-ID: <6894c5ca.170a0220.3bc3a9.25ad@mx.google.com>
Date: Thu, 07 Aug 2025 08:27:06 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0735505234671192092=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, hadess@hadess.net
Subject: RE: Prepare for meson build system
In-Reply-To: <20250807140424.937218-2-hadess@hadess.net>
References: <20250807140424.937218-2-hadess@hadess.net>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0735505234671192092==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=989142

---Test result---

Test Summary:
CheckPatch                    PENDING   0.37 seconds
GitLint                       PENDING   0.43 seconds
BuildEll                      PASS      20.03 seconds
BluezMake                     PASS      2651.51 seconds
MakeCheck                     PASS      20.15 seconds
MakeDistcheck                 FAIL      31.11 seconds
CheckValgrind                 PASS      238.19 seconds
CheckSmatch                   WARNING   306.79 seconds
bluezmakeextell               PASS      128.75 seconds
IncrementalBuild              PENDING   0.36 seconds
ScanBuild                     PASS      918.29 seconds

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

Package cups was not found in the pkg-config search path.
Perhaps you should add the directory containing `cups.pc'
to the PKG_CONFIG_PATH environment variable
No package 'cups' found
../../src/shared/mgmt.c:20:10: fatal error: bluetooth/bluetooth.h: No such file or directory
   20 | #include "bluetooth/bluetooth.h"
      |          ^~~~~~~~~~~~~~~~~~~~~~~
compilation terminated.
make[2]: *** [Makefile:7362: src/shared/libshared_mainloop_la-mgmt.lo] Error 1
make[2]: *** Waiting for unfinished jobs....
../../src/shared/util.c:32:10: fatal error: bluetooth/bluetooth.h: No such file or directory
   32 | #include <bluetooth/bluetooth.h>
      |          ^~~~~~~~~~~~~~~~~~~~~~~
compilation terminated.
make[2]: *** [Makefile:7355: src/shared/libshared_mainloop_la-util.lo] Error 1
make[1]: *** [Makefile:4039: all] Error 2
make: *** [Makefile:10390: distcheck] Error 1
##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
attrib/gatttool.c:235:23: warning: Variable length array is used.attrib/interactive.c: note: in included file (through /usr/include/readline/readline.h):attrib/interactive.c:174:27: warning: non-ANSI function declaration of function 'disconnect_io'attrib/interactive.c:299:23: warning: Variable length array is used.emulator/btdev.c:456:29: warning: Variable length array is used.emulator/bthost.c:678:28: warning: Variable length array is used.emulator/bthost.c:679:32: warning: Variable length array is used.emulator/bthost.c:896:28: warning: Variable length array is used.emulator/bthost.c:930:28: warning: Variable length array is used.emulator/bthost.c:931:32: warning: Variable length array is used.mesh/mesh-io-mgmt.c:525:67: warning: Variable length array is used.monitor/att.c: note: in included file:monitor/display.h:82:26: warning: Variable length array is used.monitor/l2cap.c: note: in included file:monitor/display.h:82:26: warning: Variable length array is used.monitor/msft.c: note: in included file:monitor/msft.h:88:44: warning: array of flexible structuresmonitor/packet.c: note: in included file:monitor/display.h:82:26: warning: Variable length array is used.monitor/packet.c:1918:26: warning: Variable length array is used.monitor/packet.c: note: in included file:monitor/bt.h:3822:52: warning: array of flexible structuresmonitor/bt.h:3810:40: warning: array of flexible structuresprofiles/sap/server.c: note: in included file:profiles/sap/sap.h:77:35: warning: array of flexible structuressrc/shared/bap.c:317:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:317:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:317:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/gatt-helpers.c:768:31: warning: Variable length array is used.src/shared/gatt-helpers.c:830:31: warning: Variable length array is used.src/shared/gatt-helpers.c:1323:31: warning: Variable length array is used.src/shared/gatt-helpers.c:1354:23: warning: Variable length array is used.src/shared/gatt-helpers.c:768:31: warning: Variable length array is used.src/shared/gatt-helpers.c:830:31: warning: Variable length array is used.src/shared/gatt-helpers.c:1323:31: warning: Variable length array is used.src/shared/gatt-helpers.c:1354:23: warning: Variable length array is used.src/shared/gatt-helpers.c:768:31: warning: Variable length array is used.src/shared/gatt-helpers.c:830:31: warning: Variable length array is used.src/shared/gatt-helpers.c:1323:31: warning: Variable length array is used.src/shared/gatt-helpers.c:1354:23: warning: Variable length array is used.src/shared/gatt-server.c:278:25: warning: Variable length array is used.src/shared/gatt-server.c:618:25: warning: Variable length array is used.src/shared/gatt-server.c:716:25: warning: Variable length array is used.src/shared/gatt-server.c:278:25: warning: Variable length array is used.src/shared/gatt-server.c:618:25: warning: Variable length array is used.src/shared/gatt-server.c:716:25: warning: Variable length array is used.src/shared/gatt-server.c:278:25: warning: Variable length array is used.src/shared/gatt-server.c:618:25: warning: Variable length array is used.src/shared/gatt-server.c:716:25: warning: Variable length array is used.tools/bneptest.c:634:39: warning: unknown escape sequence: '\%'tools/meshctl.c:324:33: warning: non-ANSI function declaration of function 'forget_mesh_devices'tools/rctest.c:631:33: warning: non-ANSI function declaration of function 'automated_send_recv'tools/sco-tester.c: note: in included file:./lib/bluetooth/bluetooth.h:232:15: warning: array of flexible structures./lib/bluetooth/bluetooth.h:237:31: warning: array of flexible structuresunit/avctp.c:505:34: warning: Variable length array is used.unit/avctp.c:556:34: warning: Variable length array is used.unit/avrcp-lib.c:1085:34: warning: Variable length array is used.unit/avrcp-lib.c:1583:34: warning: Variable length array is used.unit/avrcp-lib.c:1612:34: warning: Variable length array is used.unit/avrcp-lib.c:1638:34: warning: Variable length array is used.unit/test-avrcp.c:373:26: warning: Variable length array is used.unit/test-avrcp.c:398:26: warning: Variable length array is used.unit/test-avrcp.c:414:24: warning: Variable length array is used.client/display.c: note: in included file (through /usr/include/readline/readline.h):
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============0735505234671192092==--
