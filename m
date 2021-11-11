Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94FF6C433EF
	for <linux-bluetooth@archiver.kernel.org>; Thu, 11 Nov 2021 16:35:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 695DF61252
	for <linux-bluetooth@archiver.kernel.org>; Thu, 11 Nov 2021 16:35:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234205AbhKKQif convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 11 Nov 2021 11:38:35 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:36685 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233128AbhKKQid (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 11 Nov 2021 11:38:33 -0500
Received: from smtpclient.apple (p4fefc15c.dip0.t-ipconnect.de [79.239.193.92])
        by mail.holtmann.org (Postfix) with ESMTPSA id 01D4ACECD0;
        Thu, 11 Nov 2021 17:35:42 +0100 (CET)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 15.0 \(3693.20.0.1.32\))
Subject: Re: [Bluez PATCH 3/3] doc: Add Name Resolve Fail flag in device found
 event
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20211111195423.Bluez.3.I29367ca288fc8f4fcc3b4063425b791501c6534c@changeid>
Date:   Thu, 11 Nov 2021 17:35:42 +0100
Cc:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        CrosBT Upstreaming <chromeos-bluetooth-upstreaming@chromium.org>,
        Archie Pusaka <apusaka@chromium.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <AD8BC81A-9D68-459D-921A-C764DC4216AA@holtmann.org>
References: <20211111195423.Bluez.1.I9fc087b25433a9347b2d8c8ff7a25fadf448ef49@changeid>
 <20211111195423.Bluez.3.I29367ca288fc8f4fcc3b4063425b791501c6534c@changeid>
To:     Archie Pusaka <apusaka@google.com>
X-Mailer: Apple Mail (2.3693.20.0.1.32)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Archie,

> Userspace should use this new flag to decide whether to do the remote
> name resolving or not, by sending Confirm Name MGMT command and set
> the appropriate flag.
> 
> This patch also extends the Confirm Name command by allowing userspace
> to send 0x02 to show it doesn't care about the peer devices names.
> ---
> 
> doc/mgmt-api.txt | 18 +++++++++++++-----
> 1 file changed, 13 insertions(+), 5 deletions(-)
> 
> diff --git a/doc/mgmt-api.txt b/doc/mgmt-api.txt
> index 97d33e30a1..e4c8de39f0 100644
> --- a/doc/mgmt-api.txt
> +++ b/doc/mgmt-api.txt
> @@ -1493,7 +1493,7 @@ Confirm Name Command
> 	Controller Index:	<controller id>
> 	Command Parameters:	Address (6 Octets)
> 				Address_Type (1 Octet)
> -				Name_Known (1 Octet)
> +				Name_State (1 Octet)
> 	Return Parameters:	Address (6 Octets)
> 				Address_Type (1 Octet)
> 
> @@ -1506,10 +1506,11 @@ Confirm Name Command
> 		1	LE Public
> 		2	LE Random
> 
> -	The Name_Known parameter should be set to 0x01 if user space
> -	knows the name for the device and 0x00 if it doesn't. If set to
> -	0x00 the kernel will perform a name resolving procedure for the
> -	device in question.
> +	The Name_State parameter should be set to 0x00 if user space
> +	doesn't know the name for the device to make the kernel
> +	perform a name resolving procedure for the device in question.
> +	Otherwise, set to 0x01 if user space already knew the device's
> +	name, or 0x02 if it doesn't care.

I am a bit worried about userspace sending a 0x02 for a kernel that doesn’t understand it. Do you think the kernel can make use of this “don’t care” information? Or should we just keep it to userspace to send 0x01 / 0x00 based on its policy.

> 
> 	This command can only be used when the controller is powered.
> 
> @@ -4089,6 +4090,7 @@ Device Connected Event
> 		1	Legacy Pairing
> 		2	Reserved (not in use)
> 		3	Initiated Connection
> +		4	Reserved (not in use)
> 
> 
> Device Disconnected Event
> @@ -4263,6 +4265,7 @@ Device Found Event
> 		1	Legacy Pairing
> 		2	Not Connectable
> 		3	Reserved (not in use)
> +		4	Name Resolve Fail

I would do “Name Request Failed” here. Just to be a bit inline what the spec term is.

> 
> 	For the RSSI field a value of 127 indicates that the RSSI is
> 	not available. That can happen with Bluetooth 1.1 and earlier
> @@ -4285,6 +4288,11 @@ Device Found Event
> 	accept any connections. This can be indicated by Low Energy
> 	devices that are in broadcaster role.
> 
> +	The Name Resolve Fail flag indicates that name resolving
> +	procedure has ended with failure for this device. The user space
> +	should use this information to determine when is a good time to
> +	retry the name resolving procedure.
> +
> 

Regards

Marcel

