Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4E3BC43334
	for <linux-bluetooth@archiver.kernel.org>; Tue, 12 Jul 2022 19:19:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234556AbiGLTTp (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 12 Jul 2022 15:19:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236086AbiGLTTR (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 12 Jul 2022 15:19:17 -0400
Received: from mail2.multitech.com (spx.multitech.com [65.126.90.11])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 5E190113CB4
        for <linux-bluetooth@vger.kernel.org>; Tue, 12 Jul 2022 11:56:26 -0700 (PDT)
Received: from mail2.multitech.com (localhost.localdomain [127.0.0.1])
        by localhost (Email Security Appliance) with SMTP id B55E7585C0D_2CDC3D9B;
        Tue, 12 Jul 2022 18:56:25 +0000 (GMT)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2171.outbound.protection.outlook.com [104.47.55.171])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by mail2.multitech.com (Sophos Email Appliance) with ESMTPS id 3997C585C0A_2CDC3D9F;
        Tue, 12 Jul 2022 18:56:25 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eh5tZyGmsjUI7A5ZQkTTa9ezDqPrurVBsKBgOo/d2EggtcGDh/pfHicETBBBEN0xyZnzudJEvuwl+hIEmQcsfLnREIcd8XD61OgodU1t5uUsghKUQGsxFBTYpeP8OYUQGaxo/pqU494xZ4DXJR7kjmuz3AsH4w4wo5fX7D89NZDjmCuaLiHaL4d3494tegkkSK+zBBigmyCQ+PGluIC9aCojcJGHqAtOuud0skU72wQ13bJTBKDdIXI1opDdkSqCxPbk4YcJAXM9LjRxs86JNNDmEuW3TOPBSD5qVnoqNnXYPs3jhFhhkfkx6RJTQaNjlIXrDVuP7Yl1CyxwIqbWVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+cAwDRXS4epLf1XukOakgFBcJl1OpwjZ5YUAwb3aQpY=;
 b=KC6XDnepyN6c20yUE0HuZVn1h7xJOSDSnae7h3kjAcu+8fTDZd4Z1J2g+AJd7hFL/nfy2bPgKnkkWYDvHBhVU+Z4xxkl8DubOjHUu0khOIKhJlVB5HkYXTg3WDm0X5u/eOFGPUXuqgxU5ynaveu9yDE1pNQSWhdUvDvVsE774uodBzYkLjqSMMFeZflXqYpyNLMkg1YnGcnX/QfXx6/B0EFUdT6I1zSY7G2p9GSM9EKa2LKQfkJ1+BjMOEPFPbvs2CjJd8+FRCj+U+270Zte5Db79FeV6OWzQnIfLiqUGMSnTF/NcWSk90WOueEZ771g7SgVTT6fXOC0GpKTqlbVHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=multitech.com; dmarc=pass action=none
 header.from=multitech.com; dkim=pass header.d=multitech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=multitechsystems.onmicrosoft.com;
 s=selector1-multitechsystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+cAwDRXS4epLf1XukOakgFBcJl1OpwjZ5YUAwb3aQpY=;
 b=c8P+HVSg9ap+JfaBcmMPUUd59PCL9LyFXw7/U7E+NPytH3eQfVa91NF4Er0XmA3CIf7y/IlRRYFW4zGkRMqDtQpFfdsRXkmWeUNKFWvedgetE1ZzibgJ1ofM6bobftw8W5OjLqqXCIN2iaUEK4niJ9j8KRFR9MSM2APKvU1y1Lg=
Received: from SJ0PR13MB5755.namprd13.prod.outlook.com (2603:10b6:a03:40e::15)
 by MW5PR13MB5879.namprd13.prod.outlook.com (2603:10b6:303:1ca::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.15; Tue, 12 Jul
 2022 18:56:22 +0000
Received: from SJ0PR13MB5755.namprd13.prod.outlook.com
 ([fe80::980d:52c2:2f5d:f4b2]) by SJ0PR13MB5755.namprd13.prod.outlook.com
 ([fe80::980d:52c2:2f5d:f4b2%5]) with mapi id 15.20.5417.020; Tue, 12 Jul 2022
 18:56:22 +0000
From:   John Klug <John.Klug@multitech.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
CC:     Linux-Bluetooth MailingList <linux-bluetooth@vger.kernel.org>
Subject: Re: How does bluetoothctl work from the command line with gatt?
Thread-Topic: How does bluetoothctl work from the command line with gatt?
Thread-Index: AQHYlhLsQU9pU+y0dEmfVtUfdtr2ga17D3oAgAAFcPE=
Date:   Tue, 12 Jul 2022 18:56:22 +0000
Message-ID: <SJ0PR13MB57558B7A49D3A9C106C3C210FE869@SJ0PR13MB5755.namprd13.prod.outlook.com>
References: <SJ0PR13MB5755315F09CF8B49984DE12FFE869@SJ0PR13MB5755.namprd13.prod.outlook.com>
 <CABBYNZ+ei7=TXw_gP8keZaCyz5igABLxYxUnmBhAe35wAXoR0g@mail.gmail.com>
In-Reply-To: <CABBYNZ+ei7=TXw_gP8keZaCyz5igABLxYxUnmBhAe35wAXoR0g@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
suggested_attachment_session_id: d7dc4e0e-b9dc-17ed-3e1b-9b3932ece9d9
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=multitech.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 90e8b574-d580-4f12-450e-08da64383697
x-ms-traffictypediagnostic: MW5PR13MB5879:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0pl8AUyd5M8g6EFlYmITsI4eGPv88nGjuA9PwGQS/4jkCYnh3VJnPELW0p2NWXVu4a7fQ+8Y+4JqJF6lnnt8X0+AmYB2XCf7Fcl1YWo6zta07HWrTrRChnqpejvN810IaIlSrd4J66MY3q482RHQa4TJVpm1Q1RB5LSTKdGdceeW1oIEOxFNZ60qshoOhcImPUbCSCwA36VGcsUu4xikXdmc47QkeNYoaMQuDlp7/nb/oRGWhGGmqI5mCYj6bhMdl712B1ewZBZOLH2gk3fpg+81DHlCy89Bpjz/UqrN2dHgeKAlGIgwxmIKihD91oR1s/vEWBh7KeuGeg7XDdqydzr3/6YU2n61mbOmPD57xUwXw163rC1FnN4IuFUW9hVUJ9H/3ZLI4omd9imZS3HwBqaPqwYuBT4lh22iAWB04q7zgjagtZyv8JEukrGVc1L+Arq960N0WzEbWnaW0rkKvDZwoWKxynDfO/0wWdghVX0eqfRZrctaRXYHHlzlnoDubX1xBYSJ09qqyxvsatW7GSZ7TJN49QLMntS22ec3KIUXZ9IP4uC8+JqdfcQYZwjv57M2STyxNMjEe9OFjpHvH6rajLyaveaLfqtlA6uYsybrkp7yUiU/aERwUzceKd0wcMyL4Ia0RRdz8IEze1mOU54odHfga/xSYEexa8UxdGnfaLiB04BCGMNuHi3vL244x1tJX+YZxfwi6vOswB0DBCm1YtjYx72B+yeY7O9B+EeuqbTIeOKT0v/Vr/wTTvhPhM92MVfSN9rkURXYmhnzTHEyRGJCJWYR3IO/xj62dkegQ7JsAk5lhcPU69xotTcFkSRLCFO3UQTIGqCtxyIkps4dbwCWo0b3r8QCDxLDLIL9V4P+eJldsrx0ZILpGsLH
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR13MB5755.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(366004)(39840400004)(396003)(346002)(376002)(9686003)(91956017)(4744005)(7696005)(6506007)(2906002)(122000001)(4326008)(5660300002)(66476007)(316002)(66446008)(71200400001)(26005)(478600001)(86362001)(8936002)(76116006)(38100700002)(8676002)(52536014)(83380400001)(55016003)(38070700005)(33656002)(6916009)(186003)(66946007)(66556008)(41300700001)(64756008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?IU8ElcbIH5Fqju+ZqoPcKwmrtnAMjLw9BH7tQX3hfmRhCOYreknXm3t1GH?=
 =?iso-8859-1?Q?1T9HjXcsAw1F4UjV+zkWRAXLEqwwOQzuV3bD2UwqRiFOwLsvE32vIoqJZx?=
 =?iso-8859-1?Q?cPjl740kEZrP6xHwSzgS7uXtvxk963n0FjkPl7q7qmoANFitWBxqmrbeZx?=
 =?iso-8859-1?Q?cHvN5JFElV1Q6uYpQj/7+tbKhwJBZeXDnmP5ntwWLyUzPHihQtmw27F9jX?=
 =?iso-8859-1?Q?u+m/rE004+vm9FePZNFs8gee9aBjg8wknmhfVXzoz1EQa513rtzFJ54fPu?=
 =?iso-8859-1?Q?MA8y4SqbxMJoOrTlSP6XSzjgOeNa2cwLy3HEqYfrCHPlZDHpoMmk3KDIWK?=
 =?iso-8859-1?Q?ML6dAhZkTnrDQLiPSD41gScAKEFjYe81tjPkXwQmp82RuC2ThLlMFgyzE3?=
 =?iso-8859-1?Q?Bbcc1BpJ8XxZUP9OA0XQC9SkfY4dh0bo6ieDc0hWUfvWgoMzGtKwFhVidX?=
 =?iso-8859-1?Q?nl+OlvgPFzfLgjGEunEBmNvKLeSnuphwoXOI02oFbIF0lJ7x0EvdYts5In?=
 =?iso-8859-1?Q?TmuL9yjg8o97cTjB/B2ZouqFY/2kXlr6B+b0pPoWcDEUWVU5KwWGbS6wPu?=
 =?iso-8859-1?Q?NZ2nJbR5amiVbpbB80/ZbKZnh2d/msnRUd4aTk18p1aLHdWLeCyA9NcFDi?=
 =?iso-8859-1?Q?+bufzZHNYvLSEXW/CmpKbp5zPM7Y22zLNl9MWzj2IEAAFVCFD4b4q2Rk7n?=
 =?iso-8859-1?Q?rFfWQHVjIKMzNZDaCm0F5bkXLAVYEp7SjVkqbx67/lij/+R7Coqh0OuoVU?=
 =?iso-8859-1?Q?DYAElzepIP/zxq0uMZJ+8XBKDvVqoPQAVX+agYYoSLpYPGCnsCD0sZ/TVp?=
 =?iso-8859-1?Q?IB5P8oRlxUJ6dzmWq27tilZN6SxgIpaSMA/fbwaaio3HAihA/8nXt9enhQ?=
 =?iso-8859-1?Q?zsgg0HqW+zMiE8n+nzI9kbIb8LChKwD/yV+nmcImy23IMfHzmfOcH0eoMH?=
 =?iso-8859-1?Q?Dws1D3ihACpUEFVshZiUlN0OOakISseoBkax242j/STZavNEbOS8Waxi7W?=
 =?iso-8859-1?Q?lKPW6w82SpqQpr4bLnb5uJT0BnRHBLxc0+B0O0eiDRpkBK+279Kig3eVRF?=
 =?iso-8859-1?Q?dwOJNyI2Vx91CB1MYOnam5UhIs9Y+8JdNqiU/EfAUHPxnK94FS7OB5/Ju4?=
 =?iso-8859-1?Q?c28Q+kWJTNlxvIbf2ZfA4O5pSpa5dSVhL2CEyupxaQ21vHqQhxObUGIuT7?=
 =?iso-8859-1?Q?KsfSlgLzayY21RR0m5vo3nt5zPfOXCBubOSj/2Qb9OTVb4B7bTy/fi/o8D?=
 =?iso-8859-1?Q?4ntZDmyvEzK1yOyptcuXg/IDceO39PWHTPPIq0an+5eGap3imZYlZcQJcc?=
 =?iso-8859-1?Q?QkcOkSUJUhNTqK29d2iPOGh4p3O6uIYQ+tWxk/ym14Tsb5zpfcNkUqQpid?=
 =?iso-8859-1?Q?XwGr4PxC013k/lhafgJ/G0NnwmRwlFFGzeLb9oV7cXhPK2xcSDrZNXMi6K?=
 =?iso-8859-1?Q?0MKjxLvWUsMesq3jy3pO/1oD0w6Dgk+WTTAAoTA43ULYT5pHbAI0e3/Vw3?=
 =?iso-8859-1?Q?mcnVpJEbkrIKgaqA4Y/QsHrX9Rk7Jsq3Yq0Vji+WpQlRJF6iHLcx8Sc15J?=
 =?iso-8859-1?Q?4eQcJGxu6KNqP4Rx5+sdKEBRg1V7rz/MjV5PK6RsvGP3IIAJHghZykFdoI?=
 =?iso-8859-1?Q?49hLu+Iltg7zc=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: multitech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR13MB5755.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90e8b574-d580-4f12-450e-08da64383697
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jul 2022 18:56:22.2551
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f802e804-804f-4d1e-b625-870b4d57fd00
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ichVj0zkk7cKOTc/b9sUvIetadDzMfkk2xdCa0Vyqq/akiIMMJovpqQUJ7Q8vq1I0r73hKobzzpYF34d6WtaYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR13MB5879
X-SASI-RCODE: 200
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

>You will probably need to wait for the daemon to resolve the services=0A=
>which will then export the attributes as D-Bus objects that can be=0A=
=0A=
>accessed by bluetoothctl,=0A=
=0A=
How long would one have to wait?=A0 The following was typed manually from t=
he command line:=0A=
=0A=
>> # bluetoothctl gatt.select-attribute f000aa22-0451-4000-b000-00000000000=
0=0A=
=0A=
>> # bluetoothctl gatt.acquire-write=0A=
=0A=
>> No attribute selected=0A=
=0A=
>> # bluetoothctl gatt.write 0x01=0A=
=0A=
>> No attribute selected=0A=
=0A=
I had no idea whether the above is the correct syntax or not. I merely gues=
sed, since the procedure does not appear to be documented.=0A=
=0A=
=0A=
=0A=
=0A=
=0A=
John Klug=0A=
=0A=
=0A=
=0A=
=0A=
