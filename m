Return-Path: <SRS0=XILz=C2=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFEF9C43463
	for <linux-bluetooth@archiver.kernel.org>; Thu, 17 Sep 2020 21:51:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8441F2075B
	for <linux-bluetooth@archiver.kernel.org>; Thu, 17 Sep 2020 21:51:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bjdAcii3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726002AbgIQVvp (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 17 Sep 2020 17:51:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725858AbgIQVvp (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 17 Sep 2020 17:51:45 -0400
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE00DC06174A
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Sep 2020 14:51:44 -0700 (PDT)
Received: by mail-qv1-xf2f.google.com with SMTP id ef16so1807763qvb.8
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Sep 2020 14:51:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=1dy9pId6C6wOeNWf4V5IzS0StCIiVpbomRAUrnj/khM=;
        b=bjdAcii3Gjvw8KxrI15xjWTo+8TH0sW5i/OssaHBrv5aB6kbJJuimX1dVY52ERbb7d
         l4wBtC8VqsQXu9gaph9rdH7y+9BngUnsweaGMWMCdOrYnI0zCi3j6qC4ImmOz5yQzk12
         uI+X0dKHcuGwgXJmggeIYwkj9M6wnBnmefGtm23HKbCrKJSeSw23AFBXDQll++psyir5
         VEkga9S1FeIhLif4Y0mKownMX1MKcoD/5sFqFwHLJt94wfMutKUDkYS5BV6ihqsjVx/8
         mhjPZYSCFl9LGg076+cIQg0kNtwf8tXFx48MnASrpt0B7OTUUXKX9vLGT6cP750/HBGz
         3SdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=1dy9pId6C6wOeNWf4V5IzS0StCIiVpbomRAUrnj/khM=;
        b=qKvqUssRXJLLdclWRvkJuixY4KmTzlVdpw5+rmPNCB+V6wdWmnYEWCI6Tm6la47CbM
         GVMFQp0KxSaUDAX+hm6xhYeD7KXo/dZUTCu43qPjC/na8P9uckDQ9YQwmoaT+k6mgI4r
         ErdCKflA/iMzR+xsd+SiU63HagmNQjY4P+EW+hJaIObZeR6MGRNe3HAvErOMKzqV2uDA
         gStj7On1DFCGeuRnLHzbFFSsTRh3EdvXBxXBdA+YNeOAJzqF1/VCMdXm9mQxpVNx45cl
         zHI4tEP7bgjOYPcAjZyCwdbVWdlE8Tw8PLt5okfZ0sDMDtkZ1FdQ4RqFIJfCoxa8us1X
         pYSA==
X-Gm-Message-State: AOAM53021kq5mD5RDEYxYLoSBWVEukkJFq/cPh4vp1cF5loJ9LtqF4ea
        2MivUA45ElueaB0Uyv/CcS+UCjRuLcNAfw==
X-Google-Smtp-Source: ABdhPJwU+2vFKUNvlOXXWpT9NwtTFQgBjfz1rn0ngAUBJV+s7IGBXEl7lUjXzg/KAcZSmmGzjcGJLA==
X-Received: by 2002:a0c:f54e:: with SMTP id p14mr27098773qvm.28.1600379503162;
        Thu, 17 Sep 2020 14:51:43 -0700 (PDT)
Received: from [172.17.0.2] ([20.186.152.21])
        by smtp.gmail.com with ESMTPSA id s10sm762071qkg.61.2020.09.17.14.51.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2020 14:51:42 -0700 (PDT)
Message-ID: <5f63da6e.1c69fb81.9de0.5489@mx.google.com>
Date:   Thu, 17 Sep 2020 14:51:42 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4429390691823547765=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, mcchou@chromium.org
Subject: RE: [BlueZ,v4,1/8] adv_monitor: Implement RSSI Filter logic for background scanning
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20200917142456.BlueZ.v4.1.I2830b9c1212a64b062201ed9f2b71294f50ad22d@changeid>
References: <20200917142456.BlueZ.v4.1.I2830b9c1212a64b062201ed9f2b71294f50ad22d@changeid>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============4429390691823547765==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit


This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While we are preparing for reviewing the patches, we found the following
issue/warning.

Test Result:
checkbuild Failed

Outputs:
ar: `u' modifier ignored since `D' is the default (see `U')
ar: `u' modifier ignored since `D' is the default (see `U')
ar: `u' modifier ignored since `D' is the default (see `U')
ar: `u' modifier ignored since `D' is the default (see `U')
ar: `u' modifier ignored since `D' is the default (see `U')
/usr/bin/ld: src/adv_monitor.o: in function `app_destroy':
/github/workspace/src/adv_monitor.c:245: undefined reference to `btd_error_failed'
/usr/bin/ld: src/adv_monitor.o: in function `app_reply_msg':
/github/workspace/src/adv_monitor.c:175: undefined reference to `btd_get_dbus_connection'
/usr/bin/ld: src/adv_monitor.o: in function `unregister_monitor':
/github/workspace/src/adv_monitor.c:908: undefined reference to `btd_error_invalid_args'
/usr/bin/ld: /github/workspace/src/adv_monitor.c:914: undefined reference to `btd_error_does_not_exist'
/usr/bin/ld: src/adv_monitor.o: in function `register_monitor':
/github/workspace/src/adv_monitor.c:869: undefined reference to `btd_error_invalid_args'
/usr/bin/ld: /github/workspace/src/adv_monitor.c:874: undefined reference to `btd_error_already_exists'
/usr/bin/ld: /github/workspace/src/adv_monitor.c:881: undefined reference to `btd_error_failed'
/usr/bin/ld: src/adv_monitor.o: in function `manager_destroy':
/github/workspace/src/adv_monitor.c:1093: undefined reference to `adapter_get_path'
/usr/bin/ld: /github/workspace/src/adv_monitor.c:1093: undefined reference to `btd_get_dbus_connection'
/usr/bin/ld: src/adv_monitor.o: in function `app_reply_msg':
/github/workspace/src/adv_monitor.c:175: undefined reference to `btd_get_dbus_connection'
/usr/bin/ld: src/adv_monitor.o: in function `manager_new':
/github/workspace/src/adv_monitor.c:1067: undefined reference to `btd_adapter_get_index'
/usr/bin/ld: src/adv_monitor.o: in function `btd_adv_monitor_manager_create':
/github/workspace/src/adv_monitor.c:1147: undefined reference to `adapter_get_path'
/usr/bin/ld: /github/workspace/src/adv_monitor.c:1147: undefined reference to `btd_get_dbus_connection'
/usr/bin/ld: src/device.o: in function `store_device_info_cb':
/github/workspace/src/device.c:403: undefined reference to `ba2str'
/usr/bin/ld: /github/workspace/src/device.c:404: undefined reference to `btd_adapter_get_storage_dir'
/usr/bin/ld: /github/workspace/src/device.c:479: undefined reference to `create_file'
/usr/bin/ld: src/device.o: in function `browse_request_free':
/github/workspace/src/device.c:562: undefined reference to `sdp_record_free'
/usr/bin/ld: /github/workspace/src/device.c:562: undefined reference to `sdp_list_free'
/usr/bin/ld: src/device.o: in function `service_prio_cmp':
/github/workspace/src/device.c:1929: undefined reference to `btd_service_get_profile'
/usr/bin/ld: /github/workspace/src/device.c:1930: undefined reference to `btd_service_get_profile'
/usr/bin/ld: src/device.o: in function `find_service_with_uuid':
/github/workspace/src/device.c:343: undefined reference to `btd_service_get_profile'
/usr/bin/ld: /github/workspace/src/device.c:345: undefined reference to `bt_uuid_strcmp'
/usr/bin/ld: src/device.o: in function `disconnect_gatt_service':
/github/workspace/src/device.c:5075: undefined reference to `btd_service_get_profile'
/usr/bin/ld: src/device.o: in function `device_disappeared':
/github/workspace/src/device.c:4281: undefined reference to `btd_adapter_remove_device'
/usr/bin/ld: src/device.o: in function `store_service':
/github/workspace/src/device.c:2447: undefined reference to `bt_uuid_to_string'
/usr/bin/ld: src/device.o: in function `store_chrc':
/github/workspace/src/device.c:2365: undefined reference to `bt_uuid_to_string'
/usr/bin/ld: /github/workspace/src/device.c:2368: undefined reference to `bt_uuid16_create'
/usr/bin/ld: /github/workspace/src/device.c:2369: undefined reference to `bt_uuid_cmp'
/usr/bin/ld: src/device.o: in function `store_desc':
/github/workspace/src/device.c:2337: undefined reference to `bt_uuid_to_string'
/usr/bin/ld: /github/workspace/src/device.c:2339: undefined reference to `bt_uuid16_create'
/usr/bin/ld: /github/workspace/src/device.c:2340: undefined reference to `bt_uuid_cmp'
/usr/bin/ld: src/device.o: in function `store_incl':
/github/workspace/src/device.c:2422: undefined reference to `bt_uuid_to_string'
/usr/bin/ld: src/device.o: in function `dev_property_get_adapter':
/github/workspace/src/device.c:1224: undefined reference to `adapter_get_path'
/usr/bin/ld: src/device.o: in function `dev_property_get_alias':
/github/workspace/src/device.c:812: undefined reference to `ba2str'
/usr/bin/ld: src/device.o: in function `dev_property_get_address':
/github/workspace/src/device.c:758: undefined reference to `ba2str'
/usr/bin/ld: src/device.o: in function `append_service_data':
/github/workspace/src/device.c:1278: undefined reference to `bt_uuid_to_string'
/usr/bin/ld: /github/workspace/src/device.c:1280: undefined reference to `dict_append_array'
/usr/bin/ld: src/device.o: in function `bonding_request_free':
/github/workspace/src/device.c:2741: undefined reference to `agent_cancel'
/usr/bin/ld: /github/workspace/src/device.c:2742: undefined reference to `agent_unref'
/usr/bin/ld: src/device.o: in function `select_conn_bearer':
/github/workspace/src/device.c:2098: undefined reference to `btd_adapter_get_bredr'
/usr/bin/ld: src/device.o: in function `new_auth':
/github/workspace/src/device.c:6350: undefined reference to `ba2str'
/usr/bin/ld: /github/workspace/src/device.c:6359: undefined reference to `agent_ref'
/usr/bin/ld: /github/workspace/src/device.c:6361: undefined reference to `agent_get'
/usr/bin/ld: src/device.o: in function `store_services':
/github/workspace/src/device.c:2251: undefined reference to `sdp_uuid16_create'
/usr/bin/ld: /github/workspace/src/device.c:2252: undefined reference to `bt_uuid2string'
/usr/bin/ld: /github/workspace/src/device.c:2256: undefined reference to `ba2str'
/usr/bin/ld: /github/workspace/src/device.c:2258: undefined reference to `btd_adapter_get_storage_dir'
/usr/bin/ld: /github/workspace/src/device.c:2270: undefined reference to `bt_string2uuid'
/usr/bin/ld: /github/workspace/src/device.c:2271: undefined reference to `sdp_uuid128_to_uuid'
/usr/bin/ld: /github/workspace/src/device.c:2297: undefined reference to `create_file'
/usr/bin/ld: src/device.o: in function `device_set_auto_connect':
/github/workspace/src/device.c:1674: undefined reference to `ba2str'
/usr/bin/ld: /github/workspace/src/device.c:1691: undefined reference to `adapter_auto_connect_add'
/usr/bin/ld: /github/workspace/src/device.c:1698: undefined reference to `adapter_connect_list_add'
/usr/bin/ld: /github/workspace/src/device.c:1685: undefined reference to `adapter_connect_list_remove'
/usr/bin/ld: /github/workspace/src/device.c:1686: undefined reference to `adapter_auto_connect_remove'
/usr/bin/ld: src/device.o: in function `pincode_cb':
/github/workspace/src/device.c:6286: undefined reference to `btd_adapter_pincode_reply'
/usr/bin/ld: /github/workspace/src/device.c:6289: undefined reference to `agent_unref'
/usr/bin/ld: src/device.o: in function `passkey_cb':
/github/workspace/src/device.c:6323: undefined reference to `btd_adapter_passkey_reply'
/usr/bin/ld: /github/workspace/src/device.c:6326: undefined reference to `agent_unref'
/usr/bin/ld: src/device.o: in function `confirm_cb':
/github/workspace/src/device.c:6302: undefined reference to `btd_adapter_confirm_reply'
/usr/bin/ld: /github/workspace/src/device.c:6306: undefined reference to `agent_unref'
/usr/bin/ld: src/device.o: in function `read_device_records':
/github/workspace/src/device.c:6679: undefined reference to `btd_adapter_get_address'
/usr/bin/ld: /github/workspace/src/device.c:6679: undefined reference to `ba2str'
/usr/bin/ld: /github/workspace/src/device.c:6680: undefined reference to `ba2str'
/usr/bin/ld: /github/workspace/src/device.c:6694: undefined reference to `record_from_string'
/usr/bin/ld: /github/workspace/src/device.c:6695: undefined reference to `sdp_list_append'
/usr/bin/ld: src/device.o: in function `disconnect_all':
/github/workspace/src/device.c:1483: undefined reference to `btd_adapter_disconnect_device'
/usr/bin/ld: /github/workspace/src/device.c:1487: undefined reference to `btd_adapter_disconnect_device'
/usr/bin/ld: src/device.o: in function `gatt_server_cleanup':
/github/workspace/src/device.c:611: undefined reference to `btd_adapter_get_database'
/usr/bin/ld: /github/workspace/src/device.c:611: undefined reference to `btd_gatt_database_att_disconnected'
/usr/bin/ld: src/device.o: in function `add_service_data':
/github/workspace/src/device.c:1866: undefined reference to `bt_string_to_uuid'
/usr/bin/ld: src/device.o: in function `find_connectable_service':
/github/workspace/src/device.c:1915: undefined reference to `btd_service_get_profile'
/usr/bin/ld: src/device.o: in function `disconnect_profile':
/github/workspace/src/device.c:2201: undefined reference to `bt_name2string'
/usr/bin/ld: /github/workspace/src/device.c:2212: undefined reference to `btd_error_in_progress'
/usr/bin/ld: /github/workspace/src/device.c:2209: undefined reference to `btd_error_invalid_args'
/usr/bin/ld: /github/workspace/src/device.c:2214: undefined reference to `btd_service_get_state'
/usr/bin/ld: /github/workspace/src/device.c:2219: undefined reference to `btd_service_disconnect'
/usr/bin/ld: /github/workspace/src/device.c:2231: undefined reference to `btd_error_failed'
/usr/bin/ld: /github/workspace/src/device.c:2227: undefined reference to `btd_error_not_supported'
/usr/bin/ld: src/device.o: in function `create_pending_list':
/github/workspace/src/device.c:1951: undefined reference to `btd_service_get_profile'
/usr/bin/ld: /github/workspace/src/device.c:1959: undefined reference to `btd_service_get_state'
/usr/bin/ld: src/device.o: in function `connect_next':
/github/workspace/src/device.c:1728: undefined reference to `btd_service_connect'
/usr/bin/ld: src/device.o: in function `add_primary':
/github/workspace/src/device.c:3474: undefined reference to `bt_uuid_to_string'
/usr/bin/ld: src/device.o: in function `device_auth_req_free':
/github/workspace/src/device.c:6018: undefined reference to `agent_unref'
/usr/bin/ld: src/device.o: in function `record_has_uuid':
/github/workspace/src/device.c:4581: undefined reference to `bt_uuid2string'
/usr/bin/ld: src/device.o: in function `load_services':
/github/workspace/src/device.c:3179: undefined reference to `bt_uuid_strcmp'
/usr/bin/ld: src/device.o: in function `convert_info':
/github/workspace/src/device.c:3218: undefined reference to `btd_adapter_get_address'
/usr/bin/ld: /github/workspace/src/device.c:3218: undefined reference to `ba2str'
/usr/bin/ld: /github/workspace/src/device.c:3219: undefined reference to `ba2str'
/usr/bin/ld: src/device.o: in function `load_att_info':
/github/workspace/src/device.c:3377: undefined reference to `sdp_uuid16_create'
/usr/bin/ld: /github/workspace/src/device.c:3378: undefined reference to `bt_uuid2string'
/usr/bin/ld: /github/workspace/src/device.c:3440: undefined reference to `bt_uuid2string'
/usr/bin/ld: src/device.o: in function `device_match_profile':
/github/workspace/src/device.c:3819: undefined reference to `bt_uuid_strcmp'
/usr/bin/ld: src/device.o: in function `probe_service':
/github/workspace/src/device.c:4623: undefined reference to `service_create'
/usr/bin/ld: /github/workspace/src/device.c:4625: undefined reference to `service_probe'
/usr/bin/ld: src/device.o: in function `find_service_with_profile':
/github/workspace/src/device.c:315: undefined reference to `btd_service_get_profile'
/usr/bin/ld: src/device.o: in function `probe_service':
/github/workspace/src/device.c:4626: undefined reference to `btd_service_unref'
/usr/bin/ld: src/device.o: in function `device_store_cached_name':
/github/workspace/src/device.c:533: undefined reference to `ba2str'
/usr/bin/ld: /github/workspace/src/device.c:534: undefined reference to `btd_adapter_get_storage_dir'
/usr/bin/ld: /github/workspace/src/device.c:536: undefined reference to `create_file'
/usr/bin/ld: src/device.o: in function `gatt_cache_is_enabled':
/github/workspace/src/device.c:569: undefined reference to `main_opts'
/usr/bin/ld: src/device.o: in function `store_gatt_db':
/github/workspace/src/device.c:2480: undefined reference to `ba2str'
/usr/bin/ld: /github/workspace/src/device.c:2482: undefined reference to `btd_adapter_get_storage_dir'
/usr/bin/ld: /github/workspace/src/device.c:2485: undefined reference to `create_file'
/usr/bin/ld: src/device.o: in function `gatt_service_removed':
/github/workspace/src/device.c:4009: undefined reference to `bt_uuid_strcmp'
/usr/bin/ld: /github/workspace/src/device.c:4034: undefined reference to `btd_gatt_client_service_removed'
/usr/bin/ld: src/device.o: in function `device_remove_gatt_service':
/github/workspace/src/device.c:3899: undefined reference to `bt_uuid_to_string'
/usr/bin/ld: /github/workspace/src/device.c:3908: undefined reference to `service_remove'
/usr/bin/ld: src/device.o: in function `gatt_cache_is_enabled':
/github/workspace/src/device.c:569: undefined reference to `main_opts'
/usr/bin/ld: src/device.o: in function `attio_cleanup':
/github/workspace/src/device.c:642: undefined reference to `g_attrib_cancel_all'
/usr/bin/ld: src/device.o: in function `browse_request_cancel':
/github/workspace/src/device.c:654: undefined reference to `btd_adapter_get_address'
/usr/bin/ld: /github/workspace/src/device.c:654: undefined reference to `bt_cancel_discovery'
/usr/bin/ld: src/device.o: in function `device_free':
/github/workspace/src/device.c:677: undefined reference to `btd_gatt_client_destroy'
/usr/bin/ld: /github/workspace/src/device.c:694: undefined reference to `sdp_record_free'
/usr/bin/ld: /github/workspace/src/device.c:694: undefined reference to `sdp_list_free'
/usr/bin/ld: /github/workspace/src/device.c:716: undefined reference to `agent_unref'
/usr/bin/ld: src/device.o: in function `att_disconnected_cb':
/github/workspace/src/device.c:5097: undefined reference to `btd_gatt_client_disconnected'
/usr/bin/ld: /github/workspace/src/device.c:5110: undefined reference to `adapter_connect_list_add'
/usr/bin/ld: src/device.o: in function `gatt_cache_is_enabled':
/github/workspace/src/device.c:569: undefined reference to `main_opts'
/usr/bin/ld: src/device.o: in function `load_service':
/github/workspace/src/device.c:3651: undefined reference to `bt_string_to_uuid'
/usr/bin/ld: src/device.o: in function `load_gatt_db_impl':
/github/workspace/src/device.c:3733: undefined reference to `bt_uuid_to_string'
/usr/bin/ld: src/device.o: in function `load_chrc':
/github/workspace/src/device.c:3572: undefined reference to `bt_string_to_uuid'
/usr/bin/ld: src/device.o: in function `load_desc':
/github/workspace/src/device.c:3522: undefined reference to `bt_string_to_uuid'
/usr/bin/ld: /github/workspace/src/device.c:3523: undefined reference to `bt_uuid16_create'
/usr/bin/ld: /github/workspace/src/device.c:3526: undefined reference to `bt_uuid_cmp'
/usr/bin/ld: src/device.o: in function `load_chrc':
/github/workspace/src/device.c:3572: undefined reference to `bt_string_to_uuid'
/usr/bin/ld: /github/workspace/src/device.c:3572: undefined reference to `bt_string_to_uuid'
/usr/bin/ld: src/device.o: in function `device_add_eir_uuids':
/github/workspace/src/device.c:1825: undefined reference to `bt_uuid_strcmp'
/usr/bin/ld: src/device.o: in function `btd_device_connect_services':
/github/workspace/src/device.c:1977: undefined reference to `btd_adapter_get_powered'
/usr/bin/ld: src/device.o: in function `bonding_request_cancel':
/github/workspace/src/device.c:1587: undefined reference to `adapter_cancel_bonding'
/usr/bin/ld: src/device.o: in function `device_request_disconnect':
/github/workspace/src/device.c:1610: undefined reference to `btd_error_failed'
/usr/bin/ld: src/device.o: in function `btd_device_get_storage_path':
/github/workspace/src/device.c:4169: undefined reference to `ba2str'
/usr/bin/ld: /github/workspace/src/device.c:4176: undefined reference to `btd_adapter_get_storage_dir'
/usr/bin/ld: /github/workspace/src/device.c:4172: undefined reference to `btd_adapter_get_storage_dir'
/usr/bin/ld: src/device.o: in function `device_browse_sdp':
/github/workspace/src/device.c:5614: undefined reference to `sdp_uuid16_create'
/usr/bin/ld: src/device.o: in function `get_sdp_flags':
/github/workspace/src/device.c:5592: undefined reference to `btd_adapter_ssp_enabled'
/usr/bin/ld: src/device.o: in function `device_browse_sdp':
/github/workspace/src/device.c:5618: undefined reference to `btd_adapter_get_address'
/usr/bin/ld: /github/workspace/src/device.c:5618: undefined reference to `bt_search'
/usr/bin/ld: src/device.o: in function `device_address_cmp':
/github/workspace/src/device.c:4516: undefined reference to `ba2str'
/usr/bin/ld: src/device.o: in function `find_service_with_profile':
/github/workspace/src/device.c:315: undefined reference to `btd_service_get_profile'
/usr/bin/ld: src/device.o: in function `device_probe_profiles':
/github/workspace/src/device.c:4694: undefined reference to `ba2str'
/usr/bin/ld: /github/workspace/src/device.c:4703: undefined reference to `btd_profile_foreach'
/usr/bin/ld: src/device.o: in function `device_add_uuids':
/github/workspace/src/device.c:3795: undefined reference to `bt_uuid_strcmp'
/usr/bin/ld: src/device.o: in function `device_unblock':
/github/workspace/src/device.c:1548: undefined reference to `btd_adapter_unblock_address'
/usr/bin/ld: /github/workspace/src/device.c:1552: undefined reference to `btd_adapter_unblock_address'
/usr/bin/ld: src/device.o: in function `device_connect_le':
/github/workspace/src/device.c:5455: undefined reference to `ba2str'
/usr/bin/ld: /github/workspace/src/device.c:5472: undefined reference to `btd_adapter_get_address_type'
/usr/bin/ld: /github/workspace/src/device.c:5468: undefined reference to `btd_adapter_get_address'
/usr/bin/ld: /github/workspace/src/device.c:5468: undefined reference to `bt_io_connect'
/usr/bin/ld: /github/workspace/src/device.c:5481: undefined reference to `btd_error_failed'
/usr/bin/ld: src/device.o: in function `bonding_request_cancel':
/github/workspace/src/device.c:1587: undefined reference to `adapter_cancel_bonding'
/usr/bin/ld: src/device.o: in function `device_attach_att':
/github/workspace/src/device.c:5287: undefined reference to `bt_io_get'
/usr/bin/ld: /github/workspace/src/device.c:5299: undefined reference to `main_opts'
/usr/bin/ld: /github/workspace/src/device.c:5327: undefined reference to `main_opts'
/usr/bin/ld: /github/workspace/src/device.c:5328: undefined reference to `g_attrib_new'
/usr/bin/ld: /github/workspace/src/device.c:5337: undefined reference to `g_attrib_get_att'
/usr/bin/ld: /github/workspace/src/device.c:5353: undefined reference to `btd_adapter_get_database'
/usr/bin/ld: /github/workspace/src/device.c:5356: undefined reference to `ba2str'
/usr/bin/ld: src/device.o: in function `device_accept_gatt_profiles':
/github/workspace/src/device.c:3887: undefined reference to `service_accept'
/usr/bin/ld: src/device.o: in function `gatt_server_init':
/github/workspace/src/device.c:5226: undefined reference to `btd_gatt_database_get_db'
/usr/bin/ld: /github/workspace/src/device.c:5245: undefined reference to `btd_gatt_database_server_connected'
/usr/bin/ld: src/device.o: in function `device_attach_att':
/github/workspace/src/device.c:5370: undefined reference to `adapter_connect_list_remove'
/usr/bin/ld: /github/workspace/src/device.c:5318: undefined reference to `bt_io_set'
/usr/bin/ld: /github/workspace/src/device.c:5359: undefined reference to `btd_adapter_get_storage_dir'
/usr/bin/ld: src/device.o: in function `gatt_client_init':
/github/workspace/src/device.c:5220: undefined reference to `btd_gatt_client_connected'
/usr/bin/ld: src/device.o: in function `device_update_last_seen':
/github/workspace/src/device.c:4300: undefined reference to `main_opts'
/usr/bin/ld: src/device.o: in function `device_add_connection':
/github/workspace/src/device.c:2977: undefined reference to `ba2str'
/usr/bin/ld: src/device.o: in function `device_remove_connection':
/github/workspace/src/device.c:3031: undefined reference to `btd_error_failed'
/usr/bin/ld: /github/workspace/src/device.c:3050: undefined reference to `btd_adapter_remove_bonding'
/usr/bin/ld: src/device.o: in function `btd_device_set_temporary':
/github/workspace/src/device.c:5699: undefined reference to `adapter_connect_list_remove'
/usr/bin/ld: /github/workspace/src/device.c:5700: undefined reference to `main_opts'
/usr/bin/ld: /github/workspace/src/device.c:5707: undefined reference to `adapter_whitelist_add'
/usr/bin/ld: /github/workspace/src/device.c:5698: undefined reference to `adapter_whitelist_remove'
/usr/bin/ld: src/device.o: in function `device_block':
/github/workspace/src/device.c:1509: undefined reference to `service_remove'
/usr/bin/ld: /github/workspace/src/device.c:1514: undefined reference to `btd_adapter_block_address'
/usr/bin/ld: /github/workspace/src/device.c:1518: undefined reference to `btd_adapter_block_address'
/usr/bin/ld: src/device.o: in function `pair_device':
/github/workspace/src/device.c:2786: undefined reference to `btd_error_already_exists'
/usr/bin/ld: /github/workspace/src/device.c:2790: undefined reference to `agent_get'
/usr/bin/ld: /github/workspace/src/device.c:2792: undefined reference to `agent_get_io_capability'
/usr/bin/ld: src/device.o: in function `bonding_request_new':
/github/workspace/src/device.c:2649: undefined reference to `ba2str'
/usr/bin/ld: /github/workspace/src/device.c:2657: undefined reference to `btd_adapter_pin_cb_iter_new'
/usr/bin/ld: /github/workspace/src/device.c:2665: undefined reference to `agent_ref'
/usr/bin/ld: src/device.o: in function `pair_device':
/github/workspace/src/device.c:2799: undefined reference to `agent_unref'
/usr/bin/ld: /github/workspace/src/device.c:2814: undefined reference to `btd_le_connect_before_pairing'
/usr/bin/ld: /github/workspace/src/device.c:2817: undefined reference to `adapter_create_bonding'
/usr/bin/ld: /github/workspace/src/device.c:2827: undefined reference to `btd_error_failed'
/usr/bin/ld: /github/workspace/src/device.c:2774: undefined reference to `btd_error_in_progress'
/usr/bin/ld: /github/workspace/src/device.c:2771: undefined reference to `btd_error_invalid_args'
/usr/bin/ld: /github/workspace/src/device.c:2821: undefined reference to `adapter_create_bonding'
/usr/bin/ld: src/device.o: in function `find_service_with_state':
/github/workspace/src/device.c:330: undefined reference to `btd_service_get_state'
/usr/bin/ld: src/device.o: in function `browse_request_complete':
/github/workspace/src/device.c:2544: undefined reference to `btd_error_failed'
/usr/bin/ld: /github/workspace/src/device.c:2521: undefined reference to `btd_error_failed'
/usr/bin/ld: src/device.o: in function `device_browse_gatt':
/github/workspace/src/device.c:5563: undefined reference to `btd_adapter_get_address_type'
/usr/bin/ld: /github/workspace/src/device.c:5558: undefined reference to `btd_adapter_get_address'
/usr/bin/ld: /github/workspace/src/device.c:5558: undefined reference to `bt_io_connect'
/usr/bin/ld: src/device.o: in function `connect_profiles':
/github/workspace/src/device.c:2008: undefined reference to `btd_adapter_get_powered'
/usr/bin/ld: src/device.o: in function `find_service_with_state':
/github/workspace/src/device.c:330: undefined reference to `btd_service_get_state'
/usr/bin/ld: src/device.o: in function `connect_profile':
/github/workspace/src/device.c:2163: undefined reference to `bt_name2string'
/usr/bin/ld: /github/workspace/src/device.c:2161: undefined reference to `btd_error_invalid_args'
/usr/bin/ld: src/device.o: in function `att_connect_cb':
/github/workspace/src/device.c:5388: undefined reference to `bt_io_error_quark'
/usr/bin/ld: /github/workspace/src/device.c:5421: undefined reference to `btd_error_failed'
/usr/bin/ld: src/device.o: in function `bonding_request_cancel':
/github/workspace/src/device.c:1587: undefined reference to `adapter_cancel_bonding'
/usr/bin/ld: src/device.o: in function `att_connect_cb':
/github/workspace/src/device.c:5432: undefined reference to `btd_error_failed'
/usr/bin/ld: /github/workspace/src/device.c:5393: undefined reference to `adapter_connect_list_add'
/usr/bin/ld: /github/workspace/src/device.c:5413: undefined reference to `agent_get_io_capability'
/usr/bin/ld: /github/workspace/src/device.c:5417: undefined reference to `adapter_create_bonding'
/usr/bin/ld: src/device.o: in function `device_remove_stored':
/github/workspace/src/device.c:4429: undefined reference to `ba2str'
/usr/bin/ld: /github/workspace/src/device.c:4431: undefined reference to `btd_adapter_get_storage_dir'
/usr/bin/ld: /github/workspace/src/device.c:4436: undefined reference to `btd_adapter_get_storage_dir'
/usr/bin/ld: /github/workspace/src/device.c:4446: undefined reference to `create_file'
/usr/bin/ld: src/device.o: in function `gatt_client_ready_cb':
/github/workspace/src/device.c:5160: undefined reference to `btd_gatt_client_ready'
/usr/bin/ld: src/device.o: in function `device_add_gatt_services':
/github/workspace/src/device.c:3872: undefined reference to `ba2str'
/usr/bin/ld: src/device.o: in function `service_state_changed':
/github/workspace/src/device.c:6870: undefined reference to `btd_service_get_profile'
/usr/bin/ld: /github/workspace/src/device.c:6871: undefined reference to `btd_service_get_device'
/usr/bin/ld: /github/workspace/src/device.c:6872: undefined reference to `btd_service_get_error'
/usr/bin/ld: src/device.o: in function `find_service_with_profile':
/github/workspace/src/device.c:315: undefined reference to `btd_service_get_profile'
/usr/bin/ld: src/device.o: in function `device_profile_connected':
/github/workspace/src/device.c:1771: undefined reference to `btd_service_get_profile'
/usr/bin/ld: src/device.o: in function `device_profile_disconnected':
/github/workspace/src/device.c:2177: undefined reference to `btd_error_failed'
/usr/bin/ld: src/device.o: in function `device_profile_connected':
/github/workspace/src/device.c:1804: undefined reference to `btd_error_failed'
/usr/bin/ld: src/device.o: in function `find_service_with_state':
/github/workspace/src/device.c:330: undefined reference to `btd_service_get_state'
/usr/bin/ld: src/device.o: in function `device_store_svc_chng_ccc':
/github/workspace/src/device.c:5777: undefined reference to `ba2str'
/usr/bin/ld: /github/workspace/src/device.c:5778: undefined reference to `btd_adapter_get_storage_dir'
/usr/bin/ld: /github/workspace/src/device.c:5806: undefined reference to `create_file'
/usr/bin/ld: src/device.o: in function `device_load_svc_chng_ccc':
/github/workspace/src/device.c:5822: undefined reference to `ba2str'
/usr/bin/ld: /github/workspace/src/device.c:5823: undefined reference to `btd_adapter_get_storage_dir'
/usr/bin/ld: src/device.o: in function `device_wait_for_svc_complete':
/github/workspace/src/device.c:6145: undefined reference to `main_opts'
/usr/bin/ld: src/device.o: in function `device_bonding_attempt_retry':
/github/workspace/src/device.c:6240: undefined reference to `btd_adapter_pin_cb_iter_end'
/usr/bin/ld: src/device.o: in function `device_request_pincode':
/github/workspace/src/device.c:6388: undefined reference to `agent_request_pincode'
/usr/bin/ld: src/device.o: in function `device_request_passkey':
/github/workspace/src/device.c:6407: undefined reference to `agent_request_passkey'
/usr/bin/ld: src/device.o: in function `device_confirm_passkey':
/github/workspace/src/device.c:6449: undefined reference to `btd_adapter_confirm_reply'
/usr/bin/ld: /github/workspace/src/device.c:6458: undefined reference to `agent_request_confirmation'
/usr/bin/ld: /github/workspace/src/device.c:6425: undefined reference to `main_opts'
/usr/bin/ld: /github/workspace/src/device.c:6455: undefined reference to `agent_request_authorization'
/usr/bin/ld: /github/workspace/src/device.c:6426: undefined reference to `btd_adapter_confirm_reply'
/usr/bin/ld: src/device.o: in function `device_notify_passkey':
/github/workspace/src/device.c:6492: undefined reference to `agent_display_passkey'
/usr/bin/ld: src/device.o: in function `device_notify_pincode':
/github/workspace/src/device.c:6513: undefined reference to `agent_display_pincode'
/usr/bin/ld: src/device.o: in function `device_cancel_authentication':
/github/workspace/src/device.c:6572: undefined reference to `ba2str'
/usr/bin/ld: /github/workspace/src/device.c:6576: undefined reference to `agent_cancel'
/usr/bin/ld: src/device.o: in function `device_cancel_bonding':
/github/workspace/src/device.c:2878: undefined reference to `ba2str'
/usr/bin/ld: src/device.o: in function `bonding_request_cancel':
/github/workspace/src/device.c:1587: undefined reference to `adapter_cancel_bonding'
/usr/bin/ld: src/device.o: in function `create_bond_req_exit':
/github/workspace/src/device.c:2714: undefined reference to `ba2str'
/usr/bin/ld: src/device.o: in function `device_bonding_complete':
/github/workspace/src/device.c:6043: undefined reference to `agent_cancel'
/usr/bin/ld: /github/workspace/src/device.c:6101: undefined reference to `main_opts'
/usr/bin/ld: src/device.o: in function `device_bonding_retry':
/github/workspace/src/device.c:6212: undefined reference to `agent_get_io_capability'
/usr/bin/ld: /github/workspace/src/device.c:6216: undefined reference to `adapter_bonding_attempt'
/usr/bin/ld: src/device.o: in function `btd_device_get_primary':
/github/workspace/src/device.c:6594: undefined reference to `bt_uuid_strcmp'
/usr/bin/ld: src/device.o: in function `btd_device_add_uuid':
/github/workspace/src/device.c:6652: undefined reference to `bt_uuid_strcmp'
/usr/bin/ld: src/device.o: in function `add_gatt_service':
/github/workspace/src/device.c:3836: undefined reference to `bt_uuid_to_string'
/usr/bin/ld: /github/workspace/src/device.c:3856: undefined reference to `btd_service_get_profile'
/usr/bin/ld: /github/workspace/src/device.c:3865: undefined reference to `service_accept'
/usr/bin/ld: src/device.o: in function `gatt_service_added':
/github/workspace/src/device.c:3945: undefined reference to `btd_gatt_client_service_added'
/usr/bin/ld: src/device.o: in function `device_new':
/github/workspace/src/device.c:4044: undefined reference to `adapter_get_path'
/usr/bin/ld: /github/workspace/src/device.c:4073: undefined reference to `str2ba'
/usr/bin/ld: /github/workspace/src/device.c:4075: undefined reference to `btd_gatt_client_new'
/usr/bin/ld: /github/workspace/src/device.c:4100: undefined reference to `main_opts'
/usr/bin/ld: src/device.o: in function `device_create':
/github/workspace/src/device.c:4134: undefined reference to `ba2str'
/usr/bin/ld: /github/workspace/src/device.c:4148: undefined reference to `btd_adapter_get_storage_dir'
/usr/bin/ld: src/device.o: in function `device_remove':
/github/workspace/src/device.c:4481: undefined reference to `service_remove'
/usr/bin/ld: src/device.o: in function `device_set_appearance':
/github/workspace/src/device.c:6786: undefined reference to `gap_appearance_to_icon'
/usr/bin/ld: src/device.o: in function `btd_device_set_pnpid':
/github/workspace/src/device.c:6815: undefined reference to `bt_modalias'
/usr/bin/ld: src/device.o: in function `update_bredr_services':
/github/workspace/src/device.c:4827: undefined reference to `btd_adapter_get_address'
/usr/bin/ld: /github/workspace/src/device.c:4827: undefined reference to `ba2str'
/usr/bin/ld: /github/workspace/src/device.c:4828: undefined reference to `ba2str'
/usr/bin/ld: /github/workspace/src/device.c:4852: undefined reference to `bt_uuid2string'
/usr/bin/ld: /github/workspace/src/device.c:4857: undefined reference to `bt_uuid_strcmp'
/usr/bin/ld: src/device.o: in function `update_record':
/github/workspace/src/device.c:4799: undefined reference to `sdp_copy_record'
/usr/bin/ld: /github/workspace/src/device.c:4799: undefined reference to `sdp_list_append'
/usr/bin/ld: /github/workspace/src/device.c:4802: undefined reference to `bt_uuid_strcmp'
/usr/bin/ld: src/device.o: in function `store_sdp_record':
/github/workspace/src/device.c:4718: undefined reference to `sdp_gen_record_pdu'
/usr/bin/ld: src/device.o: in function `store_primaries_from_sdp_record':
/github/workspace/src/device.c:4743: undefined reference to `sdp_uuid16_create'
/usr/bin/ld: /github/workspace/src/device.c:4744: undefined reference to `bt_uuid2string'
/usr/bin/ld: /github/workspace/src/device.c:4746: undefined reference to `sdp_uuid16_create'
/usr/bin/ld: /github/workspace/src/device.c:4747: undefined reference to `bt_uuid2string'
/usr/bin/ld: /github/workspace/src/device.c:4752: undefined reference to `gatt_parse_record'
/usr/bin/ld: src/device.o: in function `update_bredr_services':
/github/workspace/src/device.c:4861: undefined reference to `sdp_data_get'
/usr/bin/ld: /github/workspace/src/device.c:4864: undefined reference to `sdp_data_get'
/usr/bin/ld: /github/workspace/src/device.c:4867: undefined reference to `sdp_data_get'
/usr/bin/ld: /github/workspace/src/device.c:4870: undefined reference to `sdp_data_get'
/usr/bin/ld: src/device.o: in function `update_record':
/github/workspace/src/device.c:4804: undefined reference to `bt_uuid_strcmp'
/usr/bin/ld: src/device.o: in function `update_bredr_services':
/github/workspace/src/device.c:4894: undefined reference to `create_file'
/usr/bin/ld: /github/workspace/src/device.c:4905: undefined reference to `create_file'
/usr/bin/ld: src/device.o: in function `search_cb':
/github/workspace/src/device.c:4988: undefined reference to `ba2str'
/usr/bin/ld: /github/workspace/src/device.c:4999: undefined reference to `sdp_record_free'
/usr/bin/ld: /github/workspace/src/device.c:4999: undefined reference to `sdp_list_free'
/usr/bin/ld: src/device.o: in function `device_services_from_record':
/github/workspace/src/device.c:4948: undefined reference to `sdp_uuid16_create'
/usr/bin/ld: /github/workspace/src/device.c:4949: undefined reference to `bt_uuid2string'
/usr/bin/ld: /github/workspace/src/device.c:4965: undefined reference to `gatt_parse_record'
/usr/bin/ld: /github/workspace/src/device.c:4971: undefined reference to `sdp_uuid2strn'
/usr/bin/ld: src/device.o: in function `search_cb':
/github/workspace/src/device.c:4988: undefined reference to `ba2str'
/usr/bin/ld: /github/workspace/src/device.c:4988: undefined reference to `ba2str'
/usr/bin/ld: src/device.o: in function `browse_cb':
/github/workspace/src/device.c:5052: undefined reference to `sdp_uuid16_create'
/usr/bin/ld: /github/workspace/src/device.c:5053: undefined reference to `btd_adapter_get_address'
/usr/bin/ld: /github/workspace/src/device.c:5053: undefined reference to `bt_search_service'
/usr/bin/ld: src/device.o: in function `btd_device_set_record':
/github/workspace/src/device.c:6721: undefined reference to `record_from_string'
/usr/bin/ld: /github/workspace/src/device.c:6722: undefined reference to `sdp_list_append'
/usr/bin/ld: /github/workspace/src/device.c:6724: undefined reference to `sdp_list_free'
/usr/bin/ld: src/device.o: in function `device_create_from_storage':
/github/workspace/src/device.c:4119: undefined reference to `btd_adapter_get_storage_dir'
/usr/bin/ld: src/device.o: in function `btd_device_get_service':
/github/workspace/src/device.c:6891: undefined reference to `btd_service_get_profile'
/usr/bin/ld: src/device.o: in function `btd_device_init':
/github/workspace/src/device.c:6902: undefined reference to `btd_get_dbus_connection'
/usr/bin/ld: /github/workspace/src/device.c:6903: undefined reference to `btd_service_add_state_cb'
/usr/bin/ld: src/device.o: in function `dev_disconn_service':
/github/workspace/src/device.c:1592: undefined reference to `btd_service_disconnect'
/usr/bin/ld: src/device.o: in function `prim_uuid_cmp':
/github/workspace/src/device.c:3966: undefined reference to `bt_uuid_strcmp'
/usr/bin/ld: src/device.o: in function `disconnect_gatt_service':
/github/workspace/src/device.c:5081: undefined reference to `btd_service_disconnect'
/usr/bin/ld: src/device.o: in function `get_icon':
/github/workspace/src/device.c:930: undefined reference to `gap_appearance_to_icon'
/usr/bin/ld: /github/workspace/src/device.c:928: undefined reference to `class_to_icon'
/usr/bin/ld: src/device.o: in function `attio_cleanup':
/github/workspace/src/device.c:643: undefined reference to `g_attrib_unref'
/usr/bin/ld: src/device.o: in function `device_remove_profile':
/github/workspace/src/device.c:4686: undefined reference to `service_remove'
/usr/bin/ld: src/device.o: in function `device_set_wake_allowed':
/github/workspace/src/device.c:1399: undefined reference to `adapter_set_device_wakeable'
/usr/bin/ld: src/device.o: in function `device_remove_connection':
/github/workspace/src/device.c:3071: undefined reference to `btd_adapter_remove_device'
/usr/bin/ld: src/device.o: in function `dev_connect':
/github/workspace/src/device.c:2141: undefined reference to `btd_error_failed'
/usr/bin/ld: src/device.o: in function `connect_profiles':
/github/workspace/src/device.c:2006: undefined reference to `btd_error_in_progress'
/usr/bin/ld: /github/workspace/src/device.c:2050: undefined reference to `btd_error_failed'
/usr/bin/ld: /github/workspace/src/device.c:2009: undefined reference to `btd_error_not_ready'
/usr/bin/ld: /github/workspace/src/device.c:2025: undefined reference to `btd_error_not_available'
/usr/bin/ld: src/device.o: in function `device_remove_bonding':
/github/workspace/src/device.c:4405: undefined reference to `btd_adapter_remove_bonding'
/usr/bin/ld: src/device.o: in function `device_set_unpaired':
/github/workspace/src/device.c:6007: undefined reference to `btd_adapter_remove_device'
/usr/bin/ld: src/device.o: in function `cancel_pairing':
/github/workspace/src/device.c:2900: undefined reference to `btd_error_does_not_exist'
/usr/bin/ld: src/device.o: in function `btd_device_get_record':
/github/workspace/src/device.c:6748: undefined reference to `find_record_in_list'
/usr/bin/ld: src/device.o: in function `btd_device_cleanup':
/github/workspace/src/device.c:6909: undefined reference to `btd_service_remove_state_cb'
/usr/bin/ld: src/.libs/libshared-glib.a(ad.o): in function `serialize_uuids':
/github/workspace/src/shared/ad.c:322: undefined reference to `bt_uuid_to_le'
/usr/bin/ld: src/.libs/libshared-glib.a(ad.o): in function `uuid_match':
/github/workspace/src/shared/ad.c:527: undefined reference to `bt_uuid_cmp'
/usr/bin/ld: src/.libs/libshared-glib.a(ad.o): in function `service_uuid_match':
/github/workspace/src/shared/ad.c:713: undefined reference to `bt_uuid_cmp'
/usr/bin/ld: src/.libs/libshared-glib.a(ad.o): in function `uuid_data_match':
/github/workspace/src/shared/ad.c:84: undefined reference to `bt_uuid_cmp'
/usr/bin/ld: src/.libs/libshared-glib.a(ad.o): in function `service_data_match':
/github/workspace/src/shared/ad.c:764: undefined reference to `bt_uuid_cmp'
/usr/bin/ld: src/.libs/libshared-glib.a(ad.o): in function `serialize_service_data':
/github/workspace/src/shared/ad.c:404: undefined reference to `bt_uuid_to_le'
/usr/bin/ld: src/.libs/libshared-glib.a(gatt-client.o): in function `find_ccc':
/github/workspace/src/shared/gatt-client.c:233: undefined reference to `bt_uuid16_create'
/usr/bin/ld: /github/workspace/src/shared/gatt-client.c:235: undefined reference to `bt_uuid_cmp'
/usr/bin/ld: src/.libs/libshared-glib.a(gatt-client.o): in function `discovery_parse_services':
/github/workspace/src/shared/gatt-client.c:1121: undefined reference to `bt_uuid128_create'
/usr/bin/ld: /github/workspace/src/shared/gatt-client.c:1124: undefined reference to `bt_uuid_to_string'
/usr/bin/ld: src/.libs/libshared-glib.a(gatt-client.o): in function `discover_descs':
/github/workspace/src/shared/gatt-client.c:716: undefined reference to `bt_uuid16_create'
/usr/bin/ld: src/.libs/libshared-glib.a(gatt-client.o): in function `read_server_feat':
/github/workspace/src/shared/gatt-client.c:1511: undefined reference to `bt_uuid16_create'
/usr/bin/ld: src/.libs/libshared-glib.a(gatt-client.o): in function `read_db_hash':
/github/workspace/src/shared/gatt-client.c:1452: undefined reference to `bt_uuid16_create'
/usr/bin/ld: src/.libs/libshared-glib.a(gatt-client.o): in function `discover_incl_cb':
/github/workspace/src/shared/gatt-client.c:567: undefined reference to `bt_uuid128_create'
/usr/bin/ld: /github/workspace/src/shared/gatt-client.c:570: undefined reference to `bt_uuid_to_string'
/usr/bin/ld: src/.libs/libshared-glib.a(gatt-client.o): in function `discover_chrcs_cb':
/github/workspace/src/shared/gatt-client.c:970: undefined reference to `bt_uuid128_create'
/usr/bin/ld: /github/workspace/src/shared/gatt-client.c:973: undefined reference to `bt_uuid_to_string'
/usr/bin/ld: src/.libs/libshared-glib.a(gatt-client.o): in function `notify_chrc_create':
/github/workspace/src/shared/gatt-client.c:299: undefined reference to `bt_uuid16_create'
/usr/bin/ld: /github/workspace/src/shared/gatt-client.c:300: undefined reference to `bt_uuid_cmp'
/usr/bin/ld: src/.libs/libshared-glib.a(gatt-client.o): in function `register_service_changed':
/github/workspace/src/shared/gatt-client.c:1786: undefined reference to `bt_uuid16_create'
/usr/bin/ld: src/.libs/libshared-glib.a(gatt-client.o): in function `discover_descs_cb':
/github/workspace/src/shared/gatt-client.c:875: undefined reference to `bt_uuid16_create'
/usr/bin/ld: /github/workspace/src/shared/gatt-client.c:878: undefined reference to `bt_uuid128_create'
/usr/bin/ld: /github/workspace/src/shared/gatt-client.c:881: undefined reference to `bt_uuid_to_string'
/usr/bin/ld: /github/workspace/src/shared/gatt-client.c:904: undefined reference to `bt_uuid_cmp'
/usr/bin/ld: /github/workspace/src/shared/gatt-client.c:891: undefined reference to `bt_uuid_cmp'
/usr/bin/ld: src/.libs/libshared-glib.a(gatt-client.o): in function `write_client_features':
/github/workspace/src/shared/gatt-client.c:1969: undefined reference to `bt_uuid16_create'
/usr/bin/ld: /github/workspace/src/shared/gatt-client.c:1980: undefined reference to `bt_uuid16_create'
/usr/bin/ld: src/.libs/libshared-glib.a(gatt-client.o): in function `write_server_features':
/github/workspace/src/shared/gatt-client.c:1947: undefined reference to `bt_uuid16_create'
/usr/bin/ld: src/.libs/libshared-glib.a(gatt-server.o): in function `find_by_type_val_cb':
/github/workspace/src/shared/gatt-server.c:757: undefined reference to `bt_uuid16_create'
/usr/bin/ld: src/.libs/libshared-glib.a(gatt-server.o): in function `get_uuid_le':
/github/workspace/src/shared/gatt-server.c:179: undefined reference to `bt_uuid128_create'
/usr/bin/ld: /github/workspace/src/shared/gatt-server.c:175: undefined reference to `bt_uuid16_create'
/usr/bin/ld: src/.libs/libshared-glib.a(gatt-server.o): in function `encode_find_info_rsp':
/github/workspace/src/shared/gatt-server.c:612: undefined reference to `bt_uuid_to_le'
/usr/bin/ld: src/.libs/libshared-glib.a(gatt-server.o): in function `read_by_grp_type_cb':
/github/workspace/src/shared/gatt-server.c:306: undefined reference to `bt_uuid16_create'
/usr/bin/ld: /github/workspace/src/shared/gatt-server.c:307: undefined reference to `bt_uuid16_create'
/usr/bin/ld: /github/workspace/src/shared/gatt-server.c:308: undefined reference to `bt_uuid_cmp'
/usr/bin/ld: /github/workspace/src/shared/gatt-server.c:308: undefined reference to `bt_uuid_cmp'
/usr/bin/ld: src/.libs/libshared-glib.a(gatt-db.o): in function `uuid_to_le':
/github/workspace/src/shared/gatt-db.c:491: undefined reference to `bt_uuid_to_uuid128'
/usr/bin/ld: src/.libs/libshared-glib.a(gatt-db.o): in function `gen_hash_m':
/github/workspace/src/shared/gatt-db.c:333: undefined reference to `bt_uuid_to_le'
/usr/bin/ld: /github/workspace/src/shared/gatt-db.c:321: undefined reference to `bt_uuid_to_le'
/usr/bin/ld: src/.libs/libshared-glib.a(gatt-db.o): in function `le_to_uuid':
/github/workspace/src/shared/gatt-db.c:514: undefined reference to `bt_uuid128_create'
/usr/bin/ld: /github/workspace/src/shared/gatt-db.c:501: undefined reference to `bt_uuid16_create'
/usr/bin/ld: /github/workspace/src/shared/gatt-db.c:506: undefined reference to `bt_uuid32_create'
/usr/bin/ld: src/.libs/libshared-glib.a(gatt-db.o): in function `gatt_db_service_foreach':
/github/workspace/src/shared/gatt-db.c:1452: undefined reference to `bt_uuid_cmp'
/usr/bin/ld: src/.libs/libshared-glib.a(gatt-db.o): in function `gatt_db_service_foreach_desc':
/github/workspace/src/shared/gatt-db.c:1478: undefined reference to `bt_uuid_cmp'
/usr/bin/ld: /github/workspace/src/shared/gatt-db.c:1497: undefined reference to `bt_uuid_cmp'
/usr/bin/ld: /github/workspace/src/shared/gatt-db.c:1498: undefined reference to `bt_uuid_cmp'
/usr/bin/ld: src/.libs/libshared-glib.a(gatt-db.o): in function `gatt_db_attribute_get_service_uuid':
/github/workspace/src/shared/gatt-db.c:1630: undefined reference to `bt_uuid128_create'
/usr/bin/ld: /github/workspace/src/shared/gatt-db.c:1621: undefined reference to `bt_uuid16_create'
/usr/bin/ld: src/.libs/libshared-glib.a(gatt-db.o): in function `gatt_db_insert_service':
/github/workspace/src/shared/gatt-db.c:722: undefined reference to `bt_uuid_cmp'
/usr/bin/ld: /github/workspace/src/shared/gatt-db.c:723: undefined reference to `bt_uuid_cmp'
/usr/bin/ld: src/.libs/libshared-glib.a(gatt-db.o): in function `foreach_in_range':
/github/workspace/src/shared/gatt-db.c:1382: undefined reference to `bt_uuid_cmp'
/usr/bin/ld: src/.libs/libshared-glib.a(gatt-db.o): in function `foreach_service_in_range':
/github/workspace/src/shared/gatt-db.c:1335: undefined reference to `bt_uuid_cmp'
/usr/bin/ld: /github/workspace/src/shared/gatt-db.c:1339: undefined reference to `bt_uuid_cmp'
/usr/bin/ld: src/.libs/libshared-glib.a(gatt-db.o):/github/workspace/src/shared/gatt-db.c:1572: more undefined references to `bt_uuid_cmp' follow
/usr/bin/ld: src/.libs/libshared-glib.a(gatt-helpers.o): in function `bt_gatt_iter_next_service':
/github/workspace/src/shared/gatt-helpers.c:349: undefined reference to `bt_uuid_to_uuid128'
/usr/bin/ld: src/.libs/libshared-glib.a(gatt-helpers.o): in function `discover_services':
/github/workspace/src/shared/gatt-helpers.c:856: undefined reference to `bt_uuid_to_le'
/usr/bin/ld: src/.libs/libshared-glib.a(gatt-helpers.o): in function `find_by_type_val_cb':
/github/workspace/src/shared/gatt-helpers.c:786: undefined reference to `bt_uuid_to_le'
/usr/bin/ld: src/.libs/libshared-glib.a(gatt-helpers.o): in function `read_by_type_cb':
/github/workspace/src/shared/gatt-helpers.c:1340: undefined reference to `bt_uuid_to_le'
/usr/bin/ld: src/.libs/libshared-glib.a(gatt-helpers.o): in function `bt_gatt_read_by_type':
/github/workspace/src/shared/gatt-helpers.c:1383: undefined reference to `bt_uuid_to_le'
collect2: error: ld returned 1 exit status
make[1]: *** [Makefile:6060: unit/test-adv-monitor] Error 1
make: *** [Makefile:4056: all] Error 2



---
Regards,
Linux Bluetooth

--===============4429390691823547765==--
