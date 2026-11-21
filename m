Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795245336;
	b=YLDisPG5SqPqWZsRrYvS7DMDP+DcMES1ywUIyGHuj5DmieAsoEd0AcnfwxblryJIY457
	 pMpyTZEgUYqd5Kw1kmXy0IC/dz1/n4X++UE/y4464NE46+WlDp5VpZaCkJaV+EI1rI1br
	 +M2RgNZBV0AiZF5hPcZGS4T1U0rK+8OgA85Xpb3VrTj2Xh7PW14mithbZ81jZX7owoRlO
	 dI6fmB19ArO68jQIUZNiUnQdCO47ZohgLJPoOU8edyPjoVrZuF+SplVd8+DrJs6S7cVa8
	 lJgLxpMSI7XHbaEQaGv6UNk2m7pRjjxJizWIkxNti58h7HpVNC991R+5gwKUv+vNvvg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795245336;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=KNdj2KYdydX2zqKT4RqJarDshMygrJ5nIrbhNDBbZ40=;
	b=O0uwU+4ZyagcjlieBNB4o+2L9SIiduwelQZEf7aB4Z7ls2M2MANeYq8lsIFd2p+0blz5
	 ILUVRMxQrOBug94QBAw1fMnXdaq4DhA8A7kuwqhhA2buBMRebg0+IVCs9qPSMqqKpTThb
	 m/Nrw+idG21alVqaDBOaCdmKiBNv1oRlFsN4FKBwYmdvYF10+U78nDPmW2ixb7l8aq7Rv
	 3AiKs1I6QhbZr5H6K6BhP8vdCSstHnzRs6Serqp5s6PcnWPHny132jlzHCgLiE8ES7cmk
	 /v3Ri+S42AikJRFWh1kVqfIYzZH5LehbbSQEXMpulWBbHCj/kJOu7qQ4Rhim8bnvSCA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZsC32Nv0;
	arc=none smtp.remote-ip=209.85.214.169
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E880606A330
	for <linux-bluetooth@vger.kernel.org>; Sat, 21 Nov 2026 07:15:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9E880606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZsC32Nv0
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2f00fc215f9so11265025ad.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 20 Nov 2026 23:15:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795245335; x=1795850135; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KNdj2KYdydX2zqKT4RqJarDshMygrJ5nIrbhNDBbZ40=;
        b=ZsC32Nv0GNTFlvPF6LUsheBOQ6dDrCQfeIUqLfWglbThHMzXFDnQu77u0C6vwUcAga
         cxywL0qtfi1rDV+VVJM60xhBTmac+JQ764vjh9m0Szq/JAfADKybI7KLkWW4V1a8GOUp
         ChWaejDRr8CVdXCqKwMRfm6WrmLIK83gK62J9K++dhWrAcYAxDQKjvzGw6DLRrx0oT8a
         QcymYN8dxfHoTMO3NomPaclhaFc4M2Dc3i/QxcEa+PaIQi3Jf64tbYXOY7jpsc/Yu3Nh
         9iuwHeAYalABXACpwcbRZHh+lAdm+2gBNahjI35Faz15pZfN86Ltqkp7NHtgiYIsAkMS
         TgKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795245335; x=1795850135;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=KNdj2KYdydX2zqKT4RqJarDshMygrJ5nIrbhNDBbZ40=;
        b=MKJOMxU25GKbQ0FXLND1OltXnG1Rf+kdZs6+tdO5b96a93Z/M3yDD6/nP/XWxSrjQN
         AFMVTUBCiFoDY4ElqHxDfISyXee0gkvdNg/IKSSF2Sx522P+Tf5IZMe5Rzicp/GHP16M
         r239vPXQ38FNVUhrZ8SnZlvU7KKplgkCQvz54d765h85kab7NLy1YpoBpN/qUqFxB8EL
         CwOA9w0ZxxA0nBUSSFk6+59gAGEZZvF81nlAh4DujEgKzZtdrXZ9PVOlOFK+qSee+rqZ
         fuEKx6QcLIXevvr8pTR6bNJ98w8+TLPy48OVLtMO8mlC0gkQTUfTj/JlnE5H+xYE6agL
         zZjg==
X-Gm-Message-State: APuU4Z9COS4Rt0BzrdJML0LZNXEEELppvc/DqC+F5DY04vdEfLuuIj22
	33J+keuZfGqqnCPyfTK16m9tNfdDzmeVU7Yd2o0T2Pm2tV/s4+P9vW3C
