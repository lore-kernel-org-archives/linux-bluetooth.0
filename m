Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF102C6377D
	for <linux-bluetooth@archiver.kernel.org>; Thu, 22 Jul 2021 14:47:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D13D46120D
	for <linux-bluetooth@archiver.kernel.org>; Thu, 22 Jul 2021 14:47:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232474AbhGVOHB convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 22 Jul 2021 10:07:01 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:47739 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232523AbhGVOG7 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 22 Jul 2021 10:06:59 -0400
Received: from smtpclient.apple (p5b3d2eb8.dip0.t-ipconnect.de [91.61.46.184])
        by mail.holtmann.org (Postfix) with ESMTPSA id D5418CECE4;
        Thu, 22 Jul 2021 16:47:33 +0200 (CEST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.100.0.2.22\))
Subject: =?utf-8?Q?Re=3A_=5BPATCH=5D_____bluez=3Afix_btmon_tools_=E2=80=9C?=
 =?utf-8?Q?Allow_slave=E2=80=9D_to_=22Master_Or_Slave=22__________________?=
 =?utf-8?Q?_______________________________________________________________?=
 =?utf-8?Q?______________________________________=23431_=5Bhci0=5D_99=2E92?=
 =?utf-8?Q?2927?=
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20210722021952.18260-1-wangyouwan@uniontech.com>
Date:   Thu, 22 Jul 2021 16:47:33 +0200
Cc:     linux-bluetooth@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <86E74CE4-C907-46A1-BD26-2D2F4EB15FE7@holtmann.org>
References: <20210722021952.18260-1-wangyouwan@uniontech.com>
To:     wangyouwan <wangyouwan@uniontech.com>
X-Mailer: Apple Mail (2.3654.100.0.2.22)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Wang,

>    I want to explain it as　“Master Or Slave”, because this is explained in the Core_v5.2
> 
>    8.6.5 Role switch
>    There are several occasions when a role switch is used:
>    • A role switch is necessary in order to make a paging device a slave when
>    joining an existing piconet, since by definition the paging device is initially
>    master of a piconet involving the pager (master) and the paged (slave)
>    device.
>    • A role switch is necessary in order for a slave in an existing piconet to set up
>    a new piconet with itself as master and the original piconet master as slave.
>    If the original piconet had more than one slave, then this implies a double
>    role for the original piconet master; it becomes a slave
> 
> Signed-off-by: wangyouwan <wangyouwan@uniontech.com>
> ---
> monitor/packet.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/monitor/packet.c b/monitor/packet.c
> index 52d22ab21..b73615509 100644
> --- a/monitor/packet.c
> +++ b/monitor/packet.c
> @@ -4143,7 +4143,7 @@ static void create_conn_cmd(const void *data, uint8_t size)
> 		str = "Stay master";
> 		break;
> 	case 0x01:
> -		str = "Allow slave";
> +		str = "Master Or Slave";
> 		break;

the text was verbatim from Bluetooth 4.x core spec. If that has changed in Core 5.3 spec, then we can use that one.

Regards

Marcel

