Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FB06C43334
	for <linux-bluetooth@archiver.kernel.org>; Tue, 19 Jul 2022 14:18:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238260AbiGSOSG (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 19 Jul 2022 10:18:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237654AbiGSORt (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 19 Jul 2022 10:17:49 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2105.outbound.protection.outlook.com [40.107.104.105])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A98537B1FA
        for <linux-bluetooth@vger.kernel.org>; Tue, 19 Jul 2022 06:50:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=exLueYbNWS54zcrGP2EmSeHwfUAtBXCpu+U8sI0Pc8WMz5NjTs4gxlLdtbUxIy9NtFYKEv8VpbIAMaRioadHCVyE0BjMh06WVY3kqPQYiTIKRo02w/KsGnLwlT3QPe71y1I0Q3OWV7PSrDbLFa3EmK4pmaFw+RV8FN2rIq3qJHR9i4IYU3IGMbcaM3FMksbX7MmBITs7CAda16PNcwp3AC/BYvq9iEBt3lSu1vfLXQtq6MyjGNpkBWKwsJ6SVoQ6yJ58w4snlU+vDNH4vVY7+K5Sk/h10V3sDoowmtaS7ST/nk+u7tC0KPzKRxplyKG+7kZL+UlyIXb/evqm6yopvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SU+dibBy5MPJWeNiBy5ny8bdZ/kc5UyOpZ9qoG+r/UA=;
 b=S6+QaalZ8/infXe4cIpSl7+sCt+40RypDu3zxXw63K4ereU3qvTYUCYR+zdoa3fNxKN3wHE5woQ/xckf10w4KGQR5cr0VqrTQwsa2hFA38G0xsdmt3r3UPvisfFz4KVvFhFOAZ7IF3rSVE+9/eXZzSTuXxUDminEMqRWxLJwNiIOv5mc+qx6TdLePWYaWwk05o9v3ACocXKYUw58Cp1nhbaV6uGiaCCuj7hkgXsZBg3XxKXD26GjfKLUm+iofO3fMEw2+GwxNv8z1WPLmr/7j28SyOSvdsyPg6SvN2XD9ui+0GFLdWjAPgzxvKwrAvgZWNe5sJH0DVRqbGOwqAStpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 217.111.95.7) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arri.de;
 dmarc=none action=none header.from=arri.de; dkim=none (message not signed);
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=arrigroup.onmicrosoft.com; s=selector1-arrigroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SU+dibBy5MPJWeNiBy5ny8bdZ/kc5UyOpZ9qoG+r/UA=;
 b=OFzcACrdEiKmlvLKW/qP/RgtdbAxdflSZVWUAFFQd4KprL69Px2U8sd/9V7oGgS6SpWwKRfGl+QsDtX7c4zW0xnzZ2ZV+wPhyuB6HkQ7QW5HD6wzntVU1abo6L3bXHASKpeRUovhJWD5mmTh2u5P7582doCbW9r5Mlkh5hrseL8=
