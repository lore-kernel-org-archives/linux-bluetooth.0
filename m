Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26881C433F5
	for <linux-bluetooth@archiver.kernel.org>; Mon, 25 Oct 2021 20:04:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 119B160E96
	for <linux-bluetooth@archiver.kernel.org>; Mon, 25 Oct 2021 20:04:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238005AbhJYUHS convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 25 Oct 2021 16:07:18 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:48054 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238806AbhJYUFe (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 25 Oct 2021 16:05:34 -0400
Received: from smtpclient.apple (p5b3d2be1.dip0.t-ipconnect.de [91.61.43.225])
        by mail.holtmann.org (Postfix) with ESMTPSA id 15C2BCED1E;
        Mon, 25 Oct 2021 22:03:09 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 15.0 \(3693.20.0.1.32\))
Subject: Re: [BlueZ PATCH v4 1/3] doc: Introduce the Adv Monitor Device
 Found/Lost events
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20211025121343.BlueZ.v4.1.I7f6bdb9282c1e12ffc6c662674678f2b1cb69182@changeid>
Date:   Mon, 25 Oct 2021 22:03:08 +0200
Cc:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-bluetooth@vger.kernel.org,
        chromeos-bluetooth-upstreaming@chromium.org
Content-Transfer-Encoding: 8BIT
Message-Id: <577458A3-49B9-416B-A35B-58F174CC88F8@holtmann.org>
References: <20211025191811.3575708-1-mmandlik@google.com>
 <20211025121343.BlueZ.v4.1.I7f6bdb9282c1e12ffc6c662674678f2b1cb69182@changeid>
To:     Manish Mandlik <mmandlik@google.com>
X-Mailer: Apple Mail (2.3693.20.0.1.32)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Manish,

> This patch introduces new MGMT events to indicate that the controller
> has started/stopped tracking a particular device matching one of the
> already added Advertisement Monitor.
> 
> ---
> 
> Changes in v4:
> - Add Advertisement Monitor Device Found event, make Address_Type 0 as
>  reserved.
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
> doc/mgmt-api.txt | 50 +++++++++++++++++++++++++++++++++++++++++++++++-
> 1 file changed, 49 insertions(+), 1 deletion(-)
> 
> diff --git a/doc/mgmt-api.txt b/doc/mgmt-api.txt
> index 5355fedb0..32dd8c0f2 100644
> --- a/doc/mgmt-api.txt
> +++ b/doc/mgmt-api.txt
> @@ -107,7 +107,8 @@ Configuration command, Default Runtime Configuration Changed event, Get
> Device Flags command, Set Device Flags command, Device Flags Changed event,
> Read Advertisement Monitor Features command, Add Advertisement Patterns
> Monitor command, Remove Advertisement Monitor command, Advertisement Monitor
> -Added event and Advertisement Monitor Removed event.
> +Added event, Advertisement Monitor Removed event, Advertisement Monitor Device
> +Found event and Advertisement Monitor Device Lost event.

we need to increase the mgmt version and add the new commands to that section. Leave this out of this patch and put it into a separate one.

> 
> Example
> @@ -4910,3 +4911,50 @@ Controller Resume Event
> 	Address_Type. Otherwise, Address and Address_Type will both be zero.
> 
> 	This event will be sent to all management sockets.
> +
> +
> +Advertisement Monitor Device Found Event
> +========================================
> +
> +	Event code:		0x002f
> +	Controller Index:	<controller_id>
> +	Event Parameters:	Monitor_Handle (2 Octets)
> +				Address (6 Octets)
> +				Address_Type (1 Octet)
> +
> +	This event indicates that the controller has started tracking a device
> +	matching an Advertisement Monitor with handle Monitor_Handle.
> +
> +	The address of the device being tracked will be shared in Address and
> +	Address_Type.
> +
> +	Possible values for the Address_Type parameter:
> +		0	Reserved (not in use)
> +		1	LE Public
> +		2	LE Random
> +
> +	This event will be sent to all management sockets.

My initial thought was actually to include all the fields from Device Found Event here as well. So that in case we are using advertising monitor, we just need to worry about this event only. Thoughts?

> +
> +
> +Advertisement Monitor Device Lost Event
> +=======================================
> +
> +	Event code:		0x0030
> +	Controller Index:	<controller_id>
> +	Event Parameters:	Monitor_Handle (2 Octets)
> +				Address (6 Octets)
> +				Address_Type (1 Octet)
> +
> +	This event indicates that the controller has stopped tracking a device
> +	that was being tracked by an Advertisement Monitor with handle
> +	Monitor_Handle.
> +
> +	The address of the device being tracked will be shared in Address and
> +	Address_Type.
> +
> +	Possible values for the Address_Type parameter:
> +		0	Reserved (not in use)
> +		1	LE Public
> +		2	LE Random
> +
> +	This event will be sent to all management sockets.

Regards

Marcel

