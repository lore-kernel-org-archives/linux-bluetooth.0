Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.6.129.228
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794882951;
	b=JEsFlTD+SpB3Zj9xqnhzigwUmfQ1VGE+xr+G8XkNg5lOokbbg2qZWoDEeEtyyevyM9E/
	 YhpG1hACvQduHUJNVCSRw1PqLK2jUdet1ezSB/EpXOtMyzgSXqcgK0C2YtasHsfCviTkS
	 In9oyvLVVBD5y6SSTx9JjnxWbSTkb07ssendSuUhxSSmB7G2JxTjx1pa6yve2jq/v+Yqr
	 4ALpW2qx3nBl/zK1OahoXaw9NhGuNFgdTNjWeG7coRNVcv9M8Mp8IAj2IgUbmmu2NQewl
	 iLmL0Oek4dii1baI2NlN6ldlR8u98Cakf0YZyuPDdR12oqw6us0wBtNVJzk+MRJPaqQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794882951;
	h=DMARC-Filter:DKIM-Signature:X-SONIC-DKIM-SIGN:X-YMail-OSG:X-Sonic-MF:
	 X-Sonic-ID:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding:References;
	bh=Ge6foGm3zZYc3lFUxAHqTqjfYDiT5qM+eYN2cVnPtsI=;
	b=LzPi08wwnGtjubr+UkGW+NYrIKLqgrL8OmTP4g0bqjnFrsyBOWYBQmBcH2VezntdhsWe
	 V6Y6MG/Oyv9q9fgDwfSd+av0tqG5/4jk0Tsinic7h5bUlsMYmfUOB7LiLH20HeEckFV8x
	 JslVbG7KGeqNC9Seq/FlCULEYAcO1XpJuNiYyT1LxTiw71hTqCAiecOCB5R2e8BnICbf7
	 jaSKCLX8jW55IVU5BJY1DkorjmoQJbzqHjdJAfRFi0U0rh2P0+a7OQjzMmnewcarKRpXl
	 EcHisrDKDe89nyr6kPyTYQdb0Rn2VDcKNcRndu6ZJ5sU7So7xFVxZ0kI4CgZFcLZjfg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=yahoo.com;
	spf=pass smtp.mailfrom=yahoo.com;
	dkim=pass header.d=yahoo.com header.i=@yahoo.com header.a=rsa-sha256 header.s=s2048 header.b=Yvmi2hZR;
	arc=none smtp.remote-ip=74.6.129.228
