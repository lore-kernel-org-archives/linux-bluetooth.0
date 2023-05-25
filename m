Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D475C7EE2C
	for <linux-bluetooth@archiver.kernel.org>; Thu, 25 May 2023 18:52:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242566AbjEYSwJ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 25 May 2023 14:52:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243007AbjEYStu (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 25 May 2023 14:49:50 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B413010F5
        for <linux-bluetooth@vger.kernel.org>; Thu, 25 May 2023 11:43:09 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-64d5f65a2f7so50140b3a.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 25 May 2023 11:43:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685040111; x=1687632111;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=QbdbNw8WU8ERGGiQeZQFlI28MYdr2otm3JaJ7fbDVT8=;
        b=LO3D9G6O1LdZCvkXTRoiEMXoVbx44kgZ0a7UhKRnHrsfQFkoHMequZ15N53JMDjtID
         mB3lYObtrIAjdX1FV9vqQVVVNoQnVXycG4qjKdZcX8d+2uZGptr2U91TcJ2lSxqrlnZI
         8rXlZiRIZwAuvgEN6bfzQSDMPDzsOYWOl3QuSFox0sL+9ouRQb+mjxewpdIhFzI2z7HG
         T4ky5vlaW6fOInOMOSjeVlzawqt8rgIU3VtvodA+NJU1bInjaju0WyJs8zXOhmXCs4t7
         82SHTRIeLvTH50kXnVfUT+qSowtAg+qpFpK/nzPl1qL7ejOyIJ2C5YBMGplWWpy8NL8g
         SyFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685040111; x=1687632111;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QbdbNw8WU8ERGGiQeZQFlI28MYdr2otm3JaJ7fbDVT8=;
        b=Kj4A1JrcpvtlHmwqqkXv85DLX3CLWCRlsI94k2vGCl7PQixyL86k3JAW4s6j2AJUu+
         skDct2TZ6c3+OtijHu72iXiaeY36pTNPsYbUfgyBJluKi9KR7UxJuD9qARWeiyEkKEkz
         lOCJExdByOB1z+HZ3sNjuXmdFWw47enOCpUS5fkokG2tLoeEof66jWvUn0wGWqkVuGiW
         GEDXn+GZmZygjeTT00V8Q91Sfm0T/kd7+LqPgmKXfsmI7EUW518QTIoKKhg4tlWPYtX1
         hhSctuQyhSgDvYpRmrwNoyTbp8YJZeddC1Tg25KeLnJyp7+hcA1js7lF8v8XaMGUYT6D
         keaA==
X-Gm-Message-State: AC+VfDxcXUOVYQV/ZoaFQSC9xSW+iOag3zK0sVJA2AX4t5RElaW2mIUK
        9LQM+r7iLT2wWzIPgRcQ32zPN/R1Xts=
X-Google-Smtp-Source: ACHHUZ6+q7GOrh2jHV8S0rCuOypqf+M5eU5Cd/nhNuQBX4fmFaBxqtXRHiMEhI/N55atjJMbaOtLkw==
X-Received: by 2002:a05:6a20:4315:b0:ef:7aa2:3cfd with SMTP id h21-20020a056a20431500b000ef7aa23cfdmr21878847pzk.50.1685040111180;
        Thu, 25 May 2023 11:41:51 -0700 (PDT)
Received: from [172.17.0.2] ([137.135.38.231])
        by smtp.gmail.com with ESMTPSA id s10-20020a65690a000000b0052c3f0ae381sm1352805pgq.78.2023.05.25.11.41.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 May 2023 11:41:50 -0700 (PDT)
Message-ID: <646fabee.650a0220.50ee6.2802@mx.google.com>
Date:   Thu, 25 May 2023 11:41:50 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5297033370880993214=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, silviu.barbulescu@nxp.com
Subject: RE: Add initial support for BAP broadcast source
In-Reply-To: <20230525153452.125789-2-silviu.barbulescu@nxp.com>
References: <20230525153452.125789-2-silviu.barbulescu@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============5297033370880993214==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=751029

---Test result---

Test Summary:
CheckPatch                    FAIL      3.83 seconds
GitLint                       PASS      1.51 seconds
BuildEll                      PASS      29.80 seconds
BluezMake                     PASS      1071.96 seconds
MakeCheck                     PASS      12.70 seconds
MakeDistcheck                 PASS      169.42 seconds
CheckValgrind                 PASS      254.47 seconds
CheckSmatch                   WARNING   374.11 seconds
bluezmakeextell               PASS      103.93 seconds
IncrementalBuild              PASS      5483.91 seconds
ScanBuild                     WARNING   1144.31 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[v2,2/6] Add macro definitions for BAP broadcast source support
WARNING:LONG_LINE_COMMENT: line length of 83 exceeds 80 columns
#121: FILE: lib/bluetooth.h:192:
+#define BASE_MAX_LENGTH 248 /* (HCI_MAX_PER_AD_LENGTH - EIR_SERVICE_DATA_LENGTH) */

/github/workspace/src/src/13255384.patch total: 0 errors, 1 warnings, 38 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13255384.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


[v2,5/6] Update bluetoothctl with support for broadcast source
WARNING:LONG_LINE: line length of 86 exceeds 80 columns
#211: FILE: client/player.c:1796:
+	if ((!cfg->ep->broadcast) && (cfg->ep->iso_group != BT_ISO_QOS_GROUP_UNSET)) {

WARNING:LONG_LINE: line length of 88 exceeds 80 columns
#224: FILE: client/player.c:1806:
+	if ((!cfg->ep->broadcast) && (cfg->ep->iso_stream != BT_ISO_QOS_STREAM_UNSET)) {

WARNING:LONG_LINE_STRING: line length of 81 exceeds 80 columns
#243: FILE: client/player.c:1823:
+		bt_shell_printf("Framing %s\n", qos->framing ? "true" : "false");

WARNING:LONG_LINE: line length of 92 exceeds 80 columns
#250: FILE: client/player.c:1828:
+		bt_shell_printf("Framing %s\n", bcast_qos.bcast.framing ? "true" : "false");

WARNING:LONG_LINE: line length of 82 exceeds 80 columns
#253: FILE: client/player.c:1831:
+							&bcast_qos.bcast.framing);

WARNING:LONG_LINE: line length of 106 exceeds 80 columns
#309: FILE: client/player.c:1904:
+								DBUS_TYPE_BYTE, &cfg->ep->bcode->iov_base,

WARNING:LONG_LINE: line length of 89 exceeds 80 columns
#310: FILE: client/player.c:1905:
+								cfg->ep->bcode->iov_len);

WARNING:LONG_LINE: line length of 98 exceeds 80 columns
#322: FILE: client/player.c:1947:
+		iov_append(&cfg->ep->bcode, bcast_qos.bcast.bcode, sizeof(bcast_qos.bcast.bcode));

WARNING:LONG_LINE: line length of 81 exceeds 80 columns
#324: FILE: client/player.c:1949:
+		iov_append(&cfg->caps, base_lc3_16_2_1, sizeof(base_lc3_16_2_1));

WARNING:LONG_LINE: line length of 84 exceeds 80 columns
#327: FILE: client/player.c:1952:
+		iov_append(&cfg->caps, preset->data.iov_base, preset->data.iov_len);

WARNING:LONG_LINE: line length of 94 exceeds 80 columns
#384: FILE: client/player.c:2408:
+		bt_shell_prompt_input(ep->path, "CIS (auto/value):", endpoint_iso_stream, ep);

WARNING:LONG_LINE: line length of 94 exceeds 80 columns
#386: FILE: client/player.c:2410:
+		bt_shell_prompt_input(ep->path, "BIS (auto/value):", endpoint_iso_stream, ep);

WARNING:LONG_LINE: line length of 93 exceeds 80 columns
#396: FILE: client/player.c:2433:
+		bt_shell_prompt_input(ep->path, "BIG (auto/value):", endpoint_iso_group, ep);

WARNING:LONG_LINE: line length of 93 exceeds 80 columns
#398: FILE: client/player.c:2435:
+		bt_shell_prompt_input(ep->path, "CIG (auto/value):", endpoint_iso_group, ep);

WARNING:LONG_LINE: line length of 93 exceeds 80 columns
#420: FILE: client/player.c:2461:
+		bt_shell_prompt_input(ep->path, "BIG (auto/value):", endpoint_iso_group, ep);

WARNING:LONG_LINE: line length of 93 exceeds 80 columns
#422: FILE: client/player.c:2463:
+		bt_shell_prompt_input(ep->path, "CIG (auto/value):", endpoint_iso_group, ep);

WARNING:LONG_LINE_STRING: line length of 86 exceeds 80 columns
#451: FILE: client/player.c:3755:
+			bt_shell_printf("Transport %s already in acquiring process\n",

WARNING:LONG_LINE_STRING: line length of 89 exceeds 80 columns
#463: FILE: client/player.c:3767:
+				bt_shell_printf("Link %s already in acquiring process\n",

WARNING:LONG_LINE: line length of 82 exceeds 80 columns
#465: FILE: client/player.c:3769:
+				return bt_shell_noninteractive_quit(EXIT_FAILURE);

/github/workspace/src/src/13255387.patch total: 0 errors, 19 warnings, 350 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13255387.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


[v2,6/6] Add initial support for BAP broadcast source
WARNING:LONG_LINE: line length of 84 exceeds 80 columns
#238: FILE: profiles/audio/bap.c:370:
+							&qos->ucast.target_latency);

WARNING:LONG_LINE: line length of 82 exceeds 80 columns
#264: FILE: profiles/audio/bap.c:396:
+							&qos->bcast.sync_timeout);

WARNING:LONG_LINE: line length of 83 exceeds 80 columns
#270: FILE: profiles/audio/bap.c:402:
+							&qos->bcast.sync_cte_type);

