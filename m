Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="v40S9pXS"
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2145DD4E
	for <linux-bluetooth@vger.kernel.org>; Fri, 17 Nov 2023 11:29:47 -0800 (PST)
Received: by mail-pg1-x549.google.com with SMTP id 41be03b00d2f7-5bdfc1bb3eeso3738843a12.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 17 Nov 2023 11:29:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1700249386; x=1700854186; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=7BLtURhc1ohq6G7Ehb9fNj26PZtAiF6i6XyPfX0SmPQ=;
        b=v40S9pXSOHQ6tKdCq7miQ1egRBEA72FQZnxTRJ1jtcOTjnOyKgTQUuN75Qzh3DF+eG
         yzCBflI1AcAVzOtYcnUEsbScZTQo5cOiqUMT1rZWraE+jO9FepwduneKooLVF0mKAcdg
         5M/57Lx99Ld34M8EY0cj7arxbbWOcX+ZCR2ZvO+k6LWAbcnyd5BVLSxptDV7De5YBD1x
         U48B6iQx3bNyG1wOOOlHQghZCQPR1o7slfP++mBGM1HdfZJxL5qWPILPa+ly2+LoJUi0
         3J9xTiyyM3jt/C89EPqqk4ahh64qa/wsSDXgUloi0AUu4ooingvJY5TbzjgukvFI08Od
         Pq0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700249386; x=1700854186;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7BLtURhc1ohq6G7Ehb9fNj26PZtAiF6i6XyPfX0SmPQ=;
        b=H3wpFQxjQjRTYW4oQDn780m29VMCnCOB0oEhFozFLfWbTzveKGRCeYq7JshbyS9t09
         LeDv+zD/hvfv1YU3laBDR5XxawpUs1X+Mz65rBF7tWuj5x1s9UA/VkAZPgyEkASkZb10
         XRR0ulldcLNM9V+EWo24T6VNHBSBqRaQ2SWTlHLuw0G+qNXmKRG8BEare/5i/xar6NDZ
         UPeN1KlWid933DgTJLRRFv6rjCaDLa6Qe4w2RaLK9pwTZE95bIghcUiuI3Z3Y+SN9/MW
         3KGx1so9kAEH45MM1vl94hXru3CI5IyIliqgIH7orJRjgjN4nzKvakNQvJ5kgjKYOH8J
         3k4w==
X-Gm-Message-State: AOJu0Yy+K3aQZrsL4LKR3sCAxSJJFBimf7GDgpL5H32YQLj0Y5OAONCy
	fApfWnwmlmZJWLput3ZZdC7kcHxT5ZZ2Ag==
X-Google-Smtp-Source: AGHT+IHPOmLYguT+8vb5GwUDrc+ZP4ecu7SsbJuI3BcLECKsyV3gfi+SPO2WAh3jllf3e2TWKANI9fc+O0t1hA==
X-Received: from mmandlik-cloudtop.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:2893])
 (user=mmandlik job=sendgmr) by 2002:a17:90a:bd97:b0:280:c3df:e29f with SMTP
 id z23-20020a17090abd9700b00280c3dfe29fmr2081pjr.3.1700249386621; Fri, 17 Nov
 2023 11:29:46 -0800 (PST)
Date: Fri, 17 Nov 2023 11:28:34 -0800
In-Reply-To: <20231117112833.v2.1.I4c7ab22148e168e3cde00f27b89748ff4bc651c2@changeid>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231117112833.v2.1.I4c7ab22148e168e3cde00f27b89748ff4bc651c2@changeid>
X-Mailer: git-send-email 2.43.0.rc0.421.g78406f8d94-goog
Message-ID: <20231117112833.v2.2.I5f8211e201324f6d9f699e995fc59dda1e51f0ce@changeid>
Subject: [PATCH v2 2/2] Bluetooth: btusb: Fix double free in handle_dump_pkt_qca()
From: Manish Mandlik <mmandlik@google.com>
To: marcel@holtmann.org, luiz.dentz@gmail.com
Cc: chromeos-bluetooth-upstreaming@chromium.org, 
	linux-bluetooth@vger.kernel.org, Manish Mandlik <mmandlik@google.com>, 
	Johan Hedberg <johan.hedberg@gmail.com>, Tim Jiang <quic_tjiang@quicinc.com>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The hci_devcd_init() returns 0 on success. Do not use this return value
when eturning from handle_dump_pkt_qca() as it incorrectly indicates
that it's not a dump packet.

This causes the first dump skb to be processed by both hci_devcd_rx()
and hci_recv_frame() leading to double free.

Fixes: 20981ce2d5a5 ("Bluetooth: btusb: Add WCN6855 devcoredump support")

Signed-off-by: Manish Mandlik <mmandlik@google.com>
---

(no changes since v1)

 drivers/bluetooth/btusb.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 35a26440cabd..d23c992502c5 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -3531,10 +3531,11 @@ static int handle_dump_pkt_qca(struct hci_dev *hdev, struct sk_buff *skb)
 			goto out;
 		}
 
-		ret = hci_devcd_init(hdev, dump_size);
-		if (ret < 0) {
-			bt_dev_err(hdev, "memdump init error(%d)", ret);
-			goto out;
+		if (hci_devcd_init(hdev, dump_size) < 0) {
+			bt_dev_err(hdev, "memdump init error");
+			clear_bit(BTUSB_HW_SSR_ACTIVE, &btdata->flags);
+			kfree_skb(skb);
+			return ret;
 		}
 
 		btdata->qca_dump.ram_dump_size = dump_size;
-- 
2.43.0.rc0.421.g78406f8d94-goog