Received: from sonic301-29.consmr.mail.bf2.yahoo.com (sonic301-29.consmr.mail.bf2.yahoo.com [74.6.129.228])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFEB0606A31C
	for <linux-bluetooth@vger.kernel.org>; Tue, 17 Nov 2026 02:35:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DFEB0606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=yahoo.com header.i=@yahoo.com header.a=rsa-sha256 header.s=s2048 header.b=Yvmi2hZR
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1794882949; bh=Ge6foGm3zZYc3lFUxAHqTqjfYDiT5qM+eYN2cVnPtsI=; h=From:To:Cc:Subject:Date:References:From:Subject:Reply-To:Content-Type; b=Yvmi2hZRJwAL1SyHCHtCLR/gUbv+wox8k10nuVpl99hEujcxJTAMCuywXRbdguldLd0iR6MDlc+3Wwy0L7xdNuRZ2FR+d1zr2auURSIvxvJNxiTDm0wriAfGb4UFgFW4vh+FvMquOhGWgyu+7VQIJkDDbOTYDLAZyKK+wt3GQxvtz2BRs7w3M39ZgZcm91gHxICKJDyo5YZIFkUcMa5RQkTHgR8iGr9nxx7b2vo2UyFZRwds3qrxn4R3b/yGetynACxqZHvm5DPI4T1uae28sZcFiKw5xZwsCj0fpmPAcCkFX4Ax4cv44gI8uZMLWn1OcN0CL63f2gI0BAgDp9SjwA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1794882949; bh=qyFM0S3NBoOMZiI3TPx7GzpmRnfuspDqBo0rsGhOOaJ=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=FcapLUswIIAh5J64aeeifZxWBTNXz85Nu4fOqqMD09AgM22MC5ssEjN4YRoqyHzc23vhOKD1PDSNL+3CwuBJmCMcANZ6WruOLiGXCOQPBYLjf7de1c/tvNDFVpnIZc5vDmdr5AGf3wLTb0jWsztnSUe/eUZiMtKkz2PeMpDFf6ik6mA6H4BOfN5vt4hsDyF3D7U+fZGumBCueaPeqvZNRxneIqPE3rfFSwA8o2a3nib4CsMdGBpW9c4zkEo7b8+KGdhrdKrIWg5+U7W3v8Vs2aiRoLT0HlgftWerrtzYp3bW36m+XcU2dEfKkrm/WqG9gvOkJk/PSmdrGFWivqTc4Q==
X-YMail-OSG: V4IBVQ4VM1lXsKjmd23pwbYnqvpK03O54v06LyR4l3WcJu.c2lRwlHKJkIcerIN
 k6gXKXKjHOqvT7g2Gk9Ximqns3B7hHr..enJO8clz1ETsz9kUknfjfu8gMZ30ccumywECbtno1qo
 tJVPzlDXhROHBFeW8VXMF.npvn1ld5sitHVdnvwgmJjZh5WmKMHa44whNXcs_dEorB_J.xztJrV4
 d3sXl4jdIoP38tz2hG7N7APFZ0K.TED3H.e0JdS6CB2xeA.SrPekSurSLaSU_fpEoWXw3s7o.xb9
 AZ4lQx2o5rgVmVMHQbUPKF8TdWM3UD2SRGRw.iB3TfqVtZAeXwsU.w1g8VP8GL1Ex06GFJqXUYQT
 x8YuGC2vq6iH_UhxAtmFZ1mCCLLi5ODXFWG8Q1neg326ucd03sLPDg.vRs.f.Zk48J1o0yxCa2sN
 zjXLW0wpnrngk0Hmn98TpC2wW1BaDhoKNDYKZWON7Dtzx22Y9URCbueNEgBVZhR1wYkL.Ma4I_v7
 M4vGgGXMnb1XC_Lm3oDjDjmFJHsByIngSDN_pGrMgxK2jgi6OaIjdkpgBpX1Mqui.gL19D0QRnY3
 w9lm4mPPt.9.UyDnRMF4he4rdIkiS3bXgsxXnQ8t3oBG7jkW5qLKNO.baksSn8WZ424Z89.ZSKeI
 X0Wuh8vqeP9ig3dFhOpM4TZsbaGiDaiCLSW01tcqapjIDwqo8ZcBe2fgpeYOxnGVu_CKp.UTO_sx
 xDptPbszmhRGxIBy3XKgVlcQLXznsIGxvvtLml5gzOfEjbTUjozS_D7J.XcYB2tYDrxnZ_VprCNI
 TagQ6Tek_yQWg.jglie_Y18yqJv_6MlE4eFSZOUHEMbkdqsQtAkNX89vqPdulgfSnZCjz6E1EgBk
 hQUW_b3GgpjvZ8HvnDreWGEA_eN7PiROlah4jZYLbxH1OGT3XNtp5vc07hsSC8vYAWbdSLsXjB7p
 Rs_nNORHCnzgmJ27UetSpp776LjdY89TECVKTQEbYJyrNBZula5EsVMVKoDS1uQ1hRgByZMGAQ8y
 AymJys29pqQnBdL9S9RFvHNxJdVOtl07JfjvirgBF.CO1ySzNG6zEbtc55Boi..NXuqsEvqFzosB
 PFM6j6wGtgXXAMyp8AFFnq0dr3BLTdCqmauHMBbdG2ZlZ2hcX84Z71tEE3pEKeaZ2yDFFehNENVP
 X7sVtHoUroZiS3m37gympdLYtSyLDZQ_kfiaiR4RG75KLOpz2ieRQ.4rgz5Fh9cO4osodtpa3K9W
 n6xi1Jggl78X4bBDoXF6N3AZVmxgZj32s4_PfrsW587N.1H7O6INYRMdMBuOKgiANHsNfW3cRLfM
 ei2VRnfDcEbzkb8DPm2kPgifKtUyFZwSloJDnq_NLmCI4XT9k_PFzpH0Fte0s1StBQfJXhCoWwjx
 mYo7FmP8H7uvFs5hTP23fZRZyAR0IUIL5W4MA9.6AH.O9oU8lcl_gGjRlCZtYdO_nnYZwsb3EKAX
 _y9fYjI_6PbrAR4mOU1DiE1muKjo2HOcL0_6dBM43Ezb5XqzmwRI7op5VHlgrJpSK4f6beSP4RUv
 _zC_wg5Nc2r119uWF5ApijZHhggeOppGzU6ovmkBLUCSi4wejOW3xP9dT1HUQuU82m34BY3ltKVy
 VvfXto.MddR7DFqtnmG2qn3QGaYXGibQKmhb7y.RFpks4LCmj8AXwAszT3xUY3pxeZWTglJXqpq3
 xbEYkfD7bMy0n0uUDjwZmGHgjmqRcHTMse.M_dyfvXvy0eCpe5q.Fdl5OhWeHdonGBhIuEyLJMlV
 Pniv3lQa59bW4wfiCffB07oxJ_uz3R2HDfgqUz.BJXyWkMx7NXtGKSCe.Q4EJHgsyxa9T6I161ED
 n6nVqpu5M21QNz6qi18U7.7y3.PQc6lYtasKHgm67BVcB8SnhYthnLWTqpDnRLbLjkGsEyClPUlj
 50SH8XsS2vHgXSJwSJnygbN9pTcs4Z80qRRDroPffftBKSgmGEkb3R3rBUJXbGEtYor4CjH4.730
 q.IRS.zkCzUYeN6IyhBnRDPjSKgPVMVCLUsOszzAt3IkQWzbG_GlY1txe.ymMMrbptP3z9Yhp93x
 Oc0gNhZxH7T8u75hoBMM2jc05dsTOtG2yFz00vzGu1vXjQ41V7z9KuzGa2VUB1XC6dMJJm.dKjFX
 wgdm.X1tOeZ86Yq2Hwn7lCXgcbpdFhGQZngaHXf1J6CC7EAkrpck_D_hyzQFvI.RWIjIoCiZs2E.
 gRvEqCvT9gV11uuexWqIyHali3szfTlkEIv_P1lGVlpdFgaMSWk7z2POuap82yL_0hQzMyNOyOli
 MuOhvaXH.JOhmqZmpDX2ko5AvSNxIPlo-
