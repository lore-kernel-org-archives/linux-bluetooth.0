Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A712AC433F5
	for <linux-bluetooth@archiver.kernel.org>; Wed, 20 Oct 2021 12:55:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7C377611B0
	for <linux-bluetooth@archiver.kernel.org>; Wed, 20 Oct 2021 12:55:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230187AbhJTM5P convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 20 Oct 2021 08:57:15 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:47519 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229702AbhJTM5P (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 20 Oct 2021 08:57:15 -0400
Received: from smtpclient.apple (p54899aa7.dip0.t-ipconnect.de [84.137.154.167])
        by mail.holtmann.org (Postfix) with ESMTPSA id 7E51DCED1B;
        Wed, 20 Oct 2021 14:54:59 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.120.0.1.13\))
Subject: Re: [BlueZ PATCH v3 1/3] doc: Introduce the Adv Monitor Device Lost
 event
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20211013115927.BlueZ.v3.1.I7f6bdb9282c1e12ffc6c662674678f2b1cb69182@changeid>
Date:   Wed, 20 Oct 2021 14:54:58 +0200
Cc:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        CrosBT Upstreaming <chromeos-bluetooth-upstreaming@chromium.org>,
        linux-bluetooth <linux-bluetooth@vger.kernel.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <95CDCED5-0B56-4CA1-9E7A-56082CB3A777@holtmann.org>
References: <20211013190035.1876237-1-mmandlik@google.com>
 <20211013115927.BlueZ.v3.1.I7f6bdb9282c1e12ffc6c662674678f2b1cb69182@changeid>
To:     Manish Mandlik <mmandlik@google.com>
X-Mailer: Apple Mail (2.3654.120.0.1.13)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Manish,

> Add a new event 'Adv Monitor Device Lost' to indicate that the
> controller has stopped tracking a particular device.
> 
> ---
> 
> Changes in v3:
> - Discard changes to the Device Found event and notify bluetoothd only
>  when the controller stops monitoring the device via new Device Lost
>  event.
> 
> Changes in v2:
> - Instead of creating a new 'Device Tracking' event, add a flag 'Device
>  Tracked' in the existing 'Device Found' event and add a new 'Device
>  Lost' event to indicate that the controller has stopped tracking that
>  device.
> 
> doc/mgmt-api.txt | 26 +++++++++++++++++++++++++-
> 1 file changed, 25 insertions(+), 1 deletion(-)
> 
> diff --git a/doc/mgmt-api.txt b/doc/mgmt-api.txt
> index 5355fedb0..712bb362d 100644
> --- a/doc/mgmt-api.txt
> +++ b/doc/mgmt-api.txt
> @@ -107,7 +107,8 @@ Configuration command, Default Runtime Configuration Changed event, Get
> Device Flags command, Set Device Flags command, Device Flags Changed event,
> Read Advertisement Monitor Features command, Add Advertisement Patterns
> Monitor command, Remove Advertisement Monitor command, Advertisement Monitor
> -Added event and Advertisement Monitor Removed event.
> +Added event, Advertisement Monitor Removed event and Advertisement Monitor
> +Device Lost event.
> 
> 
> Example
> @@ -4910,3 +4911,26 @@ Controller Resume Event
> 	Address_Type. Otherwise, Address and Address_Type will both be zero.
> 
> 	This event will be sent to all management sockets.

I would consider adding a Advertising Monitor Device Found Event that is similar to the Device Found event, but also includes the Monitor_Handle. It just makes this whole thing a bit more symmetric.

> +
> +
> +Advertisement Monitor Device Lost Event
> +=======================================
> +
> +	Event code:		0x002f
> +	Controller Index:	<controller_id>
> +	Event Parameters:	Monitor_Handle (2 Octets)
> +				Address (6 Octets)
> +				Address_Type (1 Octet)
> +
> +	This event indicates that the controller has stopped tracking the
> +	device that was being tracked by monitor with handle Monitor_Handle.
> +
> +	The address of the device being tracked will be shared in Address and
> +	Address_Type.
> +
> +	Possible values for the Address_Type parameter:
> +		0	BR/EDR
> +		1	LE Public
> +		2	LE Random
> +
> +	This event will be sent to all management sockets.

And as noted by Luiz, make 0 Reserved since we only do this for LE at the moment.

Regards

Marcel