WARNING:LONG_LINE: line length of 84 exceeds 80 columns
#387: FILE: profiles/audio/bap.c:797:
+	} else if (bt_bap_stream_get_type(stream) == BT_BAP_STREAM_TYPE_BROADCAST) {

WARNING:LONG_LINE_COMMENT: line length of 87 exceeds 80 columns
#440: FILE: profiles/audio/bap.c:1051:
+	/* If IO already set and we are in the creation step, skip creating it again */

WARNING:LONG_LINE_COMMENT: line length of 88 exceeds 80 columns
#455: FILE: profiles/audio/bap.c:1066:
+	/* Just create socket and advance to the configured state (when defer = true) */

WARNING:LONG_LINE: line length of 82 exceeds 80 columns
#481: FILE: profiles/audio/bap.c:1092:
+		bt_bap_stream_io_connecting(stream, g_io_channel_unix_get_fd(io));

WARNING:LONG_LINE: line length of 82 exceeds 80 columns
#512: FILE: profiles/audio/bap.c:1157:
+			iso_qos.bcast.sync_interval = ep->qos.bcast.sync_interval;

WARNING:LONG_LINE: line length of 86 exceeds 80 columns
#516: FILE: profiles/audio/bap.c:1161:
+			memcpy(iso_qos.bcast.bcode, ep->qos.bcast.bcode.iov_base, 16);

WARNING:LONG_LINE: line length of 82 exceeds 80 columns
#520: FILE: profiles/audio/bap.c:1165:
+			iso_qos.bcast.sync_cte_type = ep->qos.bcast.sync_cte_type;

WARNING:LONG_LINE: line length of 104 exceeds 80 columns
#523: FILE: profiles/audio/bap.c:1168:
+			memcpy(&iso_qos.bcast.out, &ep->qos.bcast.io_qos, sizeof(struct bt_iso_io_qos));

WARNING:LONG_LINE: line length of 89 exceeds 80 columns
#526: FILE: profiles/audio/bap.c:1171:
+		iso_qos.ucast.cig = qos[0] ? qos[0]->ucast.cig_id : qos[1]->ucast.cig_id;

WARNING:LONG_LINE: line length of 89 exceeds 80 columns
#527: FILE: profiles/audio/bap.c:1172:
+		iso_qos.ucast.cis = qos[0] ? qos[0]->ucast.cis_id : qos[1]->ucast.cis_id;

WARNING:LONG_LINE: line length of 83 exceeds 80 columns
#537: FILE: profiles/audio/bap.c:1179:
+		if (bt_bap_stream_get_type(stream) == BT_BAP_STREAM_TYPE_BROADCAST)

WARNING:LONG_LINE: line length of 84 exceeds 80 columns
#538: FILE: profiles/audio/bap.c:1180:
+			bap_connect_io_broadcast(data, ep, stream, &iso_qos, defer);

WARNING:LONG_LINE: line length of 91 exceeds 80 columns
#554: FILE: profiles/audio/bap.c:1221:
+			if (bt_bap_stream_get_type(stream) == BT_BAP_STREAM_TYPE_UNICAST) {

WARNING:LONG_LINE: line length of 84 exceeds 80 columns
#556: FILE: profiles/audio/bap.c:1223:
+				ep->id = bt_bap_stream_qos(stream, &ep->qos, qos_cb,

WARNING:LONG_LINE: line length of 84 exceeds 80 columns
#557: FILE: profiles/audio/bap.c:1224:
+										ep);

WARNING:LONG_LINE: line length of 82 exceeds 80 columns
#560: FILE: profiles/audio/bap.c:1227:
+					bt_bap_stream_release(stream, NULL, NULL);

WARNING:LONG_LINE: line length of 85 exceeds 80 columns
#570: FILE: profiles/audio/bap.c:1240:
+		if (bt_bap_stream_get_type(stream) == BT_BAP_STREAM_TYPE_BROADCAST) {

WARNING:LONG_LINE: line length of 91 exceeds 80 columns
#592: FILE: profiles/audio/bap.c:1274:
+		bt_bap_foreach_pac(data->bap, BT_BAP_BROADCAST_SOURCE, pac_found, service);

WARNING:LONG_LINE: line length of 87 exceeds 80 columns
#673: FILE: profiles/audio/bap.c:1426:
+					ep->qos.ucast.cis_id == BT_ISO_QOS_CIS_UNSET) {

WARNING:LONG_LINE: line length of 92 exceeds 80 columns
#699: FILE: profiles/audio/bap.c:1443:
+						ep->qos.ucast.cig_id, ep->qos.ucast.cis_id);

WARNING:LONG_LINE: line length of 88 exceeds 80 columns
#700: FILE: profiles/audio/bap.c:1444:
+	} else if (bt_bap_stream_get_type(ep->stream) == BT_BAP_STREAM_TYPE_BROADCAST) {

WARNING:LONG_LINE: line length of 84 exceeds 80 columns
#703: FILE: profiles/audio/bap.c:1447:
+					ep->qos.bcast.bis == BT_ISO_QOS_BIS_UNSET) {

WARNING:LONG_LINE: line length of 86 exceeds 80 columns
#722: FILE: profiles/audio/bap.c:1464:
+						ep->qos.bcast.big, ep->qos.bcast.bis);

WARNING:LONG_LINE: line length of 98 exceeds 80 columns
#734: FILE: profiles/audio/bap.c:1616:
+	struct btd_device *device = btd_adapter_get_device(adapter, BDADDR_ANY, BDADDR_LE_PUBLIC);

WARNING:LONG_LINE: line length of 86 exceeds 80 columns
#769: FILE: profiles/audio/bap.c:1651:
+						pac_removed_broadcast, service, NULL);