X-Gm-Gg: AZFdTZc/banp8jnlWa/2gpsVoj+YqWEi2mM5YuzZZjtotDOTbeEJaSZbnI7B0xlR/Eo
	LGV5AS4PAwCnoVe3hEtj18knpVOYwM1pe6wU6YNJQH3XrzmaXGsXv2YrzpxKRALNQpfvczNLiSS
	G/7iK/3Yeu+jgcTcyRoyeBp9C4Dmm4MpEvWbVnLPcjgMBDYDZWO8uI4dwsyKbhNm6GqkJDRuGty
	tCSOTo4Cryu0O+d5Ao4GrzZDYP02l6FtgMHIHzYNMttcit4WDWg9RZMxkZyK34tEHDpg//sTn2N
	mLYdSbnrQFVbUaRnHd+MaetTLn57Wu2O3SlFVScpZ/KRBxsA//Rrx2qo09fd3GZ/0ov/Tsft4rU
	6oLSWS5uvtYMQ768qCC9nbQ3yIZoNzXBvDi47WUSn/zMaCfY/4jaBlPqn3AJLNw5z66h3CKAf9c
	xYIiRwC0zSymyozodIedDVCe/N6LoJK1vZpA4GCJ3BO1QuCQEfMFE/lvxiVX4Grlh1RCYYBkvQ6
	apJwroZEhM1yzu+C9MtWWuMJJR90+uV1sMC4og2Hd59jOLU1IQx/WXd/yvxJvU5VjYhv6zCOPW4
	m8RfipmBDkCQEq93DYYx4l9Y
X-Received: by 2002:a17:902:e847:b0:2f0:2c63:8bff with SMTP id d9443c01a7336-2f03f1c0088mr59655895ad.39.1795245334948;
        Fri, 20 Nov 2026 23:15:34 -0800 (PST)
Received: from localhost ([111.228.63.84])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2f04f6049dfsm13508675ad.19.2026.11.20.23.15.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 23:15:34 -0800 (PST)
From: Cen Zhang <zzzccc427@gmail.com>
To: marcel@holtmann.org,
	luiz.dentz@gmail.com
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	baijiaju1990@gmail.com,
	jjzuming@gmail.com,
	zzzccc427@gmail.com
Subject: [PATCH 3/3] Bluetooth: MGMT: Reject advertising data while parameters are pending
Date: Sat, 21 Nov 2026 15:15:18 +0800
Message-Id: <pm-bluetooth-objects-candidate-0167-v9-45c99868af18e41665a3-3@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <pm-bluetooth-objects-candidate-0167-v9-45c99868af18e41665a3-0@gmail.com>
References: <pm-bluetooth-objects-candidate-0167-v9-45c99868af18e41665a3-0@gmail.com>
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

An ADD_EXT_ADV_PARAMS request retains an instance number while its
completion runs later in request work. ADD_EXT_ADV_DATA can remove that
pending instance on a validation error and a later request can reuse the
number. The old completion then resolves the number to the new instance:

  Parameters request                Management handler
  queue parameters for A
                                    invalid data removes A
                                    create B with A's number
  complete parameters for A
    look up the instance number
    read or remove B

List the parameters command as pending, validate and claim it before
completion, and copy its instance number under the pending-list lock in
the request function. Reject advertising data while parameters are
pending so the data handler cannot retire the instance in that interval.

The report below was captured before the separate RPA work initialization
fix. The stale completion can still select and remove a replacement
instance after that fix.

The excerpt below retains the headline and stack traces.

KASAN report as below:

    BUG: KASAN: slab-use-after-free in adv_instance_rpa_expired+0x2c0/0x2f0
    Read of size 1 at addr ffff888110924b2e by task kworker/u17:1/501

    Workqueue: hci0 adv_instance_rpa_expired
    Call Trace:
     <TASK>
     dump_stack_lvl+0x93/0xd0
     print_report+0xce/0x630
     ? adv_instance_rpa_expired+0x2c0/0x2f0
     ? srso_alias_return_thunk+0x5/0xfbef5
     ? __virt_addr_valid+0x20d/0x410
     ? adv_instance_rpa_expired+0x2c0/0x2f0
     kasan_report+0xe0/0x110
     ? adv_instance_rpa_expired+0x2c0/0x2f0
     adv_instance_rpa_expired+0x2c0/0x2f0
     process_one_work+0x908/0x19c0
     ? __pfx_process_one_work+0x10/0x10
     ? srso_alias_return_thunk+0x5/0xfbef5
     ? lock_is_held_type+0x8f/0x100
     ? srso_alias_return_thunk+0x5/0xfbef5
     worker_thread+0x65c/0xe40
     ? __pfx_worker_thread+0x10/0x10
     kthread+0x34f/0x460
     ? srso_alias_return_thunk+0x5/0xfbef5
     ? __pfx_kthread+0x10/0x10
     ret_from_fork+0x659/0x940
     ? __pfx_ret_from_fork+0x10/0x10
     ? srso_alias_return_thunk+0x5/0xfbef5
     ? save_fpregs_to_fpstate+0xd7/0x230
     ? srso_alias_return_thunk+0x5/0xfbef5
     ? __switch_to+0x74f/0xf80
     ? __pfx_kthread+0x10/0x10
     ret_from_fork_asm+0x1a/0x30
     </TASK>

    Allocated by task 519:
     kasan_save_stack+0x33/0x60
     kasan_save_track+0x14/0x30
     __kasan_kmalloc+0xaa/0xb0
     __kmalloc_cache_noprof+0x251/0x610
     hci_add_adv_instance+0x756/0xae0
     add_advertising+0x85c/0xff0
     hci_sock_sendmsg+0x128b/0x22e0
     __sys_sendto+0x425/0x470
     __x64_sys_sendto+0xe5/0x1c0
     do_syscall_64+0x115/0x6a0
     entry_SYSCALL_64_after_hwframe+0x77/0x7f

    Freed by task 500:
     kasan_save_stack+0x33/0x60
     kasan_save_track+0x14/0x30
     kasan_save_free_info+0x3b/0x60
     __kasan_slab_free+0x5f/0x80
     kfree+0x307/0x580
     hci_remove_adv_instance+0x222/0x550
     add_ext_adv_params_complete+0x2b9/0x880
     hci_cmd_sync_work+0x207/0x450
     process_one_work+0x908/0x19c0
     worker_thread+0x65c/0xe40
     kthread+0x34f/0x460
     ret_from_fork+0x659/0x940
     ret_from_fork_asm+0x1a/0x30