X-Sonic-MF: <deaner92@yahoo.com>
X-Sonic-ID: 46035bde-969e-4f3f-a20d-8ed964103b98
Received: from sonic.gate.mail.ne1.yahoo.com by sonic301.consmr.mail.bf2.yahoo.com with HTTP; Tue, 17 Nov 2026 02:35:49 +0000
Received: by hermes--production-bf1-6d6877594b-c5dh2 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 6b4a44673d94ff3e2f092b66bff98f7f;
          Tue, 17 Nov 2026 02:33:49 +0000 (UTC)
From: Jeremy Dean Clifton <deaner92@yahoo.com>
To: marcel@holtmann.org,
	luiz.dentz@gmail.com
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	william.xuanziyang@huawei.com,
	johan.hedberg@intel.com,
	hdanton@sina.com,
	Jeremy Dean Clifton <deaner92@yahoo.com>
Subject: [PATCH v2 0/3] Bluetooth: Fix work queued while hci_dev_close_sync() drains
Date: Tue, 17 Nov 2026 02:33:41 +0000
Message-ID: <20261117023344.278269-1-deaner92@yahoo.com>
X-Mailer: git-send-email 2.43.0
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
References: <20261117023344.278269-1-deaner92.ref@yahoo.com>

syzbot reports "workqueue: cannot queue hci_conn_timeout on wq hci0"
from hci_conn_drop() while hci_dev_close_sync() runs drain_workqueue().

v1 made hci_conn_drop() skip queueing disc_work while
HCI_CMD_DRAIN_WORKQUEUE is set. Sashiko pointed out that this misses
two cases: a connection delayed work whose timer was armed before close
can still fire during the drain, and a connection created after
hci_conn_hash_flush() is never deleted.

v2 drops the hci_conn_drop() change and fixes the cause instead:

  - Patch 1 frees the unset handle when __hci_conn_add() fails. The
    leak already exists on the -ECONNREFUSED and -ENOMEM paths, and
    patch 2 adds another error return. Sashiko found it while
    reviewing patch 2.
  - Patch 2 makes __hci_conn_add() refuse new connections once HCI_UP
    is cleared, and asserts that hdev->lock is held. I checked every
    caller and all of them hold the lock.
  - Patch 3 disables the per-connection delayed works before
    drain_workqueue(), so neither the timers nor hci_conn_drop() can
    queue them during the drain. It depends on patch 2: without it, a
    connection added after the walk could still queue its works.

Testing: built on arm64 against bluetooth-next (da3cc02). With KASAN
and lockdep enabled, the syzbot C reproducer was run under QEMU/HVF
(2 vCPUs), one fresh boot per run:

  without this series: 7/12 runs hit "workqueue: cannot queue
                       hci_conn_timeout on wq hci0"
  with this series:    0/12 runs, no other warnings, KASAN or
                       lockdep reports

Sashiko reviewed the series locally with no critical, high or medium
findings.

Claude (Opus 5.5) helped analyze the race, draft the patches and audit
the __hci_conn_add() callers for hdev->lock. Sashiko reviewed v1 and
this series.

Changes in v2:
  - Drop the hci_conn_drop() change.
  - Add patches 1 and 2.
  - Disable the connection works before the drain (patch 3).
  - Fixes tag changed from 525daaea459f to 76727c02c1e1.

v1: https://lore.kernel.org/all/20261020145320.115333-1-deaner92@yahoo.com/

Jeremy Dean Clifton (3):
  Bluetooth: hci_conn: Free the unset handle when adding a connection
    fails
  Bluetooth: hci_conn: Refuse new connections once HCI_UP is cleared
  Bluetooth: hci_sync: Disable connection works before draining

 net/bluetooth/hci_conn.c | 16 +++++++++++++++-
 net/bluetooth/hci_sync.c | 17 +++++++++++++++++
 2 files changed, 32 insertions(+), 1 deletion(-)

-- 
2.43.0

