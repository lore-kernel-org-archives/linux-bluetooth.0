Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 080FBC433EF
	for <linux-bluetooth@archiver.kernel.org>; Thu, 14 Jul 2022 20:30:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240311AbiGNUak (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 14 Jul 2022 16:30:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232159AbiGNUaj (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 14 Jul 2022 16:30:39 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23E813A4BF
        for <linux-bluetooth@vger.kernel.org>; Thu, 14 Jul 2022 13:30:38 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id cp18-20020a17090afb9200b001ef79e8484aso6716749pjb.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 14 Jul 2022 13:30:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zMYQCyM19MbQG+315Eqm2CJpOHN3RYWkgys+f6EEYpo=;
        b=qKzvvmpAyXf3e15leVxXw29JtiR/2Weaf5xftnvTzlae0p4U/wpzxXm9AIA0RJtiS0
         9qunCD4ssbUk8pKdM9eVcNPlfyet5C2QyyX8q7Dl5IsDBhQc6e2l034xm7X/tXUzdQCw
         ojm92IRlR6SViecjwrf9CJAUg6wPfQF4oVTSTadWp0uADSGP+Vy8yycvvfhvpnVVhazw
         Cvipg4DtZPc8YWc2NvMteBkMlk5yPMZyG9+vHc6IWaxdMm1+Tlx9jvq1AW6ehOHTFQy/
         Shzqp5P8W3YJwvaarG7GAH1Ts/0e/HP6MuAA84Xxj31xjSiZzwOQH3pEYiimLUgn9/RZ
         3N3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zMYQCyM19MbQG+315Eqm2CJpOHN3RYWkgys+f6EEYpo=;
        b=NSeZKhTYSmWGkLyIs67iAzG/0cZPES5Qnqail8at6xV+7cYj8yibPT2XikVlwXX7W1
         nI5v94yjd66/PlRRmxKsdSLQlm9ALGf5Mhekkoy+WNK/VTC6Qw0B5EyZfmN8rTADZPCg
         xywXzLSvFofMH2v7bU2pIUVgoC3dMO1I5oX/+DIDoO8JA5RYsZWeu8M3WWCC38RtIVYm
         xY12K/tMaOc7KX/+dfKN4GgatYf81GkizU9IZ7SgTv8CSxdQWDoI1cP1cnb0Vynw+YM0
         Zz3drXHfHTDuL90yEv114PyKL0TeeYUmIfS81deMJ1vECO8SJ1dGNY5/rDMPyaeel25/
         qhTw==
X-Gm-Message-State: AJIora8JrK1sy6iHuxRNXqG1wC1SESF7M5fl8WIe6quFo0OpmRORn9M3
        Ana6eWTRzjRDRykZQTz1OqQS2kMZHRQ=
X-Google-Smtp-Source: AGRyM1uHs0Usy+e76nJWlmAq4Ezjbg5bkQFe64TPU6Gu54pIRJ6UtAnpZeWkjAhSjQCgRHshh9mHBA==
X-Received: by 2002:a17:902:f542:b0:16c:505c:ebb2 with SMTP id h2-20020a170902f54200b0016c505cebb2mr9964274plf.77.1657830636948;
        Thu, 14 Jul 2022 13:30:36 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id z1-20020aa79901000000b00527dba9e37bsm2121147pff.73.2022.07.14.13.30.35
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jul 2022 13:30:36 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [RFC] Bluetooth: hci_sock: Fix cookie generation
Date:   Thu, 14 Jul 2022 13:30:35 -0700
Message-Id: <20220714203035.3859253-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

The valid range for the cookie is from 1-0xffffffff but in case of
ida_simple_get fails 0xffffffff is reused which can cause the following
trace when the socket is released:

 [69803.437346] kernel BUG at /build/linux-hwe-5.4-qwJpmT/linux-hwe-5.4-
 5.4.0/lib/idr.c:492!
 [69803.437351] invalid opcode: 0000 [#1] SMP NOPTI
 [69803.437353] CPU: 2 PID: 26662 Comm: hci_crash Tainted: G
 OE     5.4.0-97-generic #110~18.04.1-Ubuntu
 [69803.437354] Hardware name: Dell Inc. Precision 5820 Tower/06JWJY,
 BIOS 2.5.1 10/20/2020
 [69803.437359] RIP: 0010:ida_free+0x120/0x140
 [69803.437361] Code: 48 8d 7d a8 31 f6 e8 9f ee 00 00 be 00 04 00 00 4c
 89 ef e8 52 9c a7 ff 48 3d 00 04 00 00 75 ce 4c 89 ef e8 62 61 7f ff eb
 b9 <0f 0b 4b 8d 74 2d 01 48 8d 7d a8 e8 70 04 01 00 eb b2 e8 09 f4 5e
 [69803.437362] RSP: 0018:ffffa52bc1cabdb0 EFLAGS: 00010286
 [69803.437363] RAX: 00000000003fffff RBX: ffff978253453000 RCX:
 0000001088064d8d
 [69803.437364] RDX: 0000001088064d8c RSI: 00000000ffffffff RDI:
 ffffffffc0c39250
 [69803.437365] RBP: ffffa52bc1cabe08 R08: ffff97825fcb7a80 R09:
 ffff9781266c7400
 [69803.437366] R10: 0000000000000008 R11: ffff9781241310c0 R12:
 00000000000003ff
 [69803.437366] R13: ffffffffc0c437c0 R14: ffff9782599eef20 R15:
 ffff9781870a3240
 [69803.437368] FS:  00000000010bc300(0000) GS:ffff97825fc80000(0000)
 knlGS:0000000000000000
 [69803.437368] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
 [69803.437370] CR2: 00007ffe67758020 CR3: 0000000f1d490004 CR4:
 00000000003606e0
 [69803.437371] DR0: 0000000000000000 DR1: 0000000000000000 DR2:
 0000000000000000
 [69803.437371] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7:
 0000000000000400
 [69803.437372] Call Trace:
 [69803.437393]  hci_sock_release+0x19a/0x1c0 [bluetooth]
 [69803.437396]  __sock_release+0x42/0xc0
 [69803.437397]  sock_close+0x15/0x20
 [69803.437399]  __fput+0xc6/0x260
 [69803.437400]  ____fput+0xe/0x10
 [69803.437402]  task_work_run+0x9d/0xc0
 [69803.437404]  exit_to_usermode_loop+0x109/0x130
 [69803.437406]  do_syscall_64+0x170/0x190
 [69803.437408]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
 [69803.437410] RIP: 0033:0x43dd73
 [69803.437411] Code: 64 89 02 48 c7 c0 ff ff ff ff c3 66 2e 0f 1f 84 00
 00 00 00 00 66 90 64 8b 04 25 18 00 00 00 85 c0 75 14 b8 03 00 00 00 0f
 05 <48 3d 00 f0 ff ff 77 45 c3 0f 1f 40 00 48 83 ec 18 89 7c 24 0c e8
 [69803.437411] RSP: 002b:00007ffe6765c038 EFLAGS: 00000246 ORIG_RAX:
 0000000000000003
 [69803.437413] RAX: 0000000000000000 RBX: 0000000000400488 RCX:
 000000000043dd73
 [69803.437413] RDX: 00007ffe6765c040 RSI: 00000000800448d3 RDI:
 0000000000000003
 [69803.437414] RBP: 00007ffe6765c0a0 R08: 000000000000000c R09:
 0000000000000002
 [69803.437415] R10: 0000000000000002 R11: 0000000000000246 R12:
 0000000000402b20
 [69803.437415] R13: 0000000000000000 R14: 00000000004ac018 R15:
 0000000000400488
 [69803.437417] Modules linked in: cmac rfcomm bnep btusb btrtl btbcm
 btintel bluetooth ecdh_generic ecc twofish_generic twofish_avx_x86_64
 twofish_x86_64_3way twofish_x86_64 twofish_common serpent_avx2
 serpent_avx_x86_64 serpent_sse2_x86_64 serpent_generic blowfish_generic
 blowfish_x86_64 blowfish_common cast5_avx_x86_64 cast5_generic
 cast_common des_generic libdes camellia_generic camellia_aesni_avx2
 camellia_aesni_avx_x86_64 camellia_x86_64 xcbc md4 algif_hash xfrm_user
 xfrm4_tunnel tunnel4 ipcomp xfrm_ipcomp esp4 ah4 af_key xfrm_algo
 anyconnect_kdf(OE) snd_hda_codec_hdmi intel_rapl_msr intel_rapl_common
 nls_iso8859_1 dell_smm_hwmon snd_hda_codec_realtek
 snd_hda_codec_generic ledtrig_audio snd_hda_intel snd_intel_dspcfg
 isst_if_common snd_hda_codec skx_edac nfit snd_hda_core snd_hwdep
 snd_pcm x86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel
 snd_seq_midi snd_seq_midi_event snd_rawmidi kvm snd_seq rapl
 intel_cstate snd_seq_device snd_timer ucsi_ccg dell_wmi ioatdma mei_me
 typec_ucsi
 [69803.437442]  snd serio_raw dell_smbios dcdbas sparse_keymap wmi_bmof
 intel_wmi_thunderbolt typec joydev dell_wmi_descriptor input_leds mei
 soundcore dca acpi_tad mac_hid ipt_REJECT nf_reject_ipv4 nf_log_ipv4
 nf_log_common xt_LOG xt_limit xt_tcpudp xt_addrtype xt_conntrack
 ip6_tables nf_conntrack_netbios_ns nf_conntrack_broadcast sch_fq_codel
 nf_nat_ftp nf_nat nf_conntrack_ftp nf_conntrack nf_defrag_ipv6
 nf_defrag_ipv4 libcrc32c parport_pc iptable_filter bpfilter ppdev lp
 parport ip_tables x_tables autofs4 algif_skcipher af_alg dm_crypt
 hid_generic usbhid hid uas usb_storage nouveau nvme nvme_core mxm_wmi
 video i2c_algo_bit ttm crct10dif_pclmul crc32_pclmul drm_kms_helper
 ghash_clmulni_intel aesni_intel syscopyarea sysfillrect crypto_simd
 sysimgblt cryptd fb_sys_fops glue_helper drm vmd e1000e i2c_nvidia_gpu
 ahci libahci wmi
 [69803.437471] ---[ end trace 650bd857a8213515 ]---
 [69803.515535] RIP: 0010:ida_free+0x120/0x140
 [69803.515544] Code: 48 8d 7d a8 31 f6 e8 9f ee 00 00 be 00 04 00 00 4c
 89 ef e8 52 9c a7 ff 48 3d 00 04 00 00 75 ce 4c 89 ef e8 62 61 7f ff eb
 b9 <0f 0b 4b 8d 74 2d 01 48 8d 7d a8 e8 70 04 01 00 eb b2 e8 09 f4 5e
 [69803.515548] RSP: 0018:ffffa52bc1cabdb0 EFLAGS: 00010286
 [69803.515553] RAX: 00000000003fffff RBX: ffff978253453000 RCX:
 0000001088064d8d
 [69803.515556] RDX: 0000001088064d8c RSI: 00000000ffffffff RDI:
 ffffffffc0c39250
 [69803.515559] RBP: ffffa52bc1cabe08 R08: ffff97825fcb7a80 R09:
 ffff9781266c7400
 [69803.515562] R10: 0000000000000008 R11: ffff9781241310c0 R12:
 00000000000003ff
 [69803.515566] R13: ffffffffc0c437c0 R14: ffff9782599eef20 R15:
 ffff9781870a3240
 [69803.515570] FS:  00000000010bc300(0000) GS:ffff97825fc80000(0000)
 knlGS:0000000000000000
 [69803.515573] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
 [69803.515576] CR2: 00007ffe67758020 CR3: 0000000f1d490004 CR4:
 00000000003606e0
 [69803.515579] DR0: 0000000000000000 DR1: 0000000000000000 DR2:
 0000000000000000
 [69803.515582] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7:
 0000000000000400

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com
---
 net/bluetooth/hci_sock.c | 322 +++++++++++++++++----------------------
 1 file changed, 137 insertions(+), 185 deletions(-)

diff --git a/net/bluetooth/hci_sock.c b/net/bluetooth/hci_sock.c
index 0d015d4a8e41..271a618c1230 100644
--- a/net/bluetooth/hci_sock.c
+++ b/net/bluetooth/hci_sock.c
@@ -96,21 +96,139 @@ u32 hci_sock_get_cookie(struct sock *sk)
 	return hci_pi(sk)->cookie;
 }
 
-static bool hci_sock_gen_cookie(struct sock *sk)
+static struct sk_buff *create_monitor_ctrl_close(struct sock *sk)
+{
+	struct hci_mon_hdr *hdr;
+	struct sk_buff *skb;
+
+	/* No message needed when cookie is not present */
+	if (!hci_pi(sk)->cookie)
+		return NULL;
+
+	switch (hci_pi(sk)->channel) {
+	case HCI_CHANNEL_RAW:
+	case HCI_CHANNEL_USER:
+	case HCI_CHANNEL_CONTROL:
+		break;
+	default:
+		/* No message for unsupported format */
+		return NULL;
+	}
+
+	skb = bt_skb_alloc(4, GFP_ATOMIC);
+	if (!skb)
+		return NULL;
+
+	put_unaligned_le32(hci_pi(sk)->cookie, skb_put(skb, 4));
+
+	__net_timestamp(skb);
+
+	hdr = skb_push(skb, HCI_MON_HDR_SIZE);
+	hdr->opcode = cpu_to_le16(HCI_MON_CTRL_CLOSE);
+	if (hci_pi(sk)->hdev)
+		hdr->index = cpu_to_le16(hci_pi(sk)->hdev->id);
+	else
+		hdr->index = cpu_to_le16(HCI_DEV_NONE);
+	hdr->len = cpu_to_le16(skb->len - HCI_MON_HDR_SIZE);
+
+	return skb;
+}
+
+static struct sk_buff *create_monitor_ctrl_open(struct sock *sk)
+{
+	struct hci_mon_hdr *hdr;
+	struct sk_buff *skb;
+	u16 format;
+	u8 ver[3];
+	u32 flags;
+
+	/* No message needed when cookie is not present */
+	if (!hci_pi(sk)->cookie)
+		return NULL;
+
+	switch (hci_pi(sk)->channel) {
+	case HCI_CHANNEL_RAW:
+		format = 0x0000;
+		ver[0] = BT_SUBSYS_VERSION;
+		put_unaligned_le16(BT_SUBSYS_REVISION, ver + 1);
+		break;
+	case HCI_CHANNEL_USER:
+		format = 0x0001;
+		ver[0] = BT_SUBSYS_VERSION;
+		put_unaligned_le16(BT_SUBSYS_REVISION, ver + 1);
+		break;
+	case HCI_CHANNEL_CONTROL:
+		format = 0x0002;
+		mgmt_fill_version_info(ver);
+		break;
+	default:
+		/* No message for unsupported format */
+		return NULL;
+	}
+
+	skb = bt_skb_alloc(14 + TASK_COMM_LEN, GFP_ATOMIC);
+	if (!skb)
+		return NULL;
+
+	flags = hci_sock_test_flag(sk, HCI_SOCK_TRUSTED) ? 0x1 : 0x0;
+
+	put_unaligned_le32(hci_pi(sk)->cookie, skb_put(skb, 4));
+	put_unaligned_le16(format, skb_put(skb, 2));
+	skb_put_data(skb, ver, sizeof(ver));
+	put_unaligned_le32(flags, skb_put(skb, 4));
+	skb_put_u8(skb, TASK_COMM_LEN);
+	skb_put_data(skb, hci_pi(sk)->comm, TASK_COMM_LEN);
+
+	__net_timestamp(skb);
+
+	hdr = skb_push(skb, HCI_MON_HDR_SIZE);
+	hdr->opcode = cpu_to_le16(HCI_MON_CTRL_OPEN);
+	if (hci_pi(sk)->hdev)
+		hdr->index = cpu_to_le16(hci_pi(sk)->hdev->id);
+	else
+		hdr->index = cpu_to_le16(HCI_DEV_NONE);
+	hdr->len = cpu_to_le16(skb->len - HCI_MON_HDR_SIZE);
+
+	return skb;
+}
+
+static int hci_sock_ctrl_open(struct sock *sk)
 {
 	int id = hci_pi(sk)->cookie;
+	struct sk_buff *skb;
 
 	if (!id) {
 		id = ida_simple_get(&sock_cookie_ida, 1, 0, GFP_KERNEL);
 		if (id < 0)
-			id = 0xffffffff;
+			return id;
 
 		hci_pi(sk)->cookie = id;
 		get_task_comm(hci_pi(sk)->comm, current);
-		return true;
+		goto done;
 	}
 
-	return false;
+	/* In the case when a cookie has already been assigned,
+	 * this socket will transition from a raw socket into
+	 * a user channel socket. For a clean transition, send
+	 * the close notification to monitor first.
+	 */
+	skb = create_monitor_ctrl_close(sk);
+	if (skb) {
+		hci_send_to_channel(HCI_CHANNEL_MONITOR, skb, HCI_SOCK_TRUSTED,
+				    NULL);
+		kfree_skb(skb);
+	}
+
+done:
+	/* Send open notification to monitor */
+	skb = create_monitor_ctrl_open(sk);
+	if (skb) {
+		hci_send_to_channel(HCI_CHANNEL_MONITOR, skb, HCI_SOCK_TRUSTED,
+				    NULL);
+		kfree_skb(skb);
+	}
+
+	return id;
 }
 
 static void hci_sock_free_cookie(struct sock *sk)
@@ -118,7 +236,7 @@ static void hci_sock_free_cookie(struct sock *sk)
 	int id = hci_pi(sk)->cookie;
 
 	if (id) {
-		hci_pi(sk)->cookie = 0xffffffff;
+		hci_pi(sk)->cookie = 0;
 		ida_simple_remove(&sock_cookie_ida, id);
 	}
 }
@@ -499,102 +617,6 @@ static struct sk_buff *create_monitor_event(struct hci_dev *hdev, int event)
 	return skb;
 }
 
