Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 903153126C2
	for <linux-bluetooth@vger.kernel.org>; Mon, 22 Jun 2026 14:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782139943; cv=none; b=YwHZTkuKtLPQxfS6CQr20yCMi3EF+wjniV/ywpkV7pImB3oBLEwSzHgGu/txvu4xgUa5VHmjWuMu3X2luBZOGl+CanxbYDWeNNdsPt1B1U+RtNsAyVipKVn/H5LBKyGdhebrcylXk8ED+G9q4FM3vqNDTQFFJ4wsYUQymLi6grw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782139943; c=relaxed/simple;
	bh=vOD0VCNIfLO8tPOwqvxHTfl3EIp6ZMGwmN3q+QlUvLA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Ur0oQrpIlgPMCMBSDCXArpkiAUwJ9SkZ8W9/aNr+YhPx0OTCN6V1dCF/tQd5jDbm5Y+yduwwuo+l8F/fep6Y97bA2pw36fSOPbqYyXUY6e/bbSzMw6ghzJEf72UNg1fGK4X3eJrE/Cpzdpw8tKg/ccYJL8K9aSsLAKHukiXbvD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=mcOdAtt4; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=LG26BZRH; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="mcOdAtt4";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="LG26BZRH"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65MDFvC91061110
	for <linux-bluetooth@vger.kernel.org>; Mon, 22 Jun 2026 14:52:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=vCOUC2LBhTnnmYlqCxPS8k
	2WyBe7Ospqvnq4gVsyoOc=; b=mcOdAtt4AK06vvk2njKGx4oUj6VgAHDkiWGz8d
	uDE2MyNBoiLPJQxmsCQPqrQcbFN9linmW5Xeg0ptVaHlc5/V0yRQaIwcw0RGunBm
	pa1pN+I7R9+51tCxl+ErArVoFjfCil1HGvaUfG+rQlapPYYVV0XNvaAzZ3i0+bwN
	X9lCkA/icYMylxpgRa4CLUylFrx+9CA4yIpSRbnLH6tMhe7WxmbXjLwhkZJsmxur
	u5G+rF0JE5Z6eBuCIv6TFGOeYsTFMHmCRFU+i969AazBzoqzMvKw2Oeuf9Q8UpRp
	4VLk3JAn7hYrqLS+2R4HgQT9pGrMyYCUqF+gVrwZ3bTFkd0w==
Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4exyn1t0ss-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Mon, 22 Jun 2026 14:52:17 +0000 (GMT)
Received: by mail-dl1-f71.google.com with SMTP id a92af1059eb24-137f3c83df1so228377c88.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 22 Jun 2026 07:52:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782139936; x=1782744736; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vCOUC2LBhTnnmYlqCxPS8k2WyBe7Ospqvnq4gVsyoOc=;
        b=LG26BZRHQ1ahiUBTHRJecoR+di2BWJjaqIbVZwsoq9YcLVDjJOAy4USuMDn0hbu9/r
         0dgd8bLk8YZw1eNSytC/ZkI6gYT5qrbrN6PlfiX/d3NXWQwTp7x7R7SYIs/P3WVzXdBD
         SjUjAouVTwTXas2FYoZOhjPM13lMWEC/jNKAyRDz5aTDDqyFzePWRa9xyZZSFlNr7/iO
         oBfA3JJl7kL8agwTyIYk+t2Aj2f9Vx7BCRTc3ZKk8nfVemHVLVnAWKmKLT4+c5Gmh4aA
         o9/UmM9k96NGL65ug3Lio0AYVAs23jcWdnnv1tnnXXcTJox6Z5no5ug+DJvbfJDx0ZFz
         MMVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782139936; x=1782744736;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vCOUC2LBhTnnmYlqCxPS8k2WyBe7Ospqvnq4gVsyoOc=;
        b=aPJer6cYYJ7p4b5D4QP48HLUIk85UOTC8rH3Jp7BYRtPA8KDvNcFJy2TfPkHALMO63
         V91wjiEU5eusHdbx8+gM52sKYlepY+vMdgJCzGsChx6ImDuMWVofXFLOgaivxLCdZ18g
         O3VbCi4OtrGbUwlGpn9m3lAPChJCcjRn4MojdeRb/9n0n4dyq6NMsIckKklLP9HoOmqn
         gsNmaR362uLuDld79GLYx827apznaEXdmZeHs1+2+Aoe5DfOX9cSDY5mbkM9VDeFVfGZ
         CNhArBgsP+h7GDLkyWJO/kHMEe2OaZBojL4iwIKepjTZH9k5zO/NPCjtDZ4pYCTT7f2l
         hKvQ==
