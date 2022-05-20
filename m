Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2017C433EF
	for <linux-bluetooth@archiver.kernel.org>; Fri, 20 May 2022 17:43:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352318AbiETRnk (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 20 May 2022 13:43:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352316AbiETRnh (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 20 May 2022 13:43:37 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2059.outbound.protection.outlook.com [40.107.220.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46C05132A29
        for <linux-bluetooth@vger.kernel.org>; Fri, 20 May 2022 10:43:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AeCvh0qxQrzAjVlSzmdjHFKmLAtFKOUGfBti8cJ9lOlqOnBIeA+mA+D4CAbyxbCYNGzW3xowV6OOYV1MQxf9h5rbRAFJS7fBhrum7W5vqWXJzj1UIzE6nEVAja1SoTiBwUInK/AxGzoU7ToKNnwpY13NGdmgpD51wR//tCEW/QmhXngGCVxrodWbGkfeh+4QRKHYGnCBRjFhYQv2ooI7TaDWDRS/03yqu2lghuElMi1VYwYu+usTyvugXMFd+IUvdaOp5zz/uwUqvri+QBbkK3yU/q6QHjlF9Z5w1M7GHF/D12hrlJwl0/t2FeSqfGtFhY3JlR6k2XRdgAUq6uTPuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nNYPIcmpZbsObrqz/pEaMrBEDrCqyG7wXX+xQ8Rtnjo=;
 b=A6MMgbfSlsH1f1EMRzTNe0D+oRy+n18ktw6zO+4+uFiwGDycjB4dAhzSOFvhOOmJm99FLdtsmtj+610ynuv4+wbRER/1NnZpa6j8D4Jl7Pc5YQH8aCA6KhW/UQiapZUOCAsxBskBrpiFXEyc2aWlHfF5wK/MeHW6y1GypA0hIt6Ev21Jd2ivdrY115pdkRkH2yNpF0jLIRPCy9i6kBwC2nndfZelyvWKGlYD9ShzVAD+ZLVBlWL+HVTaque5mIBlGFVKNA/5nDW9ZsF2+vt6p/a4eAUVvp3gUhw5WxlOmpw7O8rEHFbSp+sklr+nlWuAXHxlDyV2o7KnC7HAYs8iQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sorenson.com; dmarc=pass action=none header.from=sorenson.com;
 dkim=pass header.d=sorenson.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sorenson.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nNYPIcmpZbsObrqz/pEaMrBEDrCqyG7wXX+xQ8Rtnjo=;
 b=KH/c6GcAFYWca0OKpuMg5wE4f1zbaNlrjui8/6lgfgN9t1kzGpj0ot5087nwd0R8MRHhGt+Y2RPQVt7ACPwqtwgEoUPVf+eYihdszUPFVA58Qy7cjhqtpn9Jod0+4C17Xgy2ggh4Q9DRgLwZUmX73oNqKl7f1P51UT6b5/A9kZcRAVD5YyhD9dbnoKWPw6ijtaHtCGgIO7WQ1ktPQgjRr2gr7OBcka8/hgZwsgX5A6zN+fjxEXlJKd5i+tPEK9rJbAe/Gjrrn/77It/jxWwpgp0RVzT0j/jaDpbU00X6DaBy7V4fpPSPycWnbL72Uk1YvxqvscpYeQsYVpTP3BgLmg==
From:   Thomas Green <TGreen2@Sorenson.com>
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Strange remove problem
Thread-Topic: Strange remove problem
Thread-Index: AdhsbdioXFPwJEWGQoysNz4PF3fIDA==
Date:   Fri, 20 May 2022 17:43:29 +0000
Message-ID: <BYAPR04MB527025DD1E821C76A01987999FD39@BYAPR04MB5270.namprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=Sorenson.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 43e27feb-1980-486d-91aa-08da3a884054
x-ms-traffictypediagnostic: CO6PR04MB7617:EE_
x-microsoft-antispam-prvs: <CO6PR04MB76179692929EA473CDE2E07B9FD39@CO6PR04MB7617.namprd04.prod.outlook.com>
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR04MB5270.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(122000001)(2906002)(7116003)(71200400001)(6916009)(42186006)(64756008)(30864003)(316002)(86362001)(508600001)(38100700002)(38070700005)(66556008)(66446008)(76116006)(26005)(9686003)(186003)(66946007)(66476007)(5660300002)(52536014)(8936002)(3480700007)(8676002)(33656002);DIR:OUT;SFP:1101;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MLggMsIzhO4FIWd3P475bgRIwB7L0rw9iJy7EeRu30hkfqlHRgQyp52Rs4rNiC0g4ijuVt9Txee+3QD9mws+uQVVkdwF6kmMfax+dkiQsP1SF+Y1szaK5DanKn4U5uhydRe+ZNlWgZjQMAwtFQouSfHdZE8dklaj9hfWxQLSsrhSd1VsX2ZHWeMgHaflvTWWHladQCt/1CmhAEN6NMrmOCDu/G4scCEI97KsyAK0swGSca9PUUVobHdINGmQ1K/zcWhN28sHZenN/4eW/UMQZXTaglGtCBlFJap3KL0bgXPlc6L3RsXYUP3m5+sRh2ZbMpibFmSGWqfNeXgMKg9mCwQXw1wXEtDZgowr8/7DG6KVchy5TqnsOC4fRT6SM4XXwvViqiaSvpNtaL9WWpiP90OkRu+dP98i4FsaCtUIy3XOeZRcveGhV3t+8wPqEcnKVbXz48F0danCHoeqP4wDslF4pxDUdfsMSZ1tnggSTezj0Dc1aiUYaTSnOjk2wukbowwafHgRBaz3aPuv4TzNAWJi8Bna4hE+zkqEVdHtxVjG0UnoFbCxKqGZUhWXOdHhN1pa+a8fVIAVDxsx0yMEf/UU8HjjFVa0PGJH7F4GimIk3BfgMLi+1i/VFlc1ZH/pQdUzXCD/JvgEBTWNThbd5TcOV7ZcfpZL5X/2lzZbYCrygeYb3MkkPNDvBwRlqi+h
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?uXTeXNmbrolQfVshA3hIUjC2ez0x+dwvhgdeh5XzSN0dzFVBLiDnJy9cRR4s?=
 =?us-ascii?Q?9r64E0x/qn4Ky0+Uwr3HwxSazcXAIGZedd20qMGMwuMU1INxsvtL8r6XEYuc?=
 =?us-ascii?Q?Fn26g55j+OXBQsvvN35hvFtEn0oqFU0E4L187eKgajBikFpW3reJGt2+i55I?=
 =?us-ascii?Q?k9K++GH1wG2SLr7S3xyZ9GDgs6XNDpffKIEOm1zjN+9sPZPfI5QfehGnop3W?=
 =?us-ascii?Q?vMCNZxWBmSaYChINsawGWzMriF46h9DLvw3n94+vJuT5g5U2iKOW3tj8TPh5?=
 =?us-ascii?Q?GLSj2vwwGbpaSFhwvCuOOt+z3Zew+FFRwmT/bjWRzQJI25Pe45lb4waGQnjD?=
 =?us-ascii?Q?k0erwqFfg3eh8stAVGffIs2VUehxk+RWVmCNwFanZQasuA/+Eokya+ViR/oK?=
 =?us-ascii?Q?0WqUCZsE5OBdMftNDBXUatY7XTaFZ9arf+dMvkSxRa3C5G97L/xKIzX8wgW+?=
 =?us-ascii?Q?RLexV+fkeoKoIhnebRT69/TuISzI5TCqREDdAm/k/KpfPLsxWOLWwCz6v5Rz?=
 =?us-ascii?Q?Xvn0j8s1Dz4hZ58w0ntQ8cIsHdgG4korJCzI6gGvzvWzKgduyhUCnFw3DgxA?=
 =?us-ascii?Q?t9M+WQSIoX4zDTa0B4ZRk/o100ownF+Z0HMKxVcNe+/Q5c/Tlj+LQ1Puw5J/?=
 =?us-ascii?Q?K48CrFcHcGks5oL65o5EOHWFvm4qd4JxYn3F8YMX9KByl2OnrFdSYTHcGOvg?=
 =?us-ascii?Q?DS+4/ayWVW4GBLZIu7sdPvGY3i2MqfiK+Zims+O/6kBHy314RpSdVhVgp0PZ?=
 =?us-ascii?Q?bJ0QciBJU5CdXo56tZYaWjHTFpRd2Oji4K9bqu4YqXK98paaN9FHwlEX45jp?=
 =?us-ascii?Q?7OGCxICbiDS1Y6/j9gRPZ1VNv8NO0wH/6cgpdOwbX4C0Iz96sIHTmU40RQVP?=
 =?us-ascii?Q?WkGftnyszfi8H/m4m1vcMXcpWKepP8Dsl6rQmQfmDKPeDfTwCnBNPuyi1ggd?=
 =?us-ascii?Q?8oJBPF5yhvlZtH1FZ/lh+BaijZLnyCSJ1wKmyKSdqzB8Qs4oU6fjldwDUhbl?=
 =?us-ascii?Q?VCEzrlW3CZVtTrt9yvSzHv39qug/ssPPD9mtYQj++PTQORqvSSrcwLor7LCL?=
 =?us-ascii?Q?0cHZp7GXdTNQWk5ry0WUEz3AU0sN/zv3LVTZuiputzdrSdNC9g3VXlLesOXR?=
 =?us-ascii?Q?04z6nsYl7/dkSZ4osxDeGRv5zRbnv2Rc1owrfnAU9qmjqO8DA4MQvEwRQyx5?=
 =?us-ascii?Q?yLPSFzcuNCAo/sYJe7kivBhLLO+6+STs4PqeO7BdtMZrhwEHFfw8ZuXDaLUK?=
 =?us-ascii?Q?xbmJauZKo73IpN5YbOIe5TpjUIjWgcpx2J67Cwe9ir8hUoGHu3cI/L7gmFL2?=
 =?us-ascii?Q?06wMKzYzAYihkIAALtG6ZN5VPfNToynlhVSZ4PIjd5tPrVDeIgfjJclzJNvG?=
 =?us-ascii?Q?xcQCmzENHvimg5IAzPqUNfZAjSDw/E1pqqxfUb1QQSGP+xikHTbmfaDPWkT5?=
 =?us-ascii?Q?tGDgDlK+veKW+ELp8/ZJjl1YzIQyfrvOctx+Mmwc8F3x+eYEMwB8QYSA/rRN?=
 =?us-ascii?Q?Ka+doVT0ddEYFPEFbyvKO0N9F3RRd1Rkmg+57mfA/aVxZUNle9Z8T3VrqW28?=
 =?us-ascii?Q?bTHr9JRwcwngA2MxwCFmw2095sB9MScsg2qNGOsh8Sg5hxwdnTKjbuOq68zW?=
 =?us-ascii?Q?vGENWBGqYyr5W9yZOSMpjgIcMRGHdatEiaVgGXQpRoXZimB8wvqd2ACWrF0E?=
 =?us-ascii?Q?CeC7hXLPxsTKt7kiiFQseSd6UPqucEiMyqLIgXtL3n42ctWqqICy4sjA6aho?=
 =?us-ascii?Q?E6lkwegf+Q=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: sorenson.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB5270.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43e27feb-1980-486d-91aa-08da3a884054
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 May 2022 17:43:29.5437
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d0f7f33f-8d1f-4ac0-bccd-2ecda8bf422b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Yd2D2KFNEfpooGYJgc1eb8a+C8gLycb5fCf/vxHbBkNCLeTHhJ1qNdiihAopIRZUMWoKienrB4JjwN/fh/Q1AA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR04MB7617
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi.... I have problem when removing a device from use.  I have two identica=
l devices connected to my host.  For each of them I disconnect the device, =
then remove it.  Sometimes it works just fine, and sometimes it seems somet=
hing doesn't finish, and a timeout error is returned.  When it doesn't fini=
sh, I can't do anything any more.  A scan doesn't do anything, and if I try=
 to turn off the scan I get an InProgress error.  Here is a log produced by=
 running=20

bluetoothd -experimanal -debug -n

bluetoothd[3432]: ../bluez-5.50/src/device.c:btd_device_set_temporary() tem=
porary 1
bluetoothd[3432]: ../bluez-5.50/src/service.c:change_state() 0x55fffe0bead0=
: device C4:33:13:80:17:20 profile gap-profile state changed: connected -> =
disconnecting (0)
bluetoothd[3432]: ../bluez-5.50/src/service.c:change_state() 0x55fffe0bead0=
: device C4:33:13:80:17:20 profile gap-profile state changed: disconnecting=
 -> disconnected (0)
bluetoothd[3432]: ../bluez-5.50/src/adapter.c:dev_disconnected() Device C4:=
33:13:80:17:20 disconnected, reason 2
bluetoothd[3432]: ../bluez-5.50/src/adapter.c:adapter_remove_connection()=20
bluetoothd[3432]: ../bluez-5.50/src/adapter.c:adapter_remove_connection() R=
emoving temporary device /org/bluez/hci0/dev_C4_33_13_80_17_20
bluetoothd[3432]: ../bluez-5.50/src/device.c:device_remove() Removing devic=
e /org/bluez/hci0/dev_C4_33_13_80_17_20
bluetoothd[3432]: ../bluez-5.50/src/service.c:change_state() 0x55fffe0bead0=
: device C4:33:13:80:17:20 profile gap-profile state changed: disconnected =
-> unavailable (0)
bluetoothd[3432]: ../bluez-5.50/profiles/gap/gas.c:gap_remove() GAP profile=
 remove (C4:33:13:80:17:20)
bluetoothd[3432]: ../bluez-5.50/src/service.c:btd_service_unref() 0x55fffe0=
bead0: ref=3D0
bluetoothd[3432]: ../bluez-5.50/src/service.c:change_state() 0x55fffe0b4dc0=
: device C4:33:13:80:17:20 profile :1.70/ntouch/app/6e400001-b5a3-f393-e0a9=
-e50e24dcca9e state changed: connecting -> disconnected (-103)
bluetoothd[3432]: ../bluez-5.50/src/device.c:device_profile_connected() :1.=
70/ntouch/app/6e400001-b5a3-f393-e0a9-e50e24dcca9e Software caused connecti=
on abort (103)
bluetoothd[3432]: ../bluez-5.50/src/service.c:change_state() 0x55fffe0b4dc0=
: device C4:33:13:80:17:20 profile :1.70/ntouch/app/6e400001-b5a3-f393-e0a9=
-e50e24dcca9e state changed: disconnected -> unavailable (0)
bluetoothd[3432]: ../bluez-5.50/src/gatt-database.c:profile_device_remove()=
 :1.70/ntouch/app/6e400001-b5a3-f393-e0a9-e50e24dcca9e removed
bluetoothd[3432]: ../bluez-5.50/src/service.c:btd_service_unref() 0x55fffe0=
b4dc0: ref=3D0
bluetoothd[3432]: ../bluez-5.50/src/device.c:btd_device_unref() Freeing dev=
ice /org/bluez/hci0/dev_C4_33_13_80_17_20
bluetoothd[3432]: ../bluez-5.50/src/gatt-client.c:unregister_service() Remo=
ving GATT service: /org/bluez/hci0/dev_C4_33_13_80_17_20/service000a
bluetoothd[3432]: ../bluez-5.50/src/gatt-client.c:unregister_service() Remo=
ving GATT service: /org/bluez/hci0/dev_C4_33_13_80_17_20/service000b
bluetoothd[3432]: ../bluez-5.50/src/gatt-client.c:unregister_characteristic=
() Removing GATT characteristic: /org/bluez/hci0/dev_C4_33_13_80_17_20/serv=
ice000b/char000c
bluetoothd[3432]: ../bluez-5.50/src/gatt-client.c:unregister_descriptor() R=
emoving GATT descriptor: /org/bluez/hci0/dev_C4_33_13_80_17_20/service000b/=
char000c/desc000e
bluetoothd[3432]: ../bluez-5.50/src/gatt-client.c:unregister_service() Remo=
ving GATT service: /org/bluez/hci0/dev_C4_33_13_80_17_20/service000f
bluetoothd[3432]: ../bluez-5.50/src/gatt-client.c:unregister_characteristic=
() Removing GATT characteristic: /org/bluez/hci0/dev_C4_33_13_80_17_20/serv=
ice000f/char0010
bluetoothd[3432]: ../bluez-5.50/src/gatt-client.c:unregister_characteristic=
() Removing GATT characteristic: /org/bluez/hci0/dev_C4_33_13_80_17_20/serv=
ice000f/char0012
bluetoothd[3432]: ../bluez-5.50/src/gatt-client.c:notify_client_unref() own=
er :1.70
bluetoothd[3432]: ../bluez-5.50/src/gatt-client.c:notify_client_free() owne=
r :1.70
bluetoothd[3432]: ../bluez-5.50/src/gatt-client.c:unregister_descriptor() R=
emoving GATT descriptor: /org/bluez/hci0/dev_C4_33_13_80_17_20/service000f/=
char0012/desc0014
bluetoothd[3432]: ../bluez-5.50/src/gatt-client.c:unregister_characteristic=
() Removing GATT characteristic: /org/bluez/hci0/dev_C4_33_13_80_17_20/serv=
ice000f/char0015
bluetoothd[3432]: ../bluez-5.50/src/gatt-client.c:notify_client_unref() own=
er :1.70
bluetoothd[3432]: ../bluez-5.50/src/gatt-client.c:notify_client_free() owne=
r :1.70
bluetoothd[3432]: ../bluez-5.50/src/gatt-client.c:unregister_descriptor() R=
emoving GATT descriptor: /org/bluez/hci0/dev_C4_33_13_80_17_20/service000f/=
char0015/desc0017
bluetoothd[3432]: ../bluez-5.50/attrib/gattrib.c:g_attrib_unref() 0x55fffe0=
c3bf0: g_attrib_unref=3D0=20
bluetoothd[3432]: ../bluez-5.50/src/device.c:device_free() 0x55fffe0b99d0
bluetoothd[3432]: ../bluez-5.50/plugins/policy.c:disconnect_cb() reason 2
bluetoothd[3432]: ../bluez-5.50/src/adapter.c:bonding_attempt_complete() hc=
i0 bdaddr C4:33:13:80:17:20 type 2 status 0xe
bluetoothd[3432]: ../bluez-5.50/src/adapter.c:resume_discovery()=20
bluetoothd[3432]: ../bluez-5.50/src/adapter.c:connected_callback() hci0 dev=
ice C4:33:13:80:17:20 connected eir_len 23
bluetoothd[3432]: ../bluez-5.50/src/device.c:device_create() dst C4:33:13:8=
0:17:20
bluetoothd[3432]: ../bluez-5.50/src/device.c:device_new() address C4:33:13:=
80:17:20
bluetoothd[3432]: ../bluez-5.50/src/device.c:device_new() Creating device /=
org/bluez/hci0/dev_C4_33_13_80_17_20
bluetoothd[3432]: ../bluez-5.50/src/adapter.c:dev_disconnected() Device C4:=
33:13:80:17:20 disconnected, reason 2
bluetoothd[3432]: ../bluez-5.50/src/adapter.c:adapter_remove_connection()=20
bluetoothd[3432]: ../bluez-5.50/src/adapter.c:adapter_remove_connection() R=
emoving temporary device /org/bluez/hci0/dev_C4_33_13_80_17_20
bluetoothd[3432]: ../bluez-5.50/src/device.c:device_remove() Removing devic=
e /org/bluez/hci0/dev_C4_33_13_80_17_20
bluetoothd[3432]: ../bluez-5.50/src/device.c:btd_device_unref() Freeing dev=
ice /org/bluez/hci0/dev_C4_33_13_80_17_20
bluetoothd[3432]: ../bluez-5.50/src/device.c:device_free() 0x55fffe0d5640
bluetoothd[3432]: ../bluez-5.50/plugins/policy.c:disconnect_cb() reason 2
bluetoothd[3432]: ../bluez-5.50/src/adapter.c:bonding_attempt_complete() hc=
i0 bdaddr C4:33:13:80:17:20 type 2 status 0xe
bluetoothd[3432]: ../bluez-5.50/src/adapter.c:resume_discovery()=20
bluetoothd[3432]: ../bluez-5.50/src/device.c:btd_device_set_temporary() tem=
porary 1
bluetoothd[3432]: ../bluez-5.50/src/service.c:change_state() 0x55fffe0bcbe0=
: device C4:53:23:00:38:10 profile gap-profile state changed: connected -> =
disconnecting (0)
bluetoothd[3432]: ../bluez-5.50/src/service.c:change_state() 0x55fffe0bcbe0=
: device C4:53:23:00:38:10 profile gap-profile state changed: disconnecting=
 -> disconnected (0)
bluetoothd[3432]: ../bluez-5.50/src/adapter.c:dev_disconnected() Device C4:=
53:23:00:38:10 disconnected, reason 2
bluetoothd[3432]: ../bluez-5.50/src/adapter.c:adapter_remove_connection()=20
bluetoothd[3432]: ../bluez-5.50/src/adapter.c:adapter_remove_connection() R=
emoving temporary device /org/bluez/hci0/dev_C4_53_23_00_38_10
bluetoothd[3432]: ../bluez-5.50/src/device.c:device_remove() Removing devic=
e /org/bluez/hci0/dev_C4_53_23_00_38_10
bluetoothd[3432]: ../bluez-5.50/src/service.c:change_state() 0x55fffe0bcbe0=
: device C4:53:23:00:38:10 profile gap-profile state changed: disconnected =
-> unavailable (0)
bluetoothd[3432]: ../bluez-5.50/profiles/gap/gas.c:gap_remove() GAP profile=
 remove (C4:53:23:00:38:10)
bluetoothd[3432]: ../bluez-5.50/src/service.c:btd_service_unref() 0x55fffe0=
bcbe0: ref=3D0
bluetoothd[3432]: ../bluez-5.50/src/service.c:change_state() 0x55fffe0b3770=
: device C4:53:23:00:38:10 profile :1.70/ntouch/app/6e400001-b5a3-f393-e0a9=
-e50e24dcca9e state changed: connecting -> disconnected (-103)
bluetoothd[3432]: ../bluez-5.50/src/device.c:device_profile_connected() :1.=
70/ntouch/app/6e400001-b5a3-f393-e0a9-e50e24dcca9e Software caused connecti=
on abort (103)
bluetoothd[3432]: ../bluez-5.50/src/service.c:change_state() 0x55fffe0b3770=
: device C4:53:23:00:38:10 profile :1.70/ntouch/app/6e400001-b5a3-f393-e0a9=
-e50e24dcca9e state changed: disconnected -> unavailable (0)
bluetoothd[3432]: ../bluez-5.50/src/gatt-database.c:profile_device_remove()=
 :1.70/ntouch/app/6e400001-b5a3-f393-e0a9-e50e24dcca9e removed
bluetoothd[3432]: ../bluez-5.50/src/service.c:btd_service_unref() 0x55fffe0=
b3770: ref=3D0
bluetoothd[3432]: ../bluez-5.50/src/device.c:btd_device_unref() Freeing dev=
ice /org/bluez/hci0/dev_C4_53_23_00_38_10
bluetoothd[3432]: ../bluez-5.50/src/gatt-client.c:unregister_service() Remo=
ving GATT service: /org/bluez/hci0/dev_C4_53_23_00_38_10/service000a
bluetoothd[3432]: ../bluez-5.50/src/gatt-client.c:unregister_service() Remo=
ving GATT service: /org/bluez/hci0/dev_C4_53_23_00_38_10/service000b
bluetoothd[3432]: ../bluez-5.50/src/gatt-client.c:unregister_characteristic=
() Removing GATT characteristic: /org/bluez/hci0/dev_C4_53_23_00_38_10/serv=
ice000b/char000c
bluetoothd[3432]: ../bluez-5.50/src/gatt-client.c:unregister_descriptor() R=
emoving GATT descriptor: /org/bluez/hci0/dev_C4_53_23_00_38_10/service000b/=
char000c/desc000e
bluetoothd[3432]: ../bluez-5.50/src/gatt-client.c:unregister_service() Remo=
ving GATT service: /org/bluez/hci0/dev_C4_53_23_00_38_10/service000f
bluetoothd[3432]: ../bluez-5.50/src/gatt-client.c:unregister_characteristic=
() Removing GATT characteristic: /org/bluez/hci0/dev_C4_53_23_00_38_10/serv=
ice000f/char0010
bluetoothd[3432]: ../bluez-5.50/src/gatt-client.c:unregister_characteristic=
() Removing GATT characteristic: /org/bluez/hci0/dev_C4_53_23_00_38_10/serv=
ice000f/char0012
bluetoothd[3432]: ../bluez-5.50/src/gatt-client.c:notify_client_unref() own=
er :1.70
bluetoothd[3432]: ../bluez-5.50/src/gatt-client.c:notify_client_free() owne=
r :1.70
bluetoothd[3432]: ../bluez-5.50/src/gatt-client.c:unregister_descriptor() R=
emoving GATT descriptor: /org/bluez/hci0/dev_C4_53_23_00_38_10/service000f/=
char0012/desc0014
bluetoothd[3432]: ../bluez-5.50/src/gatt-client.c:unregister_characteristic=
() Removing GATT characteristic: /org/bluez/hci0/dev_C4_53_23_00_38_10/serv=
ice000f/char0015
bluetoothd[3432]: ../bluez-5.50/src/gatt-client.c:notify_client_unref() own=
er :1.70
bluetoothd[3432]: ../bluez-5.50/src/gatt-client.c:notify_client_free() owne=
r :1.70
bluetoothd[3432]: ../bluez-5.50/src/gatt-client.c:unregister_descriptor() R=
emoving GATT descriptor: /org/bluez/hci0/dev_C4_53_23_00_38_10/service000f/=
char0015/desc0017
bluetoothd[3432]: ../bluez-5.50/attrib/gattrib.c:g_attrib_unref() 0x55fffe0=
ab990: g_attrib_unref=3D0=20
bluetoothd[3432]: ../bluez-5.50/src/device.c:device_free() 0x55fffe0bc500
bluetoothd[3432]: ../bluez-5.50/plugins/policy.c:disconnect_cb() reason 2
bluetoothd[3432]: ../bluez-5.50/src/adapter.c:bonding_attempt_complete() hc=
i0 bdaddr C4:53:23:00:38:10 type 2 status 0xe
bluetoothd[3432]: ../bluez-5.50/src/adapter.c:resume_discovery()=20
bluetoothd[3432]: ../bluez-5.50/src/device.c:btd_device_set_temporary() tem=
porary 1
bluetoothd[3432]: ../bluez-5.50/src/service.c:change_state() 0x55fffe0b9880=
: device C4:53:23:00:56:A0 profile gap-profile state changed: connected -> =
disconnecting (0)
bluetoothd[3432]: ../bluez-5.50/src/service.c:change_state() 0x55fffe0b9880=
: device C4:53:23:00:56:A0 profile gap-profile state changed: disconnecting=
 -> disconnected (0)


If you could help me figure out why it works in once instance and not the s=
econd, I would very much appreciate it.

Tom Green
