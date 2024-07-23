Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56B9C14B082
	for <linux-bluetooth@vger.kernel.org>; Tue, 23 Jul 2024 08:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721723333; cv=none; b=rU6p15lVaEIrCSMxoZp9OdcEh0WFeZKlxu01tjpVuf/FFBSVl4xN61rGogB7QoSix6Y+nX7KvHHwpZ13dtxpKR27T7n6OUVknhIUXfu0pLa4i7sYfn5bLfxEFw+d5YO3UFHg+ydj9DHizmZZZGdzqHGocBrVznPl1MH54lnVcto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721723333; c=relaxed/simple;
	bh=kHxc/MelFyNV940ozy4yMFhPE4QFdPOmYxIv4uW/coo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZQ/0SVoA3AA95ZJwEwXXgsv77esX/msPQi6NSbTYM7ZkWxDzPxp2oGmsmzl/CQBwrOd9JCe1CyhrfPYlq5Xe14SzIyqlWSY0xTVMhkVesjtlPiKHT3N9YbgBjKNVofIl5rpYSwnmnaul+eyUu36rdpiBpk1BQe1qB81P+xoem7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CjOJBef7; arc=none smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CjOJBef7"
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-3d9c4887533so2783256b6e.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 23 Jul 2024 01:28:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721723331; x=1722328131; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wkVmixIcbkvszjS5wo+0TPqYnTyyC8pTbtvYuedDHKo=;
        b=CjOJBef7tELenWLkkaz8xosZRp5WrSW7RvrIiZxkS4oCzoEV11sP5kxpdFGR8VAoUD
         aX8N25x+RqcQxtU6x5OivnO9B9Iv4lZbbLFBOEa0TXdVBo7d5l41sas2fxs9dstCAZBV
         7/GY/7SY/I3tQpnrG2/YucwVlipZL77z+bEigXtABvWfFxMcEVYsBXOdHIm2qQ9gGvfE
         zGvUFGq3ebh9GI/oygy5qDvVzw8sD0D+as1BWs/JaC2rQrUBWKY6sid3Pw9gzYAi5QE5
         U1vovrXqM0ot6AJcUcZxr4rfVJK3+8dTdPSpReY9HCTZcpBvB65tu70qTBHW/e2Ov9d6
         +ihg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721723331; x=1722328131;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wkVmixIcbkvszjS5wo+0TPqYnTyyC8pTbtvYuedDHKo=;
        b=RUj4zA+As/stkyBnVsAR6Ij/8PQDKPYZHvR9AWbVOlZ4LAgIMWfItiy6a2AZ5nnlrm
         tnhB8VBO8kpKULCNBK/EB0t9MWzaoFewogjb3HI2xev/6QyDiBpU3RzlxfQmmw4I9/Ee
         BymzEFiH25CJB3Rwh0R/36bkr6INYvK1VWZTx0UjPHsceM7fveNkJsfXNEQgRfdGIO5R
         Fk50uTHyeMsra31tl0DEWbwggoz0cMJfzj54HxfwZPskU7IcoNRZcOu504zoFbCyegol
         SysXc/izLpQF6WEzLNcp+hLwa2lj5Bp3H0uSunCoynNd8uJPtIWC9GxAsmjkvWUQs0hd
         /f7Q==
X-Gm-Message-State: AOJu0YzVSBs+PtqOKWqYal6YM/uhBcgdFhFC1KbOkPMOzuKcFmbLQdXw
	c7F9Kpm9NiWgK7I/3DAMUOh5lAHKoQTWLer3PPWsxvUOWW63VVWcbx1SEw==
X-Google-Smtp-Source: AGHT+IFBjaCIZ9nv2AtTrNYF6UcIqDkTEqADWGWEhZKJ/wFLTIXadF0a+klKmOWQPGLZTMt/T+R5gQ==
X-Received: by 2002:a05:6808:14c9:b0:3d9:26d6:c706 with SMTP id 5614622812f47-3dafd441d78mr3114671b6e.42.1721723331215;
        Tue, 23 Jul 2024 01:28:51 -0700 (PDT)
Received: from localhost.localdomain ([192.227.249.122])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3dae099013asm1902743b6e.25.2024.07.23.01.28.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jul 2024 01:28:50 -0700 (PDT)
From: Yancey Chiew <yanceychiew@gmail.com>
X-Google-Original-From: Yancey Chiew <YanceyChiew@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Yancey Chiew <YanceyChiew@gmail.com>
Subject: [PATCH BlueZ 0/1] Fix com.bluez.battery1 randomly missing percentage value
Date: Tue, 23 Jul 2024 16:28:42 +0800
Message-ID: <20240723082843.184915-1-YanceyChiew@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For more than a year, I often found that the
org.bluez.Battery1 dbus interface randomly failed to
obtain the battery level of some devices.

When this happens, it is always accompanied by a
"Trying to update an unregistered battery" log.

Finally, I found a bug in battery.c:parse_battery_level().
Except when called for the first time, it will wait
until the battery percentage changes before updating
the value in the dbus interface.

For BLE devices, changes in battery percentage will
take a long time, which is enough for the device
to disconnect/reconnect multiple times due to
sleep/wake-up. And every reconnection has a chance to
cause "Trying to update an unregistered battery".

Yancey Chiew (1):
  profiles/battery: Fix batt random lose percentage

 profiles/battery/battery.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

-- 
2.45.2