-static struct sk_buff *create_monitor_ctrl_open(struct sock *sk)
-{
-	struct hci_mon_hdr *hdr;
-	struct sk_buff *skb;
-	u16 format;
-	u8 ver[3];
-	u32 flags;
-
-	/* No message needed when cookie is not present */
-	if (!hci_pi(sk)->cookie)
-		return NULL;
-
-	switch (hci_pi(sk)->channel) {
-	case HCI_CHANNEL_RAW:
-		format = 0x0000;
-		ver[0] = BT_SUBSYS_VERSION;
-		put_unaligned_le16(BT_SUBSYS_REVISION, ver + 1);
-		break;
-	case HCI_CHANNEL_USER:
-		format = 0x0001;
-		ver[0] = BT_SUBSYS_VERSION;
-		put_unaligned_le16(BT_SUBSYS_REVISION, ver + 1);
-		break;
-	case HCI_CHANNEL_CONTROL:
-		format = 0x0002;
-		mgmt_fill_version_info(ver);
-		break;
-	default:
-		/* No message for unsupported format */
-		return NULL;
-	}
-
-	skb = bt_skb_alloc(14 + TASK_COMM_LEN , GFP_ATOMIC);
-	if (!skb)
-		return NULL;
-
-	flags = hci_sock_test_flag(sk, HCI_SOCK_TRUSTED) ? 0x1 : 0x0;
-
-	put_unaligned_le32(hci_pi(sk)->cookie, skb_put(skb, 4));
-	put_unaligned_le16(format, skb_put(skb, 2));
-	skb_put_data(skb, ver, sizeof(ver));
-	put_unaligned_le32(flags, skb_put(skb, 4));
-	skb_put_u8(skb, TASK_COMM_LEN);
-	skb_put_data(skb, hci_pi(sk)->comm, TASK_COMM_LEN);
-
-	__net_timestamp(skb);
-
-	hdr = skb_push(skb, HCI_MON_HDR_SIZE);
-	hdr->opcode = cpu_to_le16(HCI_MON_CTRL_OPEN);
-	if (hci_pi(sk)->hdev)
-		hdr->index = cpu_to_le16(hci_pi(sk)->hdev->id);
-	else
-		hdr->index = cpu_to_le16(HCI_DEV_NONE);
-	hdr->len = cpu_to_le16(skb->len - HCI_MON_HDR_SIZE);
-
-	return skb;
-}
-
-static struct sk_buff *create_monitor_ctrl_close(struct sock *sk)
-{
-	struct hci_mon_hdr *hdr;
-	struct sk_buff *skb;
-
-	/* No message needed when cookie is not present */
-	if (!hci_pi(sk)->cookie)
-		return NULL;
-
-	switch (hci_pi(sk)->channel) {
-	case HCI_CHANNEL_RAW:
-	case HCI_CHANNEL_USER:
-	case HCI_CHANNEL_CONTROL:
-		break;
-	default:
-		/* No message for unsupported format */
-		return NULL;
-	}
-
-	skb = bt_skb_alloc(4, GFP_ATOMIC);
-	if (!skb)
-		return NULL;
-
-	put_unaligned_le32(hci_pi(sk)->cookie, skb_put(skb, 4));
-
-	__net_timestamp(skb);
-
-	hdr = skb_push(skb, HCI_MON_HDR_SIZE);
-	hdr->opcode = cpu_to_le16(HCI_MON_CTRL_CLOSE);
-	if (hci_pi(sk)->hdev)
-		hdr->index = cpu_to_le16(hci_pi(sk)->hdev->id);
-	else
-		hdr->index = cpu_to_le16(HCI_DEV_NONE);
-	hdr->len = cpu_to_le16(skb->len - HCI_MON_HDR_SIZE);
-
-	return skb;
-}
-
 static struct sk_buff *create_monitor_ctrl_command(struct sock *sk, u16 index,
 						   u16 opcode, u16 len,
 						   const void *buf)
