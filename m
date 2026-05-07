Received: from out-2.smtp.github.com (out-2.smtp.github.com [192.30.252.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27BAB46AEC2
	for <linux-bluetooth@vger.kernel.org>; Thu,  7 May 2026 18:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778178367; cv=none; b=sWl0r60MqK6q2D2OchCsJNf05OOW6oBncHmK8q88x1SICTxJ+AoIGnHtS/Ot/hl0gp2yQTsEoIdKi256puaA8MoIh3pBdbrjl7tr3aHhAqVPvSpNWSGt/BsbbPjIKxS2HnK8LYWx8CeTerPYeFG9+9S7i+ZrBhZl8aLHRI6ELtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778178367; c=relaxed/simple;
	bh=SRxlVtuTTg0Q0sSSioOjnr3rW/LI84Bd/da8d/dyQsc=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=dPs87T/28imFMbGoXO4xJPDy65ncSCVr+22ga38Q0VWudhynhDm/6B2UaFK1IlY/+cVyahkhhvd78xFXuQgE0dL/h5xIWB7lTdsLQ2oloYaeCbPLrpJrK7QDd4qTROJsO0jQ3aYyH9vNa+QLsrQKbREUKQm2AY+FC6qpwinZNXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=RF01BjsA; arc=none smtp.client-ip=192.30.252.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="RF01BjsA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1778178364;
	bh=PdDIsn7uOH9m5imy4JUDW69n27XF3AFZ1KVZyLkbjTg=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=RF01BjsAQZ4WL2Qzb7m+k423/yagzi3zru+jRYO4mpfHP9fr3fybt69p6EkePz4Qb
	 SKOyaAeUrJzS0k4HxS6WFLSVEqmU6azOcZFAbhpKfWgMhAV4tREDYcEO92TKynraQc
	 +x/J2Bn56sQ1c+kS4fMCaqq1Yv40rKl8Y2UTp3ZE=
Received: from github.com (hubbernetes-node-96689d3.va3-iad.github.net [10.48.85.33])
	by smtp.github.com (Postfix) with ESMTPA id 2D2DB3410E2
	for <linux-bluetooth@vger.kernel.org>; Thu,  7 May 2026 11:26:04 -0700 (PDT)
Date: Thu, 07 May 2026 11:26:04 -0700
From: prathibhamadugonde <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1091217/000000-27dcd3@github.com>
Subject: [bluez/bluez] 27dcd3: monitor: Add parsing of CS step mode data in
 RAS N...
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GitHub-Recipient-Address: linux-bluetooth@vger.kernel.org
X-Auto-Response-Suppress: All

  Branch: refs/heads/1091217
  Home:   https://github.com/bluez/bluez
  Commit: 27dcd34c10709dfa5aef33377d882a08538f811d
      https://github.com/bluez/bluez/commit/27dcd34c10709dfa5aef33377d882=
a08538f811d
  Author: Prathibha Madugonde <prathibha.madugonde@oss.qualcomm.com>
  Date:   2026-05-07 (Thu, 07 May 2026)

  Changed paths:
    M monitor/att.c

  Log Message:
  -----------
  monitor: Add parsing of CS step mode data in RAS Notifications Subevent=
 #0: Start ACL Connection Event: 406 Frequency Compensation: -16384 (0.01=
 ppm) Ranging Done Status: Partial results, more to follow (0x1) Subevent=
 Done Status: All results complete (0x0) Ranging Abort Reason: No abort (=
0x0) Subevent Abort Reason: No abort (0x0) Reference Power Level: -14 dBm=
 Number of Steps Reported: 58 Step 0 Mode Type: 0 Aborted: No Packet Qual=
ity: 0x00 CS Access Address check is successful, and all bits match the e=
xpected sequence Bit errors: 0 Packet RSSI: -52 Packet Antenna: 1 Step 1 =
Mode Type: 0 Aborted: No Packet Quality: 0x00 CS Access Address check is =
successful, and all bits match the expected sequence Bit errors: 0 Packet=
 RSSI: -48 Packet Antenna: 1 Step 2 Mode Type: 1 Aborted: No Packet Quali=
ty: 0x00 CS Access Address check is successful, and all bits match the ex=
pected sequence Bit errors: 0 Packet NADM: Unknown NADM (0xff) Packet RSS=
I: -60 ToA_ToD: 0xffffff45 Packet Antenna: 1 Step 3 Mode Type: 1 Aborted:=
 No Packet Quality: 0x00 CS Access Address check is successful, and all b=
its match the expected sequence Bit errors: 0 Packet NADM: Unknown NADM (=
0xff) Packet RSSI: -54 ToA_ToD: 0xffffff53 Packet Antenna: 1



To unsubscribe from these emails, change your notification settings at ht=
tps://github.com/bluez/bluez/settings/notifications
