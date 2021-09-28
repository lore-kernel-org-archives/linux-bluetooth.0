Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F7C7C433EF
	for <linux-bluetooth@archiver.kernel.org>; Tue, 28 Sep 2021 08:09:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 154AB61159
	for <linux-bluetooth@archiver.kernel.org>; Tue, 28 Sep 2021 08:09:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239286AbhI1ILh convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 28 Sep 2021 04:11:37 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:42829 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239043AbhI1ILg (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 28 Sep 2021 04:11:36 -0400
Received: from smtpclient.apple (p5b3d2185.dip0.t-ipconnect.de [91.61.33.133])
        by mail.holtmann.org (Postfix) with ESMTPSA id 09A51CECD6;
        Tue, 28 Sep 2021 10:09:56 +0200 (CEST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.120.0.1.13\))
Subject: Re: [BlueZ PATCH v1 1/3] doc: Add Advertisement Monitor Device
 Tracking event
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20210927131456.BlueZ.v1.1.I7f6bdb9282c1e12ffc6c662674678f2b1cb69182@changeid>
Date:   Tue, 28 Sep 2021 10:09:55 +0200
Cc:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        CrosBT Upstreaming <chromeos-bluetooth-upstreaming@chromium.org>,
        Miao-chen Chou <mcchou@google.com>,
        Yun-Hao Chung <howardchung@google.com>
Content-Transfer-Encoding: 8BIT
Message-Id: <AB183B14-B822-4A1D-BC13-B997C0A2F7F5@holtmann.org>
References: <20210927201657.593569-1-mmandlik@google.com>
 <20210927131456.BlueZ.v1.1.I7f6bdb9282c1e12ffc6c662674678f2b1cb69182@changeid>
To:     Manish Mandlik <mmandlik@google.com>
X-Mailer: Apple Mail (2.3654.120.0.1.13)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Manish,

> This patch adds the Advertisement Monitor Device Traching event. This
> event indicates that the controller has stated/stopped tracking a
> particular device matching one of the already added Advertisement
> Monitor.
> 
> Reviewed-by: Miao-chen Chou <mcchou@google.com>
> Reviewed-by: Yun-Hao Chung <howardchung@google.com>
> ---
> 
> doc/mgmt-api.txt | 27 ++++++++++++++++++++++++++-
> 1 file changed, 26 insertions(+), 1 deletion(-)
> 
> diff --git a/doc/mgmt-api.txt b/doc/mgmt-api.txt
> index 5355fedb0..06df3e914 100644
> --- a/doc/mgmt-api.txt
> +++ b/doc/mgmt-api.txt
> @@ -107,7 +107,8 @@ Configuration command, Default Runtime Configuration Changed event, Get
> Device Flags command, Set Device Flags command, Device Flags Changed event,
> Read Advertisement Monitor Features command, Add Advertisement Patterns
> Monitor command, Remove Advertisement Monitor command, Advertisement Monitor
> -Added event and Advertisement Monitor Removed event.
> +Added event, Advertisement Monitor Removed event and Advertisement Monitor
> +Device Tracking event.
> 
> 
> Example
> @@ -4910,3 +4911,27 @@ Controller Resume Event
> 	Address_Type. Otherwise, Address and Address_Type will both be zero.
> 
> 	This event will be sent to all management sockets.
> +
> +
> +Advertisement Monitor Device Tracking Event
> +===========================================
> +
> +	Event code:		0x002f
> +	Controller Index:	<controller_id>
> +	Event Parameters:	Monitor_Handle (2 octets)
> +				Monitor_State (1 octet)
> +				Address (6 octets)
> +				Address_Type (1 octet)
> +
> +	This event indicates that the controller has started/stopped tracking
> +	a particular device matching the Advertisement Monitor with handle
> +	Monitor_Handle.
> +
> +	Possible values for the Monitor_State parameter:
> +		0	The controller has stopped tracking a device
> +		1	The controller has started tracking a device
> +
> +	The address of the device being tracked will be shared in Address and
> +	Address_Type.
> +
> +	This event will be sent to all management sockets.

I have to echo Luiz's comment here. How is this suppose to work. We now get a Device Found and Device Tracked event?

Wouldn’t it be really better to have a “I am tracked” flag in the Device Found event?

Regards

Marcel