X-Forwarded-Encrypted: i=1; AHgh+RoMJAYTb8qzv5Qch725Vj7xot0rWRHDB+ChFMxt6UTJg1DgMEa4QesKNs/eKvJCORoi6T5ZwNmBBjW8IuRbpK8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxvtSETrfIjBY9tTepYJzdBmRG49KBQll2biT/Ca8CTdJgvlnv
	Vex72+7oTkjRckXU0dcPi9PC7jVjXHvLxSfxvuTUb5nU2l0p612V+6Gik1Xv5Hk+ZOsTyWwVE/W
	NsX82DGtFTBFhnIO/uw4USg6uXWeBauV0yobC4qQK1/NPc1bPlNgB11hesMIz1lqgGMb+Jx0=
X-Gm-Gg: AfdE7cmDZtIH2jztQXNKxji8koy1HZjTpH383WIpllrYA4vKeB0J+e4G+cyfyHnR1jC
	TD822u7k7AutKhm1Yss+AQYd9JNYEykjM6B1QsdgAhFUC878lOODp51mVx3aEKvlNiWRWShAiE4
	MV+Cz7q6h/obYkKTOg3AagdOQc1vciwo9HGb5gSjmFeZtkm1ioLfSJ+vkynCq4jwOyebfemugvG
	Ot88st2AO/3cyQLGP9DGC50f+YA0/Hfziv7ETGK0/MEmd3vCy3Zy6RU2oLeu+6cbYe/05fbHkj5
	B91gdM9eSy/5NYlCY07yUBZoB745IJiFTzFIQOcFloCj6Du6pQS+PWLk7LmD56v56AaQBKsMjEx
	F2QEJOlJXEN6fUzDTmsWGwivyIlEdvWOneR6ypn6YOoWaxUKS3P1prEfvaQ==
X-Received: by 2002:a05:7300:3b03:b0:2d4:62f0:b2e1 with SMTP id 5a478bee46e88-30c51fc533fmr234775eec.0.1782139935927;
        Mon, 22 Jun 2026 07:52:15 -0700 (PDT)
X-Received: by 2002:a05:7300:3b03:b0:2d4:62f0:b2e1 with SMTP id 5a478bee46e88-30c51fc533fmr234748eec.0.1782139935347;
        Mon, 22 Jun 2026 07:52:15 -0700 (PDT)
Received: from hu-zijuhu-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30c1bddfe34sm12025561eec.20.2026.06.22.07.52.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2026 07:52:14 -0700 (PDT)
From: Zijun Hu <zijun.hu@oss.qualcomm.com>
Subject: [PATCH 00/13] Bluetooth: btusb/btqca/hci_sync: Clean up btusb and
 fix several bugs
Date: Mon, 22 Jun 2026 07:52:13 -0700
Message-Id: <20260622-bt_bugfix-v1-0-11f936d84e72@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAB1MOWoC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDMyMj3aSS+KTS9LTMCt20pCQjQ7PkRMO0NEsloPqColSgMNis6NjaWgC
 asZxXWwAAAA==
X-Change-ID: 20260622-bt_bugfix-fbb216ca1ff9
To: Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Rocky Liao <quic_rjliao@quicinc.com>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Ben Young Tae Kim <ytkim@qca.qualcomm.com>,
        Balakrishna Godavarthi <quic_bgodavar@quicinc.com>,
        Matthias Kaehlcke <mka@chromium.org>
Cc: Zijun Hu <zijun_hu@icloud.com>, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        linux-arm-msm@vger.kernel.org, Zijun Hu <zijun.hu@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-GUID: rcUP181U1I13wDWZGp6htsowdJ_9qvCF
X-Authority-Analysis: v=2.4 cv=EOU2FVZC c=1 sm=1 tr=0 ts=6a394c21 cx=c_pps
 a=JYo30EpNSr/tUYqK9jHPoA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=5p3etvIpMzrVabLiRMoA:9 a=QEXdDO2ut3YA:10
 a=Fk4IpSoW4aLDllm1B1p-:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIyMDE0NyBTYWx0ZWRfX2Y95U1eF9RsJ
 N+wwphIK01wRTiuseBq2OO/DRTgJCF1U3wGShGLF06250Y2jt5OTGfE9WIVZP7DHQllVd7JbykP
 iift9yXpmR+8TumDU+gfHThBhdON6Ks=
X-Proofpoint-ORIG-GUID: rcUP181U1I13wDWZGp6htsowdJ_9qvCF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIyMDE0NyBTYWx0ZWRfXzGSByivLTmhX
 TrkDADRs5k7wa/+taT9N4OEmKAuaba9aQhHTDSo6H+rf9FgnNPhzQD+raNY0ANm0LQxGrt+3ul5
 GI9FzpbAQzbuxQd3CW08s0l+5kCeHOeH1pkkauESlK6OXqp9xWD/ovEyaexTiOfm2imH/qUQnvD
 8Hi3N7Sa8brgLF5pjsyheByA5LVVJcOOA43nxCyGZCxp/Dw63Oc+tzQSru6wf9tfmKjczMrL74P
 DwabY5Jt9zTuC2X3QbolmZv8CJGPjfO9A3gLQ78eyTph0zaq9rZ0j+XO12aWAc2hAL2W99i8FnF
 A49AJTakNLkoYN/pxWQDt6L4fgZrxk9McNAxl2eXQMRZJAggDNI82QEeYntBQAOYPZGfq2Lqr+b
 ewmEtfYNXrcIkEKrzakv4t/G+3FeuNpXXlVp60nwlT2SDoZlEXxMXBnec6E4dyu1K+UJuZry2iO
 QmNflLhh5TCyPzaohow==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-22_02,2026-06-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 priorityscore=1501 malwarescore=0 adultscore=0
 lowpriorityscore=0 phishscore=0 clxscore=1015 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606220147