@@ -995,26 +1017,12 @@ static int hci_sock_ioctl(struct socket *sock, unsigned int cmd,
 		goto done;
 	}
 
-	/* When calling an ioctl on an unbound raw socket, then ensure
-	 * that the monitor gets informed. Ensure that the resulting event
-	 * is only send once by checking if the cookie exists or not. The
-	 * socket cookie will be only ever generated once for the lifetime
-	 * of a given socket.
-	 */
-	if (hci_sock_gen_cookie(sk)) {
-		struct sk_buff *skb;
+	err = hci_sock_ctrl_open(sk);
+	if (err < 0)
+		goto done;
 
-		if (capable(CAP_NET_ADMIN))
-			hci_sock_set_flag(sk, HCI_SOCK_TRUSTED);
-
-		/* Send event to monitor */
-		skb = create_monitor_ctrl_open(sk);
-		if (skb) {
-			hci_send_to_channel(HCI_CHANNEL_MONITOR, skb,
-					    HCI_SOCK_TRUSTED, NULL);
-			kfree_skb(skb);
-		}
-	}
+	if (capable(CAP_NET_ADMIN))
+		hci_sock_set_flag(sk, HCI_SOCK_TRUSTED);
 
 	release_sock(sk);
 
@@ -1095,7 +1103,6 @@ static int hci_sock_bind(struct socket *sock, struct sockaddr *addr,
 	struct sockaddr_hci haddr;
 	struct sock *sk = sock->sk;
 	struct hci_dev *hdev = NULL;
-	struct sk_buff *skb;
 	int len, err = 0;
 
 	BT_DBG("sock %p sk %p", sock, sk);
@@ -1148,33 +1155,15 @@ static int hci_sock_bind(struct socket *sock, struct sockaddr *addr,
 
 		hci_pi(sk)->channel = haddr.hci_channel;
 
-		if (!hci_sock_gen_cookie(sk)) {
-			/* In the case when a cookie has already been assigned,
-			 * then there has been already an ioctl issued against
-			 * an unbound socket and with that triggered an open
-			 * notification. Send a close notification first to
-			 * allow the state transition to bounded.
-			 */
-			skb = create_monitor_ctrl_close(sk);
-			if (skb) {
-				hci_send_to_channel(HCI_CHANNEL_MONITOR, skb,
-						    HCI_SOCK_TRUSTED, NULL);
-				kfree_skb(skb);
-			}
-		}
+		err = hci_sock_ctrl_open(sk);
+		if (err < 0)
+			goto done;
 
 		if (capable(CAP_NET_ADMIN))
 			hci_sock_set_flag(sk, HCI_SOCK_TRUSTED);
 
 		hci_pi(sk)->hdev = hdev;
 
-		/* Send event to monitor */
-		skb = create_monitor_ctrl_open(sk);
-		if (skb) {
-			hci_send_to_channel(HCI_CHANNEL_MONITOR, skb,
-					    HCI_SOCK_TRUSTED, NULL);
-			kfree_skb(skb);
-		}
 		break;
 
 	case HCI_CHANNEL_USER:
@@ -1240,19 +1229,9 @@ static int hci_sock_bind(struct socket *sock, struct sockaddr *addr,
 
 		hci_pi(sk)->channel = haddr.hci_channel;
 
-		if (!hci_sock_gen_cookie(sk)) {
-			/* In the case when a cookie has already been assigned,
-			 * this socket will transition from a raw socket into
-			 * a user channel socket. For a clean transition, send
-			 * the close notification first.
-			 */
-			skb = create_monitor_ctrl_close(sk);
-			if (skb) {
-				hci_send_to_channel(HCI_CHANNEL_MONITOR, skb,
-						    HCI_SOCK_TRUSTED, NULL);
-				kfree_skb(skb);
-			}
-		}
+		err = hci_sock_ctrl_open(sk);
+		if (err < 0)
+			goto done;
 
 		/* The user channel is restricted to CAP_NET_ADMIN
 		 * capabilities and with that implicitly trusted.
@@ -1261,14 +1240,6 @@ static int hci_sock_bind(struct socket *sock, struct sockaddr *addr,
 
 		hci_pi(sk)->hdev = hdev;
 
-		/* Send event to monitor */
-		skb = create_monitor_ctrl_open(sk);
-		if (skb) {
-			hci_send_to_channel(HCI_CHANNEL_MONITOR, skb,
-					    HCI_SOCK_TRUSTED, NULL);
-			kfree_skb(skb);
-		}
-
 		atomic_inc(&hdev->promisc);
 		break;
 
@@ -1347,28 +1318,9 @@ static int hci_sock_bind(struct socket *sock, struct sockaddr *addr,
 		 * are changes to settings, class of device, name etc.
 		 */
 		if (hci_pi(sk)->channel == HCI_CHANNEL_CONTROL) {
-			if (!hci_sock_gen_cookie(sk)) {
-				/* In the case when a cookie has already been
-				 * assigned, this socket will transition from
-				 * a raw socket into a control socket. To
-				 * allow for a clean transition, send the
-				 * close notification first.
-				 */
-				skb = create_monitor_ctrl_close(sk);
-				if (skb) {
-					hci_send_to_channel(HCI_CHANNEL_MONITOR, skb,
-							    HCI_SOCK_TRUSTED, NULL);
-					kfree_skb(skb);
-				}
-			}
-
-			/* Send event to monitor */
-			skb = create_monitor_ctrl_open(sk);
-			if (skb) {
-				hci_send_to_channel(HCI_CHANNEL_MONITOR, skb,
-						    HCI_SOCK_TRUSTED, NULL);
-				kfree_skb(skb);
-			}
+			err = hci_sock_ctrl_open(sk);
+			if (err < 0)
+				goto done;
 
 			hci_sock_set_flag(sk, HCI_MGMT_INDEX_EVENTS);
 			hci_sock_set_flag(sk, HCI_MGMT_UNCONF_INDEX_EVENTS);
-- 
2.35.3

