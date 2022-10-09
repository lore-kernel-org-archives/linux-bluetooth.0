Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BF38C43217
	for <linux-bluetooth@archiver.kernel.org>; Sun,  9 Oct 2022 18:18:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230240AbiJISSC (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 9 Oct 2022 14:18:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230375AbiJISRj (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 9 Oct 2022 14:17:39 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EC16111E
        for <linux-bluetooth@vger.kernel.org>; Sun,  9 Oct 2022 11:17:16 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id p186so7047828iof.5
        for <linux-bluetooth@vger.kernel.org>; Sun, 09 Oct 2022 11:17:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=3BlaR+yeOC4vrWE7zY4ugBzTS7blF5Jvc4m0wbOdTYM=;
        b=Zb13uO0vOWcRZnkVHle0jt8ymaFXyiL4GJeZquLa6J4ALdkxdI0lApQBYFAIs27RXs
         lp01VpacUcumD1tQOpqE2yQ99hFJTllgCK1Ca9P91PYk6UFAZX3Ega9COjNVGlwRzCbQ
         nYFT4/hNB9skJ6eEhoEu6AjJO2UjhM0Vg50EycRXuh1LpXLUxk8FKCIhJ8QzSmDdXU9k
         JIeT3F+H2aSGGrqSfC2Lf4rKqkE8cArMD0mDwvJDVTnFj4ve5c1rGyHut6xC+tH03ewx
         OUTjqQ8jGMqBLYAtyyBzN23GmsVv4vHYPCyXG8FURsTXdISRZHu1WtW7ytGGxYhkwvCS
         ksNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3BlaR+yeOC4vrWE7zY4ugBzTS7blF5Jvc4m0wbOdTYM=;
        b=BXU9iPt89GH+ugEniUG3/774AsUOr399c6rhtstr5BHFsiqHhVlxvgQzMW1JGHLwMj
         LKZj33GFg+mWtLEOdpOaHKBGBGgb7SGI6il/oFx3q2JhiC8lwhGED27up7JxplWNVLBK
         t//J8FbWe9d0MawLp8lpqCl3ZtVZ8umQ6sZgdHYrhAg9EHpz+AAtzf/5DImSHKHV908w
         d+30dWJDUVDHWqnJ0qsS5cmsK2isLU+bVZhZ6O0/9DZOC+udPO+5WW/nDErFq15Yt4YU
         V5nGSBhH1Jxe5nECHpZVMcq1TkrGTANqg/cwhpiOf8ks5PRzeH0bNlwl0uSnRxY/Un1w
         GQVw==
X-Gm-Message-State: ACrzQf3JJ+S9WcSWJKza1+TVXlX9a293YakoYHBkIO3+bBvCFWGXRxhq
        Ym4CkczfJDb0q7ShN83EBJQORoJ8nlM=
X-Google-Smtp-Source: AMsMyM5gThddYAt1spdfsF+1v8589GvS2R8OoAe8VUe2M9yas6jqY4qxFeZbxXrhhwCiCBfi/+VBGA==
X-Received: by 2002:a05:6638:d81:b0:363:9e6b:49b4 with SMTP id l1-20020a0566380d8100b003639e6b49b4mr5352662jaj.22.1665339434865;
        Sun, 09 Oct 2022 11:17:14 -0700 (PDT)
Received: from [172.17.0.2] ([40.77.43.12])
        by smtp.gmail.com with ESMTPSA id n7-20020a02a187000000b00362a6fd6acbsm3183769jah.32.2022.10.09.11.17.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Oct 2022 11:17:14 -0700 (PDT)
Message-ID: <6343102a.020a0220.1dd9a.30aa@mx.google.com>
Date:   Sun, 09 Oct 2022 11:17:14 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7945168459136696711=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, pav@iki.fi
Subject: RE: Bluetooth: hci_conn: Fix CIS connection dst_type handling
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20221009174216.17533-1-pav@iki.fi>
References: <20221009174216.17533-1-pav@iki.fi>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============7945168459136696711==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=684053

---Test result---

Test Summary:
CheckPatch                    PASS      3.18 seconds
GitLint                       FAIL      0.81 seconds
SubjectPrefix                 PASS      0.73 seconds
BuildKernel                   PASS      37.86 seconds
BuildKernel32                 PASS      33.69 seconds
Incremental Build with patchesPASS      42.82 seconds
TestRunner: Setup             PASS      582.75 seconds
TestRunner: l2cap-tester      PASS      14.70 seconds
TestRunner: iso-tester        PASS      13.18 seconds
TestRunner: bnep-tester       PASS      5.05 seconds
TestRunner: mgmt-tester       FAIL      95.00 seconds
TestRunner: rfcomm-tester     PASS      8.42 seconds
TestRunner: sco-tester        PASS      7.86 seconds
TestRunner: ioctl-tester      PASS      8.81 seconds
TestRunner: mesh-tester       PASS      6.25 seconds
TestRunner: smp-tester        PASS      7.84 seconds
TestRunner: userchan-tester   PASS      5.16 seconds

Details
##############################
Test: GitLint - FAIL - 0.81 seconds
Run gitlint with rule in .gitlint
Bluetooth: hci_conn: Fix CIS connection dst_type handling
21: B2 Line has trailing whitespace: "    "
25: B2 Line has trailing whitespace: "    "
27: B2 Line has trailing whitespace: "    "
31: B2 Line has trailing whitespace: "    "
39: B2 Line has trailing whitespace: "    "
43: B2 Line has trailing whitespace: "    "
47: B2 Line has trailing whitespace: "    "
51: B2 Line has trailing whitespace: "    "
52: B1 Line exceeds max length (83>80): "    Logs for reference (on v6.0, without this patch, with some extra BT_DBG added):"
53: B2 Line has trailing whitespace: "    "
54: B1 Line exceeds max length (110>80): "    bluetoothd[5349]: profiles/audio/bap.c:bap_connect_io() ep 0x60b0000392a0 stream 0x60b000039a30 defer true"
82: B1 Line exceeds max length (93>80): "    bluetoothd[5349]: profiles/audio/bap.c:bap_connect_io() bt_io: connect: ep:0x60b0000392a0"
83: B1 Line exceeds max length (101>80): "    bluetoothd[5349]: profiles/audio/bap.c:bap_connect_io() bt_io: connect -> io:0x60c000015ac0 fd:32"
84: B1 Line exceeds max length (99>80): "    bluetoothd[5349]: src/shared/bap.c:bap_stream_io_attach() stream 0x60b000039a30 connecting true"
86: B1 Line exceeds max length (106>80): "    bluetoothd[5349]: profiles/audio/bap.c:bap_connecting() stream 0x60b000039a30 fd 32: CIG 0x00 CIS 0x00"
87: B1 Line exceeds max length (99>80): "    bluetoothd[5349]: src/shared/bap.c:bap_queue_req() req 0x606000017fc0 (op 0x02) queue 0x6030000"
88: B1 Line exceeds max length (93>80): "    bluetoothd[5349]: profiles/gap/gas.c:read_device_name_cb() GAP Device Name: NRF5340_AUDIO"
96: B1 Line exceeds max length (99>80): "    bluetoothd[5349]: src/shared/att.c:can_read_data() (chan 0x607000008bb0) ATT PDU received: 0x1b"
97: B1 Line exceeds max length (95>80): "    bluetoothd[5349]: profiles/audio/bap.c:qos_cb() stream 0x60b000039a30 code 0x00 reason 0x00"
103: B1 Line exceeds max length (99>80): "    bluetoothd[5349]: src/shared/att.c:can_read_data() (chan 0x607000008bb0) ATT PDU received: 0x1b"
104: B1 Line exceeds max length (99>80): "    bluetoothd[5349]: src/shared/bap.c:bap_ep_set_status() ASE status: ep 0x603000026980 id 0x01 ha"
105: B1 Line exceeds max length (99>80): "    bluetoothd[5349]: src/shared/bap.c:ep_status_qos() CIG 0x00 CIS 0x00 interval 10000 framing 0x0"
106: B1 Line exceeds max length (134>80): "    bluetoothd[5349]: profiles/audio/media.c:pac_config() endpoint 0x60d000000860 path /org/bluez/hci0/dev_C8_3D_D1_FE_CA_67/pac_sink0"
107: B1 Line exceeds max length (148>80): "    bluetoothd[5349]: profiles/audio/media.c:media_endpoint_async_call() Calling SetConfiguration: name = :1.146 path = /MediaEndpoint/BAPSource/lc3"
108: B1 Line exceeds max length (99>80): "    bluetoothd[5349]: src/shared/bap.c:bap_stream_state_changed() stream 0x60b000039a30 dir 0x01: c"
109: B1 Line exceeds max length (89>80): "    bluetoothd[5349]: src/shared/bap.c:bap_stream_update_io_links() stream 0x60b000039a30"
110: B1 Line exceeds max length (97>80): "    bluetoothd[5349]: profiles/audio/bap.c:bap_state() stream 0x60b000039a30: config(1) -> qos(2)"
111: B1 Line exceeds max length (109>80): "    bluetoothd[5349]: profiles/audio/bap.c:bap_create_io() ep 0x60b0000392a0 stream 0x60b000039a30 defer true"
112: B1 Line exceeds max length (93>80): "    bluetoothd[5349]: src/shared/bap.c:bt_bap_stream_io_get_qos() in (nil) out 0x60b000039a68"
113: B1 Line exceeds max length (111>80): "    bluetoothd[5349]: profiles/audio/transport.c:bap_state_changed() stream 0x60b000039a30: config(1) -> qos(2)"
114: B1 Line exceeds max length (164>80): "    bluetoothd[5349]: profiles/audio/transport.c:transport_update_playing() /org/bluez/hci0/dev_C8_3D_D1_FE_CA_67/pac_sink0/fd0 State=TRANSPORT_STATE_IDLE Playing=0"
115: B1 Line exceeds max length (84>80): "    bluetoothd[5349]: profiles/gap/gas.c:read_appearance_cb() GAP Appearance: 0x0000"
124: B1 Line exceeds max length (99>80): "    bluetoothd[5349]: src/shared/gatt-client.c:db_hash_read_cb() DB Hash found: handle 0x0008 lengt"
125: B1 Line exceeds max length (98>80): "    bluetoothd[5349]: src/shared/gatt-client.c:db_hash_read_cb() DB Hash match: skipping discovery"
126: B1 Line exceeds max length (99>80): "    bluetoothd[5349]: src/shared/gatt-client.c:write_client_features() Writing Client Features 0x05"
127: B1 Line exceeds max length (83>80): "    bluetoothd[5349]: src/device.c:gatt_client_ready_cb() status: success, error: 0"
128: B1 Line exceeds max length (81>80): "    bluetoothd[5349]: src/gatt-client.c:btd_gatt_client_ready() GATT client ready"
130: B1 Line exceeds max length (112>80): "    bluetoothd[5349]: src/gatt-client.c:create_services() Exporting objects for GATT services: C8:3D:D1:FE:CA:67"
131: B1 Line exceeds max length (129>80): "    bluetoothd[5349]: src/gatt-client.c:service_create() Exported GATT service: /org/bluez/hci0/dev_C8_3D_D1_FE_CA_67/service0001"
132: B1 Line exceeds max length (152>80): "    bluetoothd[5349]: src/gatt-client.c:characteristic_create() Exported GATT characteristic: /org/bluez/hci0/dev_C8_3D_D1_FE_CA_67/service0001/char0002"
133: B1 Line exceeds max length (168>80): "    bluetoothd[5349]: src/gatt-client.c:descriptor_create() Exported GATT characteristic descriptor: /org/bluez/hci0/dev_C8_3D_D1_FE_CA_67/service0001/char0002/desc0004"
134: B1 Line exceeds max length (152>80): "    bluetoothd[5349]: src/gatt-client.c:characteristic_create() Exported GATT characteristic: /org/bluez/hci0/dev_C8_3D_D1_FE_CA_67/service0001/char0005"
135: B1 Line exceeds max length (152>80): "    bluetoothd[5349]: src/gatt-client.c:characteristic_create() Exported GATT characteristic: /org/bluez/hci0/dev_C8_3D_D1_FE_CA_67/service0001/char0007"
136: B1 Line exceeds max length (129>80): "    bluetoothd[5349]: src/gatt-client.c:service_create() Exported GATT service: /org/bluez/hci0/dev_C8_3D_D1_FE_CA_67/service0022"
137: B1 Line exceeds max length (152>80): "    bluetoothd[5349]: src/gatt-client.c:characteristic_create() Exported GATT characteristic: /org/bluez/hci0/dev_C8_3D_D1_FE_CA_67/service0022/char0023"
138: B1 Line exceeds max length (168>80): "    bluetoothd[5349]: src/gatt-client.c:descriptor_create() Exported GATT characteristic descriptor: /org/bluez/hci0/dev_C8_3D_D1_FE_CA_67/service0022/char0023/desc0025"
139: B1 Line exceeds max length (152>80): "    bluetoothd[5349]: src/gatt-client.c:characteristic_create() Exported GATT characteristic: /org/bluez/hci0/dev_C8_3D_D1_FE_CA_67/service0022/char0026"
140: B1 Line exceeds max length (152>80): "    bluetoothd[5349]: src/gatt-client.c:characteristic_create() Exported GATT characteristic: /org/bluez/hci0/dev_C8_3D_D1_FE_CA_67/service0022/char0028"
141: B1 Line exceeds max length (168>80): "    bluetoothd[5349]: src/gatt-client.c:descriptor_create() Exported GATT characteristic descriptor: /org/bluez/hci0/dev_C8_3D_D1_FE_CA_67/service0022/char0028/desc002a"
143: B1 Line exceeds max length (84>80): "    bluetoothd[5349]: src/gatt-client.c:btd_gatt_client_ready() Update Features 0x05"
144: B1 Line exceeds max length (100>80): "    bluetoothd[5349]: src/device.c:device_svc_resolved() /org/bluez/hci0/dev_C8_3D_D1_FE_CA_67 err 0"
150: B1 Line exceeds max length (99>80): "    bluetoothd[5349]: src/shared/gatt-client.c:service_changed_register_cb() Registered handler for"
152: B1 Line exceeds max length (98>80): "    bluetoothd[5349]: profiles/audio/transport.c:media_owner_create() Owner created: sender=:1.146"
153: B1 Line exceeds max length (99>80): "    bluetoothd[5349]: src/shared/bap.c:bap_queue_req() req 0x60600001cee0 (op 0x03) queue 0x6030000"
154: B1 Line exceeds max length (188>80): "    bluetoothd[5349]: profiles/audio/transport.c:transport_set_state() State changed /org/bluez/hci0/dev_C8_3D_D1_FE_CA_67/pac_sink0/fd0: TRANSPORT_STATE_IDLE -> TRANSPORT_STATE_REQUESTING"
155: B1 Line exceeds max length (108>80): "    bluetoothd[5349]: profiles/audio/transport.c:media_request_create() Request created: method=Acquire id=3"
156: B1 Line exceeds max length (95>80): "    bluetoothd[5349]: profiles/audio/transport.c:media_owner_add() Owner :1.146 Request Acquire"
157: B1 Line exceeds max length (151>80): "    bluetoothd[5349]: profiles/audio/transport.c:media_transport_set_owner() Transport /org/bluez/hci0/dev_C8_3D_D1_FE_CA_67/pac_sink0/fd0 Owner :1.146"
160: B1 Line exceeds max length (99>80): "    bluetoothd[5349]: src/shared/att.c:can_read_data() (chan 0x607000008bb0) ATT PDU received: 0x1b"
163: B1 Line exceeds max length (99>80): "    bluetoothd[5349]: src/shared/att.c:can_read_data() (chan 0x607000008bb0) ATT PDU received: 0x1b"
164: B1 Line exceeds max length (99>80): "    bluetoothd[5349]: src/shared/bap.c:bap_ep_set_status() ASE status: ep 0x603000026980 id 0x01 ha"
165: B1 Line exceeds max length (92>80): "    bluetoothd[5349]: src/shared/bap.c:ep_status_metadata() CIS 0x00 CIG 0x00 metadata len 4"
166: B1 Line exceeds max length (99>80): "    bluetoothd[5349]: src/shared/bap.c:bap_stream_state_changed() stream 0x60b000039a30 dir 0x01: q"
167: B1 Line exceeds max length (99>80): "    bluetoothd[5349]: profiles/audio/bap.c:bap_state() stream 0x60b000039a30: qos(2) -> enabling(3)"
168: B1 Line exceeds max length (110>80): "    bluetoothd[5349]: profiles/audio/bap.c:bap_create_io() ep 0x60b0000392a0 stream 0x60b000039a30 defer false"
169: B1 Line exceeds max length (93>80): "    bluetoothd[5349]: src/shared/bap.c:bt_bap_stream_io_get_qos() in (nil) out 0x60b000039a68"
170: B1 Line exceeds max length (97>80): "    bluetoothd[5349]: profiles/audio/bap.c:bap_accept_io() stream 0x60b000039a30 fd 32 defer true"
180: B1 Line exceeds max length (131>80): "    kernel: hci0 hci_conn_hash_lookup_cis: c:00000000ece7f209 c->dst:c8:3d:d1:fe:ca:67 c->dst_type:0 ba:c8:3d:d1:fe:ca:67 ba_type:1"
198: B1 Line exceeds max length (86>80): "    bluetoothd[5349]: profiles/audio/bap.c:bap_accept_io() read: Invalid argument (22)"


##############################
Test: TestRunner: mgmt-tester - FAIL - 95.00 seconds
Run test-runner with mgmt-tester
Total: 494, Passed: 492 (99.6%), Failed: 2, Not Run: 0

Failed Test Cases
Set Static Address - Success 1                       Timed out    2.376 seconds
Set Static Address - Success 2                       Timed out    2.000 seconds



---
Regards,
Linux Bluetooth


--===============7945168459136696711==--
