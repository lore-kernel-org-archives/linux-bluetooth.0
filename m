Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794451145;
	b=bQ6vfdMQJ3VM+EQFyAzteXmCRxMKHPTOwN5ILG8auxRlNJqzCCQWM6LtfrDV5xg4Hfo9
	 ihM7YCdnYvC6hieWf25Kq9YIlLtnQNeBlMppK70V8tsw4Yt7zcAcmS4vKT0HxEg1KUdj9
	 lHZg8WxwIZ1/t2JUbwyVbfCzDEskk9FdmndHxI7fknPPtRKEeithQ1Souq85C+OU3rLLl
	 TVGEw+tSH7a5reMbMf7KNOsQ+sDP2hVqTHZHPEM3G2GsYDI85vtDBTFPza/jl8dTUD+rn
	 ZOLYJeR6a0IseHHPVHI8H85SDq1amIq7nQYw4Q8yXu4lU/izFQDg7JL7vDADv6wnSrA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794451145;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=A93ABjocx9uL1DqL9S/pXrd1FNBa30r5mGbJE0GOHJ4=;
	b=V4SPQUxnczTZJfhm46/DZB0JeJIkDZcJQ5kolYFaaBkFU+hGTJfmrgG2cysWX6xHHAvv
	 7mC+wlmU25iBHlk1uwvggfa8orp6QSmURM+QdnTWjXMnyNPujbFxlG5MVSktTjydNKjAh
	 FD4IpvnmQC+sVcR55cDGye8S5grXR0U7TjO9nXJ5KnlEyRfCFe3LMPt1IEgUABklGMqrX
	 IkZBwIm6enNqs2CTeeoESH0EKwyqv1Jq38uZ75iHBz+PuPT8mMHhj6WwDD7BW2Y/fBZjU
	 zefb8ugqoTTnf/eNSlUiAgxfxyazEQ/9IgWik7K2KT2j1vxQw+p0dl0WN/4V5d5+BjA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=AwLhSBZg;
	arc=none smtp.remote-ip=74.125.82.49
Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20DB9606A31C
	for <linux-bluetooth@vger.kernel.org>; Thu, 12 Nov 2026 02:39:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 20DB9606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=AwLhSBZg
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-1a2af4c8d00so3816375c88.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 11 Nov 2026 18:39:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794451144; x=1795055944; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=A93ABjocx9uL1DqL9S/pXrd1FNBa30r5mGbJE0GOHJ4=;
        b=AwLhSBZg6p+vyC2DJbsdeZFZDI7O6GqzW7zJkIxgeGp3CW/hsswQ36JrBG/QffQdLD
         tgr+ZYBqkNMJVGu/jzFZUFGOoV+zkngYBCf8AZUgt6/grgzH7vXDTLoZy8P2GZlhUA2y
         TQiff6J0Egrc59g/0W4aJXmjOQDYsOZB/baOqzZ5srfFmMICthRWDqkLA5IH7lNqVTTC
         XD4Ec/RmweGW283mH8z0rLCJYu8AQEwXIBXAcl5Fh0/eSqDO/nJb2Jk60oj6Jyq0+qlC
         VNhzthkYwJfn7cVrCJCYRcJkWibYFCy5yOTZRBGQ6XIt2FubX/1VjouCeTqRpDUaUGLC
         5mlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794451144; x=1795055944;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=A93ABjocx9uL1DqL9S/pXrd1FNBa30r5mGbJE0GOHJ4=;
        b=FrQBKhAh0dk5wTGgtHHvEfbjU6Tl4W4SSH83DXTgJLvgzXufGROvR7+cW5Rj6T/u9H
         RpMXdfWjAUcyBkDntXim5rKrdm0PKrAKYv2M8UCnf2O7QnvXi3dC0XCOkicRZUDGsgns
         +0ffNEnFZTjej5+CEglTPgNITg223kcpAWJ8iS6CVEp2G+siAqzlVlVVoT54NeSGakv9
         ByR5UefmT9rOI1W1+Mfeds1fO+goU4F3zOQff0jO1legWfekIGbwsOow70gjLcFy3kHb
         4Dtut0iqQDPNe8l31P8A01RIEKq+c9lX7vxiZEmB0JWBsTxLny80Z1t9Cn1ccxS25OOk
         59GA==
X-Gm-Message-State: APuU4Z/aewU81vO2TbASLOCeAE8OegRpJuT8r+e47C8zUTE7Ygt/ZzLn
	VVTGbWILObBrdBAMu/tmAiH3arJbEG7R+22Og3koPBzsyDGPclwF7SLtiWUhmmqckWY=