Received: from FR0P281CA0147.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:96::11)
 by DB7PR07MB4795.eurprd07.prod.outlook.com (2603:10a6:5:30::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.16; Tue, 19 Jul
 2022 13:50:37 +0000
Received: from VE1EUR02FT083.eop-EUR02.prod.protection.outlook.com
 (2603:10a6:d10:96:cafe::58) by FR0P281CA0147.outlook.office365.com
 (2603:10a6:d10:96::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.9 via Frontend
 Transport; Tue, 19 Jul 2022 13:50:37 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 217.111.95.7)
 smtp.mailfrom=arri.de; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arri.de;
Received-SPF: Fail (protection.outlook.com: domain of arri.de does not
 designate 217.111.95.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=217.111.95.7; helo=mta.arri.de;
Received: from mta.arri.de (217.111.95.7) by
 VE1EUR02FT083.mail.protection.outlook.com (10.152.13.186) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5438.12 via Frontend Transport; Tue, 19 Jul 2022 13:50:37 +0000
Received: from n95hx1g2.localnet (192.168.54.60) by mta.arri.de (10.10.18.5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 19 Jul
 2022 15:50:36 +0200
From:   Christian Eggers <ceggers@arri.de>
To:     <linux-bluetooth@vger.kernel.org>
Subject: Kernel warning during unpairing while bnep connection is active
Date:   Tue, 19 Jul 2022 15:50:35 +0200
Message-ID: <4729616.GXAFRqVoOG@n95hx1g2>
Organization: Arnold & Richter Cine Technik GmbH & Co. Betriebs KG
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Originating-IP: [192.168.54.60]
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 769d863b-5e3a-40f6-8688-08da698da8eb
X-MS-TrafficTypeDiagnostic: DB7PR07MB4795:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lRBdhf01GxoHUS633yAIcsCGGXH7hJzxOR/9koa7Nch+o3DuRgSvfnSG4m/s0GYwjzfETyob0ga0kFxhODLCBPBttutGuYhD3IYMCVueKvRDXLg53/Rj8yTKDNwWzAU/EvrHqEHb8HmrStPWl4HsF6E55/Le93856VPMoWbnnI1eUrIdMkbupSMfqQdaHJNLjdUbXPe72W4RM7gJNkByNaIzx0fbvkgirvcZZeMc2uL8HweLDvhYbQEy/ZhZk1Rb8yvevxTwMQtwSrOOlG7ZEuNhR1BoMnahZsm/KooWrUuMSxt4l7TXnpWQc5E342ocYJ+f0XLcKv+NwDZJShtrACnFgrieNZ4x47BbKa0ydyVHU+nwEYmebfLamEh0m6EOU30Akro/hplzDoUOwyfmXr2j2OkGkZ5flTcJPPmShYTijTLShurMDFU/Jv/Ubx1IbvhF2jZA3gVMPNNM+15plUkSKHy1bFEeBPejjguBk/T8ckC9g5mvJXbZuiejsYc4yl7NgC0cCf8yDfmdyNLJuKTk4ndlGtf8yh9Pf0MfWM1mTFtEP3XnvmbCz6J6mpVarB8BUHh7BbxZ/FijyvEFHaD9fxOS26OtTsjVcjuyjPDRlbhIbPYljEFAP9ri7BGSgx3ACG1c5USWdMOsVo1SITUzGaqychryIINMBqP1EBpKUPH51xOWJmmubceugZEABBVp8HNXJthYJzXunvAYGrK/0W5eTr/yUtGc0e1X0DHJZ9YfcVXrBiQRo8TQZBRJMLgZxM2Fy3FrNU44ZOHRwau2rAcM3f9yH7k2p5193ZFF46WyK8e6sM8GASBgcVyptN3vg0xB/WgqqkTB0sUuMARf/JRts6LkeKu+15RKlK8=
X-Forefront-Antispam-Report: CIP:217.111.95.7;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mta.arri.de;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(376002)(396003)(136003)(39850400004)(346002)(46966006)(36840700001)(70586007)(8936002)(478600001)(81166007)(41300700001)(2906002)(70206006)(5660300002)(9576002)(8676002)(36916002)(186003)(9686003)(26005)(86362001)(82310400005)(316002)(6916009)(33716001)(356005)(36860700001)(16526019)(82740400003)(40480700001)(45080400002)(83380400001)(336012)(426003)(47076005)(36900700001);DIR:OUT;SFP:1102;
X-OriginatorOrg: arri.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2022 13:50:37.1190
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 769d863b-5e3a-40f6-8688-08da698da8eb
X-MS-Exchange-CrossTenant-Id: e6a73a5a-614d-4c51-b3e3-53b660a9433a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e6a73a5a-614d-4c51-b3e3-53b660a9433a;Ip=[217.111.95.7];Helo=[mta.arri.de]
X-MS-Exchange-CrossTenant-AuthSource: VE1EUR02FT083.eop-EUR02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR07MB4795
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Target: 
- linux-5.15.49-rt47
- ARMv7l (i.MX6ULL)
- Yocto/OpenEmbedded Kirkstone
- bluez-5.64

Peer: Sony Xperia 10 III (phone with Bluetooth Tethering enabled)

Setup: Target+Peer are in paired state. A bnep connection from the
target system to the phone has been established (via NetworkManager).

When I try to remove/unpair the target on the phone side (without
disconnecting before). I get a kernel warning (about 50% reproducible):

[   24.922884] Bluetooth: BNEP (Ethernet Emulation) ver 1.3
[   24.922932] Bluetooth: BNEP socket layer initialized
[   46.225493] ------------[ cut here ]------------
[   46.225512] WARNING: CPU: 0 PID: 466 at fs/sysfs/group.c:279 sysfs_remove_group+0x2d/0x5c
[   46.225551] sysfs group 'byte_queue_limits' not found for kobject 'tx-0'
[   46.225558] Modules linked in: cmac bnep usb_f_mass_storage usb_f_ncm u_ether libcomposite configfs ebt_ip ebtable_broute ebtables x_tables btusb btbcm btintel bluetooth sd_mod jitterentropy_rng drbg ksz9477_i2c ksz9477 tag_ksz ksz_common dsa_core st_magn_spi phylink st_sensors_spi regmap_spi bridge st_magn_i2c st_sensors_i2c stp st_magn rtc_rv3028 ecdh_generic llc as73211 ecc st_sensors industrialio_triggered_buffer at24 kfifo_buf regmap_i2c i2c_dev imx_thermal spidev imx_fan usb_storage leds_pwm leds_gpio led_class scsi_mod scsi_common iio_trig_sysfs imx6sx_adc industrialio micrel fec ptp pps_core imx_napi at25 spi_imx i2c_imx imx_sdma virt_dma
[   46.225809] CPU: 0 PID: 466 Comm: kbnepd bnep0 Not tainted 5.15.49-rt47 #1
[   46.225823] Hardware name: Freescale i.MX6 Ultralite (Device Tree)
[   46.225838] [<c0107bc1>] (unwind_backtrace) from [<c01069ff>] (show_stack+0xb/0xc)
[   46.225868] [<c01069ff>] (show_stack) from [<c03a7589>] (dump_stack_lvl+0x19/0x1e)
[   46.225897] [<c03a7589>] (dump_stack_lvl) from [<c0114b89>] (__warn+0x79/0xa0)
[   46.225924] [<c0114b89>] (__warn) from [<c03a5485>] (warn_slowpath_fmt+0x31/0x54)
[   46.225949] [<c03a5485>] (warn_slowpath_fmt) from [<c0208c11>] (sysfs_remove_group+0x2d/0x5c)
[   46.225979] [<c0208c11>] (sysfs_remove_group) from [<c03445ef>] (netdev_queue_update_kobjects+0xa3/0xc8)
[   46.226006] [<c03445ef>] (netdev_queue_update_kobjects) from [<c034464f>] (netdev_unregister_kobject+0x3b/0x5c)
[   46.226028] [<c034464f>] (netdev_unregister_kobject) from [<c032be99>] (unregister_netdevice_many+0x329/0x378)
[   46.226056] [<c032be99>] (unregister_netdevice_many) from [<c032bf3f>] (unregister_netdevice_queue+0x57/0x64)
[   46.226083] [<c032bf3f>] (unregister_netdevice_queue) from [<c032bf5d>] (unregister_netdev+0x11/0x18)
[   46.226108] [<c032bf5d>] (unregister_netdev) from [<bfa0b54b>] (bnep_session+0x3d9/0x432 [bnep])
[   46.226180] [<bfa0b54b>] (bnep_session [bnep]) from [<c0126029>] (kthread+0xcd/0xdc)
[   46.226217] [<c0126029>] (kthread) from [<c0100119>] (ret_from_fork+0x11/0x38)
[   46.226238] Exception stack(0xc5259fb0 to 0xc5259ff8)
[   46.226251] 9fa0:                                     00000000 00000000 00000000 00000000
[   46.226263] 9fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
[   46.226274] 9fe0: 00000000 00000000 00000000 00000000 00000013 00000000
[   46.226782] ---[ end trace 0000000000000002 ]---
[   46.705223] ------------[ cut here ]------------
[   46.705237] WARNING: CPU: 0 PID: 466 at fs/sysfs/group.c:279 sysfs_remove_group+0x2d/0x5c
[   46.705273] sysfs group 'statistics' not found for kobject 'bnep0'
[   46.705280] Modules linked in: cmac bnep usb_f_mass_storage usb_f_ncm u_ether libcomposite configfs ebt_ip ebtable_broute ebtables x_tables btusb btbcm btintel bluetooth sd_mod jitterentropy_rng drbg ksz9477_i2c ksz9477 tag_ksz ksz_common dsa_core st_magn_spi phylink st_sensors_spi regmap_spi bridge st_magn_i2c st_sensors_i2c stp st_magn rtc_rv3028 ecdh_generic llc as73211 ecc st_sensors industrialio_triggered_buffer at24 kfifo_buf regmap_i2c i2c_dev imx_thermal spidev imx_fan usb_storage leds_pwm leds_gpio led_class scsi_mod scsi_common iio_trig_sysfs imx6sx_adc industrialio micrel fec ptp pps_core imx_napi at25 spi_imx i2c_imx imx_sdma virt_dma
[   46.705529] CPU: 0 PID: 466 Comm: kbnepd bnep0 Tainted: G        W         5.15.49-rt47 #1
[   46.705546] Hardware name: Freescale i.MX6 Ultralite (Device Tree)
[   46.705560] [<c0107bc1>] (unwind_backtrace) from [<c01069ff>] (show_stack+0xb/0xc)
[   46.705590] [<c01069ff>] (show_stack) from [<c03a7589>] (dump_stack_lvl+0x19/0x1e)
[   46.705617] [<c03a7589>] (dump_stack_lvl) from [<c0114b89>] (__warn+0x79/0xa0)
[   46.705644] [<c0114b89>] (__warn) from [<c03a5485>] (warn_slowpath_fmt+0x31/0x54)
[   46.705669] [<c03a5485>] (warn_slowpath_fmt) from [<c0208c11>] (sysfs_remove_group+0x2d/0x5c)
[   46.705699] [<c0208c11>] (sysfs_remove_group) from [<c0208e65>] (sysfs_remove_groups+0x17/0x18)
[   46.705724] [<c0208e65>] (sysfs_remove_groups) from [<c02aa02d>] (device_remove_attrs+0x2b/0x52)
[   46.705754] [<c02aa02d>] (device_remove_attrs) from [<c02ab29d>] (device_del+0xf5/0x214)
[   46.705780] [<c02ab29d>] (device_del) from [<c032be99>] (unregister_netdevice_many+0x329/0x378)
[   46.705807] [<c032be99>] (unregister_netdevice_many) from [<c032bf3f>] (unregister_netdevice_queue+0x57/0x64)
[   46.705834] [<c032bf3f>] (unregister_netdevice_queue) from [<c032bf5d>] (unregister_netdev+0x11/0x18)
[   46.705860] [<c032bf5d>] (unregister_netdev) from [<bfa0b54b>] (bnep_session+0x3d9/0x432 [bnep])
[   46.705905] [<bfa0b54b>] (bnep_session [bnep]) from [<c0126029>] (kthread+0xcd/0xdc)
[   46.705939] [<c0126029>] (kthread) from [<c0100119>] (ret_from_fork+0x11/0x38)
[   46.705962] Exception stack(0xc5259fb0 to 0xc5259ff8)
[   46.705977] 9fa0:                                     00000000 00000000 00000000 00000000
[   46.705989] 9fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
[   46.706000] 9fe0: 00000000 00000000 00000000 00000000 00000013 00000000
[   46.706007] ---[ end trace 0000000000000003 ]---


I don't get this kernel warning if I disconnect first (from the phone) before unpairing.

It looks like the device is simultaneously removed from "the other end"
at the same time when unregister_netdev() is active:

worker_thread()
+-process_one_work()
  +-hci_rx_work()
    +-hci_event_packet()
      +-hci_disconn_complete_evt()
        +-hci_conn_del()
          +-hci_conn_cleanup()
            +-hci_conn_del_sysfs()
              +-device_del()


regards
Christian



