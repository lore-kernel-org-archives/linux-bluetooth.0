Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E5B8175A95
	for <linux-bluetooth@vger.kernel.org>; Thu,  8 Oct 2026 04:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791432114; cv=none; b=TkC8bhfLFLRRctLWFfXu643o25sE97ym+cfcj7QaL8INL9Z6vdeJvx7NAE/9t91nSIZL3+kJ5Y4TsjTJxeMvTbIIeLiUA/rAg1btmyt+oQhBhBmuqbKhXVdF/45qPHVLlw/yKYYXDDbiScGtuHT4VkPBOL1qkbklXdV00vf4aaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791432114; c=relaxed/simple;
	bh=HWGlhnjAsKdJcawkVeuPvrsKBkaz2dTusqjN5Q+J2tE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=rsn3s6PapKXsl4kVibo1WHDwTAeNBvku3bUY95jOwWUvUr98ulC9moUoStalVxuPyYIFAH38wvBT9Rn7aZCdrK9bMYCSkMyBYijNOeTYJ+pLZy1j2BV0IrDw7myGD5ApbgF1/sSNDRaA7JlHcJWHPb6NPEtTelTiVeCX1Ax/Ak8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ts9Piag5; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ts9Piag5"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-cc4e9e56e9aso1288878a12.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 07 Oct 2026 21:01:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791432112; x=1792036912; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rHUntJAA/mwo/FHuh8v4le2k0YfNGeacRBz3GsN1kMw=;
        b=Ts9Piag5xkkTz/RebI0HKYBI93yR5LQqs/UcuKYKQc8WT/UO7YBcryHjFgkEF5vneV
         ZhpGq7We16DJsWq5KNjWoPX6bLD7d2Z/kz7lWLp0kGFqBJ0OBMfhmiNfCUxfdF+BAne5
         apWlaX0bYrYqM2diHjkWe4XPB599bNVzPdTAgLVyIFH3cuxyJve/ctwQJ6sGfMiikwz4
         S3gmxfRw/kWz03aSIkzg35a4ra9zbzfAAnRBGM4xyMPYFdMmGHuYyE4EygOCkFUjuc/F
         qpgnBryJ+g59ZkY744uI5s66wLqOQVzPxvQh5ud7ixi86juljOTAsGEkmmQMEexzfCPC
         YGlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791432112; x=1792036912;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=rHUntJAA/mwo/FHuh8v4le2k0YfNGeacRBz3GsN1kMw=;
        b=NDk87vfwwtxbp3fj2CiAjDN/cKciMsXWmJHwKvSqYThG0sCvJbJ5hzVZQbGgOjC6nq
         +aBNSpMZmmjsH5hdKbGQL64HBqSTeM8/8ijuyZZ5irnc+00mCkTIziIkdjVJJ8ilxBaa
         hYgqrkG2rSK3Az4uU8zsQkQx4JhTX6SOPuuC/Fi2/XlZPkQhA+dVZhe6E2Jr8vWLkeIC
         0G9JT2IVoN1SatuL+my/4+RE1i3syUgDj19qKrr2+67TVZ2+zOWNupttbvJAoUrXK9fu
         8vYdmzYKxvkALNXeJZQYW4HnebOMkJeHRql8IDy7TbtiBfsUs03KKYmE9X9WH5YbPuqc
         C6aQ==
X-Gm-Message-State: AFq9FYJDimrw1b7EO8m1xXTIWftztlbHyGtB5SC9U56aGVLDvq27+zM+
	00Hsa1EMB07ZUslRLyDw3k2964oKt45NlK1UdjHer6ZpClhavzE3CH6R
X-Gm-Gg: AYBFou0t5onSTFf5b0aKyYSzRZGaMEfG2VspU8WHC4n8C2bDLjyZL+qORcAvb98vXKa
	DrKGs+0nwQug+nPN2+QCYv1N3bf3xFfVdQD5RIMgSo6JCn1cu/CjwiL48r56dd0vOWn59aPbXcR
	cR+6G1+wYd6Ff21nMw6QVcaIkKQneSJONkg8Xki7wL3VoLrO/t6RNZbC6Ou9qbv+r93oNd5ygYQ
	r/A5qpbxwzMg3VYX0pE/41f9DifSht79Sch8tbD9uQKvFjhNA05Psuq0ongEWbhjSH2xQEnIbwg
	YR5ZvjPTNZSpU2TeLeCZ+CQmtpJ725TXlgR+EIpwQbjTdSjdB0MU5aR5l+bvMIXR3LY+787icXJ
	SfIsJOBwjWTyw9AKzoHOo3n9KRCjxx5D6q0zJi+wneDSiF31HX6KqltLExbkuLTsuREtynnM8h0
	VxoPQbtw/59fEek3TKrJNwPDhgpT1cii62tAnzJE7mvuIq5V94rX4uRFp/7TWtx15jHw==
