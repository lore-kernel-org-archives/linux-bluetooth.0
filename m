Return-Path: <SRS0=lrWy=7U=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5795EC433E0
	for <linux-bluetooth@archiver.kernel.org>; Sun,  7 Jun 2020 14:07:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 219D5206A4
	for <linux-bluetooth@archiver.kernel.org>; Sun,  7 Jun 2020 14:07:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KiAakIaD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726610AbgFGOHR (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 7 Jun 2020 10:07:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726528AbgFGOHR (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 7 Jun 2020 10:07:17 -0400
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF87CC08C5C3
        for <linux-bluetooth@vger.kernel.org>; Sun,  7 Jun 2020 07:07:16 -0700 (PDT)
Received: by mail-qv1-xf36.google.com with SMTP id fc4so7129562qvb.1
        for <linux-bluetooth@vger.kernel.org>; Sun, 07 Jun 2020 07:07:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=DUGrTmjWXNCekg19OvZtOevfQ1w6D2rg0uc7xHMTZXI=;
        b=KiAakIaD4+Hgnk4PVoFFiXEGaeHoRJsAtZ86aqhzembxjdpx1oEbl7+xVeqz3AB16E
         k2tyTJ/ilZBcUeJBo6JYdGbXo4sRNrRi5uhP6X/ejxw0QHzN2xbh7QbaIn9ljTzjnGTm
         ENLxU7YTLcc7j8VOtR3UINrSQLH9on49kYGS+Gy1QNECZbzy/9a4jfKXA6oj/3zajDmC
         ibyG8YNaxZM5F6YOy5Wh3YV1SmIL6nkJ68EksieEodGTP+8z7XBad1wHExA7C/jH6J77
         Pmm7px6b7oZd93Aiqwoxg62lMTs1yHPjCSmELIYGBBwwQw1rJAHIriGM5GIMZBm+WDl4
         O7Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=DUGrTmjWXNCekg19OvZtOevfQ1w6D2rg0uc7xHMTZXI=;
        b=s9KiG0A7AbTDqYE2JCB7U3Tb+8k61R08NlHzyfh+bis2HZMlc0b4aW498VVW4SirY9
         5JmT27SkmwbPS0dUXCkh0F5BC99r62uy4IQeaYkDDwdZGp+dVLrrc3xyCH+oE3jVLHBP
         9kl7b78GuaB/FVWWCpN6YDtBglhxE5kooqpWt6gylDbndxUMABgnfSbxsNxo4eJiDJ+c
         8Jduh1ZGDEyhjTSV3g6O8QYpR/3LXl1oNZCDMGo+i6sBOEU/WLPaTg3UFbnZ5p9vURdV
         2HVR2+T7ZweAZG9NrMZITFb5M4vihPQ/YxUz6mMs3CihjkLnVgeU6FQqdHEerCG6+ivb
         ACcQ==
X-Gm-Message-State: AOAM531VcDksALcXiVj5w4bDoZxcSG9PGjW0LNSk+4vRinLgQeun/q7+
        Kh19l3ndmTaZx23UA7307DVYwBXWEu8=
X-Google-Smtp-Source: ABdhPJwdEgtrWebMx1GfArDwSKCoh15aCHCYCKFuULRZwteq9ZhABTuXhDSsyvslk2ndfxBMtEp+PA==
X-Received: by 2002:ad4:528d:: with SMTP id v13mr18734888qvr.90.1591538835442;
        Sun, 07 Jun 2020 07:07:15 -0700 (PDT)
Received: from [172.17.0.2] ([52.251.94.21])
        by smtp.gmail.com with ESMTPSA id z9sm4572833qkj.129.2020.06.07.07.07.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jun 2020 07:07:15 -0700 (PDT)
Message-ID: <5edcf493.1c69fb81.56076.9e91@mx.google.com>
Date:   Sun, 07 Jun 2020 07:07:15 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5255654027539686008=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, przemyslaw.fierek@silvair.com
Subject: RE: Segmentation fault in the mesh/node.c
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <116e6cc1-5a49-a833-689b-4f00880e455b@silvair.com>
References: <116e6cc1-5a49-a833-689b-4f00880e455b@silvair.com>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============5255654027539686008==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit


This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While we are preparing for reviewing the patches, we found the following
issue/warning.

Test Result:
checkgitlint Failed

Outputs:
16: B1 Line exceeds max length (90>80): "11:58:15  =================================== FAILURES ==================================="
17: B1 Line exceeds max length (90>80): "11:58:15  _______________________ test_remove_storage_after_leave ________________________"
19: B1 Line exceeds max length (105>80): "11:58:15  application = <bluez_tests.fixtures.application.<locals>._Application object at 0x7f0cf3fb1050>"
21: B1 Line exceeds max length (89>80): "11:58:15  node_storage = <class 'bluez_tests.fixtures.node_storage.<locals>.NodeStorage'>"
23: B1 Line exceeds max length (90>80): "11:58:15      async def test_remove_storage_after_leave(application, meshd, node_storage):"
28: B1 Line exceeds max length (86>80): "11:58:15          with node_storage() as storage, node_storage(backup=True) as backup:"
35: B1 Line exceeds max length (89>80): "11:58:15  _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _"
36: B1 Line exceeds max length (92>80): "11:58:15  /usr/local/lib/python3.7/dist-packages/bluetooth_mesh/application.py:721: in leave"
38: B1 Line exceeds max length (91>80): "11:58:15  /usr/local/lib/python3.7/dist-packages/bluetooth_mesh/interfaces.py:309: in leave"
40: B1 Line exceeds max length (95>80): "11:58:15  /usr/local/lib/python3.7/dist-packages/dbus_next/aio/proxy_object.py:79: in method_fn"
41: B1 Line exceeds max length (85>80): "11:58:15      BaseProxyInterface._check_method_return(msg, intr_method.out_signature)"
42: B1 Line exceeds max length (89>80): "11:58:15  _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _"
44: B1 Line exceeds max length (84>80): "11:58:15  msg = <dbus_next.message.Message object at 0x7f0cf41a8fd0>, signature = ''"
50: B1 Line exceeds max length (114>80): "11:58:15  E           dbus_next.errors.DBusError: Message recipient disconnected from message bus without replying"
52: B1 Line exceeds max length (88>80): "11:58:15  /usr/local/lib/python3.7/dist-packages/dbus_next/proxy_object.py:59: DBusError"
53: B1 Line exceeds max length (90>80): "11:58:15  ------------------------------ Captured log setup ------------------------------"
55: B1 Line exceeds max length (325>80): "11:58:15  09:58:06.393 MESHD                 INFO Starting: ['gosu', 'root', 'env', 'SEGFAULT_SIGNALS=abrt segv fpe', 'LD_PRELOAD=/lib/x86_64-linux-gnu/libSegFault.so', '/usr/libexec/bluetooth/bluetooth-meshd', '--config=/tmp/pytest-of-user/pytest-0/test_remove_storage_after_leav0/config', '--io=tcpserver:65254', '--debug']"
56: B1 Line exceeds max length (130>80): "11:58:15  09:58:06.402 MESHD.stderr          INFO 2020-06-05 09:58:06.399       main.c:126  ready_callback             D-Bus ready"
57: B1 Line exceeds max length (139>80): "11:58:15  09:58:06.402 MESHD.stderr          INFO 2020-06-05 09:58:06.399       main.c:107  request_name_callback      Request name success"
58: B1 Line exceeds max length (218>80): "11:58:15  09:58:06.402 MESHD.stderr          INFO 2020-06-05 09:58:06.399       mesh.c:276  mesh_init                  Loading node configuration from /tmp/pytest-of-user/pytest-0/test_remove_storage_after_leav0/config"
62: B1 Line exceeds max length (150>80): "11:58:15  09:58:06.409 MESHD.stderr          INFO 2020-06-05 09:58:06.403 mesh-io-tcpserver.c:435  tls_ctx_init               TLS initialization: done"
63: B1 Line exceeds max length (169>80): "11:58:15  09:58:06.409 MESHD.stderr          INFO 2020-06-05 09:58:06.403 mesh-io-tcpserver.c:234  get_fd_info                Server bind -> addr:0.0.0.0 port:65254 fd:6"
64: B1 Line exceeds max length (156>80): "11:58:15  09:58:06.409 MESHD.stderr          INFO 2020-06-05 09:58:06.403 mesh-io-tcpserver.c:580  tcpserver_io_init          Started mesh on tcp port 65254"
65: B1 Line exceeds max length (160>80): "11:58:15  09:58:06.409 MESHD.stderr          INFO 2020-06-05 09:58:06.403       mesh.c:296  mesh_init                  mesh/mesh.c:mesh_init() io 0x56413d49e9c0"
66: B1 Line exceeds max length (161>80): "11:58:15  09:58:06.410 MESHD.stderr          INFO 2020-06-05 09:58:06.404       mesh.c:881  mesh_dbus_init             Added Network Interface on /org/bluez/mesh"
69: B1 Line exceeds max length (90>80): "11:58:15  ------------------------------ Captured log call -------------------------------"
70: B1 Line exceeds max length (94>80): "11:58:15  09:58:06.434 APPLICATION         WARNING Import 83bf3b46-8103-45a2-8bcc-e70d8d0b46d3"
71: B1 Line exceeds max length (170>80): "11:58:15  09:58:06.436 MESHD.stderr          INFO 2020-06-05 09:58:06.435       mesh.c:778  import_call                mesh/mesh.c:import_call() Import local node request"
72: B1 Line exceeds max length (144>80): "11:58:15  09:58:06.437 MESHD.stderr          INFO 2020-06-05 09:58:06.435       node.c:1720 node_import                mesh/node.c:node_import()"
73: B1 Line exceeds max length (147>80): "11:58:15  09:58:06.437 MESHD.stderr          INFO 2020-06-05 09:58:06.435       node.c:267  node_new                   new elements: 0x56413d4ca930"
74: B1 Line exceeds max length (181>80): "11:58:15  09:58:06.438 MESHD.stderr          INFO 2020-06-05 09:58:06.438       node.c:1283 get_app_properties         mesh/node.c:get_app_properties() path /com/silvair/application"
75: B1 Line exceeds max length (194>80): "11:58:15  09:58:06.438 MESHD.stderr          INFO 2020-06-05 09:58:06.438       node.c:1129 get_element_properties     mesh/node.c:get_element_properties() path /com/silvair/application/element0"
76: B1 Line exceeds max length (151>80): "11:58:15  09:58:06.439 MESHD.stderr          INFO 2020-06-05 09:58:06.438       node.c:1214 convert_node_to_storage    db_node->elements 0x56413d4c9840"
77: B1 Line exceeds max length (296>80): "11:58:15  09:58:06.440 MESHD.stderr          INFO 2020-06-05 09:58:06.438 mesh-config-json.c:1706 mesh_config_create         mesh/mesh-config-json.c:mesh_config_create() New node config /tmp/pytest-of-user/pytest-0/test_remove_storage_after_leav0/config/83bf3b46810345a28bcce70d8d0b46d3/node.json"
78: B1 Line exceeds max length (201>80): "11:58:15  09:58:06.450 MESHD.stderr          INFO 2020-06-05 09:58:06.450   net-keys.c:493  net_key_beacon_refresh     mesh/net-keys.c:net_key_beacon_refresh() Setting SNB: IVI: 00000000, IVU: 0, KR: 0"
79: B1 Line exceeds max length (221>80): "11:58:15  09:58:06.451 MESHD.stderr          INFO 2020-06-05 09:58:06.450       util.c:52   print_packet               mesh/util.c:print_packet() 51086.450 Set SNB Beacon to: 2b01003ecaff672f67337000000000a502cffc80248d4c"
80: B1 Line exceeds max length (186>80): "11:58:15  09:58:06.451 MESHD.stderr          INFO 2020-06-05 09:58:06.450 mesh-config-json.c:565  mesh_config_net_key_add    mesh/mesh-config-json.c:mesh_config_net_key_add() netKey 0000"
81: B1 Line exceeds max length (185>80): "11:58:15  09:58:06.451 MESHD.stderr          INFO 2020-06-05 09:58:06.451        net.c:778  mesh_net_set_friend_mode   mesh/net.c:mesh_net_set_friend_mode() mesh_net_set_friend_mode - 0"
82: B1 Line exceeds max length (179>80): "11:58:15  09:58:06.452 MESHD.stderr          INFO 2020-06-05 09:58:06.451        net.c:292  trigger_heartbeat          mesh/net.c:trigger_heartbeat() trigger_heartbeat: 0001 --> 0"
83: B1 Line exceeds max length (166>80): "11:58:15  09:58:06.453 MESHD.stderr          INFO 2020-06-05 09:58:06.453 cfgmod-server.c:1263 cfgmod_server_init         mesh/cfgmod-server.c:cfgmod_server_init() 00"
84: B1 Line exceeds max length (183>80): "11:58:15  09:58:06.454 MESHD.stderr          INFO 2020-06-05 09:58:06.453       mesh.c:712  create_node_ready_cb       mesh/mesh.c:create_node_ready_cb() Calling JoinComplete (create)"
85: B1 Line exceeds max length (160>80): "11:58:15  09:58:06.461 STORAGE               INFO /tmp/pytest-of-user/pytest-0/test_remove_storage_after_leav0/config/83bf3b46810345a28bcce70d8d0b46d3/node.json"
86: B1 Line exceeds max length (164>80): "11:58:15  09:58:06.468 STORAGE               INFO /tmp/pytest-of-user/pytest-0/test_remove_storage_after_leav0/config/83bf3b46810345a28bcce70d8d0b46d3/node.json.bak"
88: B1 Line exceeds max length (149>80): "11:58:15  09:58:06.475 MESHD.stderr          INFO 2020-06-05 09:58:06.475       mesh.c:659  leave_call                 mesh/mesh.c:leave_call() Leave"
89: B1 Line exceeds max length (294>80): "11:58:15  09:58:06.475 MESHD.stderr          INFO 2020-06-05 09:58:06.475 mesh-config-json.c:2329 mesh_config_destroy_nvm    mesh/mesh-config-json.c:mesh_config_destroy_nvm() Delete node config /tmp/pytest-of-user/pytest-0/test_remove_storage_after_leav0/config/83bf3b46810345a28bcce70d8d0b46d3"
90: B1 Line exceeds max length (262>80): "11:58:15  09:58:06.476 MESHD.stderr          INFO 2020-06-05 09:58:06.476       util.c:151  del_fobject                mesh/util.c:del_fobject() RM /tmp/pytest-of-user/pytest-0/test_remove_storage_after_leav0/config/83bf3b46810345a28bcce70d8d0b46d3/node.json.bak"
91: B1 Line exceeds max length (258>80): "11:58:15  09:58:06.477 MESHD.stderr          INFO 2020-06-05 09:58:06.476       util.c:151  del_fobject                mesh/util.c:del_fobject() RM /tmp/pytest-of-user/pytest-0/test_remove_storage_after_leav0/config/83bf3b46810345a28bcce70d8d0b46d3/node.json"
92: B1 Line exceeds max length (251>80): "11:58:15  09:58:06.477 MESHD.stderr          INFO 2020-06-05 09:58:06.476       util.c:145  del_fobject                mesh/util.c:del_fobject() RMDIR /tmp/pytest-of-user/pytest-0/test_remove_storage_after_leav0/config/83bf3b46810345a28bcce70d8d0b46d3"
93: B1 Line exceeds max length (139>80): "11:58:15  09:58:06.477 MESHD.stderr          INFO 2020-06-05 09:58:06.476       node.c:296  free_node_dbus_resources   Node: 0x56413d4cadb0"
94: B1 Line exceeds max length (143>80): "11:58:15  09:58:06.477 MESHD.stderr          INFO 2020-06-05 09:58:06.476       node.c:306  free_node_dbus_resources   elements: 0x56413d4ca930"
95: B1 Line exceeds max length (159>80): "11:58:15  09:58:06.478 MESHD.stderr          INFO 2020-06-05 09:58:06.476       node.c:278  free_element_path          el: 0x56413d49f3d0, path: 0x56413d4cac50"
96: B1 Line exceeds max length (123>80): "11:58:15  09:58:06.478 MESHD.stderr          INFO 2020-06-05 09:58:06.476       node.c:343  free_node_resources        log1"
97: B1 Line exceeds max length (123>80): "11:58:15  09:58:06.478 MESHD.stderr          INFO 2020-06-05 09:58:06.476       node.c:345  free_node_resources        log2"
98: B1 Line exceeds max length (123>80): "11:58:15  09:58:06.479 MESHD.stderr          INFO 2020-06-05 09:58:06.476       node.c:347  free_node_resources        log3"
99: B1 Line exceeds max length (123>80): "11:58:15  09:58:06.479 MESHD.stderr          INFO 2020-06-05 09:58:06.477       node.c:353  free_node_resources        log4"
100: B1 Line exceeds max length (142>80): "11:58:15  09:58:06.479 MESHD.stderr          INFO 2020-06-05 09:58:06.477       node.c:2414 node_finalize_new_node     Nnnnode: 0x56413d4cadb0"
101: B1 Line exceeds max length (139>80): "11:58:15  09:58:06.479 MESHD.stderr          INFO 2020-06-05 09:58:06.477       node.c:296  free_node_dbus_resources   Node: 0x56413d4cadb0"
102: B1 Line exceeds max length (143>80): "11:58:15  09:58:06.480 MESHD.stderr          INFO 2020-06-05 09:58:06.477       node.c:306  free_node_dbus_resources   elements: 0x56413d498010"
106: B1 Line exceeds max length (120>80): "11:58:15  09:58:06.481 MESHD.registers      DEBUG  RAX: 0000000000000000   RBX: 0005000600070007   RCX: 0000000000000000"
107: B1 Line exceeds max length (120>80): "11:58:15  09:58:06.481 MESHD.registers      DEBUG  RDX: 0000000000000000   RSI: 000056413c31ba70   RDI: 000056413d498010"
108: B1 Line exceeds max length (120>80): "11:58:15  09:58:06.481 MESHD.registers      DEBUG  RBP: 000056413c31ba70   R8 : 0000000000000019   R9 : 0000000000000019"
109: B1 Line exceeds max length (120>80): "11:58:15  09:58:06.481 MESHD.registers      DEBUG  R10: 000056413c37a2ae   R11: 0000000000000246   R12: 0000000000000000"
110: B1 Line exceeds max length (120>80): "11:58:15  09:58:06.482 MESHD.registers      DEBUG  R13: 000056413d4cdf20   R14: 000056413d49e1a0   R15: 0000000000000001"
113: B1 Line exceeds max length (91>80): "11:58:15  09:58:06.482 MESHD.registers      DEBUG  RIP: 000056413c347330   EFLAGS: 00010202"
115: B1 Line exceeds max length (81>80): "11:58:15  09:58:06.483 MESHD.registers      DEBUG  CS: 0033   FS: 0000   GS: 0000"
117: B1 Line exceeds max length (119>80): "11:58:15  09:58:06.483 MESHD.registers      DEBUG  Trap: 0000000d   Error: 00000000   OldMask: 00004002   CR2: 00000000"
119: B1 Line exceeds max length (100>80): "11:58:15  09:58:06.484 MESHD.registers      DEBUG  FPUCW: 0000037f   FPUSW: 00000000   TAG: 00000000"
122: B1 Line exceeds max length (108>80): "11:58:15  09:58:06.485 MESHD.registers      DEBUG  ST(0) 0000 0000000000000000   ST(1) 0000 0000000000000000"
123: B1 Line exceeds max length (108>80): "11:58:15  09:58:06.485 MESHD.registers      DEBUG  ST(2) 0000 0000000000000000   ST(3) 0000 0000000000000000"
124: B1 Line exceeds max length (108>80): "11:58:15  09:58:06.485 MESHD.registers      DEBUG  ST(4) 0000 0000000000000000   ST(5) 0000 0000000000000000"
125: B1 Line exceeds max length (108>80): "11:58:15  09:58:06.485 MESHD.registers      DEBUG  ST(6) 0000 0000000000000000   ST(7) 0000 0000000000000000"
127: B1 Line exceeds max length (130>80): "11:58:15  09:58:06.486 MESHD.registers      DEBUG  XMM0:  00000000000000000000000000ffff00 XMM1:  00000000000000000000000000ffff00"
128: B1 Line exceeds max length (130>80): "11:58:15  09:58:06.486 MESHD.registers      DEBUG  XMM2:  00000000000000000000000000ffff00 XMM3:  00000000000000000000000000ffff00"
129: B1 Line exceeds max length (130>80): "11:58:15  09:58:06.486 MESHD.registers      DEBUG  XMM4:  00000000000000000000000000ffff00 XMM5:  00000000000000000000000000ffff00"
130: B1 Line exceeds max length (130>80): "11:58:15  09:58:06.487 MESHD.registers      DEBUG  XMM6:  00000000000000000000000000ffff00 XMM7:  00000000000000000000000000ffff00"
131: B1 Line exceeds max length (130>80): "11:58:15  09:58:06.487 MESHD.registers      DEBUG  XMM8:  00000000000000000000000000ffff00 XMM9:  00000000000000000000000000ffff00"
132: B1 Line exceeds max length (130>80): "11:58:15  09:58:06.487 MESHD.registers      DEBUG  XMM10: 00000000000000000000000000ffff00 XMM11: 00000000000000000000000000ffff00"
133: B1 Line exceeds max length (130>80): "11:58:15  09:58:06.487 MESHD.registers      DEBUG  XMM12: 00000000000000000000000000ffff00 XMM13: 00000000000000000000000000ffff00"
134: B1 Line exceeds max length (130>80): "11:58:15  09:58:06.487 MESHD.registers      DEBUG  XMM14: 00000000000000000000000000ffff00 XMM15: 00000000000000000000000000ffff00"
137: B1 Line exceeds max length (116>80): "11:58:15  09:58:06.509 MESHD.backtrace       INFO l_queue_foreach /home/user/bluez/ell/queue.c:441 (discriminator 3)"
139: B1 Line exceeds max length (113>80): "11:58:15  09:58:06.510 MESHD.backtrace      DEBUG  440:     for (entry = queue->head; entry; entry = entry->next)"
140: B1 Line exceeds max length (97>80): "11:58:15  09:58:06.511 MESHD.backtrace      DEBUG  441:         function(entry->data, user_data);"



---
Regards,
Linux Bluetooth

--===============5255654027539686008==--
