Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D518143C59
	for <linux-bluetooth@vger.kernel.org>; Mon,  8 Apr 2024 17:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712598241; cv=none; b=JEMWTmKJ+rtlCO8ILd2A1RPMEsa+j56zg/UGqpeDJM1DUGo5P7908sKAeducC4E6OjGDV/NkodU2/kl+QXwYznQRx9ClXxP7/TnwJlB33MAMxAVnWLs8nSZXSOvYUpSdCdQiinC5aBOdbfYnpbBluxKnmA0HOMV2y/GJSOsnY9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712598241; c=relaxed/simple;
	bh=ULOFLbBoVDVTPgrXvpqGFjXcNCNl8o+8sejM01Qmf/4=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=OwFnQOznINMqxatjIK1koz7oSyAkb6NGP8SlwvEjAAy+rOezz2ieAXHHJxa8uL2J8P6/mVSQqP6qmSuof9VKjkoxXKrJ60Sd8BK4wY4xplK1z+iKWQdsxlaeO/HSe75lohez8DOdgIJm1w0+kU6x/jtxjWhDh4ywwgY40Ctd42k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BZnZLmsd; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BZnZLmsd"
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-61495e769bdso39378177b3.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 08 Apr 2024 10:44:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712598239; x=1713203039; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=L7+S05Xg25hDYaYCxDG+yjWqJnSHchQvmdtkMvb0Lek=;
        b=BZnZLmsdg0/YIeLCI6qtJWAbH3ef+E/gpYtFqO248hi0AAlHWNxn176MZBUfHbz39r
         npaCsuB6XdlSTZmXzzBL3GA0g2FU9dl5jOwi0B+asqtcpbZB3FIHSixBrb9Dzmrr107X
         wEhZIflSj6oph9EooBC8eGmKIOewBAFYyRPEIIOP1PzcZ+FSHfCNAW7IJAC+2GXx3XoN
         Sv9LYK1ytNv5Lk1HM5DQSSR+QNcbZyKbeJk5YwRnz69VYEw09ipp/sfpYHJou3sRp86S
         cAZdRRTIZLHwIkwEoEnRSHG5+NXGG98K7sOvrMFWXTBQfR58v4A6YiABsYrWFfkvbarl
         PanA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712598239; x=1713203039;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=L7+S05Xg25hDYaYCxDG+yjWqJnSHchQvmdtkMvb0Lek=;
        b=XVYoGeXKJniCchecUiBt5KaSpsub/1B3XquI6LMC4xOcVYXSJp5+OkeQ+2AD3RY3/o
         LiXVKnxIEEJ3SWJoOgcqa7KUozuRdVQskDKvVCcDFdE889mCqqMQ2pnkP/gIdnAvZdeE
         Yg5W6q7CT9eakUrJlgI5h6BeMcUzMapWE9gjcdHrpVVIxc1aMvncO18bTtOqkAIl4cBt
         UAzhEFWMTufaY4RVQlZfLY9Ev4H+ymU9JIt/ilALpTJWAVLSkEbuIDmsr6LFWfFvD5Jj
         KAC8s0SVv1txs4DJL5lVv/Jpr6P9tERIHXcpk6PmfD/GKSlgkFN5vZv83hfPzZPMI7Er
         Cd2A==
X-Gm-Message-State: AOJu0YwSOcHwI45qzgtPp+nsnUhL+9vaw7iTvlE/ZFCjIep8VUxW0kTI
	fQQLdbwLxsByHvVfkKSCigS44cE9t9u0nJs23mmu8EbK6ydGVwgTRSQKyXyV
X-Google-Smtp-Source: AGHT+IEG3Tppf3KUshacMv3QrYlIjLptEi6uk3vfMmGmIjHDzlx4fSfeb34IB/sZDXqKkvBfc/NaZg==
X-Received: by 2002:a05:6902:f81:b0:dcb:aa26:50f9 with SMTP id ft1-20020a0569020f8100b00dcbaa2650f9mr8761667ybb.46.1712598238995;
        Mon, 08 Apr 2024 10:43:58 -0700 (PDT)
Received: from [172.17.0.2] ([40.84.37.208])
        by smtp.gmail.com with ESMTPSA id kk29-20020a056214509d00b006994aae00e9sm2628697qvb.7.2024.04.08.10.43.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Apr 2024 10:43:58 -0700 (PDT)
Message-ID: <66142cde.050a0220.ef703.daa5@mx.google.com>
Date: Mon, 08 Apr 2024 10:43:58 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7327204384837557460=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v1] shared/gatt-db: Fix gatt_db_service_insert_characteristic
In-Reply-To: <20240408155949.3622429-1-luiz.dentz@gmail.com>
References: <20240408155949.3622429-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7327204384837557460==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=842520

---Test result---

Test Summary:
CheckPatch                    PASS      0.52 seconds
GitLint                       PASS      0.31 seconds
BuildEll                      PASS      24.58 seconds
BluezMake                     PASS      1681.37 seconds
MakeCheck                     PASS      13.38 seconds
MakeDistcheck                 PASS      174.59 seconds
CheckValgrind                 PASS      250.29 seconds
CheckSmatch                   WARNING   353.90 seconds
bluezmakeextell               PASS      118.80 seconds
IncrementalBuild              PASS      1477.58 seconds
ScanBuild                     WARNING   985.63 seconds

Details
##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
monitor/att.c: note: in included file:monitor/display.h:82:26: warning: Variable length array is used.
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
src/shared/gatt-client.c:1294:2: warning: Use of memory after it is freed
        discovery_op_complete(op, success, att_ecode);
        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
src/shared/gatt-client.c:1359:2: warning: Use of memory after it is freed
        discovery_op_complete(op, success, att_ecode);
        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
src/shared/gatt-client.c:1634:6: warning: Use of memory after it is freed
        if (read_db_hash(op)) {
            ^~~~~~~~~~~~~~~~
src/shared/gatt-client.c:1639:2: warning: Use of memory after it is freed
        discover_all(op);
        ^~~~~~~~~~~~~~~~
src/shared/gatt-client.c:2143:6: warning: Use of memory after it is freed
        if (read_db_hash(op)) {
            ^~~~~~~~~~~~~~~~
src/shared/gatt-client.c:2151:8: warning: Use of memory after it is freed
                                                        discovery_op_ref(op),
                                                        ^~~~~~~~~~~~~~~~~~~~
src/shared/gatt-client.c:3240:2: warning: Use of memory after it is freed
        complete_write_long_op(req, success, 0, false);
        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
src/shared/gatt-client.c:3262:2: warning: Use of memory after it is freed
        request_unref(req);
        ^~~~~~~~~~~~~~~~~~
12 warnings generated.



---
Regards,
Linux Bluetooth


--===============7327204384837557460==--