This series originated as a cleanup of btusb in preparation for adding
support for a new chip, QCC2072: specifically, moving struct btusb_data
and the BTUSB_* macros into a new btusb.h header so that the forthcoming
QCC2072 driver can share them without duplicating definitions.

While doing that cleanup, several pre-existing bugs were found and fixed.

Preparatory cleanups:
- Initialize priv_size to 0 at declaration in btusb_probe() to remove a
  redundant assignment a few lines below.
- Move struct btusb_data and the BTUSB_* macros into a new btusb.h header
  so that btqca.c (and future drivers) can access them without duplicating
  definitions.
- Record the matched usb_device_id pointer in struct btusb_data so that
  downstream code (e.g. qca_setup) can inspect driver_info without
  needing to re-scan the id table.
- Move qca_dump out of struct btusb_data into a dedicated struct
  btqca_data stored in hci priv, decoupling the QCA coredump state from
  the generic btusb driver data.
- Simplify the hci_reset_sync() return path (trivial two-liner to one).
- Add __hci_reset_sync() as an exported helper for vendor drivers; it
  sends HCI_OP_RESET and returns a proper errno.
- Use __hci_reset_sync() in btusb_shutdown_qca() to remove open-coded
  __hci_cmd_sync() boilerplate.

Bug fixes found during the cleanup:
- BTUSB_IGNORE is a bitmask flag and must be tested with '&', not '=='.
  The '==' test would miss any device whose driver_info word carries
  additional flags alongside BTUSB_IGNORE.
- qca_setup() unconditionally populated devcoredump fw_version and
  controller_id fields even on ATH3012 and QCA_ROME devices where those
  fields are meaningless.  Guard the assignment behind a WCN6855 check.
- btusb_set_bdaddr_wcn6855() passed the raw bdaddr pointer to the HCI
  command without byte-swapping it first; use baswap() as other set_bdaddr
  implementations do.
- hci_reset_sync() returned the raw HCI status byte instead of a negative
  errno on error.  Add the bt_to_errno() conversion.
- qca_send_reset() used __hci_cmd_sync() which only checks transport-level
  errors and silently ignores a non-zero HCI status in the response.  The
  function is replaced by a call to the new __hci_reset_sync() which does
  the right conversion.
- qca_set_bdaddr() passed HCI_EV_VENDOR as the expected event type; the
  correct value is 0 (any), matching how other set_bdaddr callers behave.

Signed-off-by: Zijun Hu <zijun.hu@oss.qualcomm.com>
---
Zijun Hu (13):
      Bluetooth: btusb: Initialize @priv_size at declaration in btusb_probe()
      Bluetooth: btusb: Use & instead of == to test bitflag BTUSB_IGNORE
      Bluetooth: btusb: Record matched usb_device_id into btusb_data
      Bluetooth: btusb: QCA: Do not populate devcoredump fields on ATH3012 or QCA_ROME
      Bluetooth: btusb: QCA: move qca_dump out of struct btusb_data
      Bluetooth: btusb: Fix BD_ADDR byte order in btusb_set_bdaddr_wcn6855()
      Bluetooth: hci_sync: Simplify hci_reset_sync()
      Bluetooth: hci_sync: Fix return value of hci_reset_sync()
      Bluetooth: hci_sync: Add __hci_reset_sync() for device driver
      Bluetooth: btusb: Simplify btusb_shutdown_qca() by using __hci_reset_sync()
      Bluetooth: btusb: Move struct btusb_data and macros into btusb.h
      Bluetooth: btqca: Fix undetected error HCI status in qca_send_reset()
      Bluetooth: btqca: Fix qca_set_bdaddr() using wrong HCI event type

 drivers/bluetooth/btqca.c        |  25 +----
 drivers/bluetooth/btusb.c        | 197 +++++++++------------------------------
 drivers/bluetooth/btusb.h        | 139 +++++++++++++++++++++++++++
 include/net/bluetooth/hci_sync.h |   1 +
 net/bluetooth/hci_sync.c         |  18 +++-
 5 files changed, 205 insertions(+), 175 deletions(-)
---
base-commit: cb20f6afc25b2b54c0fec61b45ac0ec9eb875d59
change-id: 20260622-bt_bugfix-fbb216ca1ff9

Best regards,
-- 
Zijun Hu <zijun.hu@oss.qualcomm.com>

