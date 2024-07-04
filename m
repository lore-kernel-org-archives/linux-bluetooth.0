Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7D4F1AB524
	for <linux-bluetooth@vger.kernel.org>; Thu,  4 Jul 2024 11:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720092996; cv=none; b=BdZNnn6deSHHPwpGo03GcI/5/Uq2nu6URaMP30aQDdw/Ss98b+p+0+kXcRXJrV8SgKbMoqFLq3WeOgJnq86Tr8aw50N9kFfBAj8vtPizPE45ggHzgcVzYuzz5CUXKKOA+GuyXPBwe43Ba8J0Hr4iTaIRKrmD9Y7rLd96VwwXMnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720092996; c=relaxed/simple;
	bh=WaZi87/PBxvQ43xwKxbvhiSYp0ywxoWv6MqvP1RpTLE=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=BrMMiYKH/5h1MMuUa23DyQNuuUZtH6U+6GEW1kg3LDCBqCunTeQbBBgZLHsGrAj34GolabfcfEZ3ZJd6tf/ulNLJWLiE/PyRdxhsz6LpOSzGHVXVQ54s4CI8s2Gg/EHTfJCJ36pJA/QHMpixBuLRKPqFfnjvrNrWfHxRPbbBwik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k5m+AviY; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k5m+AviY"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-70af81e8439so444058b3a.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 04 Jul 2024 04:36:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720092994; x=1720697794; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=nI3MHZOyiieTL8k+OM5WLLeXPSFp/Q15AY+4mYXGPbk=;
        b=k5m+AviYaVrFJFtKSmaM0GICAY7sMOUD6lVRkoVxYSq4WRW7vER8usjZ4GjK8B7Sa8
         vEEsAaYlj8dgo/TUh8BixmhOPeZC3AHOS/6cVykhxyWeN97jjXRsuVNu/F4xdPAFjgMJ
         RAxOD6Urhum4Ou/2Qcj6OYLS1HZPYIBNCWe9kyaiaoZ6nVV9svs/iMIJ00Ev6YE6XEWw
         O0kwA1wFgv/B0uzHdyZ2WS91ItVtqcJRW3eB/N/DZKu8E3QmSK+GNOFGRqPLxW87e2UM
         xgADgx5W8g/qV5SrWQRxWdBU/JAJuOwTbu1Vjbkx0pgxnLdZ124M2UCwKTQsR7xKQHoX
         Tc2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720092994; x=1720697794;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nI3MHZOyiieTL8k+OM5WLLeXPSFp/Q15AY+4mYXGPbk=;
        b=Tl7XcacWcyIjP8+kbmx0aXsbRRj6yZj4uVrJVLg/5q7jSMDD5AAuwLBVNy319iBQMT
         gTUtQu1WWuYTAyzhYA/j4CpZ3T68r3/MqMthTeRVNWPa1LP9kyOVYh45hdbpHZ1I5SMU
         eQE2GV5OJDf9T0lMWTEE4vjarjkMUNI2c6Ys7ULvgN2f0UZlEY1yBtvowDHUAg+3OgzW
         esxO5wqfLuJ6yShvnA7BpZSXTkwW3Cfub+Pb1Df5h9RXUDb07gwzL3Dxc9veMtqGO6n2
         oCJR54KlsHFL8WRh4Nv9CzwEMOgznaVjsMDzWkE2gzbifAXtZHE8LdHkwTxnXujAWW+g
         X0cQ==
X-Gm-Message-State: AOJu0YxuEuEnktjpHIqWs/ACepRikjvbRwKS8IMgV14wXylxH2TFG10C
	0w8nHPkD5X8Ndj/rA1nanLpPQpwHOnc7wkQ/uLAphrWsDADoeJiIiZYRMA==
X-Google-Smtp-Source: AGHT+IHmOHafqBzKV76vbVKDVQ0ZkPedSAkevtp0u2gfBbIETLzPH/6ToeA1KigUu0D/EOGiugctWA==
X-Received: by 2002:a05:6a00:1898:b0:70b:152:331 with SMTP id d2e1a72fcca58-70b015208e0mr1398516b3a.21.1720092975912;
        Thu, 04 Jul 2024 04:36:15 -0700 (PDT)
Received: from [172.17.0.2] ([13.83.1.209])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-72c6c9e0ee3sm9490590a12.60.2024.07.04.04.36.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jul 2024 04:36:15 -0700 (PDT)
Message-ID: <6686892f.630a0220.5de6d.34c2@mx.google.com>
Date: Thu, 04 Jul 2024 04:36:15 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8060588988181790973=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, r.smirnov@omp.ru
Subject: RE: fix errors found by SVACE static analyzer
In-Reply-To: <20240704090756.31351-2-r.smirnov@omp.ru>
References: <20240704090756.31351-2-r.smirnov@omp.ru>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8060588988181790973==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=868373

---Test result---

Test Summary:
CheckPatch                    PASS      0.77 seconds
GitLint                       PASS      0.59 seconds
BuildEll                      PASS      24.78 seconds
BluezMake                     PASS      1695.19 seconds
MakeCheck                     PASS      13.40 seconds
MakeDistcheck                 PASS      177.22 seconds
CheckValgrind                 PASS      252.90 seconds
CheckSmatch                   PASS      357.48 seconds
bluezmakeextell               PASS      120.68 seconds
IncrementalBuild              PASS      4657.50 seconds
ScanBuild                     WARNING   1080.72 seconds

Details
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


--===============8060588988181790973==--
