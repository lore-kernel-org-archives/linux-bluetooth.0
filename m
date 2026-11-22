Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795378407;
	b=zd2KO3Cu8kRUSiVmh4GW/Zb6Ebt/WXAsHQbVo8AhRtg1N6PdFlFq6Z63TrEab1w8Itot
	 SIgdMKtihX/9NrCZy98lwZxtHPLr4rn6Grrd1FcOUagsPPRL8e4pICKxSzJQIqoW1ou0A
	 et6nYm+O2QbYe8rrdcV3z7mo0+pKfHUPqqu30t7TPj8YEMYjlpThjm8siZIJ/wzCKUzrP
	 KWYWQBFu9rpJK4lpYOK8jtXzoipOAMp+n9Kq8lg2GOyIm6VsRU+pT+jSXVeeA4DqfK1sC
	 49RX1H5ySO6OJjl5wYtMbZhN1BxScFgvPxJkkkGLOfj/fDXIuQuR3SONIaxxOwwf7pw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795378407;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=8AxblH8Bt2Z0dAUNptioluuArRPLJb6+/w46pDsSOwY=;
	b=KTyIEN2CSTprV81rT3q+0CsF08VMh+vATEIEFs2ZMwnrfmX3HQXOI+hleyEWdD4NdJeM
	 TVylMmtJfog1q2xOKjNSNR8i90OTlrmWmSzIaCFPO2W1bNvE0yVmeHS2tE7l2H5f/Aiso
	 Fhb5EPrz48R2LDt/cK4tFes5lQBb+U3i2C6+FxIRCyL8Aur31deUyV5f5M+wuPb86BCcH
	 1y/ISxtF9lbSgyw1/RkL6AAuUnzZhXaHJ0N/WY3YgQ/IDJh17Z9OWIMMfrRwIHOh/aGS9
	 /QDdq7LX6GsJMdbKE0jBg/eUz9ArKqhYHd16W57Ll1dNDgZbNi6diiEjnveBUCabFbA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=streamunlimited.com;
	spf=pass smtp.mailfrom=streamunlimited.com;
	dkim=pass header.d=streamunlimited.com header.i=@streamunlimited.com header.a=rsa-sha256 header.s=google header.b=pB41kxWT;
	arc=none smtp.remote-ip=209.85.221.41
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D74F606A31A
	for <linux-bluetooth@vger.kernel.org>; Sun, 22 Nov 2026 20:13:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0D74F606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=streamunlimited.com header.i=@streamunlimited.com header.a=rsa-sha256 header.s=google header.b=pB41kxWT
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-4a3e706b5dfso1705849f8f.2
        for <linux-bluetooth@vger.kernel.org>; Sun, 22 Nov 2026 12:13:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=streamunlimited.com; s=google; t=1795378405; x=1795983205; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=8AxblH8Bt2Z0dAUNptioluuArRPLJb6+/w46pDsSOwY=;
        b=pB41kxWTi1TjxT/sdz25TTB5+6IZywe4X/VDEDsM1wwKFdRIbPorOPPA0qrGssGFAH
         tqaEyd5xBeYfvDuYxn/Ulg5NNGL/uf1AoBdwpG6G8coYIcS68eXQEvQQ+MOQAEhdbWrv
         +OwTbt+IZwONRX1u/s9KAsUy7xV0CM2b2eIx8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795378405; x=1795983205;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8AxblH8Bt2Z0dAUNptioluuArRPLJb6+/w46pDsSOwY=;
        b=XcRgXmRII1CtMP8FywMo4fh+JpVQ5gl+ThZ/M0KjSsripoDyQfA/n/cu7A1iJPHtxm
         QbPz4lWtwsOTWctSJzJlsX8F0laul0jmfGrb7K4S+Ba/uKaBiDPBYVwNbUtugHJDcGos
         r54iwRpZnyFdS619BY8hhxtpMBp4jY8BxvCf/dzViUmQxFZLY6uAoylCA6P0wWC2srk5
         +YEammI/4cPPoAGJcGGJBjLO/VHD7fkhxp9EMtBw7F23xa+TWLpFd8B0fl1lDT9AO2ma
         hQq9xamLxruZIR0tYFQ1gPRBjZge0ncc3lHulMSIenw3k/4Gi5LCpe6JCN/0xnSPQcF4
         OhSg==