WARNING:LONG_LINE: line length of 83 exceeds 80 columns
#779: FILE: profiles/audio/bap.c:1661:
+	struct bap_data *data = queue_find(sessions, match_data_bap_data, adapter);

WARNING:LONG_LINE: line length of 84 exceeds 80 columns
#911: FILE: profiles/audio/media.c:853:
+							&qos->ucast.target_latency);

WARNING:LONG_LINE: line length of 82 exceeds 80 columns
#936: FILE: profiles/audio/media.c:878:
+							&qos->bcast.sync_timeout);

WARNING:LONG_LINE: line length of 83 exceeds 80 columns
#942: FILE: profiles/audio/media.c:884:
+							&qos->bcast.sync_cte_type);

WARNING:LONG_LINE: line length of 83 exceeds 80 columns
#949: FILE: profiles/audio/media.c:891:
+							&qos->bcast.sync_interval);

WARNING:LONG_LINE: line length of 85 exceeds 80 columns
#1016: FILE: profiles/audio/media.c:1272:
+static bool endpoint_init_broadcast_source(struct media_endpoint *endpoint, int *err)

WARNING:LONG_LINE: line length of 96 exceeds 80 columns
#1082: FILE: profiles/audio/transport.c:551:
+	if (bt_bap_stream_get_type(get_stream_bap(transport)) == BT_BAP_STREAM_TYPE_BROADCAST) {

WARNING:LONG_LINE: line length of 94 exceeds 80 columns
#1096: FILE: profiles/audio/transport.c:562:
+	if (bt_bap_stream_get_type(get_stream_bap(transport)) == BT_BAP_STREAM_TYPE_UNICAST) {

WARNING:LONG_LINE: line length of 89 exceeds 80 columns
#1136: FILE: profiles/audio/transport.c:880:
+							&bap->qos.ucast.io_qos.interval);

WARNING:LONG_LINE: line length of 89 exceeds 80 columns
#1154: FILE: profiles/audio/transport.c:903:
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_BYTE, &bap->qos.ucast.io_qos.phy);

