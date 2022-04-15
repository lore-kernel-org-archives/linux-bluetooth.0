Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7424BC433EF
	for <linux-bluetooth@archiver.kernel.org>; Fri, 15 Apr 2022 16:44:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354701AbiDOQqb (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 15 Apr 2022 12:46:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355907AbiDOQq2 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 15 Apr 2022 12:46:28 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-oln040092074091.outbound.protection.outlook.com [40.92.74.91])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55C92DCE22
        for <linux-bluetooth@vger.kernel.org>; Fri, 15 Apr 2022 09:43:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fo5GFy0EmoFvbDZMY4lcVN8W1ty+sGibvbujhoh3SO445IbYu11yiCF1i9GaBvyKZ89X39xax2dITUZYmJ8JRK2ScglxZOuy3q/IHjtX8O5HGQGuhFTw3GlDJ6Nm2LfXqNCo/OMBenO1ItgB9ilh+8JXv7zHlEi53+J9MvMzPtiR6dHxjio1YWIDdKGx1wGLhgkgr3YlNnNGdh48tLuAeQqcA2As4Z7ZM9Fu1XpOuOW89X1vBjqRhfis2AWF8J0LFMuk5w0BipiXJNIn+6IQ2FMUVEVtFP2HFNoouTFg+ToX/ZcS3MgYwGLQOf5RXq8PFFQpVGc32qxt4WveOdNgIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UnqcIb/OlNxNTMV1+fhojvzahHvbehJgp3yBNhQp7E0=;
 b=cqWPMFP0ARuzBPCWzG0WLQtlJQhvU44SxnsBe83gGN6FYCRphjEpeYhHqQoQDIysXbox1OKkyaAyID6CWyGc7VKLuJZCwXzUfGai3v2A9KVPlGwkwuYOXGvAPlc7Y168gJotJJ8STBVn251RtgfTQJyvjLlycgPlsZsO5l4WGRpxfG4MUz1XFA484H1397i2yYFqG2YdEG8E5G1Jk3PPkFaBjLBrZsyYt/nTfrRR0YF3YZEY7f6cc76IY+eteGtQ12neCfVPg8v1AyJcs7lpcZJThQmwoWKM2+O4c78mGsZxGQgW5WIzJnsy1uZzo2cCeqTST1ehScWA9f5nEz3QHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UnqcIb/OlNxNTMV1+fhojvzahHvbehJgp3yBNhQp7E0=;
 b=t1ojU/FAU6EuTmOc+SfTOo8rNUKQ141Bsdyy7MT4uTcYtgZZESCMMgRqYFuSY/hKnRQCW3BhFWegzGKZp67vgMfaJflm264pkWwL8o6OD1j4rueU4nzzwykpZ7WDGXG3ZbW8WGhU4EhcS6xThRlCuem2nzQ6kEWMvaJ45hGsa5IlGBKQgOXq+AbghcvUh1mzdMLNqp79hr75rYHhUeIQhw+f4xdOGdB2rfCVkOTYI07BBfdr05+EwzKscYfXl9Eg5LH624pfVsOf1YrpOeV1i3+nO+30GMwy02VoXnijOT73EUiLa8i9BX1umej3CDfxDG4YBiBYBWoc9QWitd5KxA==
Received: from VI1PR09MB4239.eurprd09.prod.outlook.com (2603:10a6:800:12f::23)
 by DBBPR09MB3029.eurprd09.prod.outlook.com (2603:10a6:10:f0::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20; Fri, 15 Apr
 2022 16:43:57 +0000
Received: from VI1PR09MB4239.eurprd09.prod.outlook.com
 ([fe80::dcb2:a4a2:335a:98ec]) by VI1PR09MB4239.eurprd09.prod.outlook.com
 ([fe80::dcb2:a4a2:335a:98ec%3]) with mapi id 15.20.5164.020; Fri, 15 Apr 2022
 16:43:57 +0000
From:   Isak Westin <isak.westin@hotmail.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Isak Westin <isak.westin@hotmail.com>
Subject: [PATCH BlueZ 0/1] mesh: Use correct net_id for received CTL messages
Date:   Fri, 15 Apr 2022 18:43:34 +0200
Message-ID: <VI1PR09MB4239A3A5435BB78BD76C74F9E3EE9@VI1PR09MB4239.eurprd09.prod.outlook.com>
X-Mailer: git-send-email 2.20.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [aM3rzLzD5z/M2y3EpCNreGzAko47jTmr]
X-ClientProxiedBy: ZR0P278CA0135.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:40::14) To VI1PR09MB4239.eurprd09.prod.outlook.com
 (2603:10a6:800:12f::23)
