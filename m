Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36B90C63777
	for <linux-bluetooth@archiver.kernel.org>; Mon, 30 Nov 2020 07:32:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 95A5520857
	for <linux-bluetooth@archiver.kernel.org>; Mon, 30 Nov 2020 07:32:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g9zSWAmR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726302AbgK3HcY (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 30 Nov 2020 02:32:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725860AbgK3HcX (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 30 Nov 2020 02:32:23 -0500
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24CE3C0613CF
        for <linux-bluetooth@vger.kernel.org>; Sun, 29 Nov 2020 23:31:43 -0800 (PST)
Received: by mail-il1-x12e.google.com with SMTP id t13so10346804ilp.2
        for <linux-bluetooth@vger.kernel.org>; Sun, 29 Nov 2020 23:31:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=4JMM7f6OSFg3/R648EcZDrKPNUF/EJsU5cHic92TZKM=;
        b=g9zSWAmROSP5emmQ+bEBXaDhVtcOe/kgr2AphBjSWewBnCQnyFLOFp+kedEZL+NUrL
         oEJiF8YO4q8j+ngXGZd4OFMpWlvx7FqrvzLpoyWJ5JrS+J66Vl5y66qZG/86a/dE6uBR
         lghjstMHynDabsvBdFg5uOwgF4Snu3o+15UREevO6jOPD7R9jvuQj85jE48SGtAePKTm
         SnurmrYNmHpS9qhh0bGDW2tAZxxkdfpMJrd3lPX9/yGwjOWEYzeMTRwkJV31l5FlJVyH
         YqgO5RFHvhdbvpTsabqYsG0Xrq5KHm0NHLpnvX6xYJ2lkmImnTG1nQcPg4kNmzl2GqyR
         Me9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=4JMM7f6OSFg3/R648EcZDrKPNUF/EJsU5cHic92TZKM=;
        b=PacDou81GX0Ia477lzHTRIZ2vn4TzDtv2MyQRU9irJ81ESQ7gQE2E7FWnRKii+laTt
         s7LJqvaRG2PyxnzgI7A378mskQk8gFNixQS6nx7ERJ69ZdihHCykhJbz+Fb/xbFPf0Cb
         YyGrjyE302mrha/xy1EOJXyjFXMGqr4Pu9VTZzci9OjJrdoxMSZKzhuo529La+ijgJvP
         bWMzgmH8/Jsd/PG2rylg6QvQUe+CH1SA77lxD7wrK5E8M/sTyqDQKaJ13+p3wCNrCBiw
         BnN6L3UchUBqLrsJpmP1WzXHFCWBJuqbI1IMGSpplrfz0LGIv62/E0laUZhNWRLKZGJW
         Iiuw==
X-Gm-Message-State: AOAM533nfFjdF1lOKZTZlwf5b1Zu3jMKvEbFysY2ubAH60Jn4tF3NOfY
        8tK53MEdN6vCG53PMxfoyjLqZD+FldI=
X-Google-Smtp-Source: ABdhPJy+HyCcyooLCv7uFLR9e3o3HCF67g1p0MesG8PyxVKn5arfb+lvJFplOz42fAEtL/pH6dwP4g==
X-Received: by 2002:a92:a154:: with SMTP id v81mr18009193ili.85.1606721500429;
        Sun, 29 Nov 2020 23:31:40 -0800 (PST)
Received: from [172.17.0.2] ([52.167.57.62])
        by smtp.gmail.com with ESMTPSA id y13sm4382112iop.14.2020.11.29.23.31.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Nov 2020 23:31:39 -0800 (PST)
Message-ID: <5fc49fdb.1c69fb81.a1f58.dc47@mx.google.com>
Date:   Sun, 29 Nov 2020 23:31:39 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============7511037406244737267=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, peter.tsao@mediatek.com
Subject: RE: MTK mt7921 driver upstream
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20201130071655.31515-1-peter.tsao@mediatek.com>
References: <20201130071655.31515-1-peter.tsao@mediatek.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============7511037406244737267==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=393043

---Test result---

##############################
Test: CheckPatch - FAIL
Output:
MTK mt7921 driver upstream
WARNING:LONG_LINE: line length of 90 exceeds 80 columns
#33: FILE: drivers/bluetooth/btmtk_buffer_mode.c:20:
+static int btmtk_buffer_mode_check_auto_mode(struct btmtk_buffer_mode_struct *buffer_mode)

WARNING:LONG_LINE: line length of 83 exceeds 80 columns
#109: FILE: drivers/bluetooth/btmtk_buffer_mode.c:96:
+static int btmtk_buffer_mode_set_addr(struct btmtk_buffer_mode_struct *buffer_mode)

WARNING:LONG_LINE: line length of 98 exceeds 80 columns
#124: FILE: drivers/bluetooth/btmtk_buffer_mode.c:111:
+	ret = btmtk_main_send_cmd(buffer_mode->bdev, cmd, sizeof(cmd), event, sizeof(event), 0, 0,

WARNING:LONG_LINE: line length of 84 exceeds 80 columns
#131: FILE: drivers/bluetooth/btmtk_buffer_mode.c:118:
+static int btmtk_buffer_mode_set_radio(struct btmtk_buffer_mode_struct *buffer_mode)

WARNING:LONG_LINE: line length of 92 exceeds 80 columns
#133: FILE: drivers/bluetooth/btmtk_buffer_mode.c:120:
+	u8 cmd[] = {0x01, 0x2C, 0xFC, 0x08, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00};

WARNING:LONG_LINE_COMMENT: line length of 82 exceeds 80 columns
#138: FILE: drivers/bluetooth/btmtk_buffer_mode.c:125:
+	cmd[4] = buffer_mode->bt0_radio.radio_0 & 0x3F;		/* edr_init_pwr */

WARNING:LONG_LINE_COMMENT: line length of 85 exceeds 80 columns
#139: FILE: drivers/bluetooth/btmtk_buffer_mode.c:126:
+	cmd[8] = buffer_mode->bt0_radio.radio_2 & 0x3F;		/* ble_default_pwr */

WARNING:LONG_LINE_COMMENT: line length of 81 exceeds 80 columns
#140: FILE: drivers/bluetooth/btmtk_buffer_mode.c:127:
+	cmd[9] = buffer_mode->bt0_radio.radio_1 & 0x3F;		/* edr_max_pwr */

WARNING:LONG_LINE_COMMENT: line length of 82 exceeds 80 columns
#141: FILE: drivers/bluetooth/btmtk_buffer_mode.c:128:
+	cmd[11] = (buffer_mode->bt0_radio.radio_0 & 0xC0) >> 6;	/* edr_pwr_mode */

WARNING:LONG_LINE: line length of 98 exceeds 80 columns
#144: FILE: drivers/bluetooth/btmtk_buffer_mode.c:131:
+	ret = btmtk_main_send_cmd(buffer_mode->bdev, cmd, sizeof(cmd), event, sizeof(event), 0, 0,

WARNING:LONG_LINE: line length of 93 exceeds 80 columns
#151: FILE: drivers/bluetooth/btmtk_buffer_mode.c:138:
+static int btmtk_buffer_mode_set_group_boundary(struct btmtk_buffer_mode_struct *buffer_mode)

WARNING:LONG_LINE: line length of 98 exceeds 80 columns
#153: FILE: drivers/bluetooth/btmtk_buffer_mode.c:140:
+	u8 cmd[] = {0x01, 0xEA, 0xFC, 0x09, 0x02, 0x0B, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00};

WARNING:LONG_LINE: line length of 98 exceeds 80 columns
#162: FILE: drivers/bluetooth/btmtk_buffer_mode.c:149:
+	ret = btmtk_main_send_cmd(buffer_mode->bdev, cmd, sizeof(cmd), event, sizeof(event), 0, 0,

WARNING:LONG_LINE: line length of 91 exceeds 80 columns
#169: FILE: drivers/bluetooth/btmtk_buffer_mode.c:156:
+static int btmtk_buffer_mode_set_power_offset(struct btmtk_buffer_mode_struct *buffer_mode)

WARNING:LONG_LINE: line length of 100 exceeds 80 columns
#177: FILE: drivers/bluetooth/btmtk_buffer_mode.c:164:
+	memcpy(&cmd[8], buffer_mode->bt0_ant0_pwr_offset, sizeof(buffer_mode->bt0_ant0_pwr_offset));

WARNING:LONG_LINE: line length of 98 exceeds 80 columns
#180: FILE: drivers/bluetooth/btmtk_buffer_mode.c:167:
+	ret = btmtk_main_send_cmd(buffer_mode->bdev, cmd, sizeof(cmd), event, sizeof(event), 0, 0,

WARNING:LONG_LINE: line length of 89 exceeds 80 columns
#228: FILE: drivers/bluetooth/btmtk_buffer_mode.c:215:
+	ret = btmtk_load_code_from_setting_files(BUFFER_MODE_SWITCH_FILE, bdev->intf_dev,

WARNING:LONG_LINE: line length of 98 exceeds 80 columns
#231: FILE: drivers/bluetooth/btmtk_buffer_mode.c:218:
+	btmtk_buffer_mode.efuse_mode = btmtk_buffer_mode_parse_mode(bdev->setting_file, code_len);

WARNING:LONG_LINE_STRING: line length of 100 exceeds 80 columns
#236: FILE: drivers/bluetooth/btmtk_buffer_mode.c:223:
+		snprintf(btmtk_buffer_mode.file_name, MAX_BIN_FILE_NAME_LEN, "EEPROM_MT%04x_1a.bin",

WARNING:LONG_LINE_STRING: line length of 99 exceeds 80 columns
#239: FILE: drivers/bluetooth/btmtk_buffer_mode.c:226:
+		snprintf(btmtk_buffer_mode.file_name, MAX_BIN_FILE_NAME_LEN, "EEPROM_MT%04x_1.bin",

WARNING:LONG_LINE: line length of 81 exceeds 80 columns
#243: FILE: drivers/bluetooth/btmtk_buffer_mode.c:230:
+						bdev->intf_dev, &code_len, bdev);

WARNING:LONG_LINE: line length of 83 exceeds 80 columns
#253: FILE: drivers/bluetooth/btmtk_buffer_mode.c:240:
+	memcpy(&btmtk_buffer_mode.bt0_radio, &bdev->setting_file[BT0_RADIO_OFFSET],

WARNING:LONG_LINE: line length of 83 exceeds 80 columns
#255: FILE: drivers/bluetooth/btmtk_buffer_mode.c:242:
+	memcpy(&btmtk_buffer_mode.bt1_radio, &bdev->setting_file[BT1_RADIO_OFFSET],

WARNING:LONG_LINE: line length of 99 exceeds 80 columns
#257: FILE: drivers/bluetooth/btmtk_buffer_mode.c:244:
+	memcpy(btmtk_buffer_mode.bt0_ant0_grp_boundary, &bdev->setting_file[BT0_GROUP_ANT0_OFFSET],

WARNING:LONG_LINE: line length of 99 exceeds 80 columns
#259: FILE: drivers/bluetooth/btmtk_buffer_mode.c:246:
+	memcpy(btmtk_buffer_mode.bt0_ant1_grp_boundary, &bdev->setting_file[BT0_GROUP_ANT1_OFFSET],

WARNING:LONG_LINE: line length of 99 exceeds 80 columns
#261: FILE: drivers/bluetooth/btmtk_buffer_mode.c:248:
+	memcpy(btmtk_buffer_mode.bt1_ant0_grp_boundary, &bdev->setting_file[BT1_GROUP_ANT0_OFFSET],

WARNING:LONG_LINE: line length of 99 exceeds 80 columns
#263: FILE: drivers/bluetooth/btmtk_buffer_mode.c:250:
+	memcpy(btmtk_buffer_mode.bt1_ant1_grp_boundary, &bdev->setting_file[BT1_GROUP_ANT1_OFFSET],

WARNING:LONG_LINE: line length of 95 exceeds 80 columns
#265: FILE: drivers/bluetooth/btmtk_buffer_mode.c:252:
+	memcpy(btmtk_buffer_mode.bt0_ant0_pwr_offset, &bdev->setting_file[BT0_CAL_ANT0_OFFSET],

WARNING:LONG_LINE: line length of 95 exceeds 80 columns
#267: FILE: drivers/bluetooth/btmtk_buffer_mode.c:254:
+	memcpy(btmtk_buffer_mode.bt0_ant1_pwr_offset, &bdev->setting_file[BT0_CAL_ANT1_OFFSET],

WARNING:LONG_LINE: line length of 95 exceeds 80 columns
#269: FILE: drivers/bluetooth/btmtk_buffer_mode.c:256:
+	memcpy(btmtk_buffer_mode.bt1_ant0_pwr_offset, &bdev->setting_file[BT1_CAL_ANT0_OFFSET],

WARNING:LONG_LINE: line length of 95 exceeds 80 columns
#271: FILE: drivers/bluetooth/btmtk_buffer_mode.c:258:
+	memcpy(btmtk_buffer_mode.bt1_ant1_pwr_offset, &bdev->setting_file[BT1_CAL_ANT1_OFFSET],

WARNING:LONG_LINE: line length of 81 exceeds 80 columns
#385: FILE: drivers/bluetooth/btmtk_main.c:103:
+	{BTMTK_STATE_DISCONNECT, BTMTK_STATE_DISCONNECT, BTMTK_STATE_DISCONNECT},

WARNING:LONG_LINE_COMMENT: line length of 93 exceeds 80 columns
#468: FILE: drivers/bluetooth/btmtk_main.c:186:
+				0x00, 0x00, 0x00, 0x00};/*4 sub block number(sub block 0~3)*/

WARNING:LONG_LINE_COMMENT: line length of 93 exceeds 80 columns
#472: FILE: drivers/bluetooth/btmtk_main.c:190:
+	 *04 E4 LEN(1B) 02 0D LEN(2Byte) 02 04 ADDR(2Byte) VALUE(4B) ADDR(2Byte) VALUE(4Byte)

WARNING:LONG_LINE_COMMENT: line length of 85 exceeds 80 columns
#511: FILE: drivers/bluetooth/btmtk_main.c:229:
+			sub_block_addr_in_event = ((addr / 16) / 4);/*cal block num*/

WARNING:LONG_LINE: line length of 87 exceeds 80 columns
#554: FILE: drivers/bluetooth/btmtk_main.c:272:
+			       void *src, u32 len, u8 type, struct sk_buff_head *queue)

WARNING:LONG_LINE: line length of 85 exceeds 80 columns
#569: FILE: drivers/bluetooth/btmtk_main.c:287:
+		pr_err("%s: alloc_skb return 0, error, retry = %d", __func__, retry);

WARNING:LONG_LINE: line length of 98 exceeds 80 columns
#581: FILE: drivers/bluetooth/btmtk_main.c:299:
+		if (type == HCI_ACLDATA_PKT || type == HCI_EVENT_PKT || type == HCI_COMMAND_PKT) {

WARNING:LONG_LINE: line length of 95 exceeds 80 columns
#585: FILE: drivers/bluetooth/btmtk_main.c:303:
+			index += (HCI_TYPE_SIZE + FWLOG_ATTR_RX_LEN_LEN + FWLOG_ATTR_TYPE_LEN);

WARNING:LONG_LINE: line length of 81 exceeds 80 columns
#593: FILE: drivers/bluetooth/btmtk_main.c:311:
+		skb_tmp->data[2] = ((len + index - FWLOG_TL_SIZE) & 0xFF00) >> 8;

WARNING:LONG_LINE: line length of 93 exceeds 80 columns
#606: FILE: drivers/bluetooth/btmtk_main.c:324:
+static int btmtk_dispatch_data_bluetooth_kpi(struct hci_dev *hdev, u8 *buf, int len, u8 type)

WARNING:LONG_LINE: line length of 85 exceeds 80 columns
#613: FILE: drivers/bluetooth/btmtk_main.c:331:
+	    skb_queue_len(&g_fwlog->fwlog_queue) < FWLOG_BLUETOOTH_KPI_QUEUE_COUNT) {

WARNING:LONG_LINE_COMMENT: line length of 91 exceeds 80 columns
#614: FILE: drivers/bluetooth/btmtk_main.c:332:
+		/* sent event to queue, picus tool will log it for bluetooth KPI feature */

WARNING:LONG_LINE: line length of 98 exceeds 80 columns
#615: FILE: drivers/bluetooth/btmtk_main.c:333:
+		if (btmtk_skb_enq_fwlog(bdev->hdev, buf, len, type, &g_fwlog->fwlog_queue) == 0) {

WARNING:LONG_LINE: line length of 94 exceeds 80 columns
#628: FILE: drivers/bluetooth/btmtk_main.c:346:
+ssize_t btmtk_fops_readfwlog(struct file *filp, char __user *buf, size_t count, loff_t *f_pos)

WARNING:LONG_LINE_STRING: line length of 83 exceeds 80 columns
#649: FILE: drivers/bluetooth/btmtk_main.c:367:
+		BTMTK_DBG("%s: socket buffer length error(count: %d, skb.len: %d)",

WARNING:LONG_LINE: line length of 94 exceeds 80 columns
#684: FILE: drivers/bluetooth/btmtk_main.c:402:
+				BTMTK_WARN("%s: fops is not open yet(%d)!", __func__, fstate);

WARNING:LONG_LINE_STRING: line length of 94 exceeds 80 columns
#690: FILE: drivers/bluetooth/btmtk_main.c:408:
+				BTMTK_WARN("%s: dongle state already power off, do not write",

WARNING:LONG_LINE_STRING: line length of 90 exceeds 80 columns
#699: FILE: drivers/bluetooth/btmtk_main.c:417:
+		BTMTK_ERR("%s: your command is larger than maximum length, count = %zd\n",

WARNING:LONG_LINE: line length of 88 exceeds 80 columns
#728: FILE: drivers/bluetooth/btmtk_main.c:446:
+	if (strncmp(i_fwlog_buf, "whole chip reset", strlen("whole chip reset")) == 0) {

WARNING:LONG_LINE: line length of 90 exceeds 80 columns
#735: FILE: drivers/bluetooth/btmtk_main.c:453:
+	if (strncmp(i_fwlog_buf, "subsys chip reset", strlen("subsys chip reset")) == 0) {

WARNING:LONG_LINE: line length of 82 exceeds 80 columns
#760: FILE: drivers/bluetooth/btmtk_main.c:478:
+		if (*pos == ' ' || *pos == '\t' || *pos == '\r' || *pos == '\n') {

WARNING:LONG_LINE: line length of 85 exceeds 80 columns
#762: FILE: drivers/bluetooth/btmtk_main.c:480:
+		} else if (*pos == '0' && (*(pos + 1) == 'x' || *(pos + 1) == 'X')) {

WARNING:LONG_LINE: line length of 92 exceeds 80 columns
#765: FILE: drivers/bluetooth/btmtk_main.c:483:
+		} else if (!(*pos >= '0' && *pos <= '9') && !(*pos >= 'A' && *pos <= 'F') &&

WARNING:LONG_LINE: line length of 87 exceeds 80 columns
#767: FILE: drivers/bluetooth/btmtk_main.c:485:
+			BTMTK_ERR("%s: There is an invalid input(%c)", __func__, *pos);

WARNING:LONG_LINE: line length of 85 exceeds 80 columns
#778: FILE: drivers/bluetooth/btmtk_main.c:496:
+			BT_ERR("%s: Convert %s failed(%d)", __func__, temp_str, ret);

WARNING:LONG_LINE: line length of 94 exceeds 80 columns
#788: FILE: drivers/bluetooth/btmtk_main.c:506:
+		BT_ERR("%s: command is larger than max buf size, length = %d", __func__, len);

WARNING:LONG_LINE: line length of 82 exceeds 80 columns
#817: FILE: drivers/bluetooth/btmtk_main.c:535:
+				BTMTK_DBG("%s: send to hci%d", __func__, hci_idx);

WARNING:LONG_LINE: line length of 98 exceeds 80 columns
#822: FILE: drivers/bluetooth/btmtk_main.c:540:
+				memcpy(skb->data, o_fwlog_buf + index + FWLOG_ATTR_TL_SIZE, vlen);

WARNING:LONG_LINE: line length of 83 exceeds 80 columns
#848: FILE: drivers/bluetooth/btmtk_main.c:566:
+	    skb->data[1] == 0x5d && skb->data[2] == 0xfc && skb->data[4] == 0x00) {

WARNING:LONG_LINE: line length of 93 exceeds 80 columns
#854: FILE: drivers/bluetooth/btmtk_main.c:572:
+	btmtk_dispatch_data_bluetooth_kpi(bdev->hdev, skb->data, skb->len, KPI_WITHOUT_TYPE);

WARNING:LONG_LINE: line length of 99 exceeds 80 columns
#856: FILE: drivers/bluetooth/btmtk_main.c:574:
+	ret = main_info.hif_hook.send_cmd(g_bdev[hci_idx], skb, 0, 0, (int)BTMTK_TX_PKT_FROM_HOST);

WARNING:LONG_LINE: line length of 91 exceeds 80 columns
#892: FILE: drivers/bluetooth/btmtk_main.c:610:
+long btmtk_fops_unlocked_ioctlfwlog(struct file *filp, unsigned int cmd, unsigned long arg)

WARNING:LONG_LINE: line length of 89 exceeds 80 columns
#936: FILE: drivers/bluetooth/btmtk_main.c:654:
+	btmtk_free_fw_cfg_struct(bdev->woble_setting_apcf_fill_mac, WOBLE_SETTING_COUNT);

WARNING:LONG_LINE: line length of 98 exceeds 80 columns
#937: FILE: drivers/bluetooth/btmtk_main.c:655:
+	btmtk_free_fw_cfg_struct(bdev->woble_setting_apcf_fill_mac_location, WOBLE_SETTING_COUNT);

WARNING:LONG_LINE: line length of 87 exceeds 80 columns
#938: FILE: drivers/bluetooth/btmtk_main.c:656:
+	btmtk_free_fw_cfg_struct(bdev->woble_setting_apcf_resume, WOBLE_SETTING_COUNT);

WARNING:LONG_LINE: line length of 81 exceeds 80 columns
#940: FILE: drivers/bluetooth/btmtk_main.c:658:
+	btmtk_free_fw_cfg_struct(&bdev->woble_setting_radio_off_status_event, 1);

WARNING:LONG_LINE: line length of 84 exceeds 80 columns
#951: FILE: drivers/bluetooth/btmtk_main.c:669:
+	btmtk_free_fw_cfg_struct(bdev->bt_cfg.phase1_wmt_cmd, PHASE1_WMT_CMD_COUNT);

WARNING:LONG_LINE: line length of 89 exceeds 80 columns
#955: FILE: drivers/bluetooth/btmtk_main.c:673:
+		if (bdev->wobt_irq != 0 && atomic_read(&(bdev->irq_enable_count)) == 1) {

WARNING:LONG_LINE: line length of 98 exceeds 80 columns
#960: FILE: drivers/bluetooth/btmtk_main.c:678:
+			BTMTK_INFO("irq_enable count:%d", atomic_read(&(bdev->irq_enable_count)));

WARNING:LONG_LINE: line length of 84 exceeds 80 columns
#993: FILE: drivers/bluetooth/btmtk_main.c:711:
+	btmtk_free_fw_cfg_struct(bdev->bt_cfg.phase1_wmt_cmd, PHASE1_WMT_CMD_COUNT);

WARNING:LONG_LINE_STRING: line length of 89 exceeds 80 columns
#1013: FILE: drivers/bluetooth/btmtk_main.c:731:
+		"UNKNOWN", "INIT", "DISCONNECT", "PROBE", "WORKING", "SUSPEND", "RESUME",

WARNING:LONG_LINE: line length of 86 exceeds 80 columns
#1017: FILE: drivers/bluetooth/btmtk_main.c:735:
+	BTMTK_INFO("%s: %s(%d) -> %s(%d)", __func__, state_msg[bdev->interface_state],

WARNING:LONG_LINE: line length of 92 exceeds 80 columns
#1042: FILE: drivers/bluetooth/btmtk_main.c:760:
+	BTMTK_INFO("%s: FOPS_%s(%d) -> FOPS_%s(%d)", __func__, fstate_msg[bdev->fops_state],

WARNING:LONG_LINE_STRING: line length of 92 exceeds 80 columns
#1075: FILE: drivers/bluetooth/btmtk_main.c:793:
+	BTMTK_INFO("Using A5 A5 to separator the head 32 bytes and the tail 32 bytes data");

WARNING:LONG_LINE: line length of 90 exceeds 80 columns
#1083: FILE: drivers/bluetooth/btmtk_main.c:801:
+				"time(%u)-act_len(%d)-len(%d):", hci_cmd_timestamp[index],

WARNING:LONG_LINE_STRING: line length of 92 exceeds 80 columns
#1091: FILE: drivers/bluetooth/btmtk_main.c:809:
+	BTMTK_INFO("Using A5 A5 to separator the head 32 bytes and the tail 32 bytes data");

WARNING:LONG_LINE: line length of 82 exceeds 80 columns
#1098: FILE: drivers/bluetooth/btmtk_main.c:816:
+			BTMTK_INFO_RAW(hci_event_buf[index], hci_event_len[index],

WARNING:LONG_LINE: line length of 92 exceeds 80 columns
#1099: FILE: drivers/bluetooth/btmtk_main.c:817:
+				"time(%u)-act_len(%d)-len(%d):", hci_event_timestamp[index],

WARNING:LONG_LINE: line length of 83 exceeds 80 columns
#1100: FILE: drivers/bluetooth/btmtk_main.c:818:
+				hci_event_actual_len[index], hci_event_len[index]);

WARNING:LONG_LINE_STRING: line length of 92 exceeds 80 columns
#1107: FILE: drivers/bluetooth/btmtk_main.c:825:
+	BTMTK_INFO("Using A5 A5 to separator the head 32 bytes and the tail 32 bytes data");

WARNING:LONG_LINE: line length of 90 exceeds 80 columns
#1114: FILE: drivers/bluetooth/btmtk_main.c:832:
+			BTMTK_INFO_RAW(hci_adv_event_buf[index], hci_adv_event_len[index],

WARNING:LONG_LINE: line length of 96 exceeds 80 columns
#1115: FILE: drivers/bluetooth/btmtk_main.c:833:
+				"time(%u)-act_len(%d)-len(%d):", hci_adv_event_timestamp[index],

WARNING:LONG_LINE: line length of 91 exceeds 80 columns
#1116: FILE: drivers/bluetooth/btmtk_main.c:834:
+				hci_adv_event_actual_len[index], hci_adv_event_len[index]);

WARNING:LONG_LINE_STRING: line length of 92 exceeds 80 columns
#1123: FILE: drivers/bluetooth/btmtk_main.c:841:
+	BTMTK_INFO("Using A5 A5 to separator the head 32 bytes and the tail 32 bytes data");

WARNING:LONG_LINE: line length of 90 exceeds 80 columns
#1131: FILE: drivers/bluetooth/btmtk_main.c:849:
+				"time(%u)-act_len(%d)-len(%d):", hci_acl_timestamp[index],

WARNING:LONG_LINE: line length of 85 exceeds 80 columns
#1159: FILE: drivers/bluetooth/btmtk_main.c:877:
+		} else if (len > HCI_SNOOP_BUF_SIZE && len <= HCI_SNOOP_BUF_SIZE * 2)

WARNING:LONG_LINE: line length of 86 exceeds 80 columns
#1164: FILE: drivers/bluetooth/btmtk_main.c:882:
+		hci_cmd_timestamp[hci_cmd_index] = btmtk_hci_snoop_get_microseconds();

WARNING:LONG_LINE_COMMENT: line length of 82 exceeds 80 columns
#1167: FILE: drivers/bluetooth/btmtk_main.c:885:
+		/* save less then 32 bytes data in the buffer tail, using A5 A5 to

WARNING:LONG_LINE: line length of 85 exceeds 80 columns
#1174: FILE: drivers/bluetooth/btmtk_main.c:892:
+			memcpy(hci_cmd_buf[hci_cmd_index] + copy_len, separator_char,

WARNING:LONG_LINE: line length of 94 exceeds 80 columns
#1176: FILE: drivers/bluetooth/btmtk_main.c:894:
+			memcpy(hci_cmd_buf[hci_cmd_index] + copy_len + sizeof(separator_char),

WARNING:LONG_LINE: line length of 85 exceeds 80 columns
#1197: FILE: drivers/bluetooth/btmtk_main.c:915:
+		} else if (len > HCI_SNOOP_BUF_SIZE && len <= HCI_SNOOP_BUF_SIZE * 2)

WARNING:LONG_LINE: line length of 98 exceeds 80 columns
#1202: FILE: drivers/bluetooth/btmtk_main.c:920:
+		hci_adv_event_timestamp[hci_adv_event_index] = btmtk_hci_snoop_get_microseconds();

WARNING:LONG_LINE: line length of 90 exceeds 80 columns
#1203: FILE: drivers/bluetooth/btmtk_main.c:921:
+		memset(hci_adv_event_buf[hci_adv_event_index], 0, HCI_SNOOP_MAX_BUF_SIZE);

WARNING:LONG_LINE_COMMENT: line length of 82 exceeds 80 columns
#1205: FILE: drivers/bluetooth/btmtk_main.c:923:
+		/* save less then 32 bytes data in the buffer tail, using A5 A5 to

WARNING:LONG_LINE: line length of 97 exceeds 80 columns
#1212: FILE: drivers/bluetooth/btmtk_main.c:930:
+			memcpy(hci_adv_event_buf[hci_adv_event_index] + copy_len, separator_char,

WARNING:LONG_LINE: line length of 82 exceeds 80 columns
#1214: FILE: drivers/bluetooth/btmtk_main.c:932:
+			memcpy(hci_adv_event_buf[hci_adv_event_index] + copy_len +

WARNING:LONG_LINE: line length of 85 exceeds 80 columns
#1215: FILE: drivers/bluetooth/btmtk_main.c:933:
+			       sizeof(separator_char), copy_tail_buf, copy_tail_len);

WARNING:LONG_LINE: line length of 85 exceeds 80 columns
#1235: FILE: drivers/bluetooth/btmtk_main.c:953:
+		} else if (len > HCI_SNOOP_BUF_SIZE && len <= HCI_SNOOP_BUF_SIZE * 2)

WARNING:LONG_LINE: line length of 90 exceeds 80 columns
#1240: FILE: drivers/bluetooth/btmtk_main.c:958:
+		hci_event_timestamp[hci_event_index] = btmtk_hci_snoop_get_microseconds();

WARNING:LONG_LINE: line length of 82 exceeds 80 columns
#1241: FILE: drivers/bluetooth/btmtk_main.c:959:
+		memset(hci_event_buf[hci_event_index], 0, HCI_SNOOP_MAX_BUF_SIZE);

WARNING:LONG_LINE_COMMENT: line length of 82 exceeds 80 columns
#1243: FILE: drivers/bluetooth/btmtk_main.c:961:
+		/* save less then 32 bytes data in the buffer tail, using A5 A5 to

WARNING:LONG_LINE: line length of 89 exceeds 80 columns
#1250: FILE: drivers/bluetooth/btmtk_main.c:968:
+			memcpy(hci_event_buf[hci_event_index] + copy_len, separator_char,

WARNING:LONG_LINE: line length of 98 exceeds 80 columns
#1252: FILE: drivers/bluetooth/btmtk_main.c:970:
+			memcpy(hci_event_buf[hci_event_index] + copy_len + sizeof(separator_char),

WARNING:LONG_LINE: line length of 85 exceeds 80 columns
#1273: FILE: drivers/bluetooth/btmtk_main.c:991:
+		} else if (len > HCI_SNOOP_BUF_SIZE && len <= HCI_SNOOP_BUF_SIZE * 2)

WARNING:LONG_LINE: line length of 86 exceeds 80 columns
#1278: FILE: drivers/bluetooth/btmtk_main.c:996:
+		hci_acl_timestamp[hci_acl_index] = btmtk_hci_snoop_get_microseconds();

WARNING:LONG_LINE_COMMENT: line length of 82 exceeds 80 columns
#1281: FILE: drivers/bluetooth/btmtk_main.c:999:
+		/* save less then 32 bytes data in the buffer tail, using A5 A5 to

WARNING:LONG_LINE: line length of 85 exceeds 80 columns
#1287: FILE: drivers/bluetooth/btmtk_main.c:1005:
+						      sizeof(separator_char)) & 0xff;

WARNING:LONG_LINE: line length of 85 exceeds 80 columns
#1288: FILE: drivers/bluetooth/btmtk_main.c:1006:
+			memcpy(hci_acl_buf[hci_acl_index] + copy_len, separator_char,

WARNING:LONG_LINE: line length of 94 exceeds 80 columns
#1290: FILE: drivers/bluetooth/btmtk_main.c:1008:
+			memcpy(hci_acl_buf[hci_acl_index] + copy_len + sizeof(separator_char),

WARNING:LONG_LINE: line length of 85 exceeds 80 columns
#1313: FILE: drivers/bluetooth/btmtk_main.c:1031:
+		} else if (len > HCI_SNOOP_BUF_SIZE && len <= HCI_SNOOP_BUF_SIZE * 2)

WARNING:LONG_LINE_COMMENT: line length of 82 exceeds 80 columns
#1319: FILE: drivers/bluetooth/btmtk_main.c:1037:
+		/* save less then 32 bytes data in the buffer tail, using A5 A5 to

WARNING:LONG_LINE: line length of 89 exceeds 80 columns
#1324: FILE: drivers/bluetooth/btmtk_main.c:1042:
+			hci_snoop_len += (copy_tail_len + sizeof(separator_char)) & 0xff;

WARNING:LONG_LINE: line length of 97 exceeds 80 columns
#1325: FILE: drivers/bluetooth/btmtk_main.c:1043:
+			memcpy(hci_snoop_buf + copy_len, separator_char, sizeof(separator_char));

WARNING:LONG_LINE: line length of 81 exceeds 80 columns
#1326: FILE: drivers/bluetooth/btmtk_main.c:1044:
+			memcpy(hci_snoop_buf + copy_len + sizeof(separator_char),

WARNING:LONG_LINE_STRING: line length of 100 exceeds 80 columns
#1331: FILE: drivers/bluetooth/btmtk_main.c:1049:
+			BTMTK_INFO_RAW(hci_snoop_buf, hci_snoop_len, "act_len(%d)-len(%d)-buf(%p):",

WARNING:LONG_LINE: line length of 99 exceeds 80 columns
#1358: FILE: drivers/bluetooth/btmtk_main.c:1076:
+					BTMTK_WARN("%s: fops is not opened(%d)", __func__, fstate);

WARNING:LONG_LINE: line length of 95 exceeds 80 columns
#1364: FILE: drivers/bluetooth/btmtk_main.c:1082:
+					BTMTK_WARN("%s: not in working(%d).", __func__, state);

WARNING:LONG_LINE: line length of 85 exceeds 80 columns
#1371: FILE: drivers/bluetooth/btmtk_main.c:1089:
+					BTMTK_WARN("%s parameter is NULL", __func__);

WARNING:LONG_LINE: line length of 89 exceeds 80 columns
#1377: FILE: drivers/bluetooth/btmtk_main.c:1095:
+				btmtk_set_chip_state((void *)bdev, cif_state->ops_enter);

WARNING:LONG_LINE: line length of 85 exceeds 80 columns
#1379: FILE: drivers/bluetooth/btmtk_main.c:1097:
+				btmtk_fops_set_state(bdev, BTMTK_FOPS_STATE_CLOSING);

WARNING:LONG_LINE: line length of 97 exceeds 80 columns
#1386: FILE: drivers/bluetooth/btmtk_main.c:1104:
+					BTMTK_ERR("%s, btmtk_send_deinit_cmds failed", __func__);

WARNING:LONG_LINE: line length of 82 exceeds 80 columns
#1391: FILE: drivers/bluetooth/btmtk_main.c:1109:
+					main_info.hif_hook.cif_mutex_unlock(bdev);

WARNING:LONG_LINE: line length of 84 exceeds 80 columns
#1393: FILE: drivers/bluetooth/btmtk_main.c:1111:
+				btmtk_fops_set_state(bdev, BTMTK_FOPS_STATE_CLOSED);

WARNING:LONG_LINE: line length of 95 exceeds 80 columns
#1397: FILE: drivers/bluetooth/btmtk_main.c:1115:
+					btmtk_set_chip_state((void *)bdev, cif_state->ops_end);

WARNING:LONG_LINE: line length of 97 exceeds 80 columns
#1399: FILE: drivers/bluetooth/btmtk_main.c:1117:
+					btmtk_set_chip_state((void *)bdev, cif_state->ops_error);

WARNING:LONG_LINE: line length of 83 exceeds 80 columns
#1422: FILE: drivers/bluetooth/btmtk_main.c:1140:
+		BTMTK_WARN("%s minimum interface is %d", __func__, btmtk_intf_num);

WARNING:LONG_LINE: line length of 82 exceeds 80 columns
#1431: FILE: drivers/bluetooth/btmtk_main.c:1149:
+		func_ptr pFunc = (func_ptr) btmtk_kallsyms_lookup_name(func_name);

WARNING:LONG_LINE: line length of 85 exceeds 80 columns
#1434: FILE: drivers/bluetooth/btmtk_main.c:1152:
+			BTMTK_INFO("%s: Register Pdwnc callback success.", __func__);

WARNING:LONG_LINE_STRING: line length of 81 exceeds 80 columns
#1437: FILE: drivers/bluetooth/btmtk_main.c:1155:
+			BTMTK_WARN("%s: No Exported Func Found [%s], just skip!",

WARNING:LONG_LINE_STRING: line length of 84 exceeds 80 columns
#1465: FILE: drivers/bluetooth/btmtk_main.c:1183:
+	main_info.fwdump_ws = wakeup_source_register(NULL, "btmtk_fwdump_wakelock");

WARNING:LONG_LINE_STRING: line length of 82 exceeds 80 columns
#1466: FILE: drivers/bluetooth/btmtk_main.c:1184:
+	main_info.woble_ws = wakeup_source_register(NULL, "btmtk_woble_wakelock");

WARNING:LONG_LINE: line length of 85 exceeds 80 columns
#1545: FILE: drivers/bluetooth/btmtk_main.c:1263:
+					BTMTK_ERR("%s, alloc skb failed!", __func__);

WARNING:LONG_LINE: line length of 89 exceeds 80 columns
#1556: FILE: drivers/bluetooth/btmtk_main.c:1274:
+				BTMTK_ERR("%s,skb is invalid, buffer[0] = %d!", __func__,

WARNING:LONG_LINE_COMMENT: line length of 97 exceeds 80 columns
#1576: FILE: drivers/bluetooth/btmtk_main.c:1294:
+		/* BTMTK_DBG("%s skb->len = %d, %d", __func__, skb->len, hci_skb_expect(skb)); */

WARNING:LONG_LINE_COMMENT: line length of 94 exceeds 80 columns
#1599: FILE: drivers/bluetooth/btmtk_main.c:1317:
+			/* BTMTK_DBG("%s begin, skb->len = %d, %d, %d", __func__, skb->len, */

WARNING:LONG_LINE_STRING: line length of 93 exceeds 80 columns
#1612: FILE: drivers/bluetooth/btmtk_main.c:1330:
+					BTMTK_ERR("%s, skb_tailroom is not enough, dlen:%d!",

WARNING:LONG_LINE: line length of 83 exceeds 80 columns
#1614: FILE: drivers/bluetooth/btmtk_main.c:1332:
+					btmtk_hci_snoop_print(skb->len, skb->data);

WARNING:LONG_LINE: line length of 85 exceeds 80 columns
#1615: FILE: drivers/bluetooth/btmtk_main.c:1333:
+					btmtk_hci_snoop_print(count_dbg, buffer_dbg);

WARNING:LONG_LINE_STRING: line length of 88 exceeds 80 columns
#1629: FILE: drivers/bluetooth/btmtk_main.c:1347:
+					BTMTK_ERR("%s, skb_tailroom in case 2, dlen:%d!"

WARNING:LONG_LINE: line length of 83 exceeds 80 columns
#1631: FILE: drivers/bluetooth/btmtk_main.c:1349:
+					btmtk_hci_snoop_print(skb->len, skb->data);

WARNING:LONG_LINE: line length of 85 exceeds 80 columns
#1632: FILE: drivers/bluetooth/btmtk_main.c:1350:
+					btmtk_hci_snoop_print(count_dbg, buffer_dbg);

WARNING:LONG_LINE: line length of 88 exceeds 80 columns
#1641: FILE: drivers/bluetooth/btmtk_main.c:1359:
+				BTMTK_ERR("%s, Unsupported variable length!", __func__);

WARNING:LONG_LINE: line length of 86 exceeds 80 columns
#1670: FILE: drivers/bluetooth/btmtk_main.c:1388:
+static inline struct sk_buff *mtk_add_stp(struct btmtk_dev *bdev, struct sk_buff *skb)

WARNING:LONG_LINE_STRING: line length of 83 exceeds 80 columns
#1678: FILE: drivers/bluetooth/btmtk_main.c:1396:
+		BTMTK_DBG("%s, add pskb_expand_head, headroom = %d, tailroom = %d",

WARNING:LONG_LINE_STRING: line length of 96 exceeds 80 columns
#1858: FILE: drivers/bluetooth/btmtk_main.c:1576:
+			BTMTK_INFO("%s: FW dump on-going, total_packet = %d, total_length = %d",

WARNING:LONG_LINE: line length of 87 exceeds 80 columns
#1859: FILE: drivers/bluetooth/btmtk_main.c:1577:
+					__func__, dump_data_counter, dump_data_length);

WARNING:LONG_LINE: line length of 84 exceeds 80 columns
#1865: FILE: drivers/bluetooth/btmtk_main.c:1583:
+					__func__, dump_data_counter, &skb->data[4]);

WARNING:LONG_LINE_COMMENT: line length of 96 exceeds 80 columns
#1867: FILE: drivers/bluetooth/btmtk_main.c:1585:
+		/* In the new generation, we will check the keyword of coredump (; coredump end)

WARNING:LONG_LINE: line length of 86 exceeds 80 columns
#1881: FILE: drivers/bluetooth/btmtk_main.c:1599:
+		if (skb_queue_len(&g_fwlog->fwlog_queue) < FWLOG_ASSERT_QUEUE_COUNT) {

WARNING:LONG_LINE: line length of 81 exceeds 80 columns
#1898: FILE: drivers/bluetooth/btmtk_main.c:1616:
+				(skb->data[0] == 0xff || skb->data[0] == 0xfe) &&

WARNING:LONG_LINE: line length of 87 exceeds 80 columns
#1920: FILE: drivers/bluetooth/btmtk_main.c:1638:
+			       "%s: Discard event from user hci command - ", __func__);

WARNING:LONG_LINE: line length of 85 exceeds 80 columns
#1986: FILE: drivers/bluetooth/btmtk_main.c:1704:
+	BTMTK_DBG_RAW(skb->data, skb->len, "%s, recv evt(hci_recv_frame)", __func__);

WARNING:LONG_LINE: line length of 83 exceeds 80 columns
#1995: FILE: drivers/bluetooth/btmtk_main.c:1713:
+		const int cmd_len, const u8 *event, const int event_len, int delay,

WARNING:LONG_LINE_STRING: line length of 87 exceeds 80 columns
#2012: FILE: drivers/bluetooth/btmtk_main.c:1730:
+		BTMTK_WARN("%s: chip power isn't on, ignore this command, state is %d",

WARNING:LONG_LINE: line length of 92 exceeds 80 columns
#2019: FILE: drivers/bluetooth/btmtk_main.c:1737:
+		BTMTK_WARN("%s: FW dumping ongoing, don't send any cmd to FW!!!", __func__);

WARNING:LONG_LINE_COMMENT: line length of 83 exceeds 80 columns
#2038: FILE: drivers/bluetooth/btmtk_main.c:1756:
+	/* wmt cmd and download fw patch using wmt cmd with USB interface, need use

WARNING:LONG_LINE: line length of 92 exceeds 80 columns
#2069: FILE: drivers/bluetooth/btmtk_main.c:1787:
+	ret = btmtk_main_send_cmd(bdev, cmd, sizeof(cmd), event, sizeof(event), DELAY_TIMES,

WARNING:LONG_LINE: line length of 99 exceeds 80 columns
#2082: FILE: drivers/bluetooth/btmtk_main.c:1800:
+				     char *bin_name, struct device *dev, u8 **image, u32 *code_len)

WARNING:LONG_LINE: line length of 87 exceeds 80 columns
#2098: FILE: drivers/bluetooth/btmtk_main.c:1816:
+			BTMTK_INFO("%s: request_firmware %d times fail", __func__, 10);

WARNING:LONG_LINE_STRING: line length of 99 exceeds 80 columns
#2102: FILE: drivers/bluetooth/btmtk_main.c:1820:
+		BTMTK_INFO("%s: request_firmware fail, maybe file not exist, err = %d, retry = %d",

WARNING:LONG_LINE: line length of 89 exceeds 80 columns
#2124: FILE: drivers/bluetooth/btmtk_main.c:1842:
+		globalDesrc = (struct _Global_Descr *)(fwbuf + FW_ROM_PATCH_HEADER_SIZE);

WARNING:LONG_LINE: line length of 82 exceeds 80 columns
#2131: FILE: drivers/bluetooth/btmtk_main.c:1849:
+		BTMTK_INFO("[btmtk] Magic Number = 0x%08x", patchHdr->u4MagicNum);

WARNING:LONG_LINE: line length of 82 exceeds 80 columns
#2142: FILE: drivers/bluetooth/btmtk_main.c:1860:
+		BTMTK_INFO("[btmtk] Patch Ver = 0x%08x", globalDesrc->u4PatchVer);

WARNING:LONG_LINE: line length of 86 exceeds 80 columns
#2143: FILE: drivers/bluetooth/btmtk_main.c:1861:
+		BTMTK_INFO("[btmtk] Section num = 0x%08x", globalDesrc->u4SectionNum);

WARNING:LONG_LINE: line length of 89 exceeds 80 columns
#2162: FILE: drivers/bluetooth/btmtk_main.c:1880:
+		globalDesrc = (struct _Global_Descr *)(fwbuf + FW_ROM_PATCH_HEADER_SIZE);

WARNING:LONG_LINE: line length of 99 exceeds 80 columns
#2168: FILE: drivers/bluetooth/btmtk_main.c:1886:
+			((patchHdr->u2HwVer & 0x00ff) << 8) | ((patchHdr->u2HwVer & 0xff00) >> 8));

WARNING:LONG_LINE: line length of 99 exceeds 80 columns
#2170: FILE: drivers/bluetooth/btmtk_main.c:1888:
+			((patchHdr->u2SwVer & 0x00ff) << 8) | ((patchHdr->u2SwVer & 0xff00) >> 8));

WARNING:LONG_LINE: line length of 92 exceeds 80 columns
#2171: FILE: drivers/bluetooth/btmtk_main.c:1889:
+		BTMTK_INFO("[btmtk] Magic Number = 0x%08x", be2cpu32(patchHdr->u4MagicNum));

WARNING:LONG_LINE: line length of 87 exceeds 80 columns
#2192: FILE: drivers/bluetooth/btmtk_main.c:1910:
+		int cmd_len, u8 *event, int event_len, struct _Section_Map *sectionMap,

WARNING:LONG_LINE: line length of 81 exceeds 80 columns
#2200: FILE: drivers/bluetooth/btmtk_main.c:1918:
+	if (bdev == NULL || cmd == NULL || event == NULL || sectionMap == NULL) {

WARNING:LONG_LINE_COMMENT: line length of 87 exceeds 80 columns
#2223: FILE: drivers/bluetooth/btmtk_main.c:1941:
+		cmd[9] = dma_flag; /* 1:using DMA to download, 0:using legacy wmt cmd*/

WARNING:LONG_LINE: line length of 84 exceeds 80 columns
#2228: FILE: drivers/bluetooth/btmtk_main.c:1946:
+				revert_SecSpec = be2cpu32(sectionMap->u4SecSpec[i]);

WARNING:LONG_LINE: line length of 81 exceeds 80 columns
#2229: FILE: drivers/bluetooth/btmtk_main.c:1947:
+				memcpy(&cmd[PATCH_HEADER_SIZE] + i * sizeof(u32),

WARNING:LONG_LINE: line length of 86 exceeds 80 columns
#2233: FILE: drivers/bluetooth/btmtk_main.c:1951:
+			memcpy(&cmd[PATCH_HEADER_SIZE], (u8 *)(sectionMap->u4SecSpec),

WARNING:LONG_LINE: line length of 99 exceeds 80 columns
#2239: FILE: drivers/bluetooth/btmtk_main.c:1957:
+				event, event_len, DELAY_TIMES, RETRY_TIMES, BTMTK_TX_CMD_FROM_DRV);

WARNING:LONG_LINE: line length of 86 exceeds 80 columns
#2241: FILE: drivers/bluetooth/btmtk_main.c:1959:
+			BTMTK_ERR("%s: send wmd dl cmd failed, terminate!", __func__);

WARNING:LONG_LINE: line length of 90 exceeds 80 columns
#2257: FILE: drivers/bluetooth/btmtk_main.c:1975:
+		u8 *image, u8 *fwbuf, u8 *event, int event_len, u32 patch_len, int offset)

WARNING:LONG_LINE: line length of 90 exceeds 80 columns
#2318: FILE: drivers/bluetooth/btmtk_main.c:2036:
+			BTMTK_DBG("%s: sent_len = %d, cur_len = %d, phase = %d", __func__,

WARNING:LONG_LINE: line length of 92 exceeds 80 columns
#2321: FILE: drivers/bluetooth/btmtk_main.c:2039:
+			ret = btmtk_main_send_cmd(bdev, image, sent_len + PATCH_HEADER_SIZE,

WARNING:LONG_LINE: line length of 95 exceeds 80 columns
#2322: FILE: drivers/bluetooth/btmtk_main.c:2040:
+					event, event_len, delay, retry, BTMTK_TX_ACL_FROM_DRV);

WARNING:LONG_LINE: line length of 89 exceeds 80 columns
#2324: FILE: drivers/bluetooth/btmtk_main.c:2042:
+				BTMTK_INFO("%s: send patch failed, terminate", __func__);

WARNING:LONG_LINE: line length of 86 exceeds 80 columns
#2340: FILE: drivers/bluetooth/btmtk_main.c:2058:
+	BTMTK_ERR("%s reset_stack_flag = %d!!", __func__, main_info.reset_stack_flag);

WARNING:LONG_LINE: line length of 82 exceeds 80 columns
#2342: FILE: drivers/bluetooth/btmtk_main.c:2060:
+		skb = alloc_skb(sizeof(hwerr_event) + BT_SKB_RESERVE, GFP_ATOMIC);

WARNING:LONG_LINE: line length of 90 exceeds 80 columns
#2351: FILE: drivers/bluetooth/btmtk_main.c:2069:
+			BTMTK_DBG_RAW(skb->data, skb->len, "%s: hw err event:", __func__);

WARNING:LONG_LINE_COMMENT: line length of 94 exceeds 80 columns
#2371: FILE: drivers/bluetooth/btmtk_main.c:2089:
+	u8 event[] = {0x04, 0xE4, 0x05, 0x02, 0x01, 0x01, 0x00, 0x00}; /* event[7] is status*/

WARNING:LONG_LINE: line length of 81 exceeds 80 columns
#2379: FILE: drivers/bluetooth/btmtk_main.c:2097:
+	globalDescr = (struct _Global_Descr *)(fwbuf + FW_ROM_PATCH_HEADER_SIZE);

WARNING:LONG_LINE: line length of 87 exceeds 80 columns
#2396: FILE: drivers/bluetooth/btmtk_main.c:2114:
+		sectionMap = (struct _Section_Map *)(fwbuf + FW_ROM_PATCH_HEADER_SIZE +

WARNING:LONG_LINE: line length of 95 exceeds 80 columns
#2397: FILE: drivers/bluetooth/btmtk_main.c:2115:
+				FW_ROM_PATCH_GD_SIZE + FW_ROM_PATCH_SEC_MAP_SIZE * loop_count);

WARNING:LONG_LINE: line length of 94 exceeds 80 columns
#2403: FILE: drivers/bluetooth/btmtk_main.c:2121:
+			dma_flag = be2cpu32(sectionMap->bin_info_spec.u4DLModeCrcType) & 0xFF;

WARNING:LONG_LINE: line length of 94 exceeds 80 columns
#2413: FILE: drivers/bluetooth/btmtk_main.c:2131:
+			dma_flag = le2cpu32(sectionMap->bin_info_spec.u4DLModeCrcType) & 0xFF;

WARNING:LONG_LINE: line length of 93 exceeds 80 columns
#2417: FILE: drivers/bluetooth/btmtk_main.c:2135:
+		BTMTK_INFO("download patch_len = 0x%08x, dl mode = %d\n", dl_size, dma_flag);

WARNING:LONG_LINE: line length of 95 exceeds 80 columns
#2421: FILE: drivers/bluetooth/btmtk_main.c:2139:
+				patch_status = btmtk_send_wmt_download_cmd(bdev, pos, 0, event,

WARNING:LONG_LINE: line length of 90 exceeds 80 columns
#2424: FILE: drivers/bluetooth/btmtk_main.c:2142:
+				BTMTK_INFO("%s: patch_status %d", __func__, patch_status);

WARNING:LONG_LINE: line length of 94 exceeds 80 columns
#2426: FILE: drivers/bluetooth/btmtk_main.c:2144:
+				if (patch_status > PATCH_READY || patch_status == PATCH_ERR) {

WARNING:LONG_LINE: line length of 86 exceeds 80 columns
#2427: FILE: drivers/bluetooth/btmtk_main.c:2145:
+					BTMTK_ERR("%s: patch_status error", __func__);

WARNING:LONG_LINE_STRING: line length of 93 exceeds 80 columns
#2431: FILE: drivers/bluetooth/btmtk_main.c:2149:
+					BTMTK_INFO("%s: no need to load rom patch section%d",

WARNING:LONG_LINE: line length of 88 exceeds 80 columns
#2434: FILE: drivers/bluetooth/btmtk_main.c:2152:
+				} else if (patch_status == PATCH_IS_DOWNLOAD_BY_OTHER) {

WARNING:LONG_LINE: line length of 81 exceeds 80 columns
#2437: FILE: drivers/bluetooth/btmtk_main.c:2155:
+				} else if (patch_status == PATCH_NEED_DOWNLOAD) {

WARNING:LONG_LINE_COMMENT: line length of 81 exceeds 80 columns
#2438: FILE: drivers/bluetooth/btmtk_main.c:2156:
+					break;  /* Download ROM patch directly */

WARNING:LONG_LINE: line length of 100 exceeds 80 columns
#2443: FILE: drivers/bluetooth/btmtk_main.c:2161:
+				BTMTK_WARN("%s: Hold by another fun more than 2 seconds", __func__);

WARNING:LONG_LINE: line length of 96 exceeds 80 columns
#2448: FILE: drivers/bluetooth/btmtk_main.c:2166:
+			if (dma_flag == PATCH_DOWNLOAD_USING_DMA && main_info.hif_hook.dl_dma) {

WARNING:LONG_LINE_STRING: line length of 94 exceeds 80 columns
#2454: FILE: drivers/bluetooth/btmtk_main.c:2172:
+					BTMTK_ERR("%s: btmtk_load_fw_patch_using_dma failed!",

WARNING:LONG_LINE: line length of 96 exceeds 80 columns
#2460: FILE: drivers/bluetooth/btmtk_main.c:2178:
+				ret = btmtk_load_fw_patch_using_wmt_cmd(bdev, pos, fwbuf, event,

WARNING:LONG_LINE: line length of 92 exceeds 80 columns
#2461: FILE: drivers/bluetooth/btmtk_main.c:2179:
+						sizeof(event) - 1, dl_size, section_offset);

WARNING:LONG_LINE_STRING: line length of 98 exceeds 80 columns
#2463: FILE: drivers/bluetooth/btmtk_main.c:2181:
+					BTMTK_ERR("%s: btmtk_load_fw_patch_using_wmt_cmd failed!",

WARNING:LONG_LINE_COMMENT: line length of 90 exceeds 80 columns
#2505: FILE: drivers/bluetooth/btmtk_main.c:2223:
+			/* if flavor equals 1, it represent 7920, else it represent 7921*/

WARNING:LONG_LINE: line length of 86 exceeds 80 columns
#2506: FILE: drivers/bluetooth/btmtk_main.c:2224:
+			snprintf(bdev->rom_patch_bin_file_name, MAX_BIN_FILE_NAME_LEN,

WARNING:LONG_LINE: line length of 95 exceeds 80 columns
#2508: FILE: drivers/bluetooth/btmtk_main.c:2226:
+					bdev->chip_id & 0xffff, (bdev->fw_version & 0xff) + 1);

WARNING:LONG_LINE: line length of 86 exceeds 80 columns
#2510: FILE: drivers/bluetooth/btmtk_main.c:2228:
+			snprintf(bdev->rom_patch_bin_file_name, MAX_BIN_FILE_NAME_LEN,

WARNING:LONG_LINE: line length of 95 exceeds 80 columns
#2512: FILE: drivers/bluetooth/btmtk_main.c:2230:
+					bdev->chip_id & 0xffff, (bdev->fw_version & 0xff) + 1);

WARNING:LONG_LINE: line length of 83 exceeds 80 columns
#2515: FILE: drivers/bluetooth/btmtk_main.c:2233:
+	btmtk_load_code_from_bin(&fw_firmware, bdev->rom_patch_bin_file_name, NULL,

WARNING:LONG_LINE_STRING: line length of 96 exceeds 80 columns
#2519: FILE: drivers/bluetooth/btmtk_main.c:2237:
+		BTMTK_ERR("%s: please assign a rom patch(/etc/firmware/%s)or(/lib/firmware/%s)",

WARNING:LONG_LINE: line length of 96 exceeds 80 columns
#2520: FILE: drivers/bluetooth/btmtk_main.c:2238:
+			__func__, bdev->rom_patch_bin_file_name, bdev->rom_patch_bin_file_name);

WARNING:LONG_LINE: line length of 83 exceeds 80 columns
#2564: FILE: drivers/bluetooth/btmtk_main.c:2282:
+	btmtk_load_code_from_bin(&fw_firmware, bdev->rom_patch_bin_file_name, NULL,

WARNING:LONG_LINE: line length of 93 exceeds 80 columns
#2571: FILE: drivers/bluetooth/btmtk_main.c:2289:
+		if (patch_status > MT766X_PATCH_NEED_DOWNLOAD || patch_status == PATCH_ERR) {

WARNING:LONG_LINE: line length of 84 exceeds 80 columns
#2587: FILE: drivers/bluetooth/btmtk_main.c:2305:
+		BTMTK_WARN("%s: Hold by another fun more than 2 seconds", __func__);

WARNING:LONG_LINE: line length of 94 exceeds 80 columns
#2651: FILE: drivers/bluetooth/btmtk_main.c:2369:
+			BTMTK_ERR("%s: btmtk_load_rom_patch_79xx bt patch failed!", __func__);

WARNING:LONG_LINE: line length of 97 exceeds 80 columns
#2658: FILE: drivers/bluetooth/btmtk_main.c:2376:
+			BTMTK_WARN("%s: btmtk_load_rom_patch_79xx wifi patch failed!", __func__);

WARNING:LONG_LINE: line length of 90 exceeds 80 columns
#2684: FILE: drivers/bluetooth/btmtk_main.c:2402:
+				g_bdev[i]->dongle_index = g_bdev[i - 1]->dongle_index + 1;

WARNING:LONG_LINE_COMMENT: line length of 85 exceeds 80 columns
#2686: FILE: drivers/bluetooth/btmtk_main.c:2404:
+			/* reset pin initial value need to be -1, used to judge after

WARNING:LONG_LINE: line length of 85 exceeds 80 columns
#2693: FILE: drivers/bluetooth/btmtk_main.c:2411:
+			g_bdev[i]->cif_state = (struct btmtk_cif_state *)g_cif_state;

WARNING:LONG_LINE: line length of 82 exceeds 80 columns
#2715: FILE: drivers/bluetooth/btmtk_main.c:2433:
+			if (memcmp(tmp_bdev, g_bdev[i], sizeof(*tmp_bdev)) == 0) {

WARNING:LONG_LINE_COMMENT: line length of 93 exceeds 80 columns
#2717: FILE: drivers/bluetooth/btmtk_main.c:2435:
+				/* reset pin initial value need to be -1, used to judge after

WARNING:LONG_LINE_COMMENT: line length of 81 exceeds 80 columns
#2718: FILE: drivers/bluetooth/btmtk_main.c:2436:
+				 * disconnected before probe, can't do chip reset

WARNING:LONG_LINE: line length of 85 exceeds 80 columns
#2785: FILE: drivers/bluetooth/btmtk_main.c:2503:
+	ret = btmtk_main_send_cmd(bdev, cmd, sizeof(cmd), event, sizeof(event), 0, 0,

WARNING:LONG_LINE: line length of 89 exceeds 80 columns
#2812: FILE: drivers/bluetooth/btmtk_main.c:2530:
+		BTMTK_WARN("%s: end of Incorrect state:%d", __func__, bdev->power_state);

WARNING:LONG_LINE: line length of 91 exceeds 80 columns
#2833: FILE: drivers/bluetooth/btmtk_main.c:2551:
+		ret = btmtk_main_send_cmd(bdev, cmd, sizeof(cmd), event, sizeof(event), 20,

WARNING:LONG_LINE: line length of 89 exceeds 80 columns
#2843: FILE: drivers/bluetooth/btmtk_main.c:2561:
+		BTMTK_WARN("%s: end of Incorrect state:%d", __func__, bdev->power_state);

WARNING:LONG_LINE: line length of 82 exceeds 80 columns
#2854: FILE: drivers/bluetooth/btmtk_main.c:2572:
+	u8 cmd[] = { 0x01, 0x6F, 0xFC, 0x06, 0x01, 0x06, 0x02, 0x00, 0x00, 0x01 };

WARNING:LONG_LINE_COMMENT: line length of 93 exceeds 80 columns
#2856: FILE: drivers/bluetooth/btmtk_main.c:2574:
+	u8 event[] = { 0x04, 0xE4, 0x05, 0x02, 0x06, 0x01, 0x00 };	/* event[6] is key */

WARNING:LONG_LINE: line length of 96 exceeds 80 columns
#2866: FILE: drivers/bluetooth/btmtk_main.c:2584:
+	ret = btmtk_main_send_cmd(bdev, cmd, sizeof(cmd), event, sizeof(event), WMT_DELAY_TIMES,

WARNING:LONG_LINE_COMMENT: line length of 86 exceeds 80 columns
#2881: FILE: drivers/bluetooth/btmtk_main.c:2599:
+				 * we need to retry a sec until power on successfully.

WARNING:LONG_LINE: line length of 90 exceeds 80 columns
#2890: FILE: drivers/bluetooth/btmtk_main.c:2608:
+			BTMTK_WARN("%s: Unknown result: %02X", __func__, bdev->io_buf[6]);

WARNING:LONG_LINE: line length of 82 exceeds 80 columns
#2903: FILE: drivers/bluetooth/btmtk_main.c:2621:
+	u8 cmd[] = { 0x01, 0x6F, 0xFC, 0x06, 0x01, 0x06, 0x02, 0x00, 0x00, 0x00 };

WARNING:LONG_LINE: line length of 92 exceeds 80 columns
#2918: FILE: drivers/bluetooth/btmtk_main.c:2636:
+	ret = btmtk_main_send_cmd(bdev, cmd, sizeof(cmd), event, sizeof(event), DELAY_TIMES,

WARNING:LONG_LINE: line length of 81 exceeds 80 columns
#2933: FILE: drivers/bluetooth/btmtk_main.c:2651:
+	u8 dft_enable_cmd[] = { 0x01, 0x5D, 0xFC, 0x04, 0x00, 0x00, 0x02, 0x02 };

WARNING:LONG_LINE: line length of 85 exceeds 80 columns
#2935: FILE: drivers/bluetooth/btmtk_main.c:2653:
+	u8 enable_event[] = { 0x04, 0x0E, 0x08, 0x01, 0x5D, 0xFC, 0x00, 0x00, 0x00 };

WARNING:LONG_LINE: line length of 82 exceeds 80 columns
#2968: FILE: drivers/bluetooth/btmtk_main.c:2686:
+	u8 dft_disable_cmd[] = { 0x01, 0x5D, 0xFC, 0x04, 0x00, 0x00, 0x02, 0x00 };

WARNING:LONG_LINE: line length of 90 exceeds 80 columns
#2969: FILE: drivers/bluetooth/btmtk_main.c:2687:
+	u8 dft_disable_event[] = { 0x04, 0x0E, 0x08, 0x01, 0x5D, 0xFC, 0x00, 0x00, 0x00 };

WARNING:LONG_LINE: line length of 89 exceeds 80 columns
#2991: FILE: drivers/bluetooth/btmtk_main.c:2709:
+	u8 reserve_apcf_cmd[] = { 0x01, 0xC9, 0xFC, 0x05, 0x01, 0x30, 0x02, 0x61, 0x02 };

WARNING:LONG_LINE: line length of 91 exceeds 80 columns
#3000: FILE: drivers/bluetooth/btmtk_main.c:2718:
+		ret = btmtk_main_send_cmd(bdev, reserve_apcf_cmd, sizeof(reserve_apcf_cmd),

WARNING:LONG_LINE: line length of 96 exceeds 80 columns
#3013: FILE: drivers/bluetooth/btmtk_main.c:2731:
+	u8 event[] = { 0x04, 0x0E, 0x0A, 0x01, 0x09, 0x10, 0x00, /* AA, BB, CC, DD, EE, FF */ };

WARNING:LONG_LINE: line length of 85 exceeds 80 columns
#3030: FILE: drivers/bluetooth/btmtk_main.c:2748:
+	ret = btmtk_main_send_cmd(bdev, cmd, sizeof(cmd), event, sizeof(event), 0, 0,

WARNING:LONG_LINE: line length of 89 exceeds 80 columns
#3053: FILE: drivers/bluetooth/btmtk_main.c:2771:
+	ret = btmtk_main_send_cmd(bdev, cmd, sizeof(cmd), comp_event, sizeof(comp_event),

WARNING:LONG_LINE: line length of 89 exceeds 80 columns
#3070: FILE: drivers/bluetooth/btmtk_main.c:2788:
+	ret = btmtk_main_send_cmd(bdev, cmd, sizeof(cmd), comp_event, sizeof(comp_event),

WARNING:LONG_LINE: line length of 86 exceeds 80 columns
#3083: FILE: drivers/bluetooth/btmtk_main.c:2801:
+	u8 radio_off_cmd[] = { 0x01, 0xC9, 0xFC, 0x05, 0x01, 0x20, 0x02, 0x00, 0x00 };

WARNING:LONG_LINE: line length of 86 exceeds 80 columns
#3089: FILE: drivers/bluetooth/btmtk_main.c:2807:
+			comp_event, sizeof(comp_event), 0, 0, BTMTK_TX_PKT_FROM_HOST);

WARNING:LONG_LINE: line length of 85 exceeds 80 columns
#3100: FILE: drivers/bluetooth/btmtk_main.c:2818:
+	u8 radio_on_cmd[] = { 0x01, 0xC9, 0xFC, 0x05, 0x01, 0x21, 0x02, 0x00, 0x00 };

WARNING:LONG_LINE: line length of 86 exceeds 80 columns
#3106: FILE: drivers/bluetooth/btmtk_main.c:2824:
+			comp_event, sizeof(comp_event), 0, 0, BTMTK_TX_PKT_FROM_HOST);

WARNING:LONG_LINE: line length of 93 exceeds 80 columns
#3119: FILE: drivers/bluetooth/btmtk_main.c:2837:
+	u8 event_complete[] = { 0x04, 0x0E, 0x07, 0x01, 0x57, 0xFD, 0x00, 0x01/*, 00, 63*/ };

WARNING:LONG_LINE: line length of 86 exceeds 80 columns
#3123: FILE: drivers/bluetooth/btmtk_main.c:2841:
+		event_complete, sizeof(event_complete), 0, 0, BTMTK_TX_PKT_FROM_HOST);

WARNING:LONG_LINE: line length of 84 exceeds 80 columns
#3146: FILE: drivers/bluetooth/btmtk_main.c:2864:
+	u8 event[] = { 0x04, 0x0E, 0x07, 0x01, 0x57, 0xFD, 0x00, /* 0x06 00 63 */ };

WARNING:LONG_LINE: line length of 92 exceeds 80 columns
#3157: FILE: drivers/bluetooth/btmtk_main.c:2875:
+			BTMTK_INFO("%s: apcf_fill_mac[%d].content[0] = 0x%02x", __func__, i,

WARNING:LONG_LINE: line length of 89 exceeds 80 columns
#3158: FILE: drivers/bluetooth/btmtk_main.c:2876:
+					bdev->woble_setting_apcf_fill_mac[i].content[0]);

WARNING:LONG_LINE: line length of 93 exceeds 80 columns
#3159: FILE: drivers/bluetooth/btmtk_main.c:2877:
+			BTMTK_INFO("%s: apcf_fill_mac_location[%d].length = %d", __func__, i,

WARNING:LONG_LINE: line length of 94 exceeds 80 columns
#3160: FILE: drivers/bluetooth/btmtk_main.c:2878:
+					bdev->woble_setting_apcf_fill_mac_location[i].length);

WARNING:LONG_LINE: line length of 85 exceeds 80 columns
#3162: FILE: drivers/bluetooth/btmtk_main.c:2880:
+			if ((bdev->woble_setting_apcf_fill_mac[i].content[0] == 1) &&

WARNING:LONG_LINE: line length of 87 exceeds 80 columns
#3163: FILE: drivers/bluetooth/btmtk_main.c:2881:
+				bdev->woble_setting_apcf_fill_mac_location[i].length) {

WARNING:LONG_LINE: line length of 100 exceeds 80 columns
#3166: FILE: drivers/bluetooth/btmtk_main.c:2884:
+				       (*bdev->woble_setting_apcf_fill_mac_location[i].content + 1),

WARNING:LONG_LINE_STRING: line length of 91 exceeds 80 columns
#3168: FILE: drivers/bluetooth/btmtk_main.c:2886:
+				BTMTK_INFO("%s: apcf[%d], add local BDADDR to location %d",

WARNING:LONG_LINE: line length of 98 exceeds 80 columns
#3170: FILE: drivers/bluetooth/btmtk_main.c:2888:
+					(*bdev->woble_setting_apcf_fill_mac_location[i].content));

WARNING:LONG_LINE: line length of 92 exceeds 80 columns
#3176: FILE: drivers/bluetooth/btmtk_main.c:2894:
+			ret = btmtk_main_send_cmd(bdev, bdev->woble_setting_apcf[i].content,

WARNING:LONG_LINE: line length of 95 exceeds 80 columns
#3177: FILE: drivers/bluetooth/btmtk_main.c:2895:
+				bdev->woble_setting_apcf[i].length, event, sizeof(event), 0, 0,

WARNING:LONG_LINE: line length of 93 exceeds 80 columns
#3180: FILE: drivers/bluetooth/btmtk_main.c:2898:
+				BTMTK_ERR("%s: manufactur_data error ret %d", __func__, ret);

WARNING:LONG_LINE: line length of 89 exceeds 80 columns
#3187: FILE: drivers/bluetooth/btmtk_main.c:2905:
+		ret = btmtk_main_send_cmd(bdev, manufactur_data, sizeof(manufactur_data),

WARNING:LONG_LINE: line length of 85 exceeds 80 columns
#3190: FILE: drivers/bluetooth/btmtk_main.c:2908:
+			BTMTK_ERR("%s: manufactur_data error ret %d", __func__, ret);

WARNING:LONG_LINE: line length of 85 exceeds 80 columns
#3260: FILE: drivers/bluetooth/btmtk_main.c:2978:
+		ret = btmtk_main_send_cmd(bdev, bdev->woble_setting_radio_on.content,

WARNING:LONG_LINE: line length of 86 exceeds 80 columns
#3278: FILE: drivers/bluetooth/btmtk_main.c:2996:
+	u8 event[] = { 0x04, 0x0e, 0x07, 0x01, 0x57, 0xfd, 0x00, 0x01, /* 00, 63 */ };

WARNING:LONG_LINE: line length of 82 exceeds 80 columns
#3304: FILE: drivers/bluetooth/btmtk_main.c:3022:
+			BTMTK_INFO_RAW(bdev->woble_setting_apcf_resume[i].content,

WARNING:LONG_LINE: line length of 89 exceeds 80 columns
#3314: FILE: drivers/bluetooth/btmtk_main.c:3032:
+				BTMTK_ERR("%s: Send apcf resume fail %d", __func__, ret);

WARNING:LONG_LINE: line length of 98 exceeds 80 columns
#3322: FILE: drivers/bluetooth/btmtk_main.c:3040:
+			BTMTK_ERR("%s: btmtk_del_Woble_APCF_index return fail %d", __func__, ret);

WARNING:LONG_LINE: line length of 83 exceeds 80 columns
#3328: FILE: drivers/bluetooth/btmtk_main.c:3046:
+int btmtk_load_fw_cfg_setting(char *block_name, struct fw_cfg_struct *save_content,

WARNING:LONG_LINE: line length of 83 exceeds 80 columns
#3329: FILE: drivers/bluetooth/btmtk_main.c:3047:
+		int counter, u8 *searchcontent, enum fw_cfg_index_len index_length)

WARNING:LONG_LINE: line length of 83 exceeds 80 columns
#3349: FILE: drivers/bluetooth/btmtk_main.c:3067:
+			snprintf(search, sizeof(search), "%s%02d:", block_name, i);

WARNING:LONG_LINE: line length of 83 exceeds 80 columns
#3351: FILE: drivers/bluetooth/btmtk_main.c:3069:
+			snprintf(search, sizeof(search), "%s%03d:", block_name, i);

WARNING:LONG_LINE_COMMENT: line length of 97 exceeds 80 columns
#3359: FILE: drivers/bluetooth/btmtk_main.c:3077:
+			/* find next line as end of this command line, if NULL means last line */

WARNING:LONG_LINE: line length of 86 exceeds 80 columns
#3364: FILE: drivers/bluetooth/btmtk_main.c:3082:
+				!memcmp(block_name, "RADIOOFF", sizeof("RADIOOFF")) ||

WARNING:LONG_LINE: line length of 84 exceeds 80 columns
#3365: FILE: drivers/bluetooth/btmtk_main.c:3083:
+				!memcmp(block_name, "RADIOON", sizeof("RADIOON")) ||

WARNING:LONG_LINE: line length of 92 exceeds 80 columns
#3366: FILE: drivers/bluetooth/btmtk_main.c:3084:
+				!memcmp(block_name, "APCF_RESUME", sizeof("APCF_RESUME")) ||

WARNING:LONG_LINE: line length of 90 exceeds 80 columns
#3367: FILE: drivers/bluetooth/btmtk_main.c:3085:
+				!memcmp(block_name, "VENDOR_CMD", sizeof("VENDOR_CMD")) ||

WARNING:LONG_LINE: line length of 98 exceeds 80 columns
#3368: FILE: drivers/bluetooth/btmtk_main.c:3086:
+				!memcmp(block_name, "PHASE1_WMT_CMD", sizeof("PHASE1_WMT_CMD"))) {

WARNING:LONG_LINE: line length of 82 exceeds 80 columns
#3385: FILE: drivers/bluetooth/btmtk_main.c:3103:
+				if (search_end - search_result != CHAR2HEX_SIZE) {

WARNING:LONG_LINE: line length of 98 exceeds 80 columns
#3386: FILE: drivers/bluetooth/btmtk_main.c:3104:
+					BTMTK_ERR("%s: Incorrect Format in %s", __func__, search);

WARNING:LONG_LINE_STRING: line length of 81 exceeds 80 columns
#3395: FILE: drivers/bluetooth/btmtk_main.c:3113:
+						BTMTK_ERR("%s: %s data over %zu",

WARNING:LONG_LINE: line length of 88 exceeds 80 columns
#3396: FILE: drivers/bluetooth/btmtk_main.c:3114:
+							__func__, search, sizeof(temp));

WARNING:LONG_LINE: line length of 84 exceeds 80 columns
#3409: FILE: drivers/bluetooth/btmtk_main.c:3127:
+			BTMTK_DBG("%s: %s is not found in %d", __func__, search, i);

WARNING:LONG_LINE: line length of 87 exceeds 80 columns
#3412: FILE: drivers/bluetooth/btmtk_main.c:3130:
+			BTMTK_INFO("%s: %s found & stored in %d", __func__, search, i);

WARNING:LONG_LINE: line length of 87 exceeds 80 columns
#3415: FILE: drivers/bluetooth/btmtk_main.c:3133:
+				BTMTK_ERR("%s: Allocate memory fail(%d)", __func__, i);

WARNING:LONG_LINE: line length of 82 exceeds 80 columns
#3429: FILE: drivers/bluetooth/btmtk_main.c:3147:
+			struct device *dev, u32 *code_len, struct btmtk_dev *bdev)

WARNING:LONG_LINE: line length of 84 exceeds 80 columns
#3442: FILE: drivers/bluetooth/btmtk_main.c:3160:
+	BTMTK_INFO("%s: begin setting_file_name = %s", __func__, setting_file_name);

WARNING:LONG_LINE_STRING: line length of 96 exceeds 80 columns
#3445: FILE: drivers/bluetooth/btmtk_main.c:3163:
+		BTMTK_INFO("%s: request_firmware fail, file not exist, err = %d, fw_entry = %p",

WARNING:LONG_LINE: line length of 99 exceeds 80 columns
#3452: FILE: drivers/bluetooth/btmtk_main.c:3170:
+	BTMTK_INFO("%s: setting file request_firmware size %zu success", __func__, fw_entry->size);

WARNING:LONG_LINE: line length of 85 exceeds 80 columns
#3460: FILE: drivers/bluetooth/btmtk_main.c:3178:
+		BTMTK_ERR("%s: kzalloc size %zu failed!!", __func__, fw_entry->size);

WARNING:LONG_LINE: line length of 81 exceeds 80 columns
#3471: FILE: drivers/bluetooth/btmtk_main.c:3189:
+	BTMTK_INFO("%s: setting_file len (%d) assign done", __func__, *code_len);

WARNING:LONG_LINE_STRING: line length of 87 exceeds 80 columns
#3483: FILE: drivers/bluetooth/btmtk_main.c:3201:
+		BTMTK_ERR("woble_setting btmtk_load_code_from_setting_files failed!!");

WARNING:LONG_LINE: line length of 88 exceeds 80 columns
#3500: FILE: drivers/bluetooth/btmtk_main.c:3218:
+			bdev->woble_setting_apcf_fill_mac_location, WOBLE_SETTING_COUNT,

WARNING:LONG_LINE: line length of 86 exceeds 80 columns
#3505: FILE: drivers/bluetooth/btmtk_main.c:3223:
+	err = btmtk_load_fw_cfg_setting("RADIOOFF", &bdev->woble_setting_radio_off, 1,

WARNING:LONG_LINE: line length of 96 exceeds 80 columns
#3547: FILE: drivers/bluetooth/btmtk_main.c:3265:
+			&bdev->woble_setting_radio_on, 1, bdev->setting_file, FW_CFG_INX_LEN_2);

WARNING:LONG_LINE: line length of 85 exceeds 80 columns
#3589: FILE: drivers/bluetooth/btmtk_main.c:3307:
+	ret = btmtk_main_send_cmd(bdev, cmd, sizeof(cmd), event, sizeof(event), 0, 0,

WARNING:LONG_LINE_STRING: line length of 96 exceeds 80 columns
#3614: FILE: drivers/bluetooth/btmtk_main.c:3332:
+		BTMTK_WARN("%s: fops is not open yet(%d), need to start traffic before leaving",

WARNING:LONG_LINE_COMMENT: line length of 84 exceeds 80 columns
#3633: FILE: drivers/bluetooth/btmtk_main.c:3351:
+		/* radio on cmd with wobx_mode_disable, used when unify woble off */

WARNING:LONG_LINE: line length of 89 exceeds 80 columns
#3647: FILE: drivers/bluetooth/btmtk_main.c:3365:
+				BTMTK_ERR("%s, btmtk_send_deinit_cmds failed", __func__);

WARNING:LONG_LINE: line length of 82 exceeds 80 columns
#3652: FILE: drivers/bluetooth/btmtk_main.c:3370:
+					need to stop traffic after leaving woble",

WARNING:LONG_LINE: line length of 94 exceeds 80 columns
#3681: FILE: drivers/bluetooth/btmtk_main.c:3399:
+			BTMTK_WARN("%s: fops is not open yet(%d)!, return", __func__, fstate);

WARNING:LONG_LINE: line length of 92 exceeds 80 columns
#3688: FILE: drivers/bluetooth/btmtk_main.c:3406:
+		BTMTK_WARN("%s: FW dumping ongoing, don't send any cmd to FW!!!", __func__);

WARNING:LONG_LINE_STRING: line length of 100 exceeds 80 columns
#3706: FILE: drivers/bluetooth/btmtk_main.c:3424:
+		BTMTK_WARN("%s: fops is not open yet(%d), need to start traffic before enter woble",

WARNING:LONG_LINE: line length of 91 exceeds 80 columns
#3717: FILE: drivers/bluetooth/btmtk_main.c:3435:
+			typedef ssize_t (*func) (u16 u16Key, const char *buf, size_t size);

WARNING:LONG_LINE: line length of 91 exceeds 80 columns
#3727: FILE: drivers/bluetooth/btmtk_main.c:3445:
+				BTMTK_INFO("%s: Invoke %s, buf = %d, sret = %zd", __func__,

WARNING:LONG_LINE: line length of 99 exceeds 80 columns
#3731: FILE: drivers/bluetooth/btmtk_main.c:3449:
+				BTMTK_WARN("%s: No Exported Func Found [%s]", __func__, func_name);

WARNING:LONG_LINE_COMMENT: line length of 85 exceeds 80 columns
#3751: FILE: drivers/bluetooth/btmtk_main.c:3469:
+		/* radio off cmd with wobx_mode_disable, used when unify woble off */

WARNING:LONG_LINE_STRING: line length of 94 exceeds 80 columns
#3757: FILE: drivers/bluetooth/btmtk_main.c:3475:
+		BTMTK_WARN("%s: fops is not open(%d), need to stop traffic after enter woble",

WARNING:LONG_LINE: line length of 90 exceeds 80 columns
#3774: FILE: drivers/bluetooth/btmtk_main.c:3492:
+	BTMTK_INFO("%s: end ret = %d, power_state =%d", __func__, ret, bdev->power_state);

WARNING:LONG_LINE: line length of 83 exceeds 80 columns
#3787: FILE: drivers/bluetooth/btmtk_main.c:3505:
+	if (!is_support_unify_woble(bdev) && (fstate != BTMTK_FOPS_STATE_OPENED)) {

WARNING:LONG_LINE: line length of 97 exceeds 80 columns
#3788: FILE: drivers/bluetooth/btmtk_main.c:3506:
+		BTMTK_WARN("%s: when not support woble, in bt off state, do nothing!", __func__);

WARNING:LONG_LINE: line length of 97 exceeds 80 columns
#3794: FILE: drivers/bluetooth/btmtk_main.c:3512:
+		BTMTK_ERR("%s: btmtk_handle_entering_WoBLE_state return fail %d", __func__, ret);

WARNING:LONG_LINE: line length of 89 exceeds 80 columns
#3797: FILE: drivers/bluetooth/btmtk_main.c:3515:
+		if (bdev->wobt_irq != 0 && atomic_read(&(bdev->irq_enable_count)) == 0) {

WARNING:LONG_LINE: line length of 98 exceeds 80 columns
#3803: FILE: drivers/bluetooth/btmtk_main.c:3521:
+			BTMTK_INFO("irq_enable count:%d", atomic_read(&(bdev->irq_enable_count)));

WARNING:LONG_LINE: line length of 83 exceeds 80 columns
#3819: FILE: drivers/bluetooth/btmtk_main.c:3537:
+	if (!is_support_unify_woble(bdev) && (fstate != BTMTK_FOPS_STATE_OPENED)) {

WARNING:LONG_LINE: line length of 97 exceeds 80 columns
#3820: FILE: drivers/bluetooth/btmtk_main.c:3538:
+		BTMTK_WARN("%s: when not support woble, in bt off state, do nothing!", __func__);

WARNING:LONG_LINE_STRING: line length of 94 exceeds 80 columns
#3825: FILE: drivers/bluetooth/btmtk_main.c:3543:
+		BTMTK_INFO("%s: In BTMTK_DONGLE_STATE_ERROR(Could suspend caused), do assert",

WARNING:LONG_LINE: line length of 89 exceeds 80 columns
#3834: FILE: drivers/bluetooth/btmtk_main.c:3552:
+		if (bdev->wobt_irq != 0 && atomic_read(&(bdev->irq_enable_count)) == 1) {

WARNING:LONG_LINE: line length of 98 exceeds 80 columns
#3839: FILE: drivers/bluetooth/btmtk_main.c:3557:
+			BTMTK_INFO("irq_enable count:%d", atomic_read(&(bdev->irq_enable_count)));

WARNING:LONG_LINE: line length of 96 exceeds 80 columns
#3844: FILE: drivers/bluetooth/btmtk_main.c:3562:
+		BTMTK_ERR("%s: btmtk_handle_leaving_WoBLE_state return fail %d", __func__, ret);

WARNING:LONG_LINE: line length of 81 exceeds 80 columns
#3854: FILE: drivers/bluetooth/btmtk_main.c:3572:
+		main_info.reset_stack_flag = HW_ERR_CODE_RESET_STACK_AFTER_WOBLE;

WARNING:LONG_LINE: line length of 84 exceeds 80 columns
#3857: FILE: drivers/bluetooth/btmtk_main.c:3575:
+	BTMTK_INFO("%s: end(%d), reset_stack_flag = %d, fstate = %d", __func__, ret,

WARNING:LONG_LINE: line length of 81 exceeds 80 columns
#3892: FILE: drivers/bluetooth/btmtk_main.c:3610:
+			btmtk_set_chip_state((void *)bdev, cif_state->ops_enter);

WARNING:LONG_LINE: line length of 87 exceeds 80 columns
#3899: FILE: drivers/bluetooth/btmtk_main.c:3617:
+				btmtk_set_chip_state((void *)bdev, cif_state->ops_end);

WARNING:LONG_LINE: line length of 89 exceeds 80 columns
#3901: FILE: drivers/bluetooth/btmtk_main.c:3619:
+				btmtk_set_chip_state((void *)bdev, cif_state->ops_error);

WARNING:LONG_LINE_COMMENT: line length of 88 exceeds 80 columns
#3931: FILE: drivers/bluetooth/btmtk_main.c:3649:
+	snprintf(search, sizeof(search), "%s", item_name); /* EX: SUPPORT_UNIFY_WOBLE */

WARNING:LONG_LINE: line length of 92 exceeds 80 columns
#4001: FILE: drivers/bluetooth/btmtk_main.c:3719:
+		btmtk_bt_cfg_item_value_to_bool(text, &bt_cfg_content->support_unify_woble);

WARNING:LONG_LINE: line length of 84 exceeds 80 columns
#4002: FILE: drivers/bluetooth/btmtk_main.c:3720:
+		BTMTK_INFO("%s: bt_cfg_content->support_unify_woble = %d", __func__,

WARNING:LONG_LINE: line length of 87 exceeds 80 columns
#4005: FILE: drivers/bluetooth/btmtk_main.c:3723:
+		BTMTK_WARN("%s: search item %s is invalid!", __func__, BT_UNIFY_WOBLE);

WARNING:LONG_LINE: line length of 93 exceeds 80 columns
#4013: FILE: drivers/bluetooth/btmtk_main.c:3731:
+			BTMTK_WARN("%s: kstrtoul failed %s!", __func__, BT_UNIFY_WOBLE_TYPE);

WARNING:LONG_LINE: line length of 92 exceeds 80 columns
#4015: FILE: drivers/bluetooth/btmtk_main.c:3733:
+		BTMTK_WARN("%s: search item %s is invalid!", __func__, BT_UNIFY_WOBLE_TYPE);

WARNING:LONG_LINE: line length of 94 exceeds 80 columns
#4023: FILE: drivers/bluetooth/btmtk_main.c:3741:
+		btmtk_bt_cfg_item_value_to_bool(text, &bt_cfg_content->support_woble_by_eint);

WARNING:LONG_LINE: line length of 86 exceeds 80 columns
#4024: FILE: drivers/bluetooth/btmtk_main.c:3742:
+		BTMTK_INFO("%s: bt_cfg_content->support_woble_by_eint = %d", __func__,

WARNING:LONG_LINE: line length of 89 exceeds 80 columns
#4027: FILE: drivers/bluetooth/btmtk_main.c:3745:
+		BTMTK_WARN("%s: search item %s is invalid!", __func__, BT_WOBLE_BY_EINT);

WARNING:LONG_LINE: line length of 93 exceeds 80 columns
#4035: FILE: drivers/bluetooth/btmtk_main.c:3753:
+			BTMTK_WARN("%s: kstrtoul failed %s!", __func__, BT_DONGLE_RESET_PIN);

WARNING:LONG_LINE: line length of 92 exceeds 80 columns
#4037: FILE: drivers/bluetooth/btmtk_main.c:3755:
+		BTMTK_WARN("%s: search item %s is invalid!", __func__, BT_DONGLE_RESET_PIN);

WARNING:LONG_LINE: line length of 93 exceeds 80 columns
#4045: FILE: drivers/bluetooth/btmtk_main.c:3763:
+		btmtk_bt_cfg_item_value_to_bool(text, &bt_cfg_content->support_dongle_reset);

WARNING:LONG_LINE: line length of 85 exceeds 80 columns
#4046: FILE: drivers/bluetooth/btmtk_main.c:3764:
+		BTMTK_INFO("%s: bt_cfg_content->support_dongle_reset = %d", __func__,

WARNING:LONG_LINE: line length of 88 exceeds 80 columns
#4049: FILE: drivers/bluetooth/btmtk_main.c:3767:
+		BTMTK_WARN("%s: search item %s is invalid!", __func__, BT_RESET_DONGLE);

WARNING:LONG_LINE: line length of 93 exceeds 80 columns
#4054: FILE: drivers/bluetooth/btmtk_main.c:3772:
+		btmtk_bt_cfg_item_value_to_bool(text, &bt_cfg_content->support_full_fw_dump);

WARNING:LONG_LINE: line length of 85 exceeds 80 columns
#4055: FILE: drivers/bluetooth/btmtk_main.c:3773:
+		BTMTK_INFO("%s: bt_cfg_content->support_full_fw_dump = %d", __func__,

WARNING:LONG_LINE: line length of 88 exceeds 80 columns
#4058: FILE: drivers/bluetooth/btmtk_main.c:3776:
+		BTMTK_WARN("%s: search item %s is invalid!", __func__, BT_FULL_FW_DUMP);

WARNING:LONG_LINE: line length of 95 exceeds 80 columns
#4063: FILE: drivers/bluetooth/btmtk_main.c:3781:
+		btmtk_bt_cfg_item_value_to_bool(text, &bt_cfg_content->support_woble_wakelock);

WARNING:LONG_LINE: line length of 87 exceeds 80 columns
#4064: FILE: drivers/bluetooth/btmtk_main.c:3782:
+		BTMTK_INFO("%s: bt_cfg_content->support_woble_wakelock = %d", __func__,

WARNING:LONG_LINE: line length of 90 exceeds 80 columns
#4067: FILE: drivers/bluetooth/btmtk_main.c:3785:
+		BTMTK_WARN("%s: search item %s is invalid!", __func__, BT_WOBLE_WAKELOCK);

WARNING:LONG_LINE: line length of 84 exceeds 80 columns
#4070: FILE: drivers/bluetooth/btmtk_main.c:3788:
+	ret = btmtk_parse_bt_cfg_file(BT_WOBLE_FOR_BT_DISABLE, text, searchcontent);

WARNING:LONG_LINE: line length of 87 exceeds 80 columns
#4073: FILE: drivers/bluetooth/btmtk_main.c:3791:
+					&bt_cfg_content->support_woble_for_bt_disable);

WARNING:LONG_LINE: line length of 93 exceeds 80 columns
#4074: FILE: drivers/bluetooth/btmtk_main.c:3792:
+		BTMTK_INFO("%s: bt_cfg_content->support_woble_for_bt_disable = %d", __func__,

WARNING:LONG_LINE: line length of 96 exceeds 80 columns
#4077: FILE: drivers/bluetooth/btmtk_main.c:3795:
+		BTMTK_WARN("%s: search item %s is invalid!", __func__, BT_WOBLE_FOR_BT_DISABLE);

WARNING:LONG_LINE: line length of 87 exceeds 80 columns
#4080: FILE: drivers/bluetooth/btmtk_main.c:3798:
+	ret = btmtk_parse_bt_cfg_file(BT_RESET_STACK_AFTER_WOBLE, text, searchcontent);

WARNING:LONG_LINE: line length of 96 exceeds 80 columns
#4082: FILE: drivers/bluetooth/btmtk_main.c:3800:
+		btmtk_bt_cfg_item_value_to_bool(text, &bt_cfg_content->reset_stack_after_woble);

WARNING:LONG_LINE: line length of 88 exceeds 80 columns
#4083: FILE: drivers/bluetooth/btmtk_main.c:3801:
+		BTMTK_INFO("%s: bt_cfg_content->reset_stack_after_woble = %d", __func__,

WARNING:LONG_LINE: line length of 99 exceeds 80 columns
#4086: FILE: drivers/bluetooth/btmtk_main.c:3804:
+		BTMTK_WARN("%s: search item %s is invalid!", __func__, BT_RESET_STACK_AFTER_WOBLE);

WARNING:LONG_LINE: line length of 91 exceeds 80 columns
#4091: FILE: drivers/bluetooth/btmtk_main.c:3809:
+		btmtk_bt_cfg_item_value_to_bool(text, &bt_cfg_content->support_auto_picus);

WARNING:LONG_LINE: line length of 83 exceeds 80 columns
#4092: FILE: drivers/bluetooth/btmtk_main.c:3810:
+		BTMTK_INFO("%s: bt_cfg_content->support_auto_picus = %d", __func__,

WARNING:LONG_LINE: line length of 86 exceeds 80 columns
#4110: FILE: drivers/bluetooth/btmtk_main.c:3828:
+		BTMTK_WARN("%s: search item %s is invalid!", __func__, BT_AUTO_PICUS);

WARNING:LONG_LINE: line length of 94 exceeds 80 columns
#4115: FILE: drivers/bluetooth/btmtk_main.c:3833:
+		btmtk_bt_cfg_item_value_to_bool(text, &bt_cfg_content->support_picus_to_host);

WARNING:LONG_LINE: line length of 86 exceeds 80 columns
#4116: FILE: drivers/bluetooth/btmtk_main.c:3834:
+		BTMTK_INFO("%s: bt_cfg_content->support_picus_to_host = %d", __func__,

WARNING:LONG_LINE: line length of 89 exceeds 80 columns
#4119: FILE: drivers/bluetooth/btmtk_main.c:3837:
+		BTMTK_WARN("%s: search item %s is invalid!", __func__, BT_PICUS_TO_HOST);

WARNING:LONG_LINE: line length of 94 exceeds 80 columns
#4124: FILE: drivers/bluetooth/btmtk_main.c:3842:
+		btmtk_bt_cfg_item_value_to_bool(text, &bt_cfg_content->support_bt_single_sku);

WARNING:LONG_LINE: line length of 86 exceeds 80 columns
#4125: FILE: drivers/bluetooth/btmtk_main.c:3843:
+		BTMTK_INFO("%s: bt_cfg_content->support_bt_single_sku = %d", __func__,

WARNING:LONG_LINE: line length of 86 exceeds 80 columns
#4128: FILE: drivers/bluetooth/btmtk_main.c:3846:
+		BTMTK_WARN("%s: search item %s is invalid!", __func__, BT_SINGLE_SKU);

WARNING:LONG_LINE: line length of 90 exceeds 80 columns
#4131: FILE: drivers/bluetooth/btmtk_main.c:3849:
+	ret = btmtk_load_fw_cfg_setting(BT_PHASE1_WMT_CMD, bt_cfg_content->phase1_wmt_cmd,

WARNING:LONG_LINE: line length of 87 exceeds 80 columns
#4132: FILE: drivers/bluetooth/btmtk_main.c:3850:
+				PHASE1_WMT_CMD_COUNT, searchcontent, FW_CFG_INX_LEN_3);

WARNING:LONG_LINE: line length of 90 exceeds 80 columns
#4134: FILE: drivers/bluetooth/btmtk_main.c:3852:
+		BTMTK_WARN("%s: search item %s is invalid!", __func__, BT_PHASE1_WMT_CMD);

WARNING:LONG_LINE: line length of 82 exceeds 80 columns
#4136: FILE: drivers/bluetooth/btmtk_main.c:3854:
+	ret = btmtk_load_fw_cfg_setting(BT_VENDOR_CMD, bt_cfg_content->vendor_cmd,

WARNING:LONG_LINE: line length of 83 exceeds 80 columns
#4137: FILE: drivers/bluetooth/btmtk_main.c:3855:
+				VENDOR_CMD_COUNT, searchcontent, FW_CFG_INX_LEN_3);

WARNING:LONG_LINE: line length of 86 exceeds 80 columns
#4139: FILE: drivers/bluetooth/btmtk_main.c:3857:
+		BTMTK_WARN("%s: search item %s is invalid!", __func__, BT_VENDOR_CMD);

WARNING:LONG_LINE: line length of 82 exceeds 80 columns
#4149: FILE: drivers/bluetooth/btmtk_main.c:3867:
+bool btmtk_load_bt_cfg(char *cfg_name, struct device *dev, struct btmtk_dev *bdev)

WARNING:LONG_LINE: line length of 81 exceeds 80 columns
#4154: FILE: drivers/bluetooth/btmtk_main.c:3872:
+	if (btmtk_load_code_from_setting_files(cfg_name, dev, &code_len, bdev)) {

WARNING:LONG_LINE: line length of 99 exceeds 80 columns
#4170: FILE: drivers/bluetooth/btmtk_main.c:3888:
+	u8 cmd[] = { 0x01, 0x6F, 0xFC, 0x09, 0x01, 0x04, 0x05, 0x00, 0x03, 0x11, 0x0E, 0x00, 0x00};

WARNING:LONG_LINE: line length of 85 exceeds 80 columns
#4175: FILE: drivers/bluetooth/btmtk_main.c:3893:
+	ret = btmtk_main_send_cmd(bdev, cmd, sizeof(cmd), event, sizeof(event), 0, 0,

WARNING:LONG_LINE: line length of 85 exceeds 80 columns
#4192: FILE: drivers/bluetooth/btmtk_main.c:3910:
+	ret = btmtk_main_send_cmd(bdev, cmd, sizeof(cmd), event, sizeof(event), 0, 0,

WARNING:LONG_LINE: line length of 88 exceeds 80 columns
#4202: FILE: drivers/bluetooth/btmtk_main.c:3920:
+	u8 cmd[] = { 0x01, 0x7A, 0xFC, 0x07, 0x05, 0x40, 0x06, 0x40, 0x06, 0x00, 0x00 };

WARNING:LONG_LINE: line length of 85 exceeds 80 columns
#4212: FILE: drivers/bluetooth/btmtk_main.c:3930:
+	ret = btmtk_main_send_cmd(bdev, cmd, sizeof(cmd), event, sizeof(event), 0, 0,

WARNING:LONG_LINE: line length of 81 exceeds 80 columns
#4237: FILE: drivers/bluetooth/btmtk_main.c:3955:
+		main_info.hif_hook.reg_read(bdev, FW_VERSION, &bdev->fw_version);

WARNING:LONG_LINE: line length of 95 exceeds 80 columns
#4249: FILE: drivers/bluetooth/btmtk_main.c:3967:
+		BTMTK_ERR("%s: failed, wrong FW version : 0x%x !", __func__, bdev->fw_version);

WARNING:LONG_LINE: line length of 87 exceeds 80 columns
#4264: FILE: drivers/bluetooth/btmtk_main.c:3982:
+				bdev->chip_id & 0xffff, (bdev->fw_version & 0xff) + 1);

WARNING:LONG_LINE: line length of 87 exceeds 80 columns
#4268: FILE: drivers/bluetooth/btmtk_main.c:3986:
+				bdev->chip_id & 0xffff, (bdev->fw_version & 0xff) + 1);

WARNING:LONG_LINE: line length of 93 exceeds 80 columns
#4270: FILE: drivers/bluetooth/btmtk_main.c:3988:
+	BTMTK_INFO("%s: rom patch file name is %s", __func__, bdev->rom_patch_bin_file_name);

WARNING:LONG_LINE: line length of 83 exceeds 80 columns
#4273: FILE: drivers/bluetooth/btmtk_main.c:3991:
+		memcpy(bdev->woble_setting_file_name, WOBLE_SETTING_FILE_NAME_7663,

WARNING:LONG_LINE: line length of 83 exceeds 80 columns
#4280: FILE: drivers/bluetooth/btmtk_main.c:3998:
+		memcpy(bdev->woble_setting_file_name, WOBLE_SETTING_FILE_NAME_7961,

WARNING:LONG_LINE: line length of 95 exceeds 80 columns
#4302: FILE: drivers/bluetooth/btmtk_main.c:4020:
+			ret = btmtk_main_send_cmd(bdev, bdev->bt_cfg.vendor_cmd[index].content,

WARNING:LONG_LINE_STRING: line length of 86 exceeds 80 columns
#4307: FILE: drivers/bluetooth/btmtk_main.c:4025:
+				BTMTK_ERR("%s: Send vendor cmd failed(%d)! Index: %d",

WARNING:LONG_LINE_STRING: line length of 90 exceeds 80 columns
#4313: FILE: drivers/bluetooth/btmtk_main.c:4031:
+				bdev->bt_cfg.vendor_cmd[index].length, "send vendor cmd");

WARNING:LONG_LINE: line length of 99 exceeds 80 columns
#4333: FILE: drivers/bluetooth/btmtk_main.c:4051:
+			ret = btmtk_main_send_cmd(bdev, bdev->bt_cfg.phase1_wmt_cmd[index].content,

WARNING:LONG_LINE: line length of 82 exceeds 80 columns
#4334: FILE: drivers/bluetooth/btmtk_main.c:4052:
+					bdev->bt_cfg.phase1_wmt_cmd[index].length,

WARNING:LONG_LINE_STRING: line length of 90 exceeds 80 columns
#4338: FILE: drivers/bluetooth/btmtk_main.c:4056:
+				BTMTK_ERR("%s: Send phase1 wmt cmd failed(%d)! Index: %d",

WARNING:LONG_LINE: line length of 82 exceeds 80 columns
#4343: FILE: drivers/bluetooth/btmtk_main.c:4061:
+			BTMTK_INFO_RAW(bdev->bt_cfg.phase1_wmt_cmd[index].content,

WARNING:LONG_LINE_STRING: line length of 91 exceeds 80 columns
#4344: FILE: drivers/bluetooth/btmtk_main.c:4062:
+				bdev->bt_cfg.phase1_wmt_cmd[index].length, "send wmt cmd");

WARNING:LONG_LINE: line length of 87 exceeds 80 columns
#4376: FILE: drivers/bluetooth/btmtk_main.c:4094:
+			BTMTK_ERR("%s, btmtk_send_wmt_power_on_cmd failed!", __func__);

WARNING:LONG_LINE: line length of 82 exceeds 80 columns
#4378: FILE: drivers/bluetooth/btmtk_main.c:4096:
+				main_info.reset_stack_flag = HW_ERR_CODE_POWER_ON;

WARNING:LONG_LINE: line length of 90 exceeds 80 columns
#4476: FILE: drivers/bluetooth/btmtk_main.c:4194:
+	ret = main_info.hif_hook.send_cmd(bdev, skb, 100, 20, (int)BTMTK_TX_CMD_FROM_DRV);

WARNING:LONG_LINE_COMMENT: line length of 89 exceeds 80 columns
#4496: FILE: drivers/bluetooth/btmtk_main.c:4214:
+	 *  AA: [5:4] Indicator // [5] 1: command send to BT1, [4] 1: command send to BT0

WARNING:LONG_LINE: line length of 85 exceeds 80 columns
#4518: FILE: drivers/bluetooth/btmtk_main.c:4236:
+	ret = btmtk_main_send_cmd(bdev, cmd, sizeof(cmd), event, sizeof(event), 0, 0,

WARNING:LONG_LINE: line length of 92 exceeds 80 columns
#4539: FILE: drivers/bluetooth/btmtk_main.c:4257:
+			if (decimal != 25 && decimal != 75 && decimal != 5 && decimal != 50)

WARNING:LONG_LINE: line length of 83 exceeds 80 columns
#4559: FILE: drivers/bluetooth/btmtk_main.c:4277:
+		} else if (!is_edr && (power > BLE_MAX_R2 || power < BLE_MIN_R2)) {

WARNING:LONG_LINE: line length of 83 exceeds 80 columns
#4586: FILE: drivers/bluetooth/btmtk_main.c:4304:
+		} else if (!is_edr && (power > BLE_MAX_R1 || power < BLE_MIN_R1)) {

WARNING:LONG_LINE: line length of 82 exceeds 80 columns
#4779: FILE: drivers/bluetooth/btmtk_main.c:4497:
+	BTMTK_INFO("%s request %s success", __func__, DEFAULT_COUNTRY_TABLE_NAME);

WARNING:LONG_LINE: line length of 85 exceeds 80 columns
#4798: FILE: drivers/bluetooth/btmtk_main.c:4516:
+					BTMTK_ERR("Parse power fail, ret = %d", ret);

WARNING:LONG_LINE: line length of 84 exceeds 80 columns
#4844: FILE: drivers/bluetooth/btmtk_main.c:4562:
+	err = request_firmware_nowait(THIS_MODULE, true, DEFAULT_COUNTRY_TABLE_NAME,

WARNING:LONG_LINE: line length of 88 exceeds 80 columns
#4845: FILE: drivers/bluetooth/btmtk_main.c:4563:
+				      NULL, GFP_KERNEL, NULL, btmtk_requset_country_cb);

WARNING:LONG_LINE: line length of 93 exceeds 80 columns
#4860: FILE: drivers/bluetooth/btmtk_main.c:4578:
+		memcpy(main_info.PWS.country_code, code, sizeof(main_info.PWS.country_code));

WARNING:LONG_LINE: line length of 96 exceeds 80 columns
#4928: FILE: drivers/bluetooth/btmtk_main.c:4646:
+	BT_INFO("%s: BT_majorfwlog %d, dev_ID_fwlog %d", __func__, BT_majorfwlog, dev_ID_fwlog);

WARNING:LONG_LINE: line length of 95 exceeds 80 columns
#5008: FILE: drivers/bluetooth/btmtk_main.c:4726:
+		BTMTK_WARN("%s: not in working state and standby state(%d).", __func__, state);

WARNING:LONG_LINE: line length of 81 exceeds 80 columns
#5026: FILE: drivers/bluetooth/btmtk_main.c:4744:
+			BTMTK_ERR("%s, btmtk_send_deinit_cmds failed", __func__);

WARNING:LONG_LINE: line length of 91 exceeds 80 columns
#5049: FILE: drivers/bluetooth/btmtk_main.c:4767:
+	BTMTK_INFO("%s: end, reset_stack_flag = %d", __func__, main_info.reset_stack_flag);

WARNING:LONG_LINE: line length of 95 exceeds 80 columns
#5083: FILE: drivers/bluetooth/btmtk_main.c:4801:
+		BTMTK_WARN("%s: not in working state and standby state(%d).", __func__, state);

WARNING:LONG_LINE: line length of 87 exceeds 80 columns
#5095: FILE: drivers/bluetooth/btmtk_main.c:4813:
+	if (fstate == BTMTK_FOPS_STATE_CLOSING || fstate == BTMTK_FOPS_STATE_OPENING) {

WARNING:LONG_LINE: line length of 89 exceeds 80 columns
#5197: FILE: drivers/bluetooth/btmtk_main.c:4915:
+		BTMTK_WARN("%s: dongle state already power off, do not write", __func__);

WARNING:LONG_LINE: line length of 95 exceeds 80 columns
#5203: FILE: drivers/bluetooth/btmtk_main.c:4921:
+		BTMTK_WARN("%s: reset_stack_flag (%d)!", __func__, main_info.reset_stack_flag);

WARNING:LONG_LINE: line length of 92 exceeds 80 columns
#5208: FILE: drivers/bluetooth/btmtk_main.c:4926:
+	btmtk_dispatch_data_bluetooth_kpi(hdev, skb->data, skb->len, hci_skb_pkt_type(skb));

WARNING:LONG_LINE: line length of 97 exceeds 80 columns
#5215: FILE: drivers/bluetooth/btmtk_main.c:4933:
+	if (memcmp(skb->data, READ_ISO_PACKET_SIZE_CMD, sizeof(READ_ISO_PACKET_SIZE_CMD)) == 0) {

WARNING:LONG_LINE: line length of 83 exceeds 80 columns
#5216: FILE: drivers/bluetooth/btmtk_main.c:4934:
+		bdev->iso_threshold = skb->data[sizeof(READ_ISO_PACKET_SIZE_CMD)] +

WARNING:LONG_LINE: line length of 94 exceeds 80 columns
#5217: FILE: drivers/bluetooth/btmtk_main.c:4935:
+				      (skb->data[sizeof(READ_ISO_PACKET_SIZE_CMD) + 1]  << 8);

WARNING:LONG_LINE: line length of 88 exceeds 80 columns
#5218: FILE: drivers/bluetooth/btmtk_main.c:4936:
+		BTMTK_INFO("%s: Ble iso pkt size is %d", __func__, bdev->iso_threshold);

WARNING:LONG_LINE: line length of 83 exceeds 80 columns
#5225: FILE: drivers/bluetooth/btmtk_main.c:4943:
+			!memcmp(skb->data, fw_assert_cmd, sizeof(fw_assert_cmd))) {

WARNING:LONG_LINE: line length of 92 exceeds 80 columns
#5226: FILE: drivers/bluetooth/btmtk_main.c:4944:
+			BTMTK_INFO("%s: Dongle FW Assert Triggered by BT Stack!", __func__);

WARNING:LONG_LINE: line length of 81 exceeds 80 columns
#5229: FILE: drivers/bluetooth/btmtk_main.c:4947:
+				!memcmp(skb->data, reset_cmd, sizeof(reset_cmd)))

WARNING:LONG_LINE: line length of 88 exceeds 80 columns
#5230: FILE: drivers/bluetooth/btmtk_main.c:4948:
+			BTMTK_INFO("%s: got command: 0x03 0C 00 (HCI_RESET)", __func__);

WARNING:LONG_LINE: line length of 88 exceeds 80 columns
#5233: FILE: drivers/bluetooth/btmtk_main.c:4951:
+	ret = main_info.hif_hook.send_cmd(bdev, skb, 0, 0, (int)BTMTK_TX_PKT_FROM_HOST);

WARNING:LONG_LINE: line length of 83 exceeds 80 columns
#5253: FILE: drivers/bluetooth/btmtk_main.c:4971:
+	struct btmtk_dev *bdev = container_of(work, struct btmtk_dev, reset_waker);

WARNING:LONG_LINE: line length of 82 exceeds 80 columns
#5284: FILE: drivers/bluetooth/btmtk_main.c:5002:
+			BTMTK_INFO("%s: Not support subsys chip reset", __func__);

WARNING:LONG_LINE: line length of 85 exceeds 80 columns
#5287: FILE: drivers/bluetooth/btmtk_main.c:5005:
+		BTMTK_INFO("%s: whole_reset_flag is %d", __func__, whole_reset_flag);

WARNING:LONG_LINE_COMMENT: line length of 91 exceeds 80 columns
#5294: FILE: drivers/bluetooth/btmtk_main.c:5012:
+		/* TODO: need to confirm with usb host when suspend fail, to do chip reset,

WARNING:LONG_LINE_COMMENT: line length of 84 exceeds 80 columns
#5295: FILE: drivers/bluetooth/btmtk_main.c:5013:
+		 * because usb3.0 need to toggle reset pin after hub_event unfreeze,

WARNING:LONG_LINE_COMMENT: line length of 87 exceeds 80 columns
#5296: FILE: drivers/bluetooth/btmtk_main.c:5014:
+		 * otherwise, it will not occur disconnect on Capy Platform. When Mstar

WARNING:LONG_LINE_COMMENT: line length of 84 exceeds 80 columns
#5297: FILE: drivers/bluetooth/btmtk_main.c:5015:
+		 * chip has usb3.0 port, we will use Mstar platform to do comparison

WARNING:LONG_LINE: line length of 81 exceeds 80 columns
#5304: FILE: drivers/bluetooth/btmtk_main.c:5022:
+			BTMTK_INFO("%s: Not support whole chip reset", __func__);

WARNING:LONG_LINE_COMMENT: line length of 83 exceeds 80 columns
#5347: FILE: drivers/bluetooth/btmtk_main.c:5065:
+		/* BTMTK_DBG_RAW(skb->data, skb->len, "%s, recv evt", __func__); */

WARNING:LONG_LINE: line length of 84 exceeds 80 columns
#5358: FILE: drivers/bluetooth/btmtk_main.c:5076:
+				btmtk_hci_snoop_save_adv_event(skb->len, skb->data);

WARNING:LONG_LINE_COMMENT: line length of 91 exceeds 80 columns
#5368: FILE: drivers/bluetooth/btmtk_main.c:5086:
+			/* save hci acl pkt for debug, not include picus log and coredump*/

WARNING:LONG_LINE: line length of 83 exceeds 80 columns
#5381: FILE: drivers/bluetooth/btmtk_main.c:5099:
+						  skb->len, hci_skb_pkt_type(skb));

WARNING:LONG_LINE: line length of 87 exceeds 80 columns
#5429: FILE: drivers/bluetooth/btmtk_main.c:5147:
+						   interrupts, ARRAY_SIZE(interrupts));

WARNING:LONG_LINE: line length of 81 exceeds 80 columns
#5432: FILE: drivers/bluetooth/btmtk_main.c:5150:
+					bdev->wobt_irqlevel, "woble-eint", bdev))

WARNING:LONG_LINE: line length of 86 exceeds 80 columns
#5500: FILE: drivers/bluetooth/btmtk_main.c:5218:
+	if (fstate == BTMTK_FOPS_STATE_OPENED || fstate == BTMTK_FOPS_STATE_CLOSING) {

WARNING:LONG_LINE: line length of 87 exceeds 80 columns
#5501: FILE: drivers/bluetooth/btmtk_main.c:5219:
+		BTMTK_WARN("%s: fstate = %d , set reset_stack_flag", __func__, fstate);

WARNING:LONG_LINE: line length of 82 exceeds 80 columns
#5551: FILE: drivers/bluetooth/btmtk_main.c:5269:
+	bdev->workqueue = alloc_workqueue("BTMTK_RX_WQ", WQ_HIGHPRI | WQ_UNBOUND |

WARNING:LONG_LINE: line length of 91 exceeds 80 columns
#5602: FILE: drivers/bluetooth/btmtk_main.c:5320:
+		bdev->rom_patch_bin_file_name = kzalloc(MAX_BIN_FILE_NAME_LEN, GFP_KERNEL);

WARNING:LONG_LINE_STRING: line length of 90 exceeds 80 columns
#5604: FILE: drivers/bluetooth/btmtk_main.c:5322:
+			BTMTK_ERR("%s: alloc memory fail (bdev->rom_patch_bin_file_name)",

WARNING:LONG_LINE: line length of 84 exceeds 80 columns
#5613: FILE: drivers/bluetooth/btmtk_main.c:5331:
+			BTMTK_ERR("%s: alloc memory fail (bdev->io_buf)", __func__);

WARNING:LONG_LINE: line length of 91 exceeds 80 columns
#5619: FILE: drivers/bluetooth/btmtk_main.c:5337:
+		bdev->woble_setting_file_name = kzalloc(MAX_BIN_FILE_NAME_LEN, GFP_KERNEL);

WARNING:LONG_LINE_STRING: line length of 90 exceeds 80 columns
#5621: FILE: drivers/bluetooth/btmtk_main.c:5339:
+			BTMTK_ERR("%s: alloc memory fail (bdev->woble_setting_file_name)",

WARNING:LONG_LINE: line length of 84 exceeds 80 columns
#5628: FILE: drivers/bluetooth/btmtk_main.c:5346:
+		bdev->bt_cfg_file_name = kzalloc(MAX_BIN_FILE_NAME_LEN, GFP_KERNEL);

WARNING:LONG_LINE: line length of 94 exceeds 80 columns
#5630: FILE: drivers/bluetooth/btmtk_main.c:5348:
+			BTMTK_ERR("%s: alloc memory fail (bdev->bt_cfg_file_name)", __func__);

WARNING:LONG_LINE_COMMENT: line length of 98 exceeds 80 columns
#5714: FILE: drivers/bluetooth/btmtk_main.c:5432:
+		/* if reset_stack is true, when chip reset is done, we need to power on chip to do

WARNING:LONG_LINE: line length of 81 exceeds 80 columns
#5881: FILE: drivers/bluetooth/include/btmtk_buffer_mode.h:76:
+				  struct btmtk_buffer_mode_struct **buffer_mode);

WARNING:LONG_LINE: line length of 81 exceeds 80 columns
#6046: FILE: drivers/bluetooth/include/btmtk_define.h:121:
+#define BTMTK_INFO_RAW(p, l, fmt, ...)						\

WARNING:LONG_LINE: line length of 81 exceeds 80 columns
#6047: FILE: drivers/bluetooth/include/btmtk_define.h:122:
+	do {									\

WARNING:LONG_LINE: line length of 81 exceeds 80 columns
#6048: FILE: drivers/bluetooth/include/btmtk_define.h:123:
+		if (btmtk_log_lvl >= BTMTK_LOG_LVL_INFO) {			\

WARNING:LONG_LINE: line length of 81 exceeds 80 columns
#6049: FILE: drivers/bluetooth/include/btmtk_define.h:124:
+			int raw_count = 0;					\

WARNING:LONG_LINE: line length of 81 exceeds 80 columns
#6050: FILE: drivers/bluetooth/include/btmtk_define.h:125:
+			char str[HCI_SNOOP_MAX_BUF_SIZE * 3 + 1];		\

WARNING:LONG_LINE: line length of 81 exceeds 80 columns
#6051: FILE: drivers/bluetooth/include/btmtk_define.h:126:
+			char *p_str = str;					\

WARNING:LONG_LINE: line length of 81 exceeds 80 columns
#6052: FILE: drivers/bluetooth/include/btmtk_define.h:127:
+			const unsigned char *ptr = p;				\

WARNING:LONG_LINE: line length of 81 exceeds 80 columns
#6053: FILE: drivers/bluetooth/include/btmtk_define.h:128:
+			pr_warn("[btmtk_info] "fmt, ##__VA_ARGS__);		\

WARNING:LONG_LINE: line length of 81 exceeds 80 columns
#6054: FILE: drivers/bluetooth/include/btmtk_define.h:129:
+			for (raw_count = 0;					\

WARNING:LONG_LINE: line length of 97 exceeds 80 columns
#6055: FILE: drivers/bluetooth/include/btmtk_define.h:130:
+				raw_count < MIN(l, HCI_SNOOP_MAX_BUF_SIZE); ++raw_count)	\

WARNING:LONG_LINE: line length of 97 exceeds 80 columns
#6056: FILE: drivers/bluetooth/include/btmtk_define.h:131:
+				p_str += sprintf(p_str, " %02X", ptr[raw_count]);		\

WARNING:LONG_LINE: line length of 97 exceeds 80 columns
#6057: FILE: drivers/bluetooth/include/btmtk_define.h:132:
+			*p_str = '\0';								\

WARNING:LONG_LINE: line length of 89 exceeds 80 columns
#6058: FILE: drivers/bluetooth/include/btmtk_define.h:133:
+			pr_warn("%s\n", str);						\

WARNING:LONG_LINE: line length of 81 exceeds 80 columns
#6059: FILE: drivers/bluetooth/include/btmtk_define.h:134:
+		}								\

WARNING:LONG_LINE: line length of 81 exceeds 80 columns
#6062: FILE: drivers/bluetooth/include/btmtk_define.h:137:
+#define BTMTK_DBG_RAW(p, l, fmt, ...)						\

WARNING:LONG_LINE: line length of 81 exceeds 80 columns
#6063: FILE: drivers/bluetooth/include/btmtk_define.h:138:
+	do {									\

WARNING:LONG_LINE: line length of 81 exceeds 80 columns
#6064: FILE: drivers/bluetooth/include/btmtk_define.h:139:
+		if (btmtk_log_lvl >= BTMTK_LOG_LVL_DBG) {			\

WARNING:LONG_LINE: line length of 81 exceeds 80 columns
#6065: FILE: drivers/bluetooth/include/btmtk_define.h:140:
+			int raw_count = 0;					\

WARNING:LONG_LINE: line length of 81 exceeds 80 columns
#6066: FILE: drivers/bluetooth/include/btmtk_define.h:141:
+			char str[HCI_SNOOP_MAX_BUF_SIZE * 3 + 1];		\

WARNING:LONG_LINE: line length of 81 exceeds 80 columns
#6067: FILE: drivers/bluetooth/include/btmtk_define.h:142:
+			char *p_str = str;					\

WARNING:LONG_LINE: line length of 81 exceeds 80 columns
#6068: FILE: drivers/bluetooth/include/btmtk_define.h:143:
+			const unsigned char *ptr = p;				\

WARNING:LONG_LINE: line length of 81 exceeds 80 columns
#6069: FILE: drivers/bluetooth/include/btmtk_define.h:144:
+			pr_warn("[btmtk_debug] "fmt, ##__VA_ARGS__);		\

WARNING:LONG_LINE: line length of 81 exceeds 80 columns
#6070: FILE: drivers/bluetooth/include/btmtk_define.h:145:
+			for (raw_count = 0;					\

WARNING:LONG_LINE: line length of 97 exceeds 80 columns
#6071: FILE: drivers/bluetooth/include/btmtk_define.h:146:
+				raw_count < MIN(l, HCI_SNOOP_MAX_BUF_SIZE); ++raw_count)	\

WARNING:LONG_LINE: line length of 97 exceeds 80 columns
#6072: FILE: drivers/bluetooth/include/btmtk_define.h:147:
+				p_str += sprintf(p_str, " %02X", ptr[raw_count]);		\

WARNING:LONG_LINE: line length of 97 exceeds 80 columns
#6073: FILE: drivers/bluetooth/include/btmtk_define.h:148:
+			*p_str = '\0';								\

WARNING:LONG_LINE: line length of 89 exceeds 80 columns
#6074: FILE: drivers/bluetooth/include/btmtk_define.h:149:
+			pr_warn("%s", str);						\

WARNING:LONG_LINE: line length of 81 exceeds 80 columns
#6075: FILE: drivers/bluetooth/include/btmtk_define.h:150:
+		}								\

WARNING:LONG_LINE_COMMENT: line length of 87 exceeds 80 columns
#6104: FILE: drivers/bluetooth/include/btmtk_define.h:179:
+ * #define PATCH_HEADER_SIZE	(PATCH_HCI_HEADER_SIZE + PATCH_WMT_HEADER_SIZE + 1 + 6)

WARNING:LONG_LINE: line length of 83 exceeds 80 columns
#6109: FILE: drivers/bluetooth/include/btmtk_define.h:184:
+#define PATCH_HEADER_SIZE	(PATCH_HCI_HEADER_SIZE + PATCH_WMT_HEADER_SIZE + 1)

WARNING:LONG_LINE: line length of 85 exceeds 80 columns
#6128: FILE: drivers/bluetooth/include/btmtk_define.h:203:
+#define IO_BUF_SIZE		(HCI_MAX_EVENT_SIZE > 256 ? HCI_MAX_EVENT_SIZE : 256)

WARNING:LONG_LINE_COMMENT: line length of 81 exceeds 80 columns
#6179: FILE: drivers/bluetooth/include/btmtk_define.h:254:
+	int	length;		/* APCF content or radio off content of length */

WARNING:LONG_LINE_COMMENT: line length of 82 exceeds 80 columns
#6184: FILE: drivers/bluetooth/include/btmtk_define.h:259:
+	bool	support_woble_by_eint;		/* support woble by eint or not */

WARNING:LONG_LINE_COMMENT: line length of 82 exceeds 80 columns
#6186: FILE: drivers/bluetooth/include/btmtk_define.h:261:
+	bool	support_full_fw_dump;		/* dump full fw coredump or not */

WARNING:LONG_LINE_COMMENT: line length of 98 exceeds 80 columns
#6187: FILE: drivers/bluetooth/include/btmtk_define.h:262:
+	bool	support_woble_wakelock;		/* support when woble error, do wakelock or not */

WARNING:LONG_LINE_COMMENT: line length of 98 exceeds 80 columns
#6188: FILE: drivers/bluetooth/include/btmtk_define.h:263:
+	bool	support_woble_for_bt_disable;	/* when bt disable, support enter susend or not */

WARNING:LONG_LINE_COMMENT: line length of 97 exceeds 80 columns
#6189: FILE: drivers/bluetooth/include/btmtk_define.h:264:
+	bool	reset_stack_after_woble; /* support reset stack to re-connect IOT after resume */

WARNING:LONG_LINE_COMMENT: line length of 88 exceeds 80 columns
#6190: FILE: drivers/bluetooth/include/btmtk_define.h:265:
+	bool	support_auto_picus;		/* support enable PICUS automatically */

WARNING:LONG_LINE_COMMENT: line length of 99 exceeds 80 columns
#6191: FILE: drivers/bluetooth/include/btmtk_define.h:266:
+	struct fw_cfg_struct picus_filter;	/* support on PICUS filter command customization */

WARNING:LONG_LINE_COMMENT: line length of 99 exceeds 80 columns
#6192: FILE: drivers/bluetooth/include/btmtk_define.h:267:
+	struct fw_cfg_struct picus_enable;	/* support on PICUS enable command customization */

WARNING:LONG_LINE_COMMENT: line length of 97 exceeds 80 columns
#6193: FILE: drivers/bluetooth/include/btmtk_define.h:268:
+	bool	support_picus_to_host;		/* support picus log to host (boots/bluedroid) */

WARNING:LONG_LINE_COMMENT: line length of 85 exceeds 80 columns
#6194: FILE: drivers/bluetooth/include/btmtk_define.h:269:
+	int	dongle_reset_gpio_pin;		/* BT_DONGLE_RESET_GPIO_PIN number */

WARNING:LONG_LINE_COMMENT: line length of 83 exceeds 80 columns
#6195: FILE: drivers/bluetooth/include/btmtk_define.h:270:
+	unsigned int	unify_woble_type;	/* 0: legacy. 1: waveform. 2: IR */

WARNING:LONG_LINE_COMMENT: line length of 89 exceeds 80 columns
#6420: FILE: drivers/bluetooth/include/btmtk_main.h:22:
+//static inline struct sk_buff *mtk_add_stp(struct btmtk_dev *bdev, struct sk_buff *skb);

WARNING:LONG_LINE: line length of 90 exceeds 80 columns
#6422: FILE: drivers/bluetooth/include/btmtk_main.h:24:
+#define hci_dev_test_and_clear_flag(hdev, nr)  test_and_clear_bit((nr), (hdev)->dev_flags)

WARNING:LONG_LINE_COMMENT: line length of 90 exceeds 80 columns
#6445: FILE: drivers/bluetooth/include/btmtk_main.h:47:
+ * patch download is not complete/BT get patch semaphore fail (WiFi get semaphore success)

WARNING:LONG_LINE_COMMENT: line length of 82 exceeds 80 columns
#6459: FILE: drivers/bluetooth/include/btmtk_main.h:61:
+ * patch is downloading by Wifi,BT driver need to retry until status = PATCH_READY

WARNING:LONG_LINE: line length of 84 exceeds 80 columns
#6508: FILE: drivers/bluetooth/include/btmtk_main.h:110:
+#define FWLOG_QUEUE_COUNT			(400 * BT_MCU_MINIMUM_INTERFACE_NUM)

WARNING:LONG_LINE: line length of 81 exceeds 80 columns
#6799: FILE: drivers/bluetooth/include/btmtk_main.h:401:
+	struct fw_cfg_struct	woble_setting_apcf_fill_mac[WOBLE_SETTING_COUNT];

WARNING:LONG_LINE: line length of 90 exceeds 80 columns
#6800: FILE: drivers/bluetooth/include/btmtk_main.h:402:
+	struct fw_cfg_struct	woble_setting_apcf_fill_mac_location[WOBLE_SETTING_COUNT];

WARNING:LONG_LINE: line length of 81 exceeds 80 columns
#6840: FILE: drivers/bluetooth/include/btmtk_main.h:442:
+typedef int (*cif_event_filter_ptr)(struct btmtk_dev *bdev, struct sk_buff *skb);

WARNING:LONG_LINE: line length of 88 exceeds 80 columns
#6925: FILE: drivers/bluetooth/include/btmtk_main.h:527:
+		const int cmd_len, const uint8_t *event, const int event_len, int delay,

WARNING:LONG_LINE: line length of 83 exceeds 80 columns
#6948: FILE: drivers/bluetooth/include/btmtk_main.h:550:
+bool btmtk_load_bt_cfg(char *cfg_name, struct device *dev, struct btmtk_dev *bdev);

WARNING:LONG_LINE: line length of 95 exceeds 80 columns
#6956: FILE: drivers/bluetooth/include/btmtk_main.h:558:
+ssize_t btmtk_fops_readfwlog(struct file *filp, char __user *buf, size_t count, loff_t *f_pos);

WARNING:LONG_LINE: line length of 92 exceeds 80 columns
#6960: FILE: drivers/bluetooth/include/btmtk_main.h:562:
+long btmtk_fops_unlocked_ioctlfwlog(struct file *filp, unsigned int cmd, unsigned long arg);

WARNING:LONG_LINE_COMMENT: line length of 81 exceeds 80 columns
#7127: FILE: drivers/bluetooth/include/sdio/btmtk_sdio.h:136:
+	 * whether intr_complete and bulk_complete and soc_complete can all share

WARNING:LONG_LINE: line length of 98 exceeds 80 columns
#7443: FILE: drivers/bluetooth/sdio/btmtksdio.c:101:
+	BTMTK_ERR("%s: rx_done_cnt = %d, tx_empty_cnt = %d", __func__, rx_done_cnt, tx_empty_cnt);

WARNING:LONG_LINE_STRING: line length of 89 exceeds 80 columns
#7447: FILE: drivers/bluetooth/sdio/btmtksdio.c:105:
+		BTMTK_ERR("%02d: timestamp = %u, CHISR_r_1 = 0x%08x, CHISR_r_2 = 0x%08x",

WARNING:LONG_LINE: line length of 83 exceeds 80 columns
#7509: FILE: drivers/bluetooth/sdio/btmtksdio.c:167:
+int btmtk_sdio_set_own_back(struct btmtk_sdio_dev *cif_dev, int owntype, int retry)

WARNING:LONG_LINE: line length of 87 exceeds 80 columns
#7560: FILE: drivers/bluetooth/sdio/btmtksdio.c:218:
+			ret = btmtk_sdio_readl(CHLPCR, &u32ReadCRValue, cif_dev->func);

WARNING:LONG_LINE_STRING: line length of 83 exceeds 80 columns
#7563: FILE: drivers/bluetooth/sdio/btmtksdio.c:221:
+			BTMTK_DBG("%s DRIVER_OWN btmtk_sdio_readl(%d) CHLPCR 0x%x",

WARNING:LONG_LINE_STRING: line length of 84 exceeds 80 columns
#7570: FILE: drivers/bluetooth/sdio/btmtksdio.c:228:
+			BTMTK_WARN("%s retry set_check driver own(%d), CHLPCR 0x%x",

WARNING:LONG_LINE: line length of 83 exceeds 80 columns
#7646: FILE: drivers/bluetooth/sdio/btmtksdio.c:304:
+	ret = btmtk_main_send_cmd(bdev, cmd, sizeof(cmd), event, sizeof(event), 20,

WARNING:LONG_LINE: line length of 88 exceeds 80 columns
#7649: FILE: drivers/bluetooth/sdio/btmtksdio.c:307:
+	memcpy(val, bdev->io_buf + MCU_ADDRESS_OFFSET_EVT - HCI_TYPE_SIZE, sizeof(u32));

WARNING:LONG_LINE: line length of 81 exceeds 80 columns
#7671: FILE: drivers/bluetooth/sdio/btmtksdio.c:329:
+		cif_dev->transfer_buf = kzalloc(URB_MAX_BUFFER_SIZE, GFP_KERNEL);

WARNING:LONG_LINE: line length of 90 exceeds 80 columns
#7673: FILE: drivers/bluetooth/sdio/btmtksdio.c:331:
+			BTMTK_ERR("%s: alloc memory fail (bdev->transfer_buf)", __func__);

WARNING:LONG_LINE: line length of 90 exceeds 80 columns
#7681: FILE: drivers/bluetooth/sdio/btmtksdio.c:339:
+			BTMTK_ERR("%s: alloc memory fail (bdev->transfer_buf)", __func__);

WARNING:LONG_LINE: line length of 83 exceeds 80 columns
#7794: FILE: drivers/bluetooth/sdio/btmtksdio.c:452:
+static int btmtk_sdio_writesb(u32 offset, u8 *val, int len, struct sdio_func *func)

WARNING:LONG_LINE: line length of 82 exceeds 80 columns
#7818: FILE: drivers/bluetooth/sdio/btmtksdio.c:476:
+static int btmtk_sdio_readsb(u32 offset, u8 *val, int len, struct sdio_func *func)

WARNING:LONG_LINE: line length of 87 exceeds 80 columns
#8020: FILE: drivers/bluetooth/sdio/btmtksdio.c:678:
+	u8 fw_assert_cmd1[] = { 0x01, 0x6F, 0xFC, 0x05, 0x01, 0x02, 0x01, 0x00, 0x08 };

WARNING:LONG_LINE: line length of 91 exceeds 80 columns
#8043: FILE: drivers/bluetooth/sdio/btmtksdio.c:701:
+		if (skb->data[0] == 0x01 && skb->data[1] == 0x6f && skb->data[2] == 0xfc &&

WARNING:LONG_LINE: line length of 95 exceeds 80 columns
#8047: FILE: drivers/bluetooth/sdio/btmtksdio.c:705:
+			crAddr = ((skb->data[9] & 0xff) << 24) + ((skb->data[10] & 0xff) << 16)

WARNING:LONG_LINE: line length of 89 exceeds 80 columns
#8048: FILE: drivers/bluetooth/sdio/btmtksdio.c:706:
+				+ ((skb->data[11] & 0xff) << 8) + (skb->data[12] & 0xff);

WARNING:LONG_LINE: line length of 97 exceeds 80 columns
#8049: FILE: drivers/bluetooth/sdio/btmtksdio.c:707:
+			crValue = ((skb->data[13] & 0xff) << 24) + ((skb->data[14] & 0xff) << 16)

WARNING:LONG_LINE: line length of 89 exceeds 80 columns
#8050: FILE: drivers/bluetooth/sdio/btmtksdio.c:708:
+				+ ((skb->data[15] & 0xff) << 8) + (skb->data[16] & 0xff);

WARNING:LONG_LINE: line length of 87 exceeds 80 columns
#8062: FILE: drivers/bluetooth/sdio/btmtksdio.c:720:
+			memcpy(evt_skb->data, &notify_alt_evt, sizeof(notify_alt_evt));

WARNING:LONG_LINE: line length of 99 exceeds 80 columns
#8068: FILE: drivers/bluetooth/sdio/btmtksdio.c:726:
+		} else	if (skb->data[0] == 0x01 && skb->data[1] == 0x6f && skb->data[2] == 0xfc &&

WARNING:LONG_LINE: line length of 97 exceeds 80 columns
#8073: FILE: drivers/bluetooth/sdio/btmtksdio.c:731:
+			crAddr = ((skb->data[9] & 0xff) << 24) + ((skb->data[10] & 0xff) << 16) +

WARNING:LONG_LINE: line length of 83 exceeds 80 columns
#8074: FILE: drivers/bluetooth/sdio/btmtksdio.c:732:
+				((skb->data[11]&0xff) << 8) + (skb->data[12]&0xff);

WARNING:LONG_LINE: line length of 87 exceeds 80 columns
#8086: FILE: drivers/bluetooth/sdio/btmtksdio.c:744:
+			memcpy(evt_skb->data, &notify_alt_evt, sizeof(notify_alt_evt));

WARNING:LONG_LINE: line length of 83 exceeds 80 columns
#8095: FILE: drivers/bluetooth/sdio/btmtksdio.c:753:
+	if (skb->data[0] == 0x02 && skb->data[1] == 0x00 && skb->data[2] == 0x44) {

WARNING:LONG_LINE: line length of 96 exceeds 80 columns
#8107: FILE: drivers/bluetooth/sdio/btmtksdio.c:765:
+		BTMTK_INFO_RAW(skb->data, skb->len, "%s: Trigger FW assert, dump CR", __func__);

WARNING:LONG_LINE: line length of 89 exceeds 80 columns
#8155: FILE: drivers/bluetooth/sdio/btmtksdio.c:813:
+		BTMTK_WARN("%s: rx_length = %d, error return -EIO", __func__, rx_length);

WARNING:LONG_LINE: line length of 87 exceeds 80 columns
#8168: FILE: drivers/bluetooth/sdio/btmtksdio.c:826:
+	ret = btmtk_sdio_readsb(CRDR, cif_dev->transfer_buf, rx_length, cif_dev->func);

WARNING:LONG_LINE_STRING: line length of 92 exceeds 80 columns
#8175: FILE: drivers/bluetooth/sdio/btmtksdio.c:833:
+		BTMTK_ERR("%s sdio header length %d, rx_length %d mismatch, trigger assert",

WARNING:LONG_LINE: line length of 96 exceeds 80 columns
#8177: FILE: drivers/bluetooth/sdio/btmtksdio.c:835:
+		BTMTK_INFO_RAW(cif_dev->transfer_buf, rx_length, "%s: raw data is :", __func__);

WARNING:LONG_LINE: line length of 87 exceeds 80 columns
#8182: FILE: drivers/bluetooth/sdio/btmtksdio.c:840:
+	BTMTK_DBG_RAW(cif_dev->transfer_buf, rx_length, "%s: raw data is :", __func__);

WARNING:LONG_LINE: line length of 86 exceeds 80 columns
#8194: FILE: drivers/bluetooth/sdio/btmtksdio.c:852:
+		hci_pkt_len = cif_dev->transfer_buf[MTK_SDIO_PACKET_HEADER_SIZE + 3] +

WARNING:LONG_LINE: line length of 98 exceeds 80 columns
#8195: FILE: drivers/bluetooth/sdio/btmtksdio.c:853:
+				(cif_dev->transfer_buf[MTK_SDIO_PACKET_HEADER_SIZE + 4] << 8) + 5;

WARNING:LONG_LINE: line length of 89 exceeds 80 columns
#8198: FILE: drivers/bluetooth/sdio/btmtksdio.c:856:
+		hci_pkt_len = cif_dev->transfer_buf[MTK_SDIO_PACKET_HEADER_SIZE + 4] + 4;

WARNING:LONG_LINE: line length of 89 exceeds 80 columns
#8201: FILE: drivers/bluetooth/sdio/btmtksdio.c:859:
+		hci_pkt_len = cif_dev->transfer_buf[MTK_SDIO_PACKET_HEADER_SIZE + 2] + 3;

WARNING:LONG_LINE: line length of 86 exceeds 80 columns
#8204: FILE: drivers/bluetooth/sdio/btmtksdio.c:862:
+		hci_pkt_len = cif_dev->transfer_buf[MTK_SDIO_PACKET_HEADER_SIZE + 3] +

WARNING:LONG_LINE: line length of 98 exceeds 80 columns
#8205: FILE: drivers/bluetooth/sdio/btmtksdio.c:863:
+				(cif_dev->transfer_buf[MTK_SDIO_PACKET_HEADER_SIZE + 4] << 8) + 4;

WARNING:LONG_LINE: line length of 97 exceeds 80 columns
#8217: FILE: drivers/bluetooth/sdio/btmtksdio.c:875:
+		BTMTK_DBG_RAW(cif_dev->transfer_buf, hci_pkt_len, "%s: raw data is :", __func__);

WARNING:LONG_LINE: line length of 82 exceeds 80 columns
#8244: FILE: drivers/bluetooth/sdio/btmtksdio.c:902:
+				bdev->bdaddr[0], bdev->bdaddr[1], bdev->bdaddr[2],

WARNING:LONG_LINE: line length of 83 exceeds 80 columns
#8245: FILE: drivers/bluetooth/sdio/btmtksdio.c:903:
+				bdev->bdaddr[3], bdev->bdaddr[4], bdev->bdaddr[5]);

WARNING:LONG_LINE: line length of 89 exceeds 80 columns
#8247: FILE: drivers/bluetooth/sdio/btmtksdio.c:905:
+			event_compare_status = BTMTK_EVENT_COMPARE_STATE_COMPARE_SUCCESS;

WARNING:LONG_LINE_COMMENT: line length of 87 exceeds 80 columns
#8250: FILE: drivers/bluetooth/sdio/btmtksdio.c:908:
+			/* if it is wobx debug event, just print in kernel log, drop it

WARNING:LONG_LINE_COMMENT: line length of 93 exceeds 80 columns
#8257: FILE: drivers/bluetooth/sdio/btmtksdio.c:915:
+			/* If driver need to check result from skb, it can get from io_buf */

WARNING:LONG_LINE: line length of 89 exceeds 80 columns
#8261: FILE: drivers/bluetooth/sdio/btmtksdio.c:919:
+			event_compare_status = BTMTK_EVENT_COMPARE_STATE_COMPARE_SUCCESS;

WARNING:LONG_LINE: line length of 82 exceeds 80 columns
#8265: FILE: drivers/bluetooth/sdio/btmtksdio.c:923:
+			BTMTK_INFO_RAW(event_need_compare, event_need_compare_len,

WARNING:LONG_LINE: line length of 88 exceeds 80 columns
#8267: FILE: drivers/bluetooth/sdio/btmtksdio.c:925:
+			BTMTK_INFO_RAW(skb->data, skb->len, "%s: skb->data:", __func__);

WARNING:LONG_LINE_STRING: line length of 87 exceeds 80 columns
#8287: FILE: drivers/bluetooth/sdio/btmtksdio.c:945:
+			BTMTK_ERR("%s, event_len (%d) > EVENT_COMPARE_SIZE(%d), error",

WARNING:LONG_LINE: line length of 84 exceeds 80 columns
#8300: FILE: drivers/bluetooth/sdio/btmtksdio.c:958:
+		comp_event_timo = jiffies + msecs_to_jiffies(WOBLE_COMP_EVENT_TIMO);

WARNING:LONG_LINE: line length of 81 exceeds 80 columns
#8304: FILE: drivers/bluetooth/sdio/btmtksdio.c:962:
+		event_compare_status = BTMTK_EVENT_COMPARE_STATE_COMPARE_SUCCESS;

WARNING:LONG_LINE: line length of 85 exceeds 80 columns
#8307: FILE: drivers/bluetooth/sdio/btmtksdio.c:965:
+	BTMTK_DBG_RAW(skb->data, skb->len, "%s, send, len = %d", __func__, skb->len);

WARNING:LONG_LINE: line length of 88 exceeds 80 columns
#8317: FILE: drivers/bluetooth/sdio/btmtksdio.c:975:
+		if (event_compare_status == BTMTK_EVENT_COMPARE_STATE_COMPARE_SUCCESS) {

WARNING:LONG_LINE: line length of 88 exceeds 80 columns
#8361: FILE: drivers/bluetooth/sdio/btmtksdio.c:1019:
+	u8 cmd[] = {0x02, 0x6F, 0xFC, 0x05, 0x00, 0x01, 0x01, 0x01, 0x00, PATCH_PHASE3};

WARNING:LONG_LINE_COMMENT: line length of 94 exceeds 80 columns
#8362: FILE: drivers/bluetooth/sdio/btmtksdio.c:1020:
+	u8 event[] = {0x04, 0xE4, 0x05, 0x02, 0x01, 0x01, 0x00, 0x00}; /* event[7] is status*/

WARNING:LONG_LINE: line length of 86 exceeds 80 columns
#8375: FILE: drivers/bluetooth/sdio/btmtksdio.c:1033:
+			ret = btmtk_sdio_readl(CHISR, &u32ReadCRValue, cif_dev->func);

WARNING:LONG_LINE: line length of 87 exceeds 80 columns
#8378: FILE: drivers/bluetooth/sdio/btmtksdio.c:1036:
+					(TX_EMPTY | TX_COMPLETE_COUNT), cif_dev->func);

WARNING:LONG_LINE: line length of 90 exceeds 80 columns
#8380: FILE: drivers/bluetooth/sdio/btmtksdio.c:1038:
+					BTMTK_ERR("%s: btmtk_sdio_writel fail", __func__);

WARNING:LONG_LINE_COMMENT: line length of 97 exceeds 80 columns
#8575: FILE: drivers/bluetooth/sdio/btmtksdio.c:1233:
+//		BTMTK_INFO("%s read 0x2c = 0x%08X, retry = %d", __func__, u32ReadCRValue, retry);

WARNING:LONG_LINE_COMMENT: line length of 97 exceeds 80 columns
#8577: FILE: drivers/bluetooth/sdio/btmtksdio.c:1235:
+//		BTMTK_INFO("%s read CHLPCR 0x%08X, retry = %d", __func__, u32ReadCRValue, retry);

WARNING:LONG_LINE_COMMENT: line length of 99 exceeds 80 columns
#8579: FILE: drivers/bluetooth/sdio/btmtksdio.c:1237:
+//		BTMTK_INFO("%s read SWPCDBGR 0x%08X, retry = %d", __func__, u32ReadCRValue, retry);

WARNING:LONG_LINE: line length of 95 exceeds 80 columns
#8581: FILE: drivers/bluetooth/sdio/btmtksdio.c:1239:
+		BTMTK_INFO("%s read CHCR 0x%08X, retry = %d", __func__, u32ReadCRValue, retry);

WARNING:LONG_LINE: line length of 91 exceeds 80 columns
#8637: FILE: drivers/bluetooth/sdio/btmtksdio.c:1295:
+	ret = btmtk_sdio_writel(CHIER, FIRMWARE_INT_BIT31 | FIRMWARE_INT|TX_FIFO_OVERFLOW |

WARNING:LONG_LINE: line length of 88 exceeds 80 columns
#8715: FILE: drivers/bluetooth/sdio/btmtksdio.c:1373:
+		BTMTK_DBG("cif_dev->int_count is %d", atomic_read(&cif_dev->int_count));

WARNING:LONG_LINE: line length of 81 exceeds 80 columns
#8751: FILE: drivers/bluetooth/sdio/btmtksdio.c:1409:
+	ret = btmtk_sdio_writesb(CTDR, cif_dev->sdio_packet, len, cif_dev->func);

WARNING:LONG_LINE: line length of 94 exceeds 80 columns
#8786: FILE: drivers/bluetooth/sdio/btmtksdio.c:1444:
+		ret = btmtk_sdio_writel(CHISR, (TX_EMPTY | TX_COMPLETE_COUNT), cif_dev->func);

WARNING:LONG_LINE_COMMENT: line length of 90 exceeds 80 columns
#8814: FILE: drivers/bluetooth/sdio/btmtksdio.c:1472:
+//	struct sched_param param = { .sched_priority = 90 };/*RR 90 is the same as audio*/

WARNING:LONG_LINE_COMMENT: line length of 89 exceeds 80 columns
#8871: FILE: drivers/bluetooth/sdio/btmtksdio.c:1529:
+		/* It shall be fine to set FW_OWN if no more task to do in this thread */

WARNING:LONG_LINE: line length of 89 exceeds 80 columns
#9140: FILE: drivers/bluetooth/sdio/btmtksdio.c:1798:
+		BTMTK_WARN("Has suspended. suspend_count: %d, end", bdev->suspend_count);

WARNING:LONG_LINE: line length of 90 exceeds 80 columns
#9147: FILE: drivers/bluetooth/sdio/btmtksdio.c:1805:
+		BTMTK_WARN("%s: FW dumping ongoing, don't dos suspend flow!!!", __func__);

WARNING:LONG_LINE: line length of 83 exceeds 80 columns
#9162: FILE: drivers/bluetooth/sdio/btmtksdio.c:1820:
+		BTMTK_ERR("%s: btmtk_woble_suspend return fail %d", __func__, ret);

WARNING:LONG_LINE: line length of 89 exceeds 80 columns
#9166: FILE: drivers/bluetooth/sdio/btmtksdio.c:1824:
+		if (bdev->wobt_irq != 0 && atomic_read(&(bdev->irq_enable_count)) == 0) {

WARNING:LONG_LINE: line length of 98 exceeds 80 columns
#9172: FILE: drivers/bluetooth/sdio/btmtksdio.c:1830:
+			BTMTK_INFO("irq_enable count:%d", atomic_read(&(bdev->irq_enable_count)));

WARNING:LONG_LINE: line length of 84 exceeds 80 columns
#9221: FILE: drivers/bluetooth/sdio/btmtksdio.c:1879:
+		BTMTK_INFO("data->suspend_count %d, return 0", bdev->suspend_count);

WARNING:LONG_LINE: line length of 89 exceeds 80 columns
#9226: FILE: drivers/bluetooth/sdio/btmtksdio.c:1884:
+		if (bdev->wobt_irq != 0 && atomic_read(&(bdev->irq_enable_count)) == 1) {

WARNING:LONG_LINE: line length of 98 exceeds 80 columns
#9231: FILE: drivers/bluetooth/sdio/btmtksdio.c:1889:
+			BTMTK_INFO("irq_enable count:%d", atomic_read(&(bdev->irq_enable_count)));

WARNING:LONG_LINE: line length of 82 exceeds 80 columns
#9244: FILE: drivers/bluetooth/sdio/btmtksdio.c:1902:
+		BTMTK_ERR("%s: btmtk_woble_resume return fail %d", __func__, ret);

WARNING:LONG_LINE: line length of 84 exceeds 80 columns
#9380: FILE: drivers/bluetooth/usb/btmtkusb.c:28:
+static struct btmtk_usb_dev g_usb_dev[BT_MCU_MINIMUM_INTERFACE_NUM][BT_MCU_NUM_MAX];

WARNING:LONG_LINE: line length of 82 exceeds 80 columns
#9436: FILE: drivers/bluetooth/usb/btmtkusb.c:84:
+static int btmtk_cif_write_uhw_register(struct btmtk_dev *bdev, u32 reg, u32 val);

WARNING:LONG_LINE: line length of 82 exceeds 80 columns
#9437: FILE: drivers/bluetooth/usb/btmtkusb.c:85:
+static int btmtk_cif_read_uhw_register(struct btmtk_dev *bdev, u32 reg, u32 *val);

WARNING:LONG_LINE: line length of 89 exceeds 80 columns
#9582: FILE: drivers/bluetooth/usb/btmtkusb.c:230:
+			(urb->actual_length != (buf[1] + 2) && urb->actual_length > 1)) {

WARNING:LONG_LINE_STRING: line length of 84 exceeds 80 columns
#9583: FILE: drivers/bluetooth/usb/btmtkusb.c:231:
+			BTMTK_ERR("%s: urb->actual_length is invalid, buf[1] = %d!",

WARNING:LONG_LINE: line length of 88 exceeds 80 columns
#9585: FILE: drivers/bluetooth/usb/btmtkusb.c:233:
+			btmtk_hci_snoop_print(urb->actual_length, urb->transfer_buffer);

WARNING:LONG_LINE: line length of 92 exceeds 80 columns
#9590: FILE: drivers/bluetooth/usb/btmtkusb.c:238:
+		memcpy(cif_dev->urb_intr_buf + 1, urb->transfer_buffer, urb->actual_length);

WARNING:LONG_LINE: line length of 87 exceeds 80 columns
#9592: FILE: drivers/bluetooth/usb/btmtkusb.c:240:
+		BTMTK_DBG("%s ,urb->actual_length = %d", __func__, urb->actual_length);

WARNING:LONG_LINE: line length of 98 exceeds 80 columns
#9595: FILE: drivers/bluetooth/usb/btmtkusb.c:243:
+		BTMTK_DBG_RAW(urb->transfer_buffer, urb->actual_length, "%s, recv evt", __func__);

WARNING:LONG_LINE: line length of 82 exceeds 80 columns
#9596: FILE: drivers/bluetooth/usb/btmtkusb.c:244:
+		if (cif_dev->urb_intr_buf[1] == 0xFF && urb->actual_length == 1) {

WARNING:LONG_LINE_COMMENT: line length of 94 exceeds 80 columns
#9599: FILE: drivers/bluetooth/usb/btmtkusb.c:247:
+			 * Receive a bytes 0xFF from controller, it's WDT interrupt to driver.

WARNING:LONG_LINE: line length of 86 exceeds 80 columns
#9606: FILE: drivers/bluetooth/usb/btmtkusb.c:254:
+		err = btmtk_recv(hdev, cif_dev->urb_intr_buf, urb->actual_length + 1);

WARNING:LONG_LINE_STRING: line length of 100 exceeds 80 columns
#9608: FILE: drivers/bluetooth/usb/btmtkusb.c:256:
+			BT_ERR("%s corrupted event packet, urb_intr_buf = %p, transfer_buffer = %p",

WARNING:LONG_LINE: line length of 89 exceeds 80 columns
#9609: FILE: drivers/bluetooth/usb/btmtkusb.c:257:
+				hdev->name, cif_dev->urb_intr_buf, urb->transfer_buffer);

WARNING:LONG_LINE: line length of 88 exceeds 80 columns
#9610: FILE: drivers/bluetooth/usb/btmtkusb.c:258:
+			btmtk_hci_snoop_print(urb->actual_length, urb->transfer_buffer);

WARNING:LONG_LINE: line length of 93 exceeds 80 columns
#9611: FILE: drivers/bluetooth/usb/btmtkusb.c:259:
+			btmtk_hci_snoop_print(urb->actual_length + 1, cif_dev->urb_intr_buf);

WARNING:LONG_LINE: line length of 87 exceeds 80 columns
#9673: FILE: drivers/bluetooth/usb/btmtkusb.c:321:
+	pipe = usb_rcvintpipe(cif_dev->udev, cif_dev->reset_intr_ep->bEndpointAddress);

WARNING:LONG_LINE_COMMENT: line length of 83 exceeds 80 columns
#9676: FILE: drivers/bluetooth/usb/btmtkusb.c:324:
+	 * If driver set size = le16_to_cpu(HCI_MAX_EVENT_SIZE) to usb_fill_int_urb

WARNING:LONG_LINE: line length of 87 exceeds 80 columns
#9680: FILE: drivers/bluetooth/usb/btmtkusb.c:328:
+			 btusb_intr_complete, hdev, cif_dev->reset_intr_ep->bInterval);

WARNING:LONG_LINE: line length of 94 exceeds 80 columns
#9709: FILE: drivers/bluetooth/usb/btmtkusb.c:357:
+	BTMTK_DBG("%s : %s urb %p status %d count %d", __func__, hdev->name, urb, urb->status,

WARNING:LONG_LINE: line length of 98 exceeds 80 columns
#9713: FILE: drivers/bluetooth/usb/btmtkusb.c:361:
+		BTMTK_DBG_RAW(urb->transfer_buffer, urb->actual_length, "%s, recv evt", __func__);

WARNING:LONG_LINE: line length of 81 exceeds 80 columns
#9723: FILE: drivers/bluetooth/usb/btmtkusb.c:371:
+			BTMTK_ERR("%s urb->actual_length is invalid!", __func__);

WARNING:LONG_LINE: line length of 99 exceeds 80 columns
#9732: FILE: drivers/bluetooth/usb/btmtkusb.c:380:
+		memcpy(skb_put(skb, urb->actual_length), urb->transfer_buffer, urb->actual_length);

WARNING:LONG_LINE: line length of 81 exceeds 80 columns
#9733: FILE: drivers/bluetooth/usb/btmtkusb.c:381:
+		BTMTK_DBG_RAW(skb->data, skb->len, "%s, skb recv evt", __func__);

WARNING:LONG_LINE: line length of 81 exceeds 80 columns
#9877: FILE: drivers/bluetooth/usb/btmtkusb.c:525:
+	pipe = usb_rcvintpipe(cif_dev->udev, cif_dev->intr_ep->bEndpointAddress);

WARNING:LONG_LINE: line length of 81 exceeds 80 columns
#9880: FILE: drivers/bluetooth/usb/btmtkusb.c:528:
+			 btusb_intr_complete, hdev, cif_dev->intr_ep->bInterval);

WARNING:LONG_LINE: line length of 96 exceeds 80 columns
#9956: FILE: drivers/bluetooth/usb/btmtkusb.c:604:
+			BTMTK_ERR("%s urb->actual_length is invalid, len = %d!", __func__, len);

WARNING:LONG_LINE: line length of 88 exceeds 80 columns
#9957: FILE: drivers/bluetooth/usb/btmtkusb.c:605:
+			btmtk_hci_snoop_print(urb->actual_length, urb->transfer_buffer);

WARNING:LONG_LINE: line length of 92 exceeds 80 columns
#9962: FILE: drivers/bluetooth/usb/btmtkusb.c:610:
+		memcpy(cif_dev->urb_bulk_buf + 1, urb->transfer_buffer, urb->actual_length);

WARNING:LONG_LINE: line length of 86 exceeds 80 columns
#9964: FILE: drivers/bluetooth/usb/btmtkusb.c:612:
+		err = btmtk_recv(hdev, cif_dev->urb_bulk_buf, urb->actual_length + 1);

WARNING:LONG_LINE_STRING: line length of 98 exceeds 80 columns
#9966: FILE: drivers/bluetooth/usb/btmtkusb.c:614:
+			BT_ERR("%s corrupted ACL packet, urb_bulk_buf = %p, transfer_buffer = %p",

WARNING:LONG_LINE: line length of 89 exceeds 80 columns
#9967: FILE: drivers/bluetooth/usb/btmtkusb.c:615:
+				hdev->name, cif_dev->urb_bulk_buf, urb->transfer_buffer);

WARNING:LONG_LINE: line length of 88 exceeds 80 columns
#9968: FILE: drivers/bluetooth/usb/btmtkusb.c:616:
+			btmtk_hci_snoop_print(urb->actual_length, urb->transfer_buffer);

WARNING:LONG_LINE: line length of 93 exceeds 80 columns
#9969: FILE: drivers/bluetooth/usb/btmtkusb.c:617:
+			btmtk_hci_snoop_print(urb->actual_length + 1, cif_dev->urb_bulk_buf);

WARNING:LONG_LINE: line length of 88 exceeds 80 columns
#9974: FILE: drivers/bluetooth/usb/btmtkusb.c:622:
+		BTMTK_INFO("%s urb %p status %d count %d", hdev->name, urb, urb->status,

WARNING:LONG_LINE: line length of 85 exceeds 80 columns
#10026: FILE: drivers/bluetooth/usb/btmtkusb.c:674:
+	pipe = usb_rcvbulkpipe(cif_dev->udev, cif_dev->bulk_rx_ep->bEndpointAddress);

WARNING:LONG_LINE: line length of 90 exceeds 80 columns
#10095: FILE: drivers/bluetooth/usb/btmtkusb.c:743:
+		isoc_pkt_len = isoc_buf[2] + (isoc_buf[3] << 8) + HCI_ISO_PKT_HEADER_SIZE;

WARNING:LONG_LINE: line length of 98 exceeds 80 columns
#10105: FILE: drivers/bluetooth/usb/btmtkusb.c:753:
+		if (urb->actual_length + HCI_ISO_PKT_WITH_ACL_HEADER_SIZE > URB_MAX_BUFFER_SIZE) {

WARNING:LONG_LINE: line length of 81 exceeds 80 columns
#10106: FILE: drivers/bluetooth/usb/btmtkusb.c:754:
+			BTMTK_ERR("%s urb->actual_length is invalid!", __func__);

WARNING:LONG_LINE: line length of 88 exceeds 80 columns
#10107: FILE: drivers/bluetooth/usb/btmtkusb.c:755:
+			btmtk_hci_snoop_print(urb->actual_length, urb->transfer_buffer);

WARNING:LONG_LINE_COMMENT: line length of 90 exceeds 80 columns
#10114: FILE: drivers/bluetooth/usb/btmtkusb.c:762:
+		 * header format : 0x02 0x00 0x44 xx_a xx_2 + isoc packet header & payload

WARNING:LONG_LINE: line length of 84 exceeds 80 columns
#10122: FILE: drivers/bluetooth/usb/btmtkusb.c:770:
+		memcpy(cif_dev->urb_ble_isoc_buf + HCI_ISO_PKT_WITH_ACL_HEADER_SIZE,

WARNING:LONG_LINE: line length of 86 exceeds 80 columns
#10123: FILE: drivers/bluetooth/usb/btmtkusb.c:771:
+			urb->transfer_buffer, isoc_pkt_len + HCI_ISO_PKT_HEADER_SIZE);

WARNING:LONG_LINE: line length of 88 exceeds 80 columns
#10189: FILE: drivers/bluetooth/usb/btmtkusb.c:837:
+	pipe = usb_rcvintpipe(cif_dev->udev, cif_dev->intr_iso_rx_ep->bEndpointAddress);

WARNING:LONG_LINE: line length of 92 exceeds 80 columns
#10194: FILE: drivers/bluetooth/usb/btmtkusb.c:842:
+			 btusb_ble_isoc_complete, hdev, cif_dev->intr_iso_rx_ep->bInterval);

WARNING:LONG_LINE: line length of 83 exceeds 80 columns
#10253: FILE: drivers/bluetooth/usb/btmtkusb.c:901:
+			unsigned int length = urb->iso_frame_desc[i].actual_length;

WARNING:LONG_LINE: line length of 81 exceeds 80 columns
#10262: FILE: drivers/bluetooth/usb/btmtkusb.c:910:
+				BTMTK_ERR("%s corrupted SCO packet", hdev->name);

WARNING:LONG_LINE: line length of 85 exceeds 80 columns
#10339: FILE: drivers/bluetooth/usb/btmtkusb.c:987:
+	pipe = usb_rcvisocpipe(cif_dev->udev, cif_dev->isoc_rx_ep->bEndpointAddress);

WARNING:LONG_LINE: line length of 82 exceeds 80 columns
#10341: FILE: drivers/bluetooth/usb/btmtkusb.c:989:
+	usb_fill_int_urb(urb, cif_dev->udev, pipe, buf, size, btusb_isoc_complete,

WARNING:LONG_LINE: line length of 81 exceeds 80 columns
#10347: FILE: drivers/bluetooth/usb/btmtkusb.c:995:
+			       le16_to_cpu(cif_dev->isoc_rx_ep->wMaxPacketSize));

WARNING:LONG_LINE: line length of 84 exceeds 80 columns
#10440: FILE: drivers/bluetooth/usb/btmtkusb.c:1088:
+				err = btusb_submit_intr_reset_urb(hdev, GFP_KERNEL);

WARNING:LONG_LINE: line length of 83 exceeds 80 columns
#10444: FILE: drivers/bluetooth/usb/btmtkusb.c:1092:
+				BTMTK_INFO("%s, reset_intr_ep missing,", __func__);

WARNING:LONG_LINE: line length of 87 exceeds 80 columns
#10448: FILE: drivers/bluetooth/usb/btmtkusb.c:1096:
+				err = btusb_submit_intr_ble_isoc_urb(hdev, GFP_KERNEL);

WARNING:LONG_LINE: line length of 90 exceeds 80 columns
#10450: FILE: drivers/bluetooth/usb/btmtkusb.c:1098:
+					usb_kill_anchored_urbs(&cif_dev->ble_isoc_anchor);

WARNING:LONG_LINE: line length of 83 exceeds 80 columns
#10454: FILE: drivers/bluetooth/usb/btmtkusb.c:1102:
+				BTMTK_INFO("%s, intr_iso_rx_ep missing," __func__);

WARNING:LONG_LINE: line length of 88 exceeds 80 columns
#10540: FILE: drivers/bluetooth/usb/btmtkusb.c:1188:
+	pipe = usb_sndintpipe(cif_dev->udev, cif_dev->intr_iso_tx_ep->bEndpointAddress);

WARNING:LONG_LINE: line length of 81 exceeds 80 columns
#10550: FILE: drivers/bluetooth/usb/btmtkusb.c:1198:
+static struct urb *alloc_ctrl_bgf1_urb(struct hci_dev *hdev, struct sk_buff *skb)

WARNING:LONG_LINE: line length of 89 exceeds 80 columns
#10601: FILE: drivers/bluetooth/usb/btmtkusb.c:1249:
+	pipe = usb_sndbulkpipe(cif_dev->udev, cif_dev->bulk_cmd_tx_ep->bEndpointAddress);

WARNING:LONG_LINE: line length of 85 exceeds 80 columns
#10659: FILE: drivers/bluetooth/usb/btmtkusb.c:1307:
+	pipe = usb_sndbulkpipe(cif_dev->udev, cif_dev->bulk_tx_ep->bEndpointAddress);

WARNING:LONG_LINE: line length of 85 exceeds 80 columns
#10683: FILE: drivers/bluetooth/usb/btmtkusb.c:1331:
+	pipe = usb_sndisocpipe(cif_dev->udev, cif_dev->isoc_tx_ep->bEndpointAddress);

WARNING:LONG_LINE: line length of 81 exceeds 80 columns
#10692: FILE: drivers/bluetooth/usb/btmtkusb.c:1340:
+			       le16_to_cpu(cif_dev->isoc_tx_ep->wMaxPacketSize));

WARNING:LONG_LINE: line length of 81 exceeds 80 columns
#10766: FILE: drivers/bluetooth/usb/btmtkusb.c:1414:
+	BTMTK_DBG_RAW(skb->data, skb->len, "%s, send_frame, type = %d", __func__,

WARNING:LONG_LINE: line length of 87 exceeds 80 columns
#10773: FILE: drivers/bluetooth/usb/btmtkusb.c:1421:
+					skb->data[2] == 0x06 && skb->data[3] == 0x01 &&

WARNING:LONG_LINE: line length of 87 exceeds 80 columns
#10774: FILE: drivers/bluetooth/usb/btmtkusb.c:1422:
+					skb->data[4] == 0xff && skb->data[5] == 0x03 &&

WARNING:LONG_LINE: line length of 87 exceeds 80 columns
#10775: FILE: drivers/bluetooth/usb/btmtkusb.c:1423:
+					skb->data[6] == 0x00 && skb->data[7] == 0x00) {

WARNING:LONG_LINE: line length of 95 exceeds 80 columns
#10779: FILE: drivers/bluetooth/usb/btmtkusb.c:1427:
+				memcpy(evt_skb->data, &notify_alt_evt, sizeof(notify_alt_evt));

WARNING:LONG_LINE_COMMENT: line length of 94 exceeds 80 columns
#10781: FILE: drivers/bluetooth/usb/btmtkusb.c:1429:
+				/* After set alternate setting, we will return evt to boots */

WARNING:LONG_LINE_STRING: line length of 100 exceeds 80 columns
#10786: FILE: drivers/bluetooth/usb/btmtkusb.c:1434:
+				BTMTK_INFO("alt_setting = %d, new_isoc_altsetting_interface = %d\n",

WARNING:LONG_LINE: line length of 82 exceeds 80 columns
#10794: FILE: drivers/bluetooth/usb/btmtkusb.c:1442:
+			} else if (skb->data[0] == 0x6f && skb->data[1] == 0xfc &&

WARNING:LONG_LINE: line length of 87 exceeds 80 columns
#10795: FILE: drivers/bluetooth/usb/btmtkusb.c:1443:
+					skb->data[2] == 0x07 && skb->data[3] == 0x01 &&

WARNING:LONG_LINE: line length of 87 exceeds 80 columns
#10796: FILE: drivers/bluetooth/usb/btmtkusb.c:1444:
+					skb->data[4] == 0xff && skb->data[5] == 0x03 &&

WARNING:LONG_LINE: line length of 87 exceeds 80 columns
#10797: FILE: drivers/bluetooth/usb/btmtkusb.c:1445:
+					skb->data[6] == 0x00 && skb->data[7] == 0x00 &&

WARNING:LONG_LINE: line length of 95 exceeds 80 columns
#10801: FILE: drivers/bluetooth/usb/btmtkusb.c:1449:
+				memcpy(evt_skb->data, &notify_alt_evt, sizeof(notify_alt_evt));

WARNING:LONG_LINE_COMMENT: line length of 94 exceeds 80 columns
#10803: FILE: drivers/bluetooth/usb/btmtkusb.c:1451:
+				/* After set alternate setting, we will return evt to boots */

WARNING:LONG_LINE_COMMENT: line length of 100 exceeds 80 columns
#10805: FILE: drivers/bluetooth/usb/btmtkusb.c:1453:
+				/* if sco_num == 0, btusb_work will set alternate setting to zero */

WARNING:LONG_LINE: line length of 86 exceeds 80 columns
#10808: FILE: drivers/bluetooth/usb/btmtkusb.c:1456:
+				cif_dev->new_isoc_altsetting_interface = skb->data[8];

WARNING:LONG_LINE_STRING: line length of 82 exceeds 80 columns
#10811: FILE: drivers/bluetooth/usb/btmtkusb.c:1459:
+				BTMTK_INFO("new_isoc_altsetting_interface = %d\n",

WARNING:LONG_LINE_COMMENT: line length of 82 exceeds 80 columns
#10816: FILE: drivers/bluetooth/usb/btmtkusb.c:1464:
+				 * it will failed to set alternate setting to zero

WARNING:LONG_LINE: line length of 82 exceeds 80 columns
#10822: FILE: drivers/bluetooth/usb/btmtkusb.c:1470:
+			} else if (skb->data[0] == 0x6f && skb->data[1] == 0xfc &&

WARNING:LONG_LINE: line length of 87 exceeds 80 columns
#10823: FILE: drivers/bluetooth/usb/btmtkusb.c:1471:
+					skb->data[2] == 0x09 && skb->data[3] == 0x01 &&

WARNING:LONG_LINE: line length of 87 exceeds 80 columns
#10824: FILE: drivers/bluetooth/usb/btmtkusb.c:1472:
+					skb->data[4] == 0xff && skb->data[5] == 0x05 &&

WARNING:LONG_LINE: line length of 87 exceeds 80 columns
#10825: FILE: drivers/bluetooth/usb/btmtkusb.c:1473:
+					skb->data[6] == 0x00 && skb->data[7] == 0x01) {

WARNING:LONG_LINE_STRING: line length of 87 exceeds 80 columns
#10826: FILE: drivers/bluetooth/usb/btmtkusb.c:1474:
+				BTMTK_INFO("read CR skb->data = %02x %02x %02x %02x\n",

WARNING:LONG_LINE: line length of 98 exceeds 80 columns
#10827: FILE: drivers/bluetooth/usb/btmtkusb.c:1475:
+					skb->data[8], skb->data[9], skb->data[10], skb->data[11]);

WARNING:LONG_LINE: line length of 81 exceeds 80 columns
#10829: FILE: drivers/bluetooth/usb/btmtkusb.c:1477:
+				crRegOffset = (skb->data[10]<<8) + skb->data[11];

WARNING:LONG_LINE: line length of 99 exceeds 80 columns
#10830: FILE: drivers/bluetooth/usb/btmtkusb.c:1478:
+				BTMTK_INFO("base + offset = %04x %04x\n", crBaseAddr, crRegOffset);

WARNING:LONG_LINE: line length of 82 exceeds 80 columns
#10833: FILE: drivers/bluetooth/usb/btmtkusb.c:1481:
+						usb_rcvctrlpipe(cif_dev->udev, 0),

WARNING:LONG_LINE: line length of 81 exceeds 80 columns
#10834: FILE: drivers/bluetooth/usb/btmtkusb.c:1482:
+						1, 0xDE, crBaseAddr, crRegOffset,

WARNING:LONG_LINE: line length of 83 exceeds 80 columns
#10835: FILE: drivers/bluetooth/usb/btmtkusb.c:1483:
+						bdev->io_buf, 4, USB_CTRL_IO_TIMO);

WARNING:LONG_LINE_STRING: line length of 81 exceeds 80 columns
#10837: FILE: drivers/bluetooth/usb/btmtkusb.c:1485:
+					BTMTK_ERR("read CR(%04X[%04X]) FAILED\n",

WARNING:LONG_LINE_STRING: line length of 82 exceeds 80 columns
#10842: FILE: drivers/bluetooth/usb/btmtkusb.c:1490:
+					BTMTK_INFO("value = 0x%02x%02x%02x%02x\n",

WARNING:LONG_LINE: line length of 81 exceeds 80 columns
#10843: FILE: drivers/bluetooth/usb/btmtkusb.c:1491:
+						bdev->io_buf[3], bdev->io_buf[2],

WARNING:LONG_LINE: line length of 82 exceeds 80 columns
#10844: FILE: drivers/bluetooth/usb/btmtkusb.c:1492:
+						bdev->io_buf[1], bdev->io_buf[0]);

WARNING:LONG_LINE: line length of 82 exceeds 80 columns
#10849: FILE: drivers/bluetooth/usb/btmtkusb.c:1497:
+			} else if (skb->data[0] == 0x6f && skb->data[1] == 0xfc &&

WARNING:LONG_LINE: line length of 87 exceeds 80 columns
#10850: FILE: drivers/bluetooth/usb/btmtkusb.c:1498:
+					skb->data[2] == 0x0D && skb->data[3] == 0x01 &&

WARNING:LONG_LINE: line length of 87 exceeds 80 columns
#10851: FILE: drivers/bluetooth/usb/btmtkusb.c:1499:
+					skb->data[4] == 0xff && skb->data[5] == 0x09 &&

WARNING:LONG_LINE: line length of 87 exceeds 80 columns
#10852: FILE: drivers/bluetooth/usb/btmtkusb.c:1500:
+					skb->data[6] == 0x00 && skb->data[7] == 0x02) {

WARNING:LONG_LINE: line length of 83 exceeds 80 columns
#10854: FILE: drivers/bluetooth/usb/btmtkusb.c:1502:
+				crRegOffset = (skb->data[10] << 8) + skb->data[11];

WARNING:LONG_LINE: line length of 99 exceeds 80 columns
#10855: FILE: drivers/bluetooth/usb/btmtkusb.c:1503:
+				BTMTK_INFO("base + offset = %04x %04x\n", crBaseAddr, crRegOffset);

WARNING:LONG_LINE: line length of 84 exceeds 80 columns
#10856: FILE: drivers/bluetooth/usb/btmtkusb.c:1504:
+				memset(cif_dev->o_usb_buf, 0, HCI_MAX_COMMAND_SIZE);

WARNING:LONG_LINE: line length of 82 exceeds 80 columns
#10862: FILE: drivers/bluetooth/usb/btmtkusb.c:1510:
+						usb_sndctrlpipe(cif_dev->udev, 0),

WARNING:LONG_LINE: line length of 81 exceeds 80 columns
#10863: FILE: drivers/bluetooth/usb/btmtkusb.c:1511:
+						2, 0x5E, crBaseAddr, crRegOffset,

WARNING:LONG_LINE: line length of 89 exceeds 80 columns
#10864: FILE: drivers/bluetooth/usb/btmtkusb.c:1512:
+						cif_dev->o_usb_buf, 4, USB_CTRL_IO_TIMO);

WARNING:LONG_LINE_STRING: line length of 82 exceeds 80 columns
#10866: FILE: drivers/bluetooth/usb/btmtkusb.c:1514:
+					BTMTK_ERR("write CR(%04X[%04X]) FAILED\n",

WARNING:LONG_LINE_STRING: line length of 82 exceeds 80 columns
#10871: FILE: drivers/bluetooth/usb/btmtkusb.c:1519:
+					BTMTK_INFO("value = 0x%02x%02x%02x%02x\n",

WARNING:LONG_LINE: line length of 93 exceeds 80 columns
#10872: FILE: drivers/bluetooth/usb/btmtkusb.c:1520:
+						cif_dev->o_usb_buf[3], cif_dev->o_usb_buf[2],

WARNING:LONG_LINE: line length of 94 exceeds 80 columns
#10873: FILE: drivers/bluetooth/usb/btmtkusb.c:1521:
+						cif_dev->o_usb_buf[1], cif_dev->o_usb_buf[0]);

WARNING:LONG_LINE: line length of 96 exceeds 80 columns
#10882: FILE: drivers/bluetooth/usb/btmtkusb.c:1530:
+		if (!memcmp(skb->data, &wmt_over_hci_header[1], WMT_OVER_HCI_HEADER_SIZE - 1)) {

WARNING:LONG_LINE: line length of 92 exceeds 80 columns
#10885: FILE: drivers/bluetooth/usb/btmtkusb.c:1533:
+			BTMTK_DBG_RAW(skb->data, skb->len, "%s, 6ffc send_frame", __func__);

WARNING:LONG_LINE: line length of 86 exceeds 80 columns
#10886: FILE: drivers/bluetooth/usb/btmtkusb.c:1534:
+			btmtk_usb_send_cmd(bdev, skb, 100, 20, BTMTK_TX_CMD_FROM_DRV);

WARNING:LONG_LINE: line length of 85 exceeds 80 columns
#10892: FILE: drivers/bluetooth/usb/btmtkusb.c:1540:
+			if ((is_mt7922(bdev->chip_id) || is_mt7961(bdev->chip_id)) &&

WARNING:LONG_LINE: line length of 83 exceeds 80 columns
#10898: FILE: drivers/bluetooth/usb/btmtkusb.c:1546:
+			if (is_mt7922(bdev->chip_id) || is_mt7961(bdev->chip_id)) {

WARNING:LONG_LINE: line length of 97 exceeds 80 columns
#10907: FILE: drivers/bluetooth/usb/btmtkusb.c:1555:
+				BTMTK_ERR("%s: chip_id(%d) is invalid", __func__, bdev->chip_id);

WARNING:LONG_LINE: line length of 89 exceeds 80 columns
#10911: FILE: drivers/bluetooth/usb/btmtkusb.c:1559:
+			BTMTK_ERR("%s: ifnum_base(%d) is invalid", __func__, ifnum_base);

WARNING:LONG_LINE: line length of 83 exceeds 80 columns
#10931: FILE: drivers/bluetooth/usb/btmtkusb.c:1579:
+				isoc_pkt_len = skb->data[2] + (skb->data[3] << 8) +

WARNING:LONG_LINE: line length of 88 exceeds 80 columns
#10932: FILE: drivers/bluetooth/usb/btmtkusb.c:1580:
+								HCI_ISO_PKT_HEADER_SIZE;

WARNING:LONG_LINE: line length of 86 exceeds 80 columns
#10933: FILE: drivers/bluetooth/usb/btmtkusb.c:1581:
+				isoc_pkt_padding = bdev->iso_threshold - isoc_pkt_len;

WARNING:LONG_LINE_COMMENT: line length of 96 exceeds 80 columns
#10937: FILE: drivers/bluetooth/usb/btmtkusb.c:1585:
+					 * hci driver allocate the size of skb that is to small,

WARNING:LONG_LINE: line length of 84 exceeds 80 columns
#10941: FILE: drivers/bluetooth/usb/btmtkusb.c:1589:
+							BT_SKB_RESERVE, GFP_ATOMIC);

WARNING:LONG_LINE: line length of 96 exceeds 80 columns
#10943: FILE: drivers/bluetooth/usb/btmtkusb.c:1591:
+						BTMTK_ERR("%s allocate skb failed!!", __func__);

WARNING:LONG_LINE: line length of 86 exceeds 80 columns
#10950: FILE: drivers/bluetooth/usb/btmtkusb.c:1598:
+						skb_put(iso_skb, skb->len), skb->len);

WARNING:LONG_LINE: line length of 82 exceeds 80 columns
#10951: FILE: drivers/bluetooth/usb/btmtkusb.c:1599:
+					memset(skb_put(iso_skb, isoc_pkt_padding),

WARNING:LONG_LINE_COMMENT: line length of 89 exceeds 80 columns
#10954: FILE: drivers/bluetooth/usb/btmtkusb.c:1602:
+					/* After call back, bt drive will free iso_skb */

WARNING:LONG_LINE: line length of 82 exceeds 80 columns
#10956: FILE: drivers/bluetooth/usb/btmtkusb.c:1604:
+					BTMTK_DBG_RAW(iso_skb->data, iso_skb->len,

WARNING:LONG_LINE_COMMENT: line length of 97 exceeds 80 columns
#10959: FILE: drivers/bluetooth/usb/btmtkusb.c:1607:
+					/* It's alloc by hci drver, bt driver must be free it. */

WARNING:LONG_LINE: line length of 100 exceeds 80 columns
#10968: FILE: drivers/bluetooth/usb/btmtkusb.c:1616:
+					memset(skb_put(skb, isoc_pkt_padding), 0, isoc_pkt_padding);

WARNING:LONG_LINE: line length of 99 exceeds 80 columns
#10980: FILE: drivers/bluetooth/usb/btmtkusb.c:1628:
+				BTMTK_WARN("%s send iso data, but iso channel not exit", __func__);

WARNING:LONG_LINE: line length of 90 exceeds 80 columns
#11034: FILE: drivers/bluetooth/usb/btmtkusb.c:1682:
+	u8 dl_done_cmd[] = {0x01, 0x6F, 0xFC, 0x05, 0x01, 0x01, 0x01, 0x00, PATCH_PHASE3};

WARNING:LONG_LINE_COMMENT: line length of 94 exceeds 80 columns
#11035: FILE: drivers/bluetooth/usb/btmtkusb.c:1683:
+	u8 event[] = {0x04, 0xE4, 0x05, 0x02, 0x01, 0x01, 0x00, 0x00}; /* event[7] is status*/

WARNING:LONG_LINE: line length of 95 exceeds 80 columns
#11045: FILE: drivers/bluetooth/usb/btmtkusb.c:1693:
+		sent_len = (section_dl_size - cur_len) >= (UPLOAD_PATCH_UNIT - HCI_TYPE_SIZE) ?

WARNING:LONG_LINE: line length of 98 exceeds 80 columns
#11046: FILE: drivers/bluetooth/usb/btmtkusb.c:1694:
+				(UPLOAD_PATCH_UNIT - HCI_TYPE_SIZE) : (section_dl_size - cur_len);

WARNING:LONG_LINE: line length of 98 exceeds 80 columns
#11053: FILE: drivers/bluetooth/usb/btmtkusb.c:1701:
+			memcpy(&image[HCI_TYPE_SIZE], fwbuf + section_offset + cur_len, sent_len);

WARNING:LONG_LINE: line length of 88 exceeds 80 columns
#11061: FILE: drivers/bluetooth/usb/btmtkusb.c:1709:
+				BTMTK_ERR("%s: send patch failed, terminate", __func__);

WARNING:LONG_LINE: line length of 89 exceeds 80 columns
#11069: FILE: drivers/bluetooth/usb/btmtkusb.c:1717:
+	BTMTK_INFO_RAW(dl_done_cmd, sizeof(dl_done_cmd), "%s: send dl cmd - ", __func__);

WARNING:LONG_LINE: line length of 99 exceeds 80 columns
#11111: FILE: drivers/bluetooth/usb/btmtkusb.c:1759:
+	err = usb_set_interface(cif_dev->udev, cif_dev->new_isoc_altsetting_interface, altsetting);

WARNING:LONG_LINE: line length of 98 exceeds 80 columns
#11241: FILE: drivers/bluetooth/usb/btmtkusb.c:1889:
+		BTMTK_WARN("%s: bt driver is not ready, please don't call chip reset!", __func__);

WARNING:LONG_LINE_STRING: line length of 83 exceeds 80 columns
#11250: FILE: drivers/bluetooth/usb/btmtkusb.c:1898:
+		(pdwnc_func) btmtk_kallsyms_lookup_name("PDWNC_SetBTInResetState");

WARNING:LONG_LINE: line length of 91 exceeds 80 columns
#11254: FILE: drivers/bluetooth/usb/btmtkusb.c:1902:
+		BTMTK_WARN("%s: No Exported Func Found PDWNC_SetBTInResetState", __func__);

WARNING:LONG_LINE_STRING: line length of 83 exceeds 80 columns
#11257: FILE: drivers/bluetooth/usb/btmtkusb.c:1905:
+		(reset_func_ptr2) btmtk_kallsyms_lookup_name("mtk_gpio_set_value");

WARNING:LONG_LINE: line length of 85 exceeds 80 columns
#11259: FILE: drivers/bluetooth/usb/btmtkusb.c:1907:
+		BTMTK_ERR("%s: No Exported Func Found mtk_gpio_set_value", __func__);

WARNING:LONG_LINE_STRING: line length of 95 exceeds 80 columns
#11263: FILE: drivers/bluetooth/usb/btmtkusb.c:1911:
+	reset_func.pf_lowFunc = (set_gpio_low) btmtk_kallsyms_lookup_name("MDrv_GPIO_Set_Low");

WARNING:LONG_LINE_STRING: line length of 98 exceeds 80 columns
#11264: FILE: drivers/bluetooth/usb/btmtkusb.c:1912:
+	reset_func.pf_highFunc = (set_gpio_high) btmtk_kallsyms_lookup_name("MDrv_GPIO_Set_High");

WARNING:LONG_LINE: line length of 93 exceeds 80 columns
#11266: FILE: drivers/bluetooth/usb/btmtkusb.c:1914:
+		BTMTK_WARN("%s: No Exported Func Found MDrv_GPIO_Set_Low or High", __func__);

WARNING:LONG_LINE: line length of 89 exceeds 80 columns
#11268: FILE: drivers/bluetooth/usb/btmtkusb.c:1916:
+		BTMTK_INFO("%s: Found MDrv_GPIO_Set_Low & MDrv_GPIO_Set_High", __func__);

WARNING:LONG_LINE: line length of 82 exceeds 80 columns
#11271: FILE: drivers/bluetooth/usb/btmtkusb.c:1919:
+		BTMTK_INFO("%s: Invoke PDWNC_SetBTInResetState(%d)", __func__, 1);

WARNING:LONG_LINE: line length of 91 exceeds 80 columns
#11274: FILE: drivers/bluetooth/usb/btmtkusb.c:1922:
+		BTMTK_INFO("%s: No Exported Func Found PDWNC_SetBTInResetState", __func__);

WARNING:LONG_LINE: line length of 94 exceeds 80 columns
#11278: FILE: drivers/bluetooth/usb/btmtkusb.c:1926:
+		BTMTK_INFO("%s: Invoke bdev->pf_resetFunc2(%d,%d)", __func__, rst_pin_num, 0);

WARNING:LONG_LINE: line length of 94 exceeds 80 columns
#11281: FILE: drivers/bluetooth/usb/btmtkusb.c:1929:
+		BTMTK_INFO("%s: Invoke bdev->pf_resetFunc2(%d,%d)", __func__, rst_pin_num, 1);

WARNING:LONG_LINE: line length of 85 exceeds 80 columns
#11288: FILE: drivers/bluetooth/usb/btmtkusb.c:1936:
+		if (of_property_read_u32(node, "wifi-ctl-gpio", &rst_pin_num) == 0) {

WARNING:LONG_LINE: line length of 89 exceeds 80 columns
#11300: FILE: drivers/bluetooth/usb/btmtkusb.c:1948:
+			BTMTK_WARN("%s, failed to obtain wifi control gpio\n", __func__);

WARNING:LONG_LINE: line length of 93 exceeds 80 columns
#11304: FILE: drivers/bluetooth/usb/btmtkusb.c:1952:
+			BTMTK_INFO("%s: Invoke bdev->pf_lowFunc(%d)", __func__, rst_pin_num);

WARNING:LONG_LINE: line length of 94 exceeds 80 columns
#11307: FILE: drivers/bluetooth/usb/btmtkusb.c:1955:
+			BTMTK_INFO("%s: Invoke bdev->pf_highFunc(%d)", __func__, rst_pin_num);

WARNING:LONG_LINE_STRING: line length of 90 exceeds 80 columns
#11318: FILE: drivers/bluetooth/usb/btmtkusb.c:1966:
+		node = of_find_compatible_node(NULL, NULL, "mediatek,connectivity-combo");

WARNING:LONG_LINE: line length of 92 exceeds 80 columns
#11320: FILE: drivers/bluetooth/usb/btmtkusb.c:1968:
+			mt76xx_reset_gpio = of_get_named_gpio(node, "mt76xx-reset-gpio", 0);

WARNING:LONG_LINE: line length of 87 exceeds 80 columns
#11325: FILE: drivers/bluetooth/usb/btmtkusb.c:1973:
+				mt76xx_reset_gpio = bdev->bt_cfg.dongle_reset_gpio_pin;

WARNING:LONG_LINE: line length of 83 exceeds 80 columns
#11423: FILE: drivers/bluetooth/usb/btmtkusb.c:2071:
+		if (!cif_dev->reset_intr_ep && ep_desc->bEndpointAddress == 0x8f &&

WARNING:LONG_LINE: line length of 84 exceeds 80 columns
#11436: FILE: drivers/bluetooth/usb/btmtkusb.c:2084:
+		if (!cif_dev->bulk_cmd_tx_ep && usb_endpoint_is_bulk_out(ep_desc) &&

WARNING:LONG_LINE: line length of 99 exceeds 80 columns
#11437: FILE: drivers/bluetooth/usb/btmtkusb.c:2085:
+			(ep_desc->bEndpointAddress == 0x01 || ep_desc->bEndpointAddress == 0x0b)) {

WARNING:LONG_LINE_STRING: line length of 97 exceeds 80 columns
#11448: FILE: drivers/bluetooth/usb/btmtkusb.c:2096:
+			BTMTK_INFO("intr_rx_ep i = %d  Endpoints 0x%02X, number_of_endpoints=%d",

WARNING:LONG_LINE_STRING: line length of 97 exceeds 80 columns
#11456: FILE: drivers/bluetooth/usb/btmtkusb.c:2104:
+			BTMTK_INFO("bulk_tx_ep i = %d  Endpoints 0x%02X, number_of_endpoints=%d",

WARNING:LONG_LINE_STRING: line length of 97 exceeds 80 columns
#11464: FILE: drivers/bluetooth/usb/btmtkusb.c:2112:
+			BTMTK_INFO("bulk_rx_ep i = %d  Endpoints 0x%02X, number_of_endpoints=%d",

WARNING:LONG_LINE_COMMENT: line length of 81 exceeds 80 columns
#11512: FILE: drivers/bluetooth/usb/btmtkusb.c:2160:
+	 * There is no need for other interface such as sdio to use this function

WARNING:LONG_LINE: line length of 93 exceeds 80 columns
#11540: FILE: drivers/bluetooth/usb/btmtkusb.c:2188:
+				i < cif_dev->iso_channel->cur_altsetting->desc.bNumEndpoints;

WARNING:LONG_LINE: line length of 98 exceeds 80 columns
#11542: FILE: drivers/bluetooth/usb/btmtkusb.c:2190:
+				ep_desc = &cif_dev->iso_channel->cur_altsetting->endpoint[i].desc;

WARNING:LONG_LINE: line length of 99 exceeds 80 columns
#11544: FILE: drivers/bluetooth/usb/btmtkusb.c:2192:
+				if (!cif_dev->intr_iso_tx_ep && usb_endpoint_is_int_out(ep_desc)) {

WARNING:LONG_LINE_STRING: line length of 92 exceeds 80 columns
#11546: FILE: drivers/bluetooth/usb/btmtkusb.c:2194:
+					BTMTK_INFO("intr_iso_tx_ep i = %d Endpoints 0x%02X",

WARNING:LONG_LINE: line length of 90 exceeds 80 columns
#11549: FILE: drivers/bluetooth/usb/btmtkusb.c:2197:
+						intf->cur_altsetting->desc.bNumEndpoints);

WARNING:LONG_LINE: line length of 98 exceeds 80 columns
#11553: FILE: drivers/bluetooth/usb/btmtkusb.c:2201:
+				if (!cif_dev->intr_iso_rx_ep && usb_endpoint_is_int_in(ep_desc)) {

WARNING:LONG_LINE_STRING: line length of 92 exceeds 80 columns
#11555: FILE: drivers/bluetooth/usb/btmtkusb.c:2203:
+					BTMTK_INFO("intr_iso_rx_ep i = %d Endpoints 0x%02X",

WARNING:LONG_LINE: line length of 90 exceeds 80 columns
#11558: FILE: drivers/bluetooth/usb/btmtkusb.c:2206:
+						intf->cur_altsetting->desc.bNumEndpoints);

WARNING:LONG_LINE: line length of 85 exceeds 80 columns
#11564: FILE: drivers/bluetooth/usb/btmtkusb.c:2212:
+							 cif_dev->iso_channel, bdev);

WARNING:LONG_LINE: line length of 86 exceeds 80 columns
#11598: FILE: drivers/bluetooth/usb/btmtkusb.c:2246:
+		BTMTK_ERR("%s, btmtk_send_init_cmds failed, err = %d", __func__, err);

WARNING:LONG_LINE: line length of 83 exceeds 80 columns
#11649: FILE: drivers/bluetooth/usb/btmtkusb.c:2297:
+			usb_driver_release_interface(&btusb_driver, cif_dev->isoc);

WARNING:LONG_LINE: line length of 90 exceeds 80 columns
#11651: FILE: drivers/bluetooth/usb/btmtkusb.c:2299:
+			usb_driver_release_interface(&btusb_driver, cif_dev->iso_channel);

WARNING:LONG_LINE: line length of 83 exceeds 80 columns
#11683: FILE: drivers/bluetooth/usb/btmtkusb.c:2331:
+		BTMTK_ERR("%s: btmtk_woble_suspend return fail %d", __func__, ret);

WARNING:LONG_LINE: line length of 81 exceeds 80 columns
#11739: FILE: drivers/bluetooth/usb/btmtkusb.c:2387:
+		if (is_mt7961(bdev->chip_id) && BTMTK_IS_BT_0_INTF(ifnum_base)) {

WARNING:LONG_LINE: line length of 84 exceeds 80 columns
#11742: FILE: drivers/bluetooth/usb/btmtkusb.c:2390:
+				err = btusb_submit_intr_reset_urb(hdev, GFP_KERNEL);

WARNING:LONG_LINE: line length of 84 exceeds 80 columns
#11744: FILE: drivers/bluetooth/usb/btmtkusb.c:2392:
+					clear_bit(BTUSB_INTR_RUNNING, &bdev->flags);

WARNING:LONG_LINE_STRING: line length of 85 exceeds 80 columns
#11748: FILE: drivers/bluetooth/usb/btmtkusb.c:2396:
+				BTMTK_INFO("%s, reset_intr_ep missing, don't summit",

WARNING:LONG_LINE: line length of 87 exceeds 80 columns
#11752: FILE: drivers/bluetooth/usb/btmtkusb.c:2400:
+				err = btusb_submit_intr_ble_isoc_urb(hdev, GFP_KERNEL);

WARNING:LONG_LINE: line length of 90 exceeds 80 columns
#11754: FILE: drivers/bluetooth/usb/btmtkusb.c:2402:
+					usb_kill_anchored_urbs(&cif_dev->ble_isoc_anchor);

WARNING:LONG_LINE: line length of 84 exceeds 80 columns
#11755: FILE: drivers/bluetooth/usb/btmtkusb.c:2403:
+					clear_bit(BTUSB_INTR_RUNNING, &bdev->flags);

WARNING:LONG_LINE_STRING: line length of 86 exceeds 80 columns
#11759: FILE: drivers/bluetooth/usb/btmtkusb.c:2407:
+				BTMTK_INFO("%s, intr_iso_rx_ep missing, don't summit",

WARNING:LONG_LINE: line length of 82 exceeds 80 columns
#11798: FILE: drivers/bluetooth/usb/btmtkusb.c:2446:
+		BTMTK_ERR("%s: btmtk_woble_resume return fail %d", __func__, err);

WARNING:LONG_LINE: line length of 85 exceeds 80 columns
#11848: FILE: drivers/bluetooth/usb/btmtkusb.c:2496:
+		BTMTK_WARN("%s intf[%d] priv setting is NULL", __func__, ifnum_base);

WARNING:LONG_LINE: line length of 85 exceeds 80 columns
#11882: FILE: drivers/bluetooth/usb/btmtkusb.c:2530:
+		BTMTK_WARN("%s intf[%d] priv setting is NULL", __func__, ifnum_base);

WARNING:LONG_LINE: line length of 90 exceeds 80 columns
#11916: FILE: drivers/bluetooth/usb/btmtkusb.c:2564:
+		BTMTK_WARN("%s: FW dumping ongoing, don't dos suspend flow!!!", __func__);

WARNING:LONG_LINE: line length of 93 exceeds 80 columns
#11924: FILE: drivers/bluetooth/usb/btmtkusb.c:2572:
+			BTMTK_WARN("%s intf[%d] priv setting is NULL", __func__, ifnum_base);

WARNING:LONG_LINE: line length of 81 exceeds 80 columns
#11940: FILE: drivers/bluetooth/usb/btmtkusb.c:2588:
+			btmtk_set_chip_state((void *)bdev, cif_state->ops_error);

WARNING:LONG_LINE: line length of 98 exceeds 80 columns
#11942: FILE: drivers/bluetooth/usb/btmtkusb.c:2590:
+		BTMTK_INFO("%s, interface num is for isoc interface, do't do suspend!", __func__);

WARNING:LONG_LINE: line length of 93 exceeds 80 columns
#11964: FILE: drivers/bluetooth/usb/btmtkusb.c:2612:
+			BTMTK_WARN("%s intf[%d] priv setting is NULL", __func__, ifnum_base);

WARNING:LONG_LINE: line length of 81 exceeds 80 columns
#11980: FILE: drivers/bluetooth/usb/btmtkusb.c:2628:
+			btmtk_set_chip_state((void *)bdev, cif_state->ops_error);

WARNING:LONG_LINE: line length of 97 exceeds 80 columns
#11982: FILE: drivers/bluetooth/usb/btmtkusb.c:2630:
+		BTMTK_INFO("%s, interface num is for isoc interface, do't do resume!", __func__);

WARNING:LONG_LINE: line length of 87 exceeds 80 columns
#12059: FILE: drivers/bluetooth/usb/btmtkusb.c:2707:
+			BTMTK_ERR("%s: alloc memory fail (bdev->o_usb_buf)", __func__);

WARNING:LONG_LINE: line length of 81 exceeds 80 columns
#12065: FILE: drivers/bluetooth/usb/btmtkusb.c:2713:
+		cif_dev->urb_intr_buf = kzalloc(URB_MAX_BUFFER_SIZE, GFP_KERNEL);

WARNING:LONG_LINE: line length of 90 exceeds 80 columns
#12067: FILE: drivers/bluetooth/usb/btmtkusb.c:2715:
+			BTMTK_ERR("%s: alloc memory fail (bdev->urb_intr_buf)", __func__);

WARNING:LONG_LINE: line length of 81 exceeds 80 columns
#12072: FILE: drivers/bluetooth/usb/btmtkusb.c:2720:
+		cif_dev->urb_bulk_buf = kzalloc(URB_MAX_BUFFER_SIZE, GFP_KERNEL);

WARNING:LONG_LINE: line length of 90 exceeds 80 columns
#12074: FILE: drivers/bluetooth/usb/btmtkusb.c:2722:
+			BTMTK_ERR("%s: alloc memory fail (bdev->urb_bulk_buf)", __func__);

WARNING:LONG_LINE: line length of 85 exceeds 80 columns
#12079: FILE: drivers/bluetooth/usb/btmtkusb.c:2727:
+		cif_dev->urb_ble_isoc_buf = kzalloc(URB_MAX_BUFFER_SIZE, GFP_KERNEL);

WARNING:LONG_LINE: line length of 94 exceeds 80 columns
#12081: FILE: drivers/bluetooth/usb/btmtkusb.c:2729:
+			BTMTK_ERR("%s: alloc memory fail (bdev->urb_ble_isoc_buf)", __func__);

WARNING:LONG_LINE: line length of 81 exceeds 80 columns
#12114: FILE: drivers/bluetooth/usb/btmtkusb.c:2762:
+static int btmtk_cif_write_uhw_register(struct btmtk_dev *bdev, u32 reg, u32 val)

WARNING:LONG_LINE_COMMENT: line length of 86 exceeds 80 columns
#12132: FILE: drivers/bluetooth/usb/btmtkusb.c:2780:
+			0x02,						/* bRequest */

WARNING:LONG_LINE_COMMENT: line length of 90 exceeds 80 columns
#12133: FILE: drivers/bluetooth/usb/btmtkusb.c:2781:
+			0x5E,						/* bRequestType */

WARNING:LONG_LINE_COMMENT: line length of 84 exceeds 80 columns
#12134: FILE: drivers/bluetooth/usb/btmtkusb.c:2782:
+			reg_high,					/* wValue */

WARNING:LONG_LINE_COMMENT: line length of 84 exceeds 80 columns
#12135: FILE: drivers/bluetooth/usb/btmtkusb.c:2783:
+			reg_low,					/* wIndex */

WARNING:LONG_LINE: line length of 87 exceeds 80 columns
#12139: FILE: drivers/bluetooth/usb/btmtkusb.c:2787:
+	BTMTK_DBG("%s: high=%x, reg_low=%x, val=%x", __func__, reg_high, reg_low, val);

WARNING:LONG_LINE: line length of 82 exceeds 80 columns
#12141: FILE: drivers/bluetooth/usb/btmtkusb.c:2789:
+		__func__, reset_buf[3], reset_buf[2], reset_buf[1], reset_buf[0]);

WARNING:LONG_LINE: line length of 86 exceeds 80 columns
#12145: FILE: drivers/bluetooth/usb/btmtkusb.c:2793:
+		BTMTK_ERR("%s: error(%d), reg=%x, value=%x", __func__, ret, reg, val);

WARNING:LONG_LINE: line length of 81 exceeds 80 columns
#12151: FILE: drivers/bluetooth/usb/btmtkusb.c:2799:
+static int btmtk_cif_read_uhw_register(struct btmtk_dev *bdev, u32 reg, u32 *val)

WARNING:LONG_LINE_COMMENT: line length of 86 exceeds 80 columns
#12163: FILE: drivers/bluetooth/usb/btmtkusb.c:2811:
+			0x01,						/* bRequest */

WARNING:LONG_LINE_COMMENT: line length of 90 exceeds 80 columns
#12164: FILE: drivers/bluetooth/usb/btmtkusb.c:2812:
+			0xDE,						/* bRequestType */

WARNING:LONG_LINE_COMMENT: line length of 84 exceeds 80 columns
#12165: FILE: drivers/bluetooth/usb/btmtkusb.c:2813:
+			reg_high,					/* wValue */

WARNING:LONG_LINE_COMMENT: line length of 84 exceeds 80 columns
#12166: FILE: drivers/bluetooth/usb/btmtkusb.c:2814:
+			reg_low,					/* wIndex */

WARNING:LONG_LINE: line length of 91 exceeds 80 columns
#12172: FILE: drivers/bluetooth/usb/btmtkusb.c:2820:
+		BTMTK_ERR("%s: error(%d), reg=%x, value=0x%08x", __func__, ret, reg, *val);

WARNING:LONG_LINE_COMMENT: line length of 86 exceeds 80 columns
#12196: FILE: drivers/bluetooth/usb/btmtkusb.c:2844:
+			0x63,						/* bRequest */

WARNING:LONG_LINE_COMMENT: line length of 84 exceeds 80 columns
#12198: FILE: drivers/bluetooth/usb/btmtkusb.c:2846:
+			reg_high,					/* wValue */

WARNING:LONG_LINE_COMMENT: line length of 84 exceeds 80 columns
#12199: FILE: drivers/bluetooth/usb/btmtkusb.c:2847:
+			reg_low,					/* wIndex */

WARNING:LONG_LINE: line length of 87 exceeds 80 columns
#12205: FILE: drivers/bluetooth/usb/btmtkusb.c:2853:
+		BTMTK_ERR("%s: error(%d), reg=%x, value=%x", __func__, ret, reg, *val);

WARNING:LONG_LINE_COMMENT: line length of 86 exceeds 80 columns
#12233: FILE: drivers/bluetooth/usb/btmtkusb.c:2881:
+			0x66,						/* bRequest */

WARNING:LONG_LINE_COMMENT: line length of 84 exceeds 80 columns
#12235: FILE: drivers/bluetooth/usb/btmtkusb.c:2883:
+			reg_high,					/* wValue */

WARNING:LONG_LINE_COMMENT: line length of 84 exceeds 80 columns
#12236: FILE: drivers/bluetooth/usb/btmtkusb.c:2884:
+			reg_low,					/* wIndex */

WARNING:LONG_LINE: line length of 85 exceeds 80 columns
#12240: FILE: drivers/bluetooth/usb/btmtkusb.c:2888:
+	BTMTK_DBG("%s: buf = %x %x %x %x", __func__, buf[3], buf[2], buf[1], buf[0]);

WARNING:LONG_LINE: line length of 86 exceeds 80 columns
#12244: FILE: drivers/bluetooth/usb/btmtkusb.c:2892:
+		BTMTK_ERR("%s: error(%d), reg=%x, value=%x", __func__, ret, reg, val);

WARNING:LONG_LINE: line length of 97 exceeds 80 columns
#12264: FILE: drivers/bluetooth/usb/btmtkusb.c:2912:
+int btmtk_cif_send_control_out(struct btmtk_dev *bdev, struct sk_buff *skb, int delay, int retry)

WARNING:LONG_LINE: line length of 88 exceeds 80 columns
#12270: FILE: drivers/bluetooth/usb/btmtkusb.c:2918:
+	if (bdev == NULL || bdev->hdev == NULL || bdev->io_buf == NULL || skb == NULL ||

WARNING:LONG_LINE: line length of 87 exceeds 80 columns
#12290: FILE: drivers/bluetooth/usb/btmtkusb.c:2938:
+		ret = usb_control_msg(cif_dev->udev, usb_sndctrlpipe(cif_dev->udev, 0),

WARNING:LONG_LINE: line length of 87 exceeds 80 columns
#12295: FILE: drivers/bluetooth/usb/btmtkusb.c:2943:
+		ret = usb_control_msg(cif_dev->udev, usb_sndctrlpipe(cif_dev->udev, 0),

WARNING:LONG_LINE: line length of 92 exceeds 80 columns
#12297: FILE: drivers/bluetooth/usb/btmtkusb.c:2945:
+				(void *)cif_dev->o_usb_buf, skb->len - 1, USB_CTRL_IO_TIMO);

WARNING:LONG_LINE: line length of 99 exceeds 80 columns
#12325: FILE: drivers/bluetooth/usb/btmtkusb.c:2973:
+	buf = usb_alloc_coherent(cif_dev->udev, UPLOAD_PATCH_UNIT, GFP_KERNEL, &urb->transfer_dma);

WARNING:LONG_LINE: line length of 85 exceeds 80 columns
#12332: FILE: drivers/bluetooth/usb/btmtkusb.c:2980:
+	pipe = usb_sndbulkpipe(cif_dev->udev, cif_dev->bulk_tx_ep->bEndpointAddress);

WARNING:LONG_LINE: line length of 84 exceeds 80 columns
#12360: FILE: drivers/bluetooth/usb/btmtkusb.c:3008:
+	usb_free_coherent(cif_dev->udev, UPLOAD_PATCH_UNIT, buf, urb->transfer_dma);

WARNING:LONG_LINE_COMMENT: line length of 86 exceeds 80 columns
#12380: FILE: drivers/bluetooth/usb/btmtkusb.c:3028:
+		/* handle hci cmd and acl pkt from host, handle hci cmd from driver */

WARNING:LONG_LINE: line length of 87 exceeds 80 columns
#12413: FILE: drivers/bluetooth/usb/btmtkusb.c:3061:
+		ret = usb_control_msg(cif_dev->udev, usb_rcvctrlpipe(cif_dev->udev, 0),

WARNING:LONG_LINE: line length of 93 exceeds 80 columns
#12414: FILE: drivers/bluetooth/usb/btmtkusb.c:3062:
+				0x01, DEVICE_VENDOR_REQUEST_IN, 0x30, 0x00, bdev->io_buf + 1,

WARNING:LONG_LINE: line length of 87 exceeds 80 columns
#12417: FILE: drivers/bluetooth/usb/btmtkusb.c:3065:
+		ret = usb_control_msg(cif_dev->udev, usb_rcvctrlpipe(cif_dev->udev, 0),

WARNING:LONG_LINE: line length of 94 exceeds 80 columns
#12418: FILE: drivers/bluetooth/usb/btmtkusb.c:3066:
+				0x01, 0xA1, 0x30, 0x03, bdev->io_buf + 1, HCI_USB_IO_BUF_SIZE,

WARNING:LONG_LINE: line length of 87 exceeds 80 columns
#12452: FILE: drivers/bluetooth/usb/btmtkusb.c:3100:
+	if ((pkt_type == BTMTK_TX_CMD_FROM_DRV || pkt_type == BTMTK_TX_ACL_FROM_DRV)) {

WARNING:LONG_LINE: line length of 93 exceeds 80 columns
#12453: FILE: drivers/bluetooth/usb/btmtkusb.c:3101:
+		BTMTK_DBG_RAW(skb->data, skb->len, "%s, send, len = %d", __func__, skb->len);

WARNING:LONG_LINE: line length of 84 exceeds 80 columns
#12462: FILE: drivers/bluetooth/usb/btmtkusb.c:3110:
+			bdev->recv_evt_len = btmtk_cif_recv_evt(bdev, delay, retry);

WARNING:LONG_LINE: line length of 86 exceeds 80 columns
#12464: FILE: drivers/bluetooth/usb/btmtkusb.c:3112:
+				BTMTK_ERR("%s btmtk_cif_recv_evt failed!!", __func__);

WARNING:LONG_LINE: line length of 82 exceeds 80 columns
#12470: FILE: drivers/bluetooth/usb/btmtkusb.c:3118:
+				if (memcmp(bdev->io_buf, event, event_len) == 0) {

WARNING:LONG_LINE: line length of 94 exceeds 80 columns
#12476: FILE: drivers/bluetooth/usb/btmtkusb.c:3124:
+			BTMTK_INFO_RAW(event, event_len, "%s: event_need_compare:", __func__);

WARNING:LONG_LINE: line length of 95 exceeds 80 columns
#12477: FILE: drivers/bluetooth/usb/btmtkusb.c:3125:
+			BTMTK_INFO_RAW(bdev->io_buf, bdev->recv_evt_len, "%s: RCV:", __func__);

WARNING:LONG_LINE_STRING: line length of 95 exceeds 80 columns
#12485: FILE: drivers/bluetooth/usb/btmtkusb.c:3133:
+				BTMTK_ERR("%s, event_len (%d) > EVENT_COMPARE_SIZE(%d), error",

WARNING:LONG_LINE: line length of 81 exceeds 80 columns
#12486: FILE: drivers/bluetooth/usb/btmtkusb.c:3134:
+					__func__, event_len, EVENT_COMPARE_SIZE);

WARNING:LONG_LINE: line length of 86 exceeds 80 columns
#12490: FILE: drivers/bluetooth/usb/btmtkusb.c:3138:
+			event_compare_status = BTMTK_EVENT_COMPARE_STATE_NEED_COMPARE;

WARNING:LONG_LINE_COMMENT: line length of 88 exceeds 80 columns
#12495: FILE: drivers/bluetooth/usb/btmtkusb.c:3143:
+			/* check hci event /wmt event for SDIO/UART interface, check hci

WARNING:LONG_LINE: line length of 92 exceeds 80 columns
#12498: FILE: drivers/bluetooth/usb/btmtkusb.c:3146:
+			comp_event_timo = jiffies + msecs_to_jiffies(WOBLE_COMP_EVENT_TIMO);

WARNING:LONG_LINE_STRING: line length of 88 exceeds 80 columns
#12499: FILE: drivers/bluetooth/usb/btmtkusb.c:3147:
+			BTMTK_INFO("event_need_compare_len %d, event_compare_status %d",

WARNING:LONG_LINE: line length of 89 exceeds 80 columns
#12502: FILE: drivers/bluetooth/usb/btmtkusb.c:3150:
+			event_compare_status = BTMTK_EVENT_COMPARE_STATE_COMPARE_SUCCESS;

WARNING:LONG_LINE: line length of 93 exceeds 80 columns
#12505: FILE: drivers/bluetooth/usb/btmtkusb.c:3153:
+		BTMTK_DBG_RAW(skb->data, skb->len, "%s, send, len = %d", __func__, skb->len);

WARNING:LONG_LINE: line length of 96 exceeds 80 columns
#12515: FILE: drivers/bluetooth/usb/btmtkusb.c:3163:
+			if (event_compare_status == BTMTK_EVENT_COMPARE_STATE_COMPARE_SUCCESS) {

WARNING:LONG_LINE: line length of 86 exceeds 80 columns
#12522: FILE: drivers/bluetooth/usb/btmtkusb.c:3170:
+		event_compare_status = BTMTK_EVENT_COMPARE_STATE_NOTHING_NEED_COMPARE;

WARNING:LONG_LINE: line length of 82 exceeds 80 columns
#12543: FILE: drivers/bluetooth/usb/btmtkusb.c:3191:
+				bdev->bdaddr[0], bdev->bdaddr[1], bdev->bdaddr[2],

WARNING:LONG_LINE: line length of 83 exceeds 80 columns
#12544: FILE: drivers/bluetooth/usb/btmtkusb.c:3192:
+				bdev->bdaddr[3], bdev->bdaddr[4], bdev->bdaddr[5]);

WARNING:LONG_LINE: line length of 89 exceeds 80 columns
#12546: FILE: drivers/bluetooth/usb/btmtkusb.c:3194:
+			event_compare_status = BTMTK_EVENT_COMPARE_STATE_COMPARE_SUCCESS;

WARNING:LONG_LINE_COMMENT: line length of 87 exceeds 80 columns
#12549: FILE: drivers/bluetooth/usb/btmtkusb.c:3197:
+			/* if it is wobx debug event, just print in kernel log, drop it

WARNING:LONG_LINE: line length of 89 exceeds 80 columns
#12556: FILE: drivers/bluetooth/usb/btmtkusb.c:3204:
+			event_compare_status = BTMTK_EVENT_COMPARE_STATE_COMPARE_SUCCESS;

WARNING:LONG_LINE: line length of 82 exceeds 80 columns
#12560: FILE: drivers/bluetooth/usb/btmtkusb.c:3208:
+			BTMTK_INFO_RAW(event_need_compare, event_need_compare_len,

WARNING:LONG_LINE: line length of 88 exceeds 80 columns
#12562: FILE: drivers/bluetooth/usb/btmtkusb.c:3210:
+			BTMTK_INFO_RAW(skb->data, skb->len, "%s: skb->data:", __func__);

- total: 0 errors, 842 warnings, 12491 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

"[PATCH] MTK mt7921 driver upstream" has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: CheckGitLint - PASS

##############################
Test: CheckBuild - PASS

##############################
Test: MakeCheck - PASS



---
Regards,
Linux Bluetooth


--===============7511037406244737267==--