WARNING:LONG_LINE: line length of 91 exceeds 80 columns
#1163: FILE: profiles/audio/transport.c:914:
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_UINT16, &bap->qos.ucast.io_qos.sdu);

WARNING:LONG_LINE: line length of 89 exceeds 80 columns
#1172: FILE: profiles/audio/transport.c:925:
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_BYTE, &bap->qos.ucast.io_qos.rtn);

WARNING:LONG_LINE: line length of 88 exceeds 80 columns
#1181: FILE: profiles/audio/transport.c:937:
+							&bap->qos.ucast.io_qos.latency);

WARNING:LONG_LINE: line length of 86 exceeds 80 columns
#1190: FILE: profiles/audio/transport.c:948:
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_UINT32, &bap->qos.ucast.delay);

WARNING:LONG_LINE: line length of 82 exceeds 80 columns
#1262: FILE: src/shared/bap.c:662:
+static struct bt_bap_endpoint *bap_get_endpoint_broadcast(struct queue *endpoints,

WARNING:LONG_LINE: line length of 83 exceeds 80 columns
#1325: FILE: src/shared/bap.c:1298:
+static void stream_set_state_broadcast(struct bt_bap_stream *stream, uint8_t state)

WARNING:LONG_LINE: line length of 81 exceeds 80 columns
#1362: FILE: src/shared/bap.c:1464:
+	if (bt_bap_stream_get_type(stream) == BT_BAP_STREAM_TYPE_BROADCAST)	{

WARNING:LONG_LINE: line length of 111 exceeds 80 columns
#1397: FILE: src/shared/bap.c:1660:
+			req->cig, req->cis, qos.ucast.io_qos.interval, qos.ucast.framing, qos.ucast.io_qos.phy,

WARNING:LONG_LINE: line length of 111 exceeds 80 columns
#1398: FILE: src/shared/bap.c:1661:
+			qos.ucast.io_qos.sdu, qos.ucast.io_qos.rtn, qos.ucast.io_qos.latency, qos.ucast.delay);

WARNING:LONG_LINE: line length of 94 exceeds 80 columns
#1449: FILE: src/shared/bap.c:2533:
+		pac_brodcast_sink = bap_pac_new(bdb, name, type, &codec, qos, data, metadata);

WARNING:LONG_LINE: line length of 92 exceeds 80 columns
#1472: FILE: src/shared/bap.c:2556:
+							data, metadata, pac_ops, user_data);