X-Gm-Message-State: APuU4Z9Gw48TkgSpNOgSrsb53AdQBxUMhIuZ/zuhz1Np9cX9Lm1YASov
	jzHTACYcDCqOhbVB46DH8JOVXuKIk9u/JzkjYBsdOcffy/+RM0286UEMOyWFYU0jdLaCpcsXP2R
	JVXOL
X-Gm-Gg: AZFdTZdIIey4mrGihhvGFDsZwwdHp73pD+jbw3aAR0AOxViBmF+m9ZGSo5tN/PPOTkg
	5Rk4dXeoBSgHPqqqjYxmecKMbZGScNMUlQU5d3kPDQ2p707PeHW9IFCa9Wh09qhUnaDtLCvozcW
	NrLIyKAkZ8cIYOsoV9xV/+/lYt82dkkhK0uwqGu9TMVWOOCBmbFspxNR9wXxlwGpyZEZwXCncFK
	JWOJjawzX2aIq6XfapONzwva8fQZThZqPOuuezqHy8uudrX/inkJucb/w5b98fHBCjZsvbLSuv8
	+t7TugLvxch2k7AZImqDF+LFRFRZwicCbVk2Qnf6OIIsAKQbWcRi8axpVQMwI93kzy2MlItVlyb
	oqJNbs0owdi7wzrxjv4+nFQpq2zmCJE/rDb+hm/w3zk9mhmhcoJYqSEUOsck/+buvkNdAI+DWi7
	qH/dgOv8GNRGR7vVQoqqouFbFZyfdzT2cm2jO2jyuU548c6OnbZNAxdCSGdVlrU0MIhyIfSfyKw
	zgDIoYSGuHkAHV9K42LwO0NKKZJ8i92kd20b9jEQJA3eZ2Gz5F5vMy1zEAg+xbU4L9efk38ZmmC
	fGjjKICqJfPKlZMifEKH4NvvIfMPE8NnTiGdorXPNzN0t7ZgkQ==
X-Received: by 2002:a05:6000:4b0f:b0:48e:d7c:4bc8 with SMTP id ffacd0b85a97d-4abad6a1782mr17497807f8f.7.1795378405415;
        Sun, 22 Nov 2026 12:13:25 -0800 (PST)
Received: from SMI-ubuntu.sueba ([2a01:390:0:101:f8cf:a1d9:90ed:c978])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4b1ed8b6a05sm3500696f8f.43.2026.11.22.12.13.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2026 12:13:25 -0800 (PST)
From: Simon Mikuda <simon.mikuda@streamunlimited.com>
To: linux-bluetooth@vger.kernel.org
Cc: Simon Mikuda <simon.mikuda@streamunlimited.com>,
	Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Subject: [PATCH] Bluetooth: hci_event: Terminate PA sync transferred while not pending
Date: Sun, 22 Nov 2026 21:13:19 +0100
Message-ID: <20261122201320.2851760-1-simon.mikuda@streamunlimited.com>
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

hci_le_past_params_sync() sets the PAST parameters of the ACL connection
so the controller synchronizes to the PA train transferred by the peer,
but nothing resets them once the PA sync has completed, so a later
transfer from the same peer is synchronized to as well.

HCI_LE_Periodic_Advertising_Sync_Transfer_Received is then received
with no connection having HCI_CONN_CREATE_PA_SYNC set and is only
logged, leaving the sync established in the controller, using its
resources, without the host knowing about it. Terminate it instead.

Fixes: 33b2835f0b7e ("Bluetooth: HCI: Add initial support for PAST")
Signed-off-by: Simon Mikuda <simon.mikuda@streamunlimited.com>
---
 net/bluetooth/hci_event.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 039bcea98a5a..4b8fd3bfeba4 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -6279,6 +6279,12 @@ static void hci_le_past_received_evt(struct hci_dev *hdev, void *data,
 		bt_dev_err(hdev,
 			   "Unable to find connection for dst %pMR sid 0x%2.2x",
 			   &ev->bdaddr, ev->sid);
+		/* No PA sync is pending, the PAST parameters are just left
+		 * set from a previous one, so terminate the sync instead of
+		 * leaving it behind in the controller.
+		 */
+		if (!ev->status)
+			hci_le_pa_term_sync(hdev, ev->sync_handle);
 		goto unlock;
 	}
 

base-commit: 4fe38719e6738feaa90486e36b0790dd5d960a96
-- 
2.43.0

