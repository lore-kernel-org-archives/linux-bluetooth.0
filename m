Received: from out-5.smtp.github.com (out-5.smtp.github.com [192.30.252.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6529B37186E
	for <linux-bluetooth@vger.kernel.org>; Fri,  8 May 2026 06:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778220812; cv=none; b=PoBg/ViieATmbU0AVKEC027ADNlYu3glpeJYbYSQK9FbkNiG3IRHlZrjIzHL0rvVexR20n5RPxcr+9cxqE3ucGHObPQEEkuL+bJPddN0L0WuaVuSXnWhIhPW1YP/98uTw8sf6xItpMvym61PQebUN+pxo12fWRnAwrfLw9YD47w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778220812; c=relaxed/simple;
	bh=0wskw0Rm97L8yJAZp/SixpW1n8LM/iZJcEWNkYF2+D8=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=DSm1lRCD4+Bl9n8I7uv4CGyhUI92u1KGDqgBx+W5pCA0V99CmF1bNrTqfpmpr6cBaqoxnNSOz6CuKngYgPHi4obpKYeaMMS/AI7qwlhya9YRalonpfsa7pf1FwpwTNQI5qzmDSasUJoY6oAmfu3retBiVRxx9o71c1HLS6qEo0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=DKIDDLLK; arc=none smtp.client-ip=192.30.252.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="DKIDDLLK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1778220803;
	bh=GvPh72+S02jTwauy/+qkbU/9ydRWQq6S0E8vE6Wz1bU=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=DKIDDLLKIQUjVAElkrG2QrYa5YTeCwPQgA200ftNCDW6WguK1kYpejvtChCWT7C92
	 CO2IJZQLJXjPi46g2Ws6uslK/5CTK0DdleBrZsOlJj20XQHJxJx/UfN6jpdUBQJpar
	 3unlBriDJiqkQlgM1V89A+elWEpBl3vOVn3gay4s=
Received: from github.com (hubbernetes-node-1af9998.va3-iad.github.net [10.48.201.68])
	by smtp.github.com (Postfix) with ESMTPA id 61A10780345
	for <linux-bluetooth@vger.kernel.org>; Thu,  7 May 2026 23:13:23 -0700 (PDT)
Date: Thu, 07 May 2026 23:13:23 -0700
From: prathibhamadugonde <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1091417/000000-b1528e@github.com>
Subject: [bluez/bluez] b1528e: monitor: Parsing of cs step mode data in RAS
 Notif...
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

  Branch: refs/heads/1091417
  Home:   https://github.com/bluez/bluez
  Commit: b1528e37b53e3743947e22bdd4376bac225ba5b3
      https://github.com/bluez/bluez/commit/b1528e37b53e3743947e22bdd4376bac225ba5b3
  Author: Prathibha Madugonde <prathibha.madugonde@oss.qualcomm.com>
  Date:   2026-05-08 (Fri, 08 May 2026)

  Changed paths:
    M monitor/att.c

  Log Message:
  -----------
  monitor: Parsing of cs step mode data in RAS Notifications

Sample Decoding Example:
            Subevent #0:
              Start ACL Connection Event: 406
              Frequency Compensation: -16384 (0.01 ppm)
              Ranging Done Status: Partial results, more to follow (0x1)
              Subevent Done Status: All results complete (0x0)
              Ranging Abort Reason: No abort (0x0)
              Subevent Abort Reason: No abort (0x0)
              Reference Power Level: -14 dBm
              Number of Steps Reported: 58
                Step 0
                  Mode Type: 0
                  Aborted: No
                  Packet Quality: 0x00
                    CS Access Address check is successful
                    Bit errors: 0
                  Packet RSSI: -52
                  Packet Antenna: 1
                Step 1
                  Mode Type: 0
                  Aborted: No
                  Packet Quality: 0x00
                    CS Access Address check is successful
                    Bit errors: 0
                  Packet RSSI: -48
                  Packet Antenna: 1
                Step 2
                  Mode Type: 1
                  Aborted: No
                  Packet Quality: 0x00
                    CS Access Address check is successful
                    Bit errors: 0
                  Packet NADM: Unknown NADM (0xff)
                  Packet RSSI: -60
                  ToA_ToD: 0xffffff45
                  Packet Antenna: 1
                Step 3
                  Mode Type: 1
                  Aborted: No
                  Packet Quality: 0x00
                    CS Access Address check is successful
                    Bit errors: 0
                  Packet NADM: Unknown NADM (0xff)
                  Packet RSSI: -54
                  ToA_ToD: 0xffffff53
                  Packet Antenna: 1



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
