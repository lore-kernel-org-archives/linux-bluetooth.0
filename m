Return-Path: <SRS0=tmcz=3Q=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD0CDC2D0DB
	for <linux-bluetooth@archiver.kernel.org>; Mon, 27 Jan 2020 21:27:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 818F02465B
	for <linux-bluetooth@archiver.kernel.org>; Mon, 27 Jan 2020 21:27:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=silvair-com.20150623.gappssmtp.com header.i=@silvair-com.20150623.gappssmtp.com header.b="h+I9slgB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726323AbgA0V1S (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 27 Jan 2020 16:27:18 -0500
Received: from mail-vk1-f180.google.com ([209.85.221.180]:39246 "EHLO
        mail-vk1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725955AbgA0V1R (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 27 Jan 2020 16:27:17 -0500
Received: by mail-vk1-f180.google.com with SMTP id t129so3022509vkg.6
        for <linux-bluetooth@vger.kernel.org>; Mon, 27 Jan 2020 13:27:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silvair-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=QJhIlaK1Oy5cDVe6wmF6Og0xp+mXChMicBWqFZcFbxQ=;
        b=h+I9slgBLC1MCCKSWXnG9RV39YvvuxuCNg1iyhCfWD4s34w8IyXRB+wAptnC1G0atn
         G1BsmYCR14IyelFbrBwoHJ3+MDq/tFTCa2UJimNlq/v/nl9VJ2suELCWqy237ZNuGgdl
         OZyU89hv1aS29pexqrEwjmpKU914V4rIqHDVDXZhe//0Y2nda4gqVTMg0/25/Ip08o14
         XjdPOi8xa93EVo3TESM3BTXo/wZ9TkfCha/UfOl8GrTWU/Wy1QHcmx/lpp0jvxvofnSj
         /u6una3HPOusKubo7b+itrx0e2thKTAOQgl/Kp9Aj78UPa1MukZ5Alqzdhti+Wf9Ofus
         YXEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=QJhIlaK1Oy5cDVe6wmF6Og0xp+mXChMicBWqFZcFbxQ=;
        b=p7ABkDTz6hoTeFGe5FP1Jj9FD+3J+103tvtWgi76sRIt7zbO7KDTJj/p29kC7dc774
         Ia9K/tCp+Dio2mcCNxKOtuLBA6UEJbO+td6HtGvnat68RiLeOLMSWFQVADFvkKRpYBF8
         14UKf4uH7ySEESRHe1v0djIB1GdUElNcLu1yqgtNvYEsc/QfQTmR6fBwIpoNYQbH5Nnu
         KUrcLmuPf5OHZOZ5C20Kn2Ht/u0lJiOssDTOefll4rTSMhepk+vZYUfLVH+Fh38jPrqe
         QXUkaEjLgHfVld+yH4iJXEu0QMqUhXJKTLLDBYLss4U2TYGiUm3lY0YNQewLFNmD4B8R
         kEEw==
X-Gm-Message-State: APjAAAXLXK3FE40eGTs7NPCgP/fJqSIisluMWnocJUU4ad5RxBIVSVuM
        n25EW8gkut+/cSnqzH+ZjPVCpNBEFFF14s1if5qzbKgdTcY=
X-Google-Smtp-Source: APXvYqzrU6xjUUJi4/KWwFDAtjKveOA/35TNlo54ey4NgijXD6P5UrrPwMGYOAReo4c6ieNWf3jqbYQqnpHEp+UCIwE=
X-Received: by 2002:a1f:7c0c:: with SMTP id x12mr11072250vkc.41.1580160436197;
 Mon, 27 Jan 2020 13:27:16 -0800 (PST)
MIME-Version: 1.0
References: <20200125004350.4640-1-brian.gix@intel.com>
In-Reply-To: <20200125004350.4640-1-brian.gix@intel.com>
From:   =?UTF-8?B?UmFmYcWCIEdhamRh?= <rafal.gajda@silvair.com>
Date:   Mon, 27 Jan 2020 22:27:04 +0100
Message-ID: <CAFcXi1x4skUJuCgQLDswFQm20Hqo8XdAwmGv8qTg+ywKyjPGxg@mail.gmail.com>
Subject: Re: [PATCH BlueZ v2 0/5] mesh: Add NVM storage of Replay Protection List
To:     Brian Gix <brian.gix@intel.com>
Cc:     linux-bluetooth@vger.kernel.org, inga.stotland@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,

sob., 25 sty 2020 o 01:44 Brian Gix <brian.gix@intel.com> napisa=C5=82(a):
>
> Version 2: Fix path construction code when first reading RPL from NVM
>
>
> An oversight led to losing our Replay Protection List with every
> re-boot. This patch-set makes a number of Replay Protect List
> modifications that culminate in adding rpl.c/h, which stores the latest
> iv_index/sequence values for each node that handles an incoming packet.
>
> The first 4 patches, does some maintenance required to handle RPL
> according the the Mesh Specification.

While testing this patch set I've come across the following problem:

After importing and attaching new node to the daemon I tried to
configure new application key by sending dev key message
ConfigOpcode.APPKEY_ADD to self.
This previously resulted in DevKeyMessageReceived reply.

16:40:24.045 MESHD.stderr          INFO 2020-01-27 16:40:24.045
mesh.c:622  attach_call                mesh/mesh.c:attach_call()
Attach
16:40:24.045 DBUS.in              DEBUG /
org.freedesktop.DBus.ObjectManager::GetManagedObjects()
16:40:24.046 MESHD.stderr          INFO 2020-01-27 16:40:24.046
node.c:1311 get_app_properties
mesh/node.c:get_app_properties() path /com/silvair/application
16:40:24.046 MESHD.stderr          INFO 2020-01-27 16:40:24.046
node.c:1158 get_element_properties
mesh/node.c:get_element_properties() path
/com/silvair/application/element0
16:40:24.048 MESHD.stderr          INFO 2020-01-27 16:40:24.046
node.c:1797 build_element_config
mesh/node.c:build_element_config() Element 0
16:40:24.048 DBUS.out             DEBUG /org/bluez/mesh
org.bluez.mesh.Network1::Attach('/', 1141961045074800157) =3D
('/org/bluez/mesh/node83bf3b46810345a28bcce70d8d0b46d3', [[0, []]])
16:40:24.054 DBUS.out             DEBUG
/org/bluez/mesh/node83bf3b46810345a28bcce70d8d0b46d3
org.freedesktop.DBus.Properties::Get('org.bluez.mesh.Node1',
'Addresses') =3D (<dbus_next.signature.Variant object at
0x7f11eaece150>,)
16:40:24.054 APPLICATION           INFO Attached to node
/org/bluez/mesh/node83bf3b46810345a28bcce70d8d0b46d3, address: 05f2,
configuration: {0: {}}
16:40:24.056 MESHD.stderr          INFO 2020-01-27 16:40:24.055
keyring.c:209  keyring_put_remote_dev_key
mesh/keyring.c:keyring_put_remote_dev_key() Put Dev Key
/tmp/pytest-of-ragajda/pytest-74/test_rpl_persistence_after_res0/config/83b=
f3b46810345a28bcce70d8d0b46d3/dev_keys/05f2
16:40:24.057 DBUS.out             DEBUG
/org/bluez/mesh/node83bf3b46810345a28bcce70d8d0b46d3
org.bluez.mesh.Management1::ImportRemoteNode(1522, 1,
b'\x9dm\xd0\xe9n\xb2]\xc1\x9a@\xed\x99\x14\xf8\xf0?') =3D ()
16:40:24.060 APPLICATION.Element0.ConfigClient DEBUG Sending:
/com/silvair/application/element0 -> 05f2 [remote True, net_index 0]
ConfigOpcode.APPKEY_ADD Container(app_key_index=3D0, net_key_index=3D0,
app_key=3Db'c\x96GqsO\xbdv\xe3\xb4\x05\x19\xd1\xd9JH')
16:40:24.060 APPLICATION.Element0.ConfigClient DEBUG Sending:
/com/silvair/application/element0 - > 0001 [remote 1522, net_index 0]
0000000063964771734fbd76e3b40519d1d94a48
16:40:24.063 MESHD.stderr          INFO 2020-01-27 16:40:24.062
node.c:1891 dev_key_send_call          mesh/node.c:dev_key_send_call()
DevKeySend
16:40:24.064 MESHD.stderr          INFO 2020-01-27 16:40:24.063
model.c:604  msg_send                   mesh/model.c:msg_send() (6fff)
0x7ffffffa9fa0
16:40:24.064 MESHD.stderr          INFO 2020-01-27 16:40:24.063
model.c:605  msg_send                   mesh/model.c:msg_send()
net_idx 0
16:40:24.064 MESHD.stderr          INFO 2020-01-27 16:40:24.063
model.c:957  mesh_model_rx              mesh/model.c:mesh_model_rx()
iv_index 00000000 key_aid =3D 00
16:40:24.064 MESHD.stderr          INFO 2020-01-27 16:40:24.063
util.c:46   print_packet               mesh/util.c:print_packet()
39624.063 Clr Rx: 0000000063964771734fbd76e3b40519d1d94a48
16:40:24.065 MESHD.stderr          INFO 2020-01-27 16:40:24.063
model.c:370  forward_model              mesh/model.c:forward_model()
model ffff0000 with idx 7fff
16:40:24.065 MESHD.stderr          INFO 2020-01-27 16:40:24.063
cfgmod-server.c:783  cfg_srv_pkt
mesh/cfgmod-server.c:cfg_srv_pkt() CONFIG-SRV-opcode 0x0 size 19 idx
000
16:40:24.065 MESHD.stderr          INFO 2020-01-27 16:40:24.065
cfgmod-server.c:1036 cfg_srv_pkt
mesh/cfgmod-server.c:cfg_srv_pkt() Add/Update AppKey success: Net_Idx
000, App_Idx 000
16:40:24.065 MESHD.stderr          INFO 2020-01-27 16:40:24.065
model.c:604  msg_send                   mesh/model.c:msg_send() (7fff)
0x5564327d323c
16:40:24.066 MESHD.stderr          INFO 2020-01-27 16:40:24.065
model.c:605  msg_send                   mesh/model.c:msg_send()
net_idx 0
16:40:24.066 MESHD.stderr          INFO 2020-01-27 16:40:24.065
model.c:957  mesh_model_rx              mesh/model.c:mesh_model_rx()
iv_index 00000000 key_aid =3D 00
16:40:24.066 MESHD.stderr          INFO 2020-01-27 16:40:24.065
util.c:46   print_packet               mesh/util.c:print_packet()
39624.065 Clr Rx: 800300000000
16:40:24.066 MESHD.stderr          INFO 2020-01-27 16:40:24.065
cfgmod-server.c:783  cfg_srv_pkt
mesh/cfgmod-server.c:cfg_srv_pkt() CONFIG-SRV-opcode 0x8003 size 4 idx
000
16:40:24.067 MESHD.stderr          INFO 2020-01-27 16:40:24.065
model.c:871  send_dev_key_msg_rcvd
mesh/model.c:send_dev_key_msg_rcvd() Send "DevKeyMessageReceived"
16:40:24.067 MESHD.stderr          INFO 2020-01-27 16:40:24.065
mesh-config-json.c:2111 mesh_config_write_seq_number
mesh/mesh-config-json.c:mesh_config_write_seq_number() Seq Cache: 1 ->
14286

After applying the patch set the same procedure results in:

16:41:04.102 MESHD.stderr          INFO mesh/mesh.c:attach_call() Attach
16:41:04.103 DBUS.in              DEBUG /
org.freedesktop.DBus.ObjectManager::GetManagedObjects()
16:41:04.103 MESHD.stderr          INFO
mesh/node.c:get_app_properties() path /com/silvair/application
16:41:04.104 MESHD.stderr          INFO
mesh/node.c:get_element_properties() path
/com/silvair/application/element0
16:41:04.105 MESHD.stderr          INFO
mesh/node.c:build_element_config() Element 0
16:41:04.105 DBUS.out             DEBUG /org/bluez/mesh
org.bluez.mesh.Network1::Attach('/', 11095264700132944744) =3D
('/org/bluez/mesh/node83bf3b46810345a28bcce70d8d0b46d3', [[0, []]])
16:41:04.110 DBUS.out             DEBUG
/org/bluez/mesh/node83bf3b46810345a28bcce70d8d0b46d3
org.freedesktop.DBus.Properties::Get('org.bluez.mesh.Node1',
'Addresses') =3D (<dbus_next.signature.Variant object at
0x7f27613a2990>,)
16:41:04.110 APPLICATION           INFO Attached to node
/org/bluez/mesh/node83bf3b46810345a28bcce70d8d0b46d3, address: 05f2,
configuration: {0: {}}
16:41:04.111 MESHD.stderr          INFO
mesh/keyring.c:keyring_put_remote_dev_key() Put Dev Key
/tmp/pytest-of-ragajda/pytest-75/test_rpl_persistence_after_res0/config/83b=
f3b46810345a28bcce70d8d0b46d3/dev_keys/05f2
16:41:04.112 DBUS.out             DEBUG
/org/bluez/mesh/node83bf3b46810345a28bcce70d8d0b46d3
org.bluez.mesh.Management1::ImportRemoteNode(1522, 1,
b'\x9dm\xd0\xe9n\xb2]\xc1\x9a@\xed\x99\x14\xf8\xf0?') =3D ()
16:41:04.113 APPLICATION.Element0.ConfigClient DEBUG Sending:
/com/silvair/application/element0 -> 05f2 [remote True, net_index 0]
ConfigOpcode.APPKEY_ADD Container(app_key_index=3D0, net_key_index=3D0,
app_key=3Db'c\x96GqsO\xbdv\xe3\xb4\x05\x19\xd1\xd9JH')
16:41:04.113 APPLICATION.Element0.ConfigClient DEBUG Sending:
/com/silvair/application/element0 - > 0001 [remote 1522, net_index 0]
0000000063964771734fbd76e3b40519d1d94a48
16:41:04.113 MESHD.stderr          INFO
mesh/node.c:dev_key_send_call() DevKeySend
16:41:04.114 MESHD.stderr          INFO mesh/model.c:msg_send() (6fff)
0x7ffffce69290
16:41:04.114 MESHD.stderr          INFO mesh/model.c:msg_send() net_idx 0
16:41:04.114 MESHD.stderr          INFO
mesh/mesh-config-json.c:mesh_config_write_seq_number() Seq Cache: 1 ->
25001
16:41:04.114 MESHD.stderr          INFO mesh/model.c:mesh_model_rx()
iv_index 00000000 key_aid =3D 00
16:41:04.115 MESHD.stderr          INFO
mesh/net.c:net_msg_in_replay_cache() Test Replay src: 05f2 seq: 000001
iv: 00000000
16:41:04.115 MESHD.stderr          INFO
mesh/net.c:net_msg_in_replay_cache() New Entry for 05f2
16:41:04.115 MESHD.stderr          INFO mesh/util.c:print_packet()
39664.115 Clr Rx: 0000000063964771734fbd76e3b40519d1d94a48
16:41:04.115 MESHD.stderr          INFO mesh/model.c:forward_model()
model ffff0000 with idx 7fff
16:41:04.115 MESHD.stderr          INFO
mesh/cfgmod-server.c:cfg_srv_pkt() CONFIG-SRV-opcode 0x0 size 19 idx
000
16:41:04.115 MESHD.stderr          INFO
mesh/cfgmod-server.c:cfg_srv_pkt() Add/Update AppKey success: Net_Idx
000, App_Idx 000
16:41:04.115 MESHD.stderr          INFO mesh/model.c:msg_send() (7fff)
0x55639ab9c8ec
16:41:04.115 MESHD.stderr          INFO mesh/model.c:msg_send() net_idx 0
16:41:04.116 MESHD.stderr          INFO mesh/model.c:mesh_model_rx()
iv_index 00000000 key_aid =3D 00
16:41:04.116 MESHD.stderr          INFO
mesh/net.c:net_msg_in_replay_cache() Test Replay src: 05f2 seq: 000001
iv: 00000000
16:41:04.116 MESHD.stderr          INFO
mesh/net.c:net_msg_in_replay_cache() Message already processed
(duplicate)

It looks like sequence number is correctly incremented when calling
DevKeySend but it isn't incremented at all when ConfigModel sends the
reply back.

--=20

Rafa=C5=82 Gajda
Silvair Sp. z o.o.