WARNING:LONG_LINE: line length of 82 exceeds 80 columns
#1488: FILE: src/shared/bap.c:2589:
+	else if ((bt_bap_pac_get_type(stream->lpac) == BT_BAP_BROADCAST_SOURCE) ||

WARNING:LONG_LINE: line length of 85 exceeds 80 columns
#1489: FILE: src/shared/bap.c:2590:
+			(bt_bap_pac_get_type(stream->lpac) == BT_BAP_BROADCAST_SINK))

WARNING:LONG_LINE: line length of 94 exceeds 80 columns
#1562: FILE: src/shared/bap.c:4214:
+		return bap_foreach_pac(bap->ldb->broadcast_sources, bap->ldb->broadcast_sinks,

WARNING:LONG_LINE: line length of 81 exceeds 80 columns
#1563: FILE: src/shared/bap.c:4215:
+								func, user_data);

WARNING:LONG_LINE: line length of 88 exceeds 80 columns
#1619: FILE: src/shared/bap.c:4355:
+		req = bap_req_new(stream, BT_ASCS_CONFIG, iov, iovlen, func, user_data);

WARNING:LONG_LINE: line length of 84 exceeds 80 columns
#1635: FILE: src/shared/bap.c:4365:
+	} else if (bt_bap_stream_get_type(stream) == BT_BAP_STREAM_TYPE_BROADCAST) {

WARNING:LONG_LINE: line length of 103 exceeds 80 columns
#1659: FILE: src/shared/bap.c:4498:
+								ep_config_cb, stream->lpac->user_data);

