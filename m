Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E77C38F9C
	for <linux-bluetooth@vger.kernel.org>; Thu, 29 Aug 2024 16:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724948675; cv=none; b=liU/Y1mkb12P9J5yMaZBAWIb3squTuliUUKOkfMvwyUbCcUzUZpGiVGzamJueuV83GAeXWlCTQwHWOGSdRNwQqYVw32R7u47jmwIK5nPkWsLFhw4YoK7jbNUmBGYxT41eI7iRrfWgvmR9eLjFQ4luakdD6h0DKfzDTD0sSXAHQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724948675; c=relaxed/simple;
	bh=KCAgsh0vQHQF+Ra2PV7Da9M6orza3dE//YU23zUGTVQ=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=ZNilz8aRCWJ2YGI78ykSzCH8vfuFT2pWn0p3ylcsRBwSZa6LPacTSfxwXuozajxJKW6UbQeeuUV2J4Ky1rRfOjtuVknrpSJfIKko1mT3ysdvRHbJ1HpR9d9D+hqb5tmMngdDr6ig5M/wTTMTfsJEPdPdt8wUBqhFoU7YzLuh8VA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OBEhgwhq; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OBEhgwhq"
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-39d29ba04f2so3428535ab.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 29 Aug 2024 09:24:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724948673; x=1725553473; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=KCAgsh0vQHQF+Ra2PV7Da9M6orza3dE//YU23zUGTVQ=;
        b=OBEhgwhqWOwBWsHQiiNFqXS9aDvoA6ZYGHE2vzAKqDWyJ2K1nHe04oSJS12TK9CRGx
         jGbULHzV0Tk2iQVhw6Dr5JM0DY7mfdKdJj6dVry/MJ2pX0r3LjlHAlirb+ak5yKhl/Xd
         fwYt9nuCtJyx+nZx2x+CLXJGhE0gBEZI2DPRWdUV6q4sljbXJEW2JbM98PDU3yYnUZ7m
         jnvJgizdEm7bRxN+APp+4OWNO5erBJC+FvVrZqwrTcQa1oNxM+y4xeypMtsYkgE1wdfq
         5XlcwyfVhNs3u/tcIK6394MeQ9czsdsPy0PTiDt69mWTVaU3lVkDgVonFb2jvjn2l2HG
         l9nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724948673; x=1725553473;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KCAgsh0vQHQF+Ra2PV7Da9M6orza3dE//YU23zUGTVQ=;
        b=HslK4TV38kgKJoMcUMrcdWHbV+zbQno/6/njYhBAOmz2Ldo0zG46jA03sQE8Ns9I97
         V1hJ3cN3uqb1kfcGL8BQk4mFm1ew3iBx+s6hVmr+mN7KQSumqnhV7vhrppZmSP+ZlTZf
         q9wWt7a7U+DfVM5Wd3OujD7vaYKJKk8/BofjKjmwrO1F8zA0GxHNW8KkVC3chV6PsrCA
         Rdt3QFwpOTvKWhCbrjsygr3qNTcYkDej6vZBbRg1n9Y+1No4ADZzbWg2S+SgwIIzQsNu
         gPEOFdZjf5HWU7XTReQ5P8ujCRK3jn5/VRhHDgwnCftnx6MizQ8GQwKYpl5CR5MSXDVO
         6rNg==
X-Gm-Message-State: AOJu0YwLQNCnHHNvJI25HwKWMjRVWqzKgFXrBsvMYeehZCDOT8H764bZ
	mOKS/uIAdPoS8VDhSdfiQlY0sO1AONupYW6h/jZi6Rjl5nHxQrEc4i8sU/BMMzt/HefapAPehh3
	xi7tWMpfCKDq6XLizoL5oCnXqB0Jqe/uI
X-Google-Smtp-Source: AGHT+IFihhkc8AHN+IMOEAPm6qwL+upWZM0y/kKBeNDt3ZMpznyM0sEFsJzExrmUIjlhRSE3aeY4xua3OJeHxlMwERE=
X-Received: by 2002:a05:6e02:1a6a:b0:39d:5203:1636 with SMTP id
 e9e14a558f8ab-39f3788c774mr37410535ab.24.1724948673316; Thu, 29 Aug 2024
 09:24:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: vincent planat <vincent.planat@gmail.com>