X-Gm-Gg: AYBFou19KetEIGCGUjw7yL5UiiMr/SpogPmIaavJEP24OEAItRbqjkP3pGImWxXuDBp
	l6DqBU5F+I5bJLflgBPmwWEknU8of0uKSuX1PAG+C+x7YwjEZiHz6i3jlH22iUqJJB5MbEpq5PG
	aStJsit9Od9povhIhyZvH7kecb5f1976BKWI8aR+5v5GM2NrQgKjebU260NfYQPjywLWasExPSE
	K8PTdw7uwFWHlKq1MfzhpNPfHIKlrCm95fb0XMih76PbzxSTVaQdbboFgxzDDBPXQrwowTNlKUP
	WCmJyLbL5LQdmdfWYRuakDo73n9FD1cyEHJi2vXay25ke9c9ipft1DH0dKxaYQe0n5DcPI0UoS3
	+GWJo0pocpWqoQUC5yvOPuVguHGEKw2UFaDTMWcneJYYJclvHJ1v7rmNbnIlnP1aHMGcT6kBO1N
	hMbD++w5oeSNrEDNIivicZ/uS/3lHH9xYE8W2THrBhrpOA9uMsBmH7hGRJJuprnV6Z5dW77Qufh
	FmVBYzHzpsqTFBAdrqyKxGZ7VZtMH2N0eYx7ov1W9KTF8FPujW24SK/erJPxzq5UBCf8CVkZsUJ
	FtA4URmxKV0DHVrJACxfHKLwi68i/ZGPIBAVWQMBdqB1TyVBZ6reXPaNNMpFlQxOeE3aB0LGV9h
	nkDz3p1Nck7xkj7A/rUrA
X-Received: by 2002:a05:7022:5f1c:b0:166:b307:5855 with SMTP id a92af1059eb24-1b3c0163bb6mr3942162c88.0.1794451144080;
        Wed, 11 Nov 2026 18:39:04 -0800 (PST)
Received: from localhost.localdomain ([96.44.128.241])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b3b5b4efc2sm17819912c88.15.2026.11.11.18.39.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 18:39:03 -0800 (PST)
From: Weihong Guan <weihong.guan@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Weihong Guan <weihong.guan@gmail.com>
Subject: [PATCH BlueZ 0/2] Single advertising set in the emulator and mgmt-tester
Date: Thu, 12 Nov 2026 02:38:56 +0000
Message-ID: <20261112023858.892176-1-weihong.guan@gmail.com>
X-Mailer: git-send-email 2.47.3
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A controller may report a single advertising set (LE Read Number of
Supported Advertising Sets returns 0x01 to 0xF0). The kernel then gives
advertising instance 1 handle 0x00, the handle Global Advertising uses
too, and several places took the instance number for the handle. Those
were fixed in bluetooth-next by commits daf949c968d4, e7e877bf658a,
8b1eff978e66 and 4dce35adafb5, but the emulator always reports three
sets, so mgmt-tester couldn't see them.

Patch 1 lets a test set the emulated controller's number of sets
(btdev_set_adv_sets(), hciemu_set_central_le_adv_sets()), kept across
HCI_Reset; the default stays at three. Patch 2 adds three mgmt-tester
cases on one set: the random address, the controller ending a timed
instance, and the removal, each on handle 0x00.

How it was tested: on a Raspberry Pi 5 running 7.4-rc2 with
net/bluetooth from bluetooth-next.

 - With the four kernel commits: the three new cases pass.
 - Without them (bluetooth-next at def8a484b): all three fail. The
   first shows the bug, LE Set Advertising Set Random Address for handle
   0x01; the other two fail when adding the instance, for the same
   reason.
 - The whole of mgmt-tester with and without these patches on the same
   kernel: the same tests fail on that machine either way (Read Ext
   Controller Info and some LL Privacy cases, and a few that pass or
   fail from run to run), so nothing changed for the existing ones.

The bugs were first found on real hardware: a WCH CH582 running an open
controller firmware of ours that reports one advertising set, driven
from btmgmt and checked with btmon. These cases let anyone repeat them
without it.

Weihong Guan (2):
  emulator: Set the number of advertising sets
  mgmt-tester: Add single advertising set tests

 emulator/btdev.c    | 18 ++++++++--
 emulator/btdev.h    |  2 ++
 emulator/hciemu.c   | 14 ++++++++
 emulator/hciemu.h   |  2 ++
 tools/mgmt-tester.c | 87 +++++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 121 insertions(+), 2 deletions(-)

-- 
2.47.3

