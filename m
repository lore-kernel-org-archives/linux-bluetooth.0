Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20AF31E4AD
	for <linux-bluetooth@vger.kernel.org>; Sat, 14 Sep 2024 16:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726329761; cv=none; b=VMy39W/l7GN9qQu08WALuz/+tovVAABbw84QqR2b3yX5qHi22kn+ApTrWGdu00YzA/1Jp4EZLyJ4gSjE/NI2bZRpNRUVpaf5123te8+j1L00AeN5dwRDBo+43+MyfjXGUDdbNTXgCZ6P/3xg2h1QAwankcqjMV6UpRCTP+Qrws8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726329761; c=relaxed/simple;
	bh=UKXqr3xhmtEySt4m8aSeXyvJfBFoNeIX1rQqPERSaz0=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=P8bsskwvi+tF7b5sCPz0kKv0mu+U5+pOZ8Aezg7jZtHQ9ED6SnE+awO5GDALl1DTKMn8TJFm2ejFbPHKCq0emJ5a6naYMas9JeaaqBmz/6oFffXK3+ZfOMa/sVlEVsQbZPQRt8S2eMYsM44xmT4Qhf/BY02SHp3zXSAfQzSrBpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h4OCNbzT; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h4OCNbzT"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-458320b30e7so22238321cf.0
        for <linux-bluetooth@vger.kernel.org>; Sat, 14 Sep 2024 09:02:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726329759; x=1726934559; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=klk6SUNHTC2i+X6ScSaYXxYDkEVp39hfDclkq1LjtU0=;
        b=h4OCNbzTyy2zJ7cfSTUQQR8JT76vqUuQmz7vxYPXUvJH5NnQbkOOfRRAVWc5n3iowZ
         KLhLOqxs87isgKM2ztFbTXN3/qPb8W/9VCFilapteowuzXWyq82ljv7EPYkb7ia/81X8
         HCITEcJ8rnGcgP6glUO0vKmASaDzAvHRm2+8mPnJf3W3Wpi+2OBYWrK4dk/+5A2P8tvD
         bSJHhGptcm6ZUQ55wxha1OaAc3Bk20jCMHCcYxq1QOf/q/xEMu5hgy0Ygru5wm/yQczI
         R1nN7b9tCU4Wzkdltrb/cedn5AZLH/8Z42egxJqzAk0CezQiiV9hH9xtN55iGDepMRZ+
         6NaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726329759; x=1726934559;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=klk6SUNHTC2i+X6ScSaYXxYDkEVp39hfDclkq1LjtU0=;
        b=r9Y4EzBdY6rF/X6tNLQl8EhzdwM3AvUjGsVlzeyD6RNz/A97MZJrRvVSf9waRUGaWI
         48yutTK8AMRf/ZeGi56xiGZEDzW1zOx9SIsFBIPhyIuPruhR1QVA1udbZg8GuSXnCqIz
         MxQHYkcg7+UB4Yl8CmGpLm/pyx/LSvo28o6iR3AYG4HAuwsllkPeybDHn5j2xN85DuVl
         A5lxyMXpjg0qS1rNNOBB7RY6zmspW23T8WQqV1FC1EG5e6KUs18zOUPfDDs8JkmqeLo4
         5xe6mJVDM9/givU4Xs6tLOTEntiMNkfsXD6aSiFWs93QaSLoMsOGVGznMM+T/gW7pWhy
         AQEQ==
X-Gm-Message-State: AOJu0YzusrzdB+zfY3u8BvKDgedpXHnT8raRyhwRB6oy/UmH7WvD2s+E
	fvTWk7St9Rga1I9mjL327ZclC4o/0ddmeCh0PAQO4HNlA3lFQ6r1rmIFJg==
X-Google-Smtp-Source: AGHT+IHpwRl6Oh2y5q9w1qsXUkiiPWA1Q6bNodFEihXhuPZXkXLNERx/GmTImSPx5rSRU3+izDmp+Q==
X-Received: by 2002:ac8:7dc3:0:b0:458:1a25:acc with SMTP id d75a77b69052e-458602befe1mr138449541cf.4.1726329758444;
        Sat, 14 Sep 2024 09:02:38 -0700 (PDT)
Received: from [172.17.0.2] ([172.200.199.254])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-459aac62629sm9093341cf.5.2024.09.14.09.02.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Sep 2024 09:02:37 -0700 (PDT)
Message-ID: <66e5b39d.050a0220.34073d.206c@mx.google.com>
Date: Sat, 14 Sep 2024 09:02:37 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0874518322979203440=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, coelacanthushex@gmail.com
Subject: RE: monitor: fix buffer overflow when terminal width > 255
In-Reply-To: <20240914-fix-log-buffer-overflow-v1-1-733cb4fff673@gmail.com>
References: <20240914-fix-log-buffer-overflow-v1-1-733cb4fff673@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0874518322979203440==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=890395

---Test result---

Test Summary:
CheckPatch                    PASS      0.49 seconds
GitLint                       PASS      0.35 seconds
BuildEll                      PASS      24.73 seconds
BluezMake                     PASS      1696.44 seconds
MakeCheck                     PASS      13.31 seconds
MakeDistcheck                 PASS      179.41 seconds
CheckValgrind                 PASS      256.32 seconds
CheckSmatch                   WARNING   358.63 seconds
bluezmakeextell               PASS      120.73 seconds
IncrementalBuild              PASS      1407.21 seconds
ScanBuild                     WARNING   1016.29 seconds

Details
##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
monitor/packet.c: note: in included file:monitor/display.h:82:26: warning: Variable length array is used.monitor/packet.c:1868:26: warning: Variable length array is used.monitor/packet.c: note: in included file:monitor/bt.h:3606:52: warning: array of flexible structuresmonitor/bt.h:3594:40: warning: array of flexible structures
##############################
Test: ScanBuild - WARNING
Desc: Run Scan Build
Output:
monitor/packet.c:529:1: warning: Potential leak of memory pointed to by 'line'
}
^
1 warning generated.



---
Regards,
Linux Bluetooth


--===============0874518322979203440==--
