Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7556EC433F5
	for <linux-bluetooth@archiver.kernel.org>; Wed, 13 Oct 2021 13:15:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5C5FF610E7
	for <linux-bluetooth@archiver.kernel.org>; Wed, 13 Oct 2021 13:15:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231644AbhJMNRe convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 13 Oct 2021 09:17:34 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:57835 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbhJMNRc (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 13 Oct 2021 09:17:32 -0400
Received: from smtpclient.apple (p4ff9f2d2.dip0.t-ipconnect.de [79.249.242.210])
        by mail.holtmann.org (Postfix) with ESMTPSA id B8512CECF6;
        Wed, 13 Oct 2021 15:15:28 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.120.0.1.13\))
Subject: Re: [BlueZ PATCH v2 1/3] doc: Introduce the Adv Monitor Device Lost
 event
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20211013053935.BlueZ.v2.1.I7f6bdb9282c1e12ffc6c662674678f2b1cb69182@changeid>
Date:   Wed, 13 Oct 2021 15:15:26 +0200
Cc:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        CrosBT Upstreaming <chromeos-bluetooth-upstreaming@chromium.org>,
        linux-bluetooth@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <7414EB4C-0422-4BCF-869C-B4FA611DFCFC@holtmann.org>
References: <20211013124210.1454876-1-mmandlik@google.com>
 <20211013053935.BlueZ.v2.1.I7f6bdb9282c1e12ffc6c662674678f2b1cb69182@changeid>
To:     Manish Mandlik <mmandlik@google.com>
X-Mailer: Apple Mail (2.3654.120.0.1.13)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Manish,

> Add a flag 'Device Tracked' to the existing 'Device Found' event to
> indicate that the controller has started tracking the device matching
> an Advertisement Monitor with handle 'Monitor_Handle'.
> 
> Add a new event 'Adv Monitor Device Lost' to indicate that the
> controller has stopped tracking that particular device.
> 
> ---
> 
> Changes in v2:
> - Instead of creating a new 'Device Tracking' event, add a flag 'Device
>  Tracked' in the existing 'Device Found' event and add a new 'Device
>  Lost' event to indicate that the controller has stopped tracking that
>  device.
> 
> doc/mgmt-api.txt | 32 +++++++++++++++++++++++++++++++-
> 1 file changed, 31 insertions(+), 1 deletion(-)
> 
> diff --git a/doc/mgmt-api.txt b/doc/mgmt-api.txt
> index 5355fedb0..0fd884ed0 100644
> --- a/doc/mgmt-api.txt
> +++ b/doc/mgmt-api.txt
> @@ -107,7 +107,8 @@ Configuration command, Default Runtime Configuration Changed event, Get
> Device Flags command, Set Device Flags command, Device Flags Changed event,
> Read Advertisement Monitor Features command, Add Advertisement Patterns
> Monitor command, Remove Advertisement Monitor command, Advertisement Monitor
> -Added event and Advertisement Monitor Removed event.
> +Added event, Advertisement Monitor Removed event, Updated Device Found event
> +and Added Advertisement Monitor Device Lost event.
> 
> 
> Example
> @@ -4247,6 +4248,7 @@ Device Found Event
> 				Address_Type (1 Octet)
> 				RSSI (1 Octet)
> 				Flags (4 Octets)
> +				Monitor_Handle (2 Octets)
> 				EIR_Data_Length (2 Octets)
> 				EIR_Data (0-65535 Octets)

you can not do this. This breaks ABI.

Regards

Marcel

