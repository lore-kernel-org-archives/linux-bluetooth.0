Return-Path: <SRS0=ZUSg=BO=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB598C433DF
	for <linux-bluetooth@archiver.kernel.org>; Tue,  4 Aug 2020 23:31:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B1A3B2177B
	for <linux-bluetooth@archiver.kernel.org>; Tue,  4 Aug 2020 23:31:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726104AbgHDXbw convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 4 Aug 2020 19:31:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:58660 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725946AbgHDXbw (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 4 Aug 2020 19:31:52 -0400
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 206457] Gamepad Dualshock4 CUH-ZCT2U doesn't pair or connect
Date:   Tue, 04 Aug 2020 23:31:50 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: blocking
X-Bugzilla-Who: arael78@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-206457-62941-VVTUSo6AZ4@https.bugzilla.kernel.org/>
In-Reply-To: <bug-206457-62941@https.bugzilla.kernel.org/>
References: <bug-206457-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=206457

--- Comment #5 from arael78@gmail.com ---
Here is the log from running bluetoothd with options -n an -d:

The dualshock device is D0_27_96_19_12_33.

bluetoothd[9774]: src/adapter.c:device_found_callback() hci0 addr
D0:27:96:19:12:33, rssi -51 flags 0x0000 eir_len 42
bluetoothd[9774]: src/device.c:device_create() dst D0:27:96:19:12:33
bluetoothd[9774]: src/device.c:device_new() address D0:27:96:19:12:33
bluetoothd[9774]: src/device.c:device_new() Creating device
/org/bluez/hci0/dev_D0_27_96_19_12_33
bluetoothd[9774]: src/device.c:device_set_legacy() legacy 0
bluetoothd[9774]: src/device.c:device_set_rssi_with_delta() rssi -51
bluetoothd[9774]: src/device.c:device_set_class()
/org/bluez/hci0/dev_D0_27_96_19_12_33 0x002508
bluetoothd[9774]: src/device.c:btd_device_set_temporary() temporary 0
bluetoothd[9774]: src/agent.c:agent_ref() 0x5579ce015af0: ref=2
bluetoothd[9774]: src/device.c:bonding_request_new() Requesting bonding for
D0:27:96:19:12:33
bluetoothd[9774]: src/agent.c:agent_ref() 0x5579ce015af0: ref=3
bluetoothd[9774]: src/agent.c:agent_unref() 0x5579ce015af0: ref=2
bluetoothd[9774]: src/adapter.c:suspend_discovery() 
bluetoothd[9774]: src/adapter.c:adapter_bonding_attempt() hci0 bdaddr
D0:27:96:19:12:33 type 0 io_cap 0x01
bluetoothd[9774]: src/adapter.c:add_whitelist_complete() D0:27:96:19:12:33
added to kernel whitelist
bluetoothd[9774]: src/adapter.c:suspend_discovery_complete() status 0x00
bluetoothd[9774]: src/adapter.c:discovering_callback() hci0 type 7 discovering
0 method 1
bluetoothd[9774]: src/adapter.c:connected_callback() hci0 device
D0:27:96:19:12:33 connected eir_len 26
bluetoothd[9774]: src/adapter.c:new_link_key_callback() hci0 new key for
D0:27:96:19:12:33 type 4 pin_len 0 store_hint 1
bluetoothd[9774]: src/device.c:device_set_bonded() 
bluetoothd[9774]: src/device.c:device_bonding_complete() bonding 0x5579ce036410
status 0x00
bluetoothd[9774]: src/device.c:device_bonding_complete() Proceeding with
service discovery
bluetoothd[9774]: src/agent.c:agent_unref() 0x5579ce015af0: ref=1
bluetoothd[9774]: src/adapter.c:resume_discovery() 
bluetoothd[9774]: src/adapter.c:trigger_start_discovery() 
bluetoothd[9774]: src/adapter.c:cancel_passive_scanning() 
bluetoothd[9774]: src/adapter.c:pair_device_complete() Success (0x00)
bluetoothd[9774]: src/adapter.c:bonding_attempt_complete() hci0 bdaddr
D0:27:96:19:12:33 type 0 status 0x0
bluetoothd[9774]: src/device.c:device_bonding_complete() bonding (nil) status
0x00
bluetoothd[9774]: src/adapter.c:resume_discovery() 
bluetoothd[9774]: src/adapter.c:trigger_start_discovery() 
bluetoothd[9774]: src/adapter.c:cancel_passive_scanning() 
bluetoothd[9774]: src/adapter.c:start_discovery_timeout() 
bluetoothd[9774]: src/adapter.c:start_discovery_timeout()
adapter->current_discovery_filter == 1
bluetoothd[9774]: src/adapter.c:start_discovery_timeout() sending
MGMT_OP_START_SERVICE_DISCOVERY 127, 7, 0
bluetoothd[9774]: src/adapter.c:start_discovery_complete() status 0x00
bluetoothd[9774]: src/adapter.c:discovering_callback() hci0 type 7 discovering
1 method 1
bluetoothd[9774]: src/adapter.c:device_found_callback() hci0 addr
02:11:8D:DA:78:CB, rssi -92 flags 0x0004 eir_len 31
bluetoothd[9774]: src/device.c:device_set_legacy() legacy 0
bluetoothd[9774]: src/device.c:device_set_rssi_with_delta() rssi -92 delta 0
bluetoothd[9774]: src/device.c:device_set_flags() flags 0
bluetoothd[9774]: src/adapter.c:device_found_callback() hci0 addr
02:11:8D:DA:78:CB, rssi -92 flags 0x0004 eir_len 31
bluetoothd[9774]: src/device.c:device_set_legacy() legacy 0
bluetoothd[9774]: src/device.c:device_set_rssi_with_delta() rssi -92 delta 0
bluetoothd[9774]: src/device.c:device_set_flags() flags 0
bluetoothd[9774]: src/adapter.c:discovering_callback() hci0 type 7 discovering
0 method 1
bluetoothd[9774]: src/adapter.c:trigger_start_discovery() 
bluetoothd[9774]: src/adapter.c:cancel_passive_scanning() 
bluetoothd[9774]: src/adapter.c:start_discovery_timeout() 
bluetoothd[9774]: src/adapter.c:start_discovery_timeout()
adapter->current_discovery_filter == 1
bluetoothd[9774]: src/adapter.c:start_discovery_timeout() sending
MGMT_OP_START_SERVICE_DISCOVERY 127, 7, 0
bluetoothd[9774]: src/adapter.c:start_discovery_complete() status 0x00
bluetoothd[9774]: src/adapter.c:discovering_callback() hci0 type 7 discovering
1 method 1
bluetoothd[9774]: src/adapter.c:device_found_callback() hci0 addr
02:11:8D:DA:78:CB, rssi -92 flags 0x0004 eir_len 31
bluetoothd[9774]: src/device.c:device_set_legacy() legacy 0
bluetoothd[9774]: src/device.c:device_set_rssi_with_delta() rssi -92 delta 0
bluetoothd[9774]: src/device.c:device_set_flags() flags 0
bluetoothd[9774]: src/adapter.c:discovering_callback() hci0 type 7 discovering
0 method 1
bluetoothd[9774]: src/adapter.c:trigger_start_discovery() 
bluetoothd[9774]: src/adapter.c:cancel_passive_scanning() 
bluetoothd[9774]: src/adapter.c:start_discovery_timeout() 
bluetoothd[9774]: src/adapter.c:start_discovery_timeout()
adapter->current_discovery_filter == 1
bluetoothd[9774]: src/adapter.c:start_discovery_timeout() sending
MGMT_OP_START_SERVICE_DISCOVERY 127, 7, 0
bluetoothd[9774]: src/adapter.c:start_discovery_complete() status 0x00
bluetoothd[9774]: src/adapter.c:discovering_callback() hci0 type 7 discovering
1 method 1
bluetoothd[9774]: src/adapter.c:device_found_callback() hci0 addr
02:11:8D:DA:78:CB, rssi -92 flags 0x0004 eir_len 31
bluetoothd[9774]: src/device.c:device_set_legacy() legacy 0
bluetoothd[9774]: src/device.c:device_set_rssi_with_delta() rssi -92 delta 0
bluetoothd[9774]: src/device.c:device_set_flags() flags 0
bluetoothd[9774]: src/adapter.c:device_found_callback() hci0 addr
02:11:8D:DA:78:CB, rssi -93 flags 0x0004 eir_len 31
bluetoothd[9774]: src/device.c:device_set_legacy() legacy 0
bluetoothd[9774]: src/device.c:device_set_rssi_with_delta() rssi -93 delta 1
bluetoothd[9774]: src/device.c:device_set_flags() flags 0
bluetoothd[9774]: src/adapter.c:device_found_callback() hci0 addr
02:11:8D:DA:78:CB, rssi -92 flags 0x0004 eir_len 31
bluetoothd[9774]: src/device.c:device_set_legacy() legacy 0
bluetoothd[9774]: src/device.c:device_set_rssi_with_delta() rssi -92 delta 1
bluetoothd[9774]: src/device.c:device_set_flags() flags 0
bluetoothd[9774]: src/adapter.c:discovering_callback() hci0 type 7 discovering
0 method 1
bluetoothd[9774]: src/adapter.c:trigger_start_discovery() 
bluetoothd[9774]: src/adapter.c:cancel_passive_scanning() 
bluetoothd[9774]: src/adapter.c:start_discovery_timeout() 
bluetoothd[9774]: src/adapter.c:start_discovery_timeout()
adapter->current_discovery_filter == 1
bluetoothd[9774]: src/adapter.c:start_discovery_timeout() sending
MGMT_OP_START_SERVICE_DISCOVERY 127, 7, 0
bluetoothd[9774]: src/adapter.c:start_discovery_complete() status 0x00
bluetoothd[9774]: src/adapter.c:discovering_callback() hci0 type 7 discovering
1 method 1
bluetoothd[9774]: src/adapter.c:device_found_callback() hci0 addr
02:11:8D:DA:78:CB, rssi -93 flags 0x0004 eir_len 31
bluetoothd[9774]: src/device.c:device_set_legacy() legacy 0
bluetoothd[9774]: src/device.c:device_set_rssi_with_delta() rssi -93 delta 1
bluetoothd[9774]: src/device.c:device_set_flags() flags 0
bluetoothd[9774]: src/adapter.c:device_found_callback() hci0 addr
02:11:8D:DA:78:CB, rssi -91 flags 0x0004 eir_len 31
bluetoothd[9774]: src/device.c:device_set_legacy() legacy 0
bluetoothd[9774]: src/device.c:device_set_rssi_with_delta() rssi -91 delta 2
bluetoothd[9774]: src/device.c:device_set_flags() flags 0
bluetoothd[9774]: D0:27:96:19:12:33: error updating services: Connection timed
out (110)
bluetoothd[9774]: src/device.c:device_svc_resolved()
/org/bluez/hci0/dev_D0_27_96_19_12_33 err -110
bluetoothd[9774]: src/adapter.c:dev_disconnected() Device D0:27:96:19:12:33
disconnected, reason 2
bluetoothd[9774]: src/adapter.c:adapter_remove_connection() 
bluetoothd[9774]: plugins/policy.c:disconnect_cb() reason 2
bluetoothd[9774]: src/adapter.c:bonding_attempt_complete() hci0 bdaddr
D0:27:96:19:12:33 type 0 status 0xe
bluetoothd[9774]: src/device.c:device_bonding_complete() bonding (nil) status
0x0e
bluetoothd[9774]: src/device.c:device_bonding_failed() status 14
bluetoothd[9774]: src/adapter.c:resume_discovery() 
bluetoothd[9774]: src/adapter.c:trigger_start_discovery() 
bluetoothd[9774]: src/adapter.c:cancel_passive_scanning() 
bluetoothd[9774]: src/adapter.c:device_found_callback() hci0 addr
02:11:8D:DA:78:CB, rssi -92 flags 0x0004 eir_len 31
bluetoothd[9774]: src/device.c:device_set_legacy() legacy 0
bluetoothd[9774]: src/device.c:device_set_rssi_with_delta() rssi -92 delta 1
bluetoothd[9774]: src/device.c:device_set_flags() flags 0
bluetoothd[9774]: src/adapter.c:device_found_callback() hci0 addr
02:11:8D:DA:78:CB, rssi -92 flags 0x0004 eir_len 31
bluetoothd[9774]: src/device.c:device_set_legacy() legacy 0
bluetoothd[9774]: src/device.c:device_set_rssi_with_delta() rssi -92 delta 0
bluetoothd[9774]: src/device.c:device_set_flags() flags 0

-- 
You are receiving this mail because:
You are the assignee for the bug.