Fixes: cba6b758711c ("Bluetooth: hci_sync: Make use of hci_cmd_sync_queue set 2")
Signed-off-by: Cen Zhang <zzzccc427@gmail.com>
---
This patch was written with assistance from Codex (OpenAI).

 net/bluetooth/mgmt.c | 39 +++++++++++++++++++++++++++++++++------
 1 file changed, 33 insertions(+), 6 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 947d308145e37..dfc2d276a8107 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -9286,7 +9286,7 @@ static void add_ext_adv_params_complete(struct hci_dev *hdev, void *data,
 					int err)
 {
 	struct mgmt_pending_cmd *cmd = data;
-	struct mgmt_cp_add_ext_adv_params *cp = cmd->param;
+	struct mgmt_cp_add_ext_adv_params *cp;
 	struct mgmt_rp_add_ext_adv_params rp;
 	struct adv_info *adv;
 	u32 flags;
@@ -9295,6 +9295,12 @@ static void add_ext_adv_params_complete(struct hci_dev *hdev, void *data,
 
 	hci_dev_lock(hdev);
 
+	if (err == -ECANCELED || !mgmt_pending_valid(hdev, cmd)) {
+		hci_dev_unlock(hdev);
+		return;
+	}
+
+	cp = cmd->param;
 	adv = hci_find_adv_instance(hdev, cp->instance);
 	if (!adv)
 		goto unlock;
@@ -9335,9 +9341,22 @@ static void add_ext_adv_params_complete(struct hci_dev *hdev, void *data,
 static int add_ext_adv_params_sync(struct hci_dev *hdev, void *data)
 {
 	struct mgmt_pending_cmd *cmd = data;
-	struct mgmt_cp_add_ext_adv_params *cp = cmd->param;
+	struct mgmt_cp_add_ext_adv_params *cp;
+	u8 instance;
+
+	mutex_lock(&hdev->mgmt_pending_lock);
+
+	if (!__mgmt_pending_listed(hdev, cmd)) {
+		mutex_unlock(&hdev->mgmt_pending_lock);
+		return -ECANCELED;
+	}
+
+	cp = cmd->param;
+	instance = cp->instance;
 
-	return hci_setup_ext_adv_instance_sync(hdev, cp->instance);
+	mutex_unlock(&hdev->mgmt_pending_lock);
+
+	return hci_setup_ext_adv_instance_sync(hdev, instance);
 }
 
 static int add_ext_adv_params(struct sock *sk, struct hci_dev *hdev,
@@ -9431,8 +9450,8 @@ static int add_ext_adv_params(struct sock *sk, struct hci_dev *hdev,
 	 * will be programmed once the instance is scheduled.
 	 */
 	if (ext_adv_capable(hdev) && !adv_overridden_by_global(hdev, adv)) {
-		cmd = mgmt_pending_new(sk, MGMT_OP_ADD_EXT_ADV_PARAMS, hdev,
-				       data, data_len);
+		cmd = mgmt_pending_add(sk, MGMT_OP_ADD_EXT_ADV_PARAMS,
+				       hdev, data, data_len);
 		if (!cmd) {
 			err = -ENOMEM;
 			goto remove;
@@ -9441,7 +9460,7 @@ static int add_ext_adv_params(struct sock *sk, struct hci_dev *hdev,
 		err = hci_cmd_sync_queue(hdev, add_ext_adv_params_sync, cmd,
 					 add_ext_adv_params_complete);
 		if (err < 0) {
-			mgmt_pending_free(cmd);
+			mgmt_pending_remove(cmd);
 			goto remove;
 		}
 	} else {
@@ -9545,6 +9564,14 @@ static int add_ext_adv_data(struct sock *sk, struct hci_dev *hdev, void *data,
 		goto unlock;
 	}
 
+	/* Preserve the instance until its parameters complete. */
+	if (pending_find(MGMT_OP_ADD_EXT_ADV_PARAMS, hdev)) {
+		err = mgmt_cmd_status(sk, hdev->id,
+				      MGMT_OP_ADD_EXT_ADV_DATA,
+				      MGMT_STATUS_BUSY);
+		goto unlock;
+	}
+
 	/* In new interface, we require that we are powered to register */
 	if (!hdev_is_powered(hdev)) {
 		err = mgmt_cmd_status(sk, hdev->id, MGMT_OP_ADD_EXT_ADV_DATA,