X-Microsoft-Original-Message-ID: <20220415164335.24808-1-isak.westin@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8d37abf2-c683-4ce6-e5d3-08da1eff228d
X-MS-Exchange-SLBlob-MailProps: citmFLqyTFTOx5Cd44ygS5aHUNPKNxySkrV6htp3FB4gcKzvOlvjFSaQovf8v+lZPg4tWdFpFXzTZ6YUngchb9Qa/wuBfPGmtvI96jvlV+K/tV7Qo/6KoGWRE0C+/RKd4qPLIEpQ5qmSPCOmoWIAO8PkfeuKgr2gxCU7w6oCDguCdER8gbKX4Do58rjHzQtNyiEEaKGivmpHV8984tQROCDsuXiGU7gvLrUYJ1wBBXu1NJYmMHHkWX4xr1i//KyEi7zLFoEZuJEU5YTPckXZAC245Qg61A7MhF4TcqnOjn7H4mcjLhZs3evP/EgJoQOw3DAVzo6lvrPk2IstCqaM1Hv7N4S3fUna98xkrrwfEyq/TgF6bizTPtNMoYobdoWKnZvrzs98rTnhfuXf0NVMUukO6TmZ+RNkdlRHOI7kN2bsZf01xevllGoBwprOajmfnIlAWiXhVQ40J2JQpJSZGWaQ350VMcIXNU1C7zHRNV+UFCOUTdWfn6vWblF4znLKi5gPrWB3EGTZVVq0hFrqLVwdLclugdM3Ram9lxSxpptzU3X0SI/ZugavFQSSBmMTF54b+z2bnddaBboZNtak1JbTnIYBW9+GCRxb8uBisK5dJ/LEeQnLwhr1uC4e9oYuBnYsK4UBDYv184qKpZ+EXS/vsSTpPEIO75HHmIfUkJt5klA56HQwn2C+zI9prhnHtqaHldiCEHNsKDsFYztUW6VDvfPX3Gj+0R69egRgGtCQ4+gI7dwszuu1xLsnVCxCt8qC5LW85oqW63t9MiECjJ7eUVcfBDbrtwI0S804xHI=
X-MS-TrafficTypeDiagnostic: DBBPR09MB3029:EE_
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yyjJvV18593g4NeKdvkztop/nARSP0qV3nKE/z1CLodzl1INPsLp6flbjJINv1KqxAXbrmllN9hGyCkEEviIa0YDm/wnetHMaa3N1qw9MQ1hc/P6Hy3/L0I2n9yoqf9gbmSYPr10NTp2AELq1P3ysaSWv/0r5wnkSu0SH4qS86Orlts1o88GWClxUu9muTxvjp85tmnnCB4XqZp+Gdcybdf7YUiYcTqPsLXXoZQybsmV469qa7M/qUStOFa0s2mbn89xGhnKRMPXFCLVYbC3zuml/TiHlzokHMx8ilJbLH5B5Tt5g93UnGoPtZiqvayQqGYx41kcKYpBow//UjdPLicTRAnR+hSNVxxyjfTqk1MJ/OM28XyYHhvEqImvErPTuxkBzb2d7f7FheRgflP6xlh3BSGiLBKHSeme6DGPmH1e0jK0PXE5ygOEHU0SBHx4Rjwymsmhv/EEKj3McmtJ3wpGNBvqRzRz68Z4+iSLlZHkDrS9Mxfn9Mgc0lYgAurTkdd6n0LZ8JymBhgvtXzw1Zjs8QK7+tlTb/kNYGaECpLhwGqq4hY51Z3Vx/adAJ6+9pilDwypkn7doHWlXsoR0A==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Zd1puukzZ/qeYEbpEg0z6sI12HYV+EobisWRifZCsA4ZCAQYKZZQccUT0dOb?=
 =?us-ascii?Q?gG/V1vDgJqAA+qewK0i6okGYBPDCPPBDlWXQAUT5vBJi9bYY/M2Y9V2DPAe2?=
 =?us-ascii?Q?e7zMofVilqXPTdpmBd0TZCXr6Pa/S0VN51vkUDhL/vyGizlemDj9sid16T2I?=
 =?us-ascii?Q?u5oPlCyCdtsOHRoAQlC+fyY94hf8fDXm4oHSbxQq9FvM4orx6OXf0flkeSTj?=
 =?us-ascii?Q?gCpQc+W5FxwcQ9vSt038Fu0ynRB1H2vyAJ5FaVmoQTijYAjxb9h+F8ku6pQf?=
 =?us-ascii?Q?48pSD7TJYTPnp5MOcQQRJLZhhDwd9Yrej6yB+S3xTDChfAI38pzppDGsdzjR?=
 =?us-ascii?Q?f+EFltgN7FDbSiRZ0DP0/pVCnLmJQBv7Q5eZYjqkyfvP/Ac0ogE8nfTe3aTI?=
 =?us-ascii?Q?lW8LQjiYVpYBPFVtOJ6nm4PkLZmDOkB/2T20L/voJ5mL1pDnOuRC3VTSwLaO?=
 =?us-ascii?Q?mumxzLTsUrR4qcTg2/8y12GXeP1A5wLCOzAPMWBSpzAmJ3xutZxf5tXEIeJa?=
 =?us-ascii?Q?FgZVt+t8TQBSdoB3wWVkDb/sd53nFGZYOU6Q42sGDEQqS2sIaVYl/YjKXMXu?=
 =?us-ascii?Q?CHeAnRDpZgmD11aPz5rZonuTCsERxsZ1/GPdDGY9b2aZatk7tNj6sZpKE/bZ?=
 =?us-ascii?Q?lx3kSwXOrV5gEKrBwwhqo90yzqNEjUQwGTcK/moALGmJwol1HKCI+VePdnnn?=
 =?us-ascii?Q?VQftjnpwZOstN62f7L0K29TS9NduRuMe6j372rCOOP4USFBMckN6hV7heuWI?=
 =?us-ascii?Q?FG9gQPa3LGfq3drjVZt1rJU2HMe12UELwBweLGMjVn7vJUQjSISDDsvuVQ1O?=
 =?us-ascii?Q?W+npxKrZaR9kppYH20lOLBr5OwYXyaoqjFg3HI0XiXBLgnZYs+bhyDt6s0FC?=
 =?us-ascii?Q?juIUX/u6rnFI9yPaxQrS/iP0RSQzdEgRd1zaKSR435Bth8F5gzsNggJsE/x4?=
 =?us-ascii?Q?9qE5Y9fEV34Ej5VVa2T7oKfH7AzByRJoNQHx+eVtGBwZmhNkb0hC5QKaVQw0?=
 =?us-ascii?Q?UMGwfdiYBnPhfP4mMTKo+eGFhAxLwtorRJSnPpJ+gOTG4k12h5EOevH666Sm?=
 =?us-ascii?Q?qJWT6l0Tz+DTY5ifAFXUgBqhKEamQEdROHwi7T/y6KzfAp6A2TJ3aZMzEScC?=
 =?us-ascii?Q?JB+RiJBFScEteewWZi6JPQJtwU986IhaiZaPQPTQ+ZE/i383UmK2IVnVjFQZ?=
 =?us-ascii?Q?IuphSmKHuv090lp/ZBi1TxirEKOUaztBCZpqF9yfj/PpyQCMj7ZwSFiKc0Ou?=
 =?us-ascii?Q?9GaieZa7LILCrDDbSOBjpugMIhe7Tv+Z/YkVrjYK/DQJoGDSpvK511M939xR?=
 =?us-ascii?Q?wEnlOeiMz9OgMcqpvnnPTJuberwAl+3Ze4dQ1vnr1w8/YyHXokjJ6zMoP2uJ?=
 =?us-ascii?Q?Gff5epGnLmzHHiytVOZqg2EvTN0dziUQWeK4miHhDPBS19QOl2vo+hlPCSnW?=
 =?us-ascii?Q?JOXArKNkmKL+UR/aHqxTVWiBunlMOhD4?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-64da6.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d37abf2-c683-4ce6-e5d3-08da1eff228d
X-MS-Exchange-CrossTenant-AuthSource: VI1PR09MB4239.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2022 16:43:57.3595
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR09MB3029
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,

I had an issue that the mesh-daemon local node never responded to
friend requests. After some debugging I found that the net_key_id
passed to the ctl_received function (used to look up the network
key index) always was uninitialized. And I noticed that the wrong
variable is passed to the function. It looks like this was just a
mistake from this commit id: 7083cad2fb42fbd9640ee55df4225d921a83e2d0


Isak Westin (1):
  mesh: Use correct net_id for received CTL messages

 mesh/net.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

-- 
2.20.1

