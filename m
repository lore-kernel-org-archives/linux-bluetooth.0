Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6454B2CAB
	for <linux-bluetooth@vger.kernel.org>; Fri,  1 Nov 2024 15:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730476038; cv=none; b=pHSHZ6lPk2FHFMUjUhrRnWMD3NmbJ7aKTWpayx7Yxi3Yfzp80uryapNq62cMiAyxE5ZrbTtBckOEOdwkpWOjiPwBJKxHK2a/S7F4XRNQ6OtnATMIev56pjT+XwTksgWsJ9tCZuOTrFSAxl3usg9VrFj9KrwAVIXx2ENHnb1oA8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730476038; c=relaxed/simple;
	bh=LSW2PYvvC6uFtEZ9IZj4S+4pHndyWtiJ+uvMhuyBGaE=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=MU0VxW9uSGZNQ7rgbmrTd1p+fwzlVjbDfiv7ygYHM5ChDJol0ouec3y1tcvUffRNPBASsg3QonYMVRFX5TRyI8Hez3S8VL5HgGpSyHYiV8a8+iffEYS/Tn3coWpuDpYjAa5/hfKijvfmqqfjkfgt8pjdD2Eptnl9C/0IK6tBws0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FzxI0CmY; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FzxI0CmY"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-20c714cd9c8so22997645ad.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 01 Nov 2024 08:47:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730476035; x=1731080835; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=dxm1TTIDJLEUOAB+duSxieq4GMtPgB1dOuuWCyToLws=;
        b=FzxI0CmY9KERc/m3mpaFiAmbvVkFea+W0MtiecypFQuvpautEMaU6463FajUXctX3N
         goz24p0dnXYc7+KXRpu9cLenFMDrIYlr9mUj7VJ89mM0ttbbcWMQRwKI1Yhx9axQWy1n
         jVMCug+k6tEE/v4GmWrXioEO9N98vxfee9YjzjLSFsloLeDyW9YTauV25qL/+fKNrknO
         Ne2YHSFiMaqbQMNNXd7+fqyIRj2BHdqhfvIGo5Dz/ySEsbrXAsIqx19ShpOibzeQtCe+
         7EX0eMbCofYqsQQZzOpRb+tz9kBa6hifh0595OJfNhppNN1aAvp5Oplp9sR9dJsEBIhT
         +V3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730476035; x=1731080835;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dxm1TTIDJLEUOAB+duSxieq4GMtPgB1dOuuWCyToLws=;
        b=ujhJi//jiOJiww+P8Az8NhzHmuNL7ibjJhlVTVlnHBxLzVsgn9KKr7xt48jZW+0kMs
         /6Rvt6XkN2y8SW0chq6+NGyabsWRL11CrVVjuOcEjfrqA/jWXNysIl3H7rOyIte5qegr
         QV3tmautAt3taOBZ4jMtBrmV3ojF2dCQASP88CBPmoJAN5nlZWj55TTufd30sH349AGf
         ROAWXcymaQFQQA31htjC3XSNbvIBYwJk2rvwlxRimo0QbJbmpLYTr7SgkBT8llb4u4u7
         NY2h96NMfphkIGwSe1ah3ownM+lM86OZA3zjaD84gpNhQF/U60/818ThtUy3lTgtSDv0
         juDA==
X-Gm-Message-State: AOJu0YxE6aAJ+fEPLasBCSQR2AbLy1OdlhO4H38pTeHnqgOEqSaC8Kxy
	uNG04t6mIdsCdMg9uS0X6fD42cOv4sqHZox906OLwTv+ltd6VNPtx8BPVg==
X-Google-Smtp-Source: AGHT+IFXpPKSCFPJOYbW//zt0Qf3fOsWgfn/baD6sKBov3MS6BtvLub9h8r9YsM49s9r5V3ZzuNWtQ==
X-Received: by 2002:a17:902:e849:b0:20c:7485:891c with SMTP id d9443c01a7336-2111b01c70cmr50839865ad.54.1730476035118;
        Fri, 01 Nov 2024 08:47:15 -0700 (PDT)
Received: from [172.17.0.2] ([52.234.26.210])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211057bf377sm22692445ad.184.2024.11.01.08.47.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Nov 2024 08:47:14 -0700 (PDT)
Message-ID: <6724f802.170a0220.17313b.cae0@mx.google.com>
Date: Fri, 01 Nov 2024 08:47:14 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6373397314945302464=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, iulia.tanasescu@nxp.com
Subject: RE: iso-tester: Add tests for Broadcast Receiver sync to 2 BIGs
In-Reply-To: <20241101115118.43891-2-iulia.tanasescu@nxp.com>
References: <20241101115118.43891-2-iulia.tanasescu@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6373397314945302464==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=905388

---Test result---

Test Summary:
CheckPatch                    PASS      1.62 seconds
GitLint                       PASS      0.95 seconds
BuildEll                      PASS      24.64 seconds
BluezMake                     PASS      1641.57 seconds
MakeCheck                     PASS      12.98 seconds
MakeDistcheck                 PASS      179.56 seconds
CheckValgrind                 PASS      254.58 seconds
CheckSmatch                   WARNING   358.27 seconds
bluezmakeextell               PASS      120.52 seconds
IncrementalBuild              PASS      8125.02 seconds
ScanBuild                     WARNING   1010.64 seconds

Details
##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
emulator/btdev.c:448:29: warning: Variable length array is used.emulator/btdev.c:448:29: warning: Variable length array is used.
##############################
Test: ScanBuild - WARNING
Desc: Run Scan Build
Output:
emulator/btdev.c:1122:10: warning: Although the value stored to 'conn' is used in the enclosing expression, the value is never actually read from 'conn'
        while ((conn = queue_find(dev->conns, match_handle,
                ^      ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
emulator/btdev.c:1409:24: warning: Access to field 'link' results in a dereference of a null pointer (loaded from variable 'conn')
        pending_conn_del(dev, conn->link->dev);
                              ^~~~~~~~~~
emulator/btdev.c:1531:13: warning: Access to field 'dev' results in a dereference of a null pointer (loaded from variable 'conn')
        send_event(conn->dev, BT_HCI_EVT_AUTH_COMPLETE, &ev, sizeof(ev));
                   ^~~~~~~~~
3 warnings generated.



---
Regards,
Linux Bluetooth


--===============6373397314945302464==--