X-Received: by 2002:a17:90a:1541:b0:3a8:c0cd:57f8 with SMTP id 98e67ed59e1d1-3a8c0dcd10cmr1695006a91.4.1791432112448;
        Wed, 07 Oct 2026 21:01:52 -0700 (PDT)
Received: from localhost ([111.228.63.84])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a9f1bfbafasm2654738a91.11.2026.10.07.21.01.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2026 21:01:52 -0700 (PDT)
From: Cen Zhang <zzzccc427@gmail.com>
To: marcel@holtmann.org,
	luiz.dentz@gmail.com
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	baijiaju1990@gmail.com,
	jjzuming@gmail.com,
	zzzccc427@gmail.com
Subject: [PATCH] Bluetooth: hci_debugfs: Pin the module for open dut_mode files
Date: Thu,  8 Oct 2026 12:01:46 +0800
Message-Id: <pm-bluetooth-objects-candidate-0251-v5-7e4e8154d66ac0e60df2@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

An open dut_mode file retains dut_mode_fops in the debugfs proxy state.
The table must remain allocated until the final close has finished
accessing it. However, dut_mode_fops has no owner, so fops_get()
succeeds without taking a Bluetooth module reference.

With CONFIG_BT=m and Bluetooth debugfs enabled, a descriptor can remain
open across controller removal and module unload if all other module
references have been dropped. After hci_debugfs_create_basic() publishes
the file, the following order is possible:

    File holder                     Controller/module teardown
    -----------                     --------------------------
    open dut_mode
      full_proxy_open_regular()
      fops_get(): owner == NULL
      debugfs_file_put()
    keep descriptor open            hci_unregister_dev()
                                    hci_release_dev()
                                      debugfs_remove_recursive()
                                    delete_module()
                                      bt_exit()
                                      free_module()
    close descriptor after unload
      full_proxy_release()
        read real_fops->release

Debugfs removal drains active callbacks, but an idle open descriptor is
not an active user. Its dentry retains the saved table pointer until
close. full_proxy_release() then reads the release field, even though
it is NULL, and fops_put() reads the owner field from freed module
storage. The close can fault in full_proxy_release(), as shown below.

Set the owner of dut_mode_fops to THIS_MODULE, matching the tables
created by DEFINE_SHOW_ATTRIBUTE in the same file. The existing debugfs
fops_get()/fops_put() pair then keeps Bluetooth loaded until close has
finished using the table, preventing normal unload with the file open.

Oops report as below:
    BUG: unable to handle page fault for address: fffffbfff8056f03
    #PF: supervisor read access in kernel mode
    #PF: error_code(0x0000) - not-present page
    PGD 1a7ff6067 P4D 1a7ff6067 PUD 1a7ff2067 PMD 100ad6067 PTE 0
    Oops: Oops: 0000 [#1] SMP KASAN NOPTI
    Call Trace:
     <TASK>
     __fput+0x39f/0xa60
     fput_close_sync+0xff/0x200
     ? __pfx_fput_close_sync+0x10/0x10
     ? dnotify_flush+0x22/0x4b0
     __x64_sys_close+0x8c/0xf0
     do_syscall_64+0x115/0x6a0
     entry_SYSCALL_64_after_hwframe+0x77/0x7f
Fixes: 4b4148e9acc1 ("Bluetooth: Add support for setting DUT mode")
Assisted-by: LLM
Signed-off-by: Cen Zhang <zzzccc427@gmail.com>

Assisted-by: LLM
---

diff --git a/net/bluetooth/hci_debugfs.c b/net/bluetooth/hci_debugfs.c
index 2559fb6324d63d5fc84d530d2a19f2602ac06d3d..f17b5c960522cb22140322e4781775e4e2f6b711 100644
--- a/net/bluetooth/hci_debugfs.c
+++ b/net/bluetooth/hci_debugfs.c
@@ -1315,6 +1315,7 @@ static ssize_t dut_mode_write(struct file *file, const char __user *user_buf,
 }
 
 static const struct file_operations dut_mode_fops = {
+	.owner		= THIS_MODULE,
 	.open		= simple_open,
 	.read		= dut_mode_read,
 	.write		= dut_mode_write,