Date: Thu, 29 Aug 2024 18:24:20 +0200
Message-ID: <CAChiOE3+fSM2Lms=f3h9CW=sAQSNK5yAjKv7B1Qo7+8k5K-Y6w@mail.gmail.com>
Subject: 'discover-unprovisioned on' does not detect nodes available on other system
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

I'm testing mesh using 2 raspberry PI 5 on which I've recompile &
install the latest 5.77 version
I try a basic test where on
PI-1 I join (mesh-cfgclient) a node
PI-2 I try to discover it

I can discover the node on PI-1 but not on PI-2 .... ?
Same system on both side, same stack, same version

Find below my test case.
If an expert in the community could help me that would be great !!!

Regards

On both PI
sudo systemctl disable bluetooth
sudo systemctl stop bluetooth
in /etc/bluetooth/main.conf, AutoEnable=false then reboot

On PI-1
Terminal-1
sudo rm -rf ~/.config/meshcfg/config_db.json
sudo rm -fr /root/.config/meshcfg/config_db.json
sudo rm -rf /var/lib/bluetooth/mesh
sudo mkdir /var/lib/bluetooth/mesh
sudo /usr/libexec/bluetooth/bluetooth-meshd -nd --debug

Terminal-2
sudo mesh-cfgclient
create

Terminal-3
pyhton3 test-mesh
join
==> here I get: Joining with UUID 346d6b0cf5b8446d9beff2078ec9bfdf

Terminal-2
discover-unprovisioned on
list-unprovisioned
==> Here I get:
Unprovisioned devices:
#1 UUID: 346D6B0CF5B8446D9BEFF2078EC9BFDF, RSSI 0, Server: 0001

Up to here all looks fine

On the PI-2, I try to discover the the un provisioned node active on the PI-1
PI-2 & PI-1 have the same 5.77 bluez stack recompile

On PI-2
Terminal-1
sudo rm -rf ~/.config/meshcfg/config_db.json
sudo rm -fr /root/.config/meshcfg/config_db.json
sudo rm -rf /var/lib/bluetooth/mesh
sudo mkdir /var/lib/bluetooth/mesh
sudo /usr/libexec/bluetooth/bluetooth-meshd -nd --debug

Terminal-2
sudo mesh-cfgclient
create
discover-unprovisioned on
list-unprovisioned
Unprovisioned devices:

====>>>
The problem is that my list-unprovisioned on PI-2 / Terminal-2 does
not retrieve anything

I see nevertheless, on PI-2 (see meshd logs below) some beacon
activity, but I don't understand why I can get them on the
list-unprovisioned

