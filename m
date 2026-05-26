Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A5773BD62C;
	Tue, 26 May 2026 13:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779803480; cv=none; b=MqMC0VskP80DlKUmdLDdzJ+aBExBK88LD1FogZdC30+nSIGDQxSn3DO3U7xcZyNOiVeMJ3u58oKkk2ZhVZz/MgeHdQl67xxkO8Ij3sipZ/bUM/c7Rt5obh+7NpMdE0jh4OMIXfS3e2GFWsBnDwSGcq4yyL9qhyn5l5PiYanx/zI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779803480; c=relaxed/simple;
	bh=+WbVZLXn19xI0pHJkSI0VomvRAnpKMxTGzncn1+jgfA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Vgkmkhx+BVYy5kdICYGx8+meOnGrRut81fquWkuDfX1ouj7JCY2de3OWboFgeN0WUnZ9G7xRJY4jr02Z2MNV9DqUbsqIxlWYtlGNU2AqOL5w5/YcO242qN/KRI/uNnSK/mVypu5IB/mKOu1/YN0ei7TcTSjJCCjPQuJ2B3/E2NM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=mRKQiSGa; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="mRKQiSGa"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Cc:To:Content-Transfer-Encoding:Content-Type:MIME-Version:
	Message-Id:Date:Subject:From:Sender:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=STA9icRdG3qXVU+wm5YaThdRpZU/PIx9+fIBJc2WxpA=; b=mRKQiSGaPH+RGi5qMEI2jVLjhe
	qLIPIMzB4RJOgu8KTSp/luAB1vPp093unhYP9UIKrN4vz33sgzVStdw/fpLwQfntwxZVCa8VLsMuy
	hCXLofVaTJLbmFuFKkvfHvLX0Q6uuXSHlVPTwfZ4qbKRjx/bYAigTVQkxMJNuaMFA0S0kqT18vad3
	eoWTU0QSwYABsX+2XF70KEh4Wy2iMd/smQeU6JofyRseNX/uFM3VW/lGVXvg5yhABCnlklYbfkyrQ
	ZSnZIeSNjLZO2Gp75duygky+yLergh1ap2omdduRDbIazU8G0wTH3NBZxqakUilxyC+NaFWCl4Zrb
	v++3hX5g==;
Received: from 177-136-90-227.vmaxnet.com.br ([177.136.90.227] helo=[192.168.1.54])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1wRsBc-008SdX-3C; Tue, 26 May 2026 15:51:12 +0200
From: Heitor Alves de Siqueira <halves@igalia.com>
Subject: [PATCH v2 0/3] Bluetooth: hci_core: Refactor HCI reset functions
Date: Tue, 26 May 2026 10:50:56 -0300
Message-Id: <20260526-hci_send-v2-0-596977a9a814@igalia.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/22Nyw7CIBBFf6WZtRig9qEr/8M0Bum0jLFgoDaah
 n8X6tblSc49d4WAnjDAqVjB40KBnE0gdwVoo+yIjPrEILmseSVKZjRdA9qe1Qcuj7zHRmkNSX9
 6HOi9pS7dj8Prdkc95302DIXZ+c/2tYjs/ckuggmmsEQcmqqVLT/TqB6k9tpN0MUYv1Er/PizA
 AAA
X-Change-ID: 20260513-hci_send-640290de7acc
To: Marcel Holtmann <marcel@holtmann.org>, 
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
 Gustavo Padovan <padovan@profusion.mobi>, Schspa Shi <schspa@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kernel-dev@igalia.com, Heitor Alves de Siqueira <halves@igalia.com>, 
 Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
X-Mailer: b4 0.15.2

Dear maintainers,

While investigating some warnings reported by syzbot on the hdev
workqueue, Luiz kindly mentioned the possibility of reworking the reset
functions in hci_core. A lot of the work done "manually" in
hci_dev_do_reset() is already handled by the close/open functions in
hci_sync, and those also handle missing functionality related to LE,
discovery and advertising.

This series removes most of the code in hci_dev_do_reset() in favor of
calling hci_dev_close_sync() and hci_dev_open_sync(). The two follow-up
patches are minor fixes porting over a device flag for indicating when
the workqueue is being drained, and another for zeroing device counters.
Although I've left them as individual commits, they could probably be
squashed together if that's preferrable.

I've tested this using the Bluez HCI emulator and corresponding tester
tools, as well as on a generic USB Bluetooth dongle. No regressions were
reported by l2cap-tester, mgmt-tester and hci-tester.

Signed-off-by: Heitor Alves de Siqueira <halves@igalia.com>
---
Changes in v2:
- Removed most reset code from hci_dev_do_reset(), in favor of
  hci_dev_close_sync() and hci_dev_open_sync()
- Added HCI_CMD_DRAIN_WORKQUEUE to hci_dev_close_sync(), as it's now
  used in the reset path
- Included a minor fix for zeroing protocol counters
- Link to v1: https://patch.msgid.link/20260513-hci_send-v1-1-ae3eef758280@igalia.com

To: Marcel Holtmann <marcel@holtmann.org>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Schspa Shi <schspa@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
Heitor Alves de Siqueira (3):
      Bluetooth: hci_core: Rework hci_dev_do_reset() to use hci_sync functions
      Bluetooth: hci_sync: Set HCI_CMD_DRAIN_WORKQUEUE during device close
      Bluetooth: hci_sync: Reset device counters in hci_dev_close_sync()

 net/bluetooth/hci_core.c | 43 +++----------------------------------------
 net/bluetooth/hci_sync.c | 12 ++++++++++++
 2 files changed, 15 insertions(+), 40 deletions(-)
---
base-commit: 8bc67e4db64aa72732c474b44ea8622062c903f0
change-id: 20260513-hci_send-640290de7acc

Best regards,
--  
Heitor Alves de Siqueira <halves@igalia.com>