WARNING:LONG_LINE: line length of 81 exceeds 80 columns
#1707: FILE: src/shared/bap.c:4618:
+		ret = bap_stream_metadata(stream, BT_ASCS_ENABLE, metadata, func,

WARNING:LONG_LINE: line length of 84 exceeds 80 columns
#1714: FILE: src/shared/bap.c:4624:
+	} else if (bt_bap_stream_get_type(stream) == BT_BAP_STREAM_TYPE_BROADCAST) {

WARNING:LONG_LINE: line length of 82 exceeds 80 columns
#1715: FILE: src/shared/bap.c:4625:
+		stream_set_state_broadcast(stream, BT_BAP_STREAM_STATE_STREAMING);

WARNING:LONG_LINE: line length of 85 exceeds 80 columns
#1728: FILE: src/shared/bap.c:4809:
+			stream_set_state_broadcast(stream, BT_BAP_STREAM_STATE_IDLE);

WARNING:LONG_LINE_COMMENT: line length of 91 exceeds 80 columns
#1745: FILE: src/shared/bap.c:4853:
+		// TO DO get the location values from metadata for brodcast source and sink

WARNING:LONG_LINE: line length of 92 exceeds 80 columns
#1775: FILE: src/shared/bap.c:5008:
+	if (!qos || *qos || stream->ep->dir != BT_BAP_SINK || !stream->qos.ucast.io_qos.sdu)

WARNING:LONG_LINE: line length of 92 exceeds 80 columns
#1931: FILE: unit/test-bap.c:380:
+							NULL, data->caps, NULL, NULL, NULL);

WARNING:LONG_LINE: line length of 92 exceeds 80 columns
#1936: FILE: unit/test-bap.c:384:
+							NULL, data->caps, NULL, NULL, NULL);

WARNING:LONG_LINE: line length of 92 exceeds 80 columns
#1945: FILE: unit/test-bap.c:394:
+							NULL, data->caps, NULL, NULL, NULL);

WARNING:LONG_LINE: line length of 92 exceeds 80 columns
#1950: FILE: unit/test-bap.c:398:
+							NULL, data->caps, NULL, NULL, NULL);

/github/workspace/src/src/13255388.patch total: 0 errors, 66 warnings, 2017 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13255388.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
monitor/packet.c: note: in included file:monitor/display.h:82:26: warning: Variable length array is used.monitor/packet.c:1806:26: warning: Variable length array is used.monitor/packet.c: note: in included file:monitor/bt.h:3552:52: warning: array of flexible structuresmonitor/bt.h:3540:40: warning: array of flexible structures
##############################
Test: ScanBuild - WARNING
Desc: Run Scan Build
Output:
profiles/audio/bap.c:1094:3: warning: Value stored to 'io' is never read
                io = ep->io;
                ^    ~~~~~~
profiles/audio/bap.c:1171:55: warning: Dereference of null pointer
                iso_qos.ucast.cig = qos[0] ? qos[0]->ucast.cig_id : qos[1]->ucast.cig_id;
                                                                    ^~~~~~~~~~~~~~~~~~~~
2 warnings generated.
src/shared/bap.c:4626:10: warning: Although the value stored to 'ret' is used in the enclosing expression, the value is never actually read from 'ret'
                return ret = 1;
                       ^     ~
1 warning generated.



---
Regards,
Linux Bluetooth


--===============5297033370880993214==--