Thanks very much for your support
Regards
user@localhost:~ $ sudo /usr/libexec/bluetooth/bluetooth-meshd -nd --debug
D-Bus ready
Loading node configuration from /var/lib/bluetooth/mesh
mesh/mesh-mgmt.c:mesh_mgmt_list() send read index_list
mesh/mesh.c:mesh_init() io 0x55567219e080
mesh/mesh-mgmt.c:read_index_list_cb() Number of controllers: 1
mesh/mesh-mgmt.c:read_info_cb() hci 0 status 0x00
mesh/mesh-mgmt.c:read_info_cb() settings: supp 0001feff curr 00000080
mesh/mesh-mgmt.c:features_cb() Status: 0, Length: 4
index 0 up:1 pwr: 0 mesh: 1
mesh/mesh-io-mgmt.c:read_info_cb() hci 0 status 0x00
Controller hci 0 not in use
mesh/mesh-io-mgmt.c:le_up() HCI0 LE up status: 0
mesh/mesh-io-mgmt.c:ctl_up() HCI0 is up status: 0
mesh/mesh-io-mgmt.c:ctl_up() done 0 mesh startup
mesh_ready_callback
Added Network Interface on /org/bluez/mesh
mesh/mesh-io-mgmt.c:mesh_up() HCI0 Mesh up status: 0
mesh/mesh.c:create_network_call() Create network request
mesh/node.c:node_create()
mesh/node.c:get_app_properties() path /mesh/cfgclient
mesh/node.c:get_element_properties() path /mesh/cfgclient/ele0
mesh/mesh-config-json.c:mesh_config_create() New node config
/var/lib/bluetooth/mesh/f449ed321026445a888075a0f85f18f6/node.json
mesh/mesh-config-json.c:mesh_config_net_key_add() netKey 0000
mesh/net.c:trigger_heartbeat() HB: 0002 --> 0
mesh/net.c:mesh_net_set_friend_mode() mesh_net_set_friend_mode - 0
mesh/net.c:trigger_heartbeat() HB: 0001 --> 0
mesh/cfgmod-server.c:cfgmod_server_init() 00
mesh/prvbeac-server.c:prv_beacon_server_init() 00
mesh/keyring.c:keyring_put_remote_dev_key() Put Dev Key
/var/lib/bluetooth/mesh/f449ed321026445a888075a0f85f18f6/dev_keys/0001
mesh/mesh.c:create_node_ready_cb() Calling JoinComplete (create)
mesh/mesh.c:attach_call() Attach
mesh/node.c:get_app_properties() path /mesh/cfgclient
mesh/node.c:get_element_properties() path /mesh/cfgclient/ele0
mesh/node.c:build_element_config() Element 0
mesh/node.c:dev_key_send_call() DevKeySend
mesh/mesh-config-json.c:mesh_config_write_seq_number() Seq Cache: 1 -> 30001
mesh/model.c:mesh_model_rx() iv_index 00000000 key_aid = 00
mesh/util.c:print_packet() 43751.675 Clr Rx: 800880
mesh/cfgmod-server.c:cfg_srv_pkt() CONFIG-SRV-opcode 0x8008 size 1 idx 000
mesh/model.c:mesh_model_rx() iv_index 00000000 key_aid = 00
mesh/util.c:print_packet() 43751.675 Clr Rx:
0200f10502000100ff7f050000000600000001000400050008000900
mesh/cfgmod-server.c:cfg_srv_pkt() CONFIG-SRV-opcode 0x2 size 27 idx 000
mesh/prvbeac-server.c:prvbec_srv_pkt() PRV-BEAC-SRV-opcode 0x2 size 27 idx 000
mesh/model.c:send_dev_key_msg_rcvd() Send "DevKeyMessageReceived"
mesh/prvbeac-server.c:prvbec_srv_pkt() PRV-BEAC-SRV-opcode 0x8008 size 1 idx 000
mesh/model.c:mesh_model_rx() iv_index 00000000 key_aid = 00
mesh/util.c:print_packet() 43754.793 Clr Rx: 8052053c
mesh/cfgmod-server.c:cfg_srv_pkt() CONFIG-SRV-opcode 0x8052 size 2 idx 000
PB-SVR: src 0001 dst 0001
mesh/util.c:print_packet() 43754.794 App Tx: 80540001053c
mesh/model.c:mesh_model_rx() iv_index 00000000 key_aid = 00
mesh/util.c:print_packet() 43754.794 Clr Rx: 80540001053c
mesh/cfgmod-server.c:cfg_srv_pkt() CONFIG-SRV-opcode 0x8054 size 4 idx 000
mesh/prvbeac-server.c:prvbec_srv_pkt() PRV-BEAC-SRV-opcode 0x8054 size 4 idx 000
mesh/prvbeac-server.c:prvbec_srv_pkt() PRV-BEAC-SRV-opcode 0x8052 size 2 idx 000
mesh/util.c:print_packet() 43757.940 Set SNB to:
2b01002a9d9d56281cefca0000000005e47ebf08b81ef0
mesh/net-keys.c:net_key_beacon_refresh() Set Beacon: IVI: 00000000,
IVU: 0, KR: 0
mesh/net-keys.c:beacon_timeout() beacon 1 for 1 nodes, period 20, obs 2, exp 3
mesh/net-keys.c:beacon_timeout() beacon 1 for 1 nodes, period 20, obs 2, exp 2
mesh/net-keys.c:beacon_timeout() beacon 1 for 1 nodes, period 20, obs 2, exp 2
mesh/manager.c:scan_cancel()
mesh/model.c:mesh_model_rx() iv_index 00000000 key_aid = 00
mesh/util.c:print_packet() 43814.794 Clr Rx: 8053
mesh/cfgmod-server.c:cfg_srv_pkt() CONFIG-SRV-opcode 0x8053 size 0 idx 000
mesh/prvbeac-server.c:prvbec_srv_pkt() PRV-BEAC-SRV-opcode 0x8053 size 0 idx 000
mesh/net-keys.c:beacon_timeout() beacon 1 for 1 nodes, period 20, obs 2, exp 2
