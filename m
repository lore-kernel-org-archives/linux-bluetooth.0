Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 736D649AA46
	for <linux-bluetooth@vger.kernel.org>; Mon, 28 Sep 2026 22:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790635115; cv=none; b=S1NyE0M3la1DO1Pgzuyc0TPnHZjseXcM+/k9D0KXO2poYXBJqunvZ3aA2bR642xHTX5/c5nLYfW4VLe1RbTLlXVaaO2aJyl0I5143wNaljZpsnZnzwaWo1RTISLSqC1EjGe41Qd9Z3IYxmf6OqqJ5N91bINClcyxaNDaRKXi62I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790635115; c=relaxed/simple;
	bh=+N+MRBD1Qb7Sg2d6msIuRonB+hsWuYKHLjN7NibunLE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Z7L67K9Ngnh5YjrVLny9EZXnvpLza1W3cfH7W8bAY0Otbh8CArqMI+0Zk2PQOpbkOUUrRy3kJKFj4OLgqSTlA58fvT86aFaVMHHOlK0XeRKJJdabsAiF4Wjs5cfKfkzxUwV9Xrbx6Oh/seRQN/HlKqVvAnvU+ikiLoZqdVN3p2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=simpleble.org; spf=pass smtp.mailfrom=californiaopensource.com; dkim=pass (2048-bit key) header.d=simpleble.org header.i=@simpleble.org header.b=RYN9frW7; arc=none smtp.client-ip=74.125.82.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=simpleble.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=californiaopensource.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=simpleble.org header.i=@simpleble.org header.b="RYN9frW7"
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-3115c4451c8so276391eec.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 28 Sep 2026 15:38:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=simpleble.org; s=google; t=1790635110; x=1791239910; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=kPHOxI04S3dkk95lJFVhcFg+8LdIF80f4jILgOkMAcY=;
        b=RYN9frW7Y+K/77oZZ9EA5QhrNT/LFwpDyFx6AGJFqnkcFGAwjxx4FshwyTig+8UCnQ
         eKELoMsLV8J/c7y1Lag1FNO+Ypx4uzd+WWk0R9ogS71rfECYFsBpAaMqqbTNZjGR50+8
         fqKXfOgFV+jkDMabpYTeFZcd8j/qpDqok9VDm551r0fLJhMwW9iEw+9Wtc04LFsMlPl7
         plcno7wA+QYkknr5VFv3gek1zQVCIULTg3cQb9/pV5ktqNKz32P0cvkbAX/0vyjsFLFk
         z/24bfRcXHWA1yTq2eNXzaEZ/BUFUEF7751IDeD3EUsv8a3l85zBipr/kbHyqL3RR2hi
         L4XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790635110; x=1791239910;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kPHOxI04S3dkk95lJFVhcFg+8LdIF80f4jILgOkMAcY=;
        b=EXiI8gZyZEjQPBvKw1SrJa25f/IO8xuSNFmnV5xR4e6hqDJi9PyT7Wh42TGgMy3xxf
         wuVeotuVn6vxJIWjnVBgtv2cw9AlaefTgG0JusSlhiUkBHyaQLNXFOL5TlIjLsa4iFtJ
         OFujyclXhPesdUxz78xSPRKCHyVEalS5tW+3+BHtauBascQ7njUN3NW/7iURsJPnmdll
         WzCjet4xhxTE43nYUFneexOTfssDuJRMA/X7z7JJa5eDKnFrO/nd0p+fBEF+FqTvsZNf
         /QTSq6Sg+jWaIuejr0TiAvG80Yf006U0rDzru9tpu/y5uDSbQ9OfOjTD7JI/GyPgsEf8
         MPZA==
X-Gm-Message-State: AFq9FYJUD1cvTQGJPKSEuEKW5Xp+zkank5Gcj6OfkbqRdkVYGTzTe0eB
	aF8+ixN/pwrhvlpA9Hwl97DuwbuYnTk9KTinXbFaacEvD1MnjXuEiAK4IxePqxm/i76oMwbjR9O
	Hdtze3vY3pw==
X-Gm-Gg: AYBFou1FkFD0HXjbRedp3JNPSUaN4UMmj9fzngm/qylGFxA84uY4SEb7fq9JbdSedND
	SltDLCLeBfU+yBpcT/HLNelQUoTqfp46nZf+EGhHn7UtQ/6QszHv2c1/QM39qPByMsmldoKEqM9
	jtfR1i10hXfI324SvJGFhu+ImrGNmeiPHHruxv7wQxjD/YhqLvJsxmmq3QWJXeYle0SBWFIW+H9
	8i6N/0fFzQWhDi6wHwSN3CDUD5kXo6UXk2rfaSiY4eGM9+HvuukNg+2DnJf/2wk3ynayqkTdxMj
	tOpevSZ11F8Y08hEy3pBm6O2pImecph4cYecX+6Jrjzn8zEKD5nZNMiSQquR0crhjCRbtdN2rtw
	UYp3F2jVLW/yDLqD2E4sjHv+ljSupWGz2oMaTACwLf+PvB6XEKXxPwnoadcgPAnhyCCvHBDsHG/
	upV1Cab+olOZNgLM07Rs5V25mBg8cslcFCpCCOdrxUalkyaMFx/eeOJiKUzm1XNqMc2UkIUBDBS
	uCIBCPr2Y1RQH7a+ZVgfOj/HwkaAgcYulqSXbbPNAv/abofvXNC46mF+E5CGRUf/yeVZnobpoV/
	dbq2qRVYAro2c7i2/wdHkbFt5cztwBKXBlz0YVx8
X-Received: by 2002:a05:7300:271c:b0:33e:52d2:9219 with SMTP id 5a478bee46e88-34af7c5528fmr864597eec.9.1790635110262;
        Mon, 28 Sep 2026 15:38:30 -0700 (PDT)
Received: from localhost.localdomain ([147.185.47.151])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3421dbb2971sm27182480eec.10.2026.09.28.15.38.29
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 28 Sep 2026 15:38:29 -0700 (PDT)
From: Kevin Dewald <kevin@simpleble.org>
To: linux-bluetooth@vger.kernel.org
Cc: Kevin Dewald <kevin@simpleble.org>
Subject: [PATCH BlueZ 0/3] Add Connectable property to org.bluez.Device
Date: Mon, 28 Sep 2026 15:38:12 -0700
Message-ID: <20260928223815.11936-1-kevin@simpleble.org>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

bluetoothd records whether each advertising report was connectable,
from the Device Found event's Not Connectable flag, and uses it
internally, for example to pick the bearer to connect and to drop
temporary non-connectable devices when discovery stops. Applications
cannot read it over D-Bus, so they have to guess, e.g. from whether the
device has a name, which is wrong for named beacons and for unnamed
peripherals.

This series exposes it as a read-only Connectable property on
org.bluez.Device1, emitted when it first becomes known and whenever it
changes, and prints it in bluetoothctl info.

Tested with an nRF52840 switching between ADV_IND, ADV_SCAN_IND and
ADV_NONCONN_IND advertising: the property follows each change,
including PropertiesChanged in both directions on a device kept by
continuous discovery.

Kevin Dewald (3):
  org.bluez.Device: Add Connectable property
  device: Add Connectable property
  client: Print Connectable in info

 client/main.c            |  1 +
 doc/org.bluez.Device.rst | 11 +++++++++++
 src/device.c             | 36 ++++++++++++++++++++++++++++++++++++
 3 files changed, 48 insertions(+)

-- 
2.54.0 (Apple Git-157)

