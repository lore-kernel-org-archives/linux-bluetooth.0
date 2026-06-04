Received: from out-29.smtp.github.com (out-29.smtp.github.com [192.30.252.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68002376467
	for <linux-bluetooth@vger.kernel.org>; Thu,  4 Jun 2026 21:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.128
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780607591; cv=none; b=s/pRQW1f3hpkutapULBDapU4uV7eSDlvaaWYznqFsjrIPcCLQHxpiR+aFbb2KqUd51IZoZMTKIekA3TWDx0f1ey4ccGUwoP6AarSBA4kIlgUwBFIWxw10litFzND9BARbxzQaebnxrfM5nBUY55bjghkPrxuudnqvmLwzCtfV+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780607591; c=relaxed/simple;
	bh=wOHLa+gGpEAIcZcXxxRHQrONyOmBT79esx8005iGa9w=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=mi1FinEqriGyVmljP5cpbc9UH8+SDhE1uum92iJXtr0JSKFmrPyzhjUPpyb7cWcdmbppmqF1yaNGw9tRm9fYQTUYbqLEQkzs8dIHtTVKjW81AnTYzo17waeOhj2UGxJCfbp8megqECCOvD4YqPQx9oFebY9csRfLKv/q2UE10tM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=ZI4rqxHf; arc=none smtp.client-ip=192.30.252.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="ZI4rqxHf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1780607589;
	bh=dpE7jfGX+6bwZ/tpt2P+WeqwmW+xp8gkrMk6jMg3oIE=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=ZI4rqxHfPuCLoCnoxC+J5U2dz1XXXaBS5CbCZ3Yidnw+X0eonelRQKdSxZQSE7IlG
	 IglogO+Q8TkOHpM5cvHL11Gfbkfb3+5ubAtoF7N/n81oVtrtYO2hp9qlj3oj5PrBNZ
	 sUmhcU6oe7RVnGl+XATjuVeOSN7SHSOOvQxQruOo=
Received: from github.com (hubbernetes-node-0f1cf93.ac4-iad.github.net [10.52.183.64])
	by smtp.github.com (Postfix) with ESMTPA id A09A332000B
	for <linux-bluetooth@vger.kernel.org>; Thu,  4 Jun 2026 14:13:09 -0700 (PDT)
Date: Thu, 04 Jun 2026 14:13:09 -0700
From: prathibhamadugonde <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/c6bc42-42b2c5@github.com>
Subject: [bluez/bluez] bc5713: shared/rap: Add client ranging registration and
 no...
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 7bit
X-GitHub-Recipient-Address: linux-bluetooth@vger.kernel.org
X-Auto-Response-Suppress: All

  Branch: refs/heads/master
  Home:   https://github.com/bluez/bluez
  Commit: bc5713d69e1e4ef87bc097ecbe941a2162bf0eac
      https://github.com/bluez/bluez/commit/bc5713d69e1e4ef87bc097ecbe941a2162bf0eac
  Author: Prathibha Madugonde <prathibha.madugonde@oss.qualcomm.com>
  Date:   2026-06-04 (Thu, 04 Jun 2026)

  Changed paths:
    M src/shared/rap.c
    M src/shared/rap.h

  Log Message:
  -----------
  shared/rap: Add client ranging registration and notification parsing

Read the RAS Features characteristic to determine whether the remote
device supports real-time ranging. If supported, register for real-time
characteristic notifications using the reqtracker for the CS initiator
role.

Parse incoming segmented RAS ranging data notifications by accumulating
segments via iovec and parsing complete subevent headers and CS mode 0-3
step data, including IQ/tone PCT samples, once the last segment arrives.


  Commit: 42b2c543a70c882ed12efa06334588b0c45ae0f3
      https://github.com/bluez/bluez/commit/42b2c543a70c882ed12efa06334588b0c45ae0f3
  Author: Prathibha Madugonde <prathibha.madugonde@oss.qualcomm.com>
  Date:   2026-06-04 (Thu, 04 Jun 2026)

  Changed paths:
    M profiles/ranging/rap_hci.c

  Log Message:
  -----------
  profiles/ranging: Fix measured_freq_offset

As per Core spect it is 2 octects not 4.


Compare: https://github.com/bluez/bluez/compare/c6bc42d69661...42b2c543a70c

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
