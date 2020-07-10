Return-Path: <SRS0=rPFF=AV=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C666C433E2
	for <linux-bluetooth@archiver.kernel.org>; Fri, 10 Jul 2020 17:20:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 61B47206A5
	for <linux-bluetooth@archiver.kernel.org>; Fri, 10 Jul 2020 17:20:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727065AbgGJRUc convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 10 Jul 2020 13:20:32 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:35994 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726977AbgGJRUb (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 10 Jul 2020 13:20:31 -0400
Received: from marcel-macbook.fritz.box (p5b3d2638.dip0.t-ipconnect.de [91.61.38.56])
        by mail.holtmann.org (Postfix) with ESMTPSA id 93CCCCED26;
        Fri, 10 Jul 2020 19:30:27 +0200 (CEST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: [Bluez PATCH] doc: Add Suspend and Resume events
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20200709140928.Bluez.1.I9181af521cf0fba8f4315c9b89975848d437d6dd@changeid>
Date:   Fri, 10 Jul 2020 19:20:30 +0200
Cc:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        chromeos-bluetooth-upstreaming 
        <chromeos-bluetooth-upstreaming@chromium.org>,
        Bluetooth Kernel Mailing List 
        <linux-bluetooth@vger.kernel.org>,
        Alain Michaud <alainm@chromium.org>,
        Miao-chen Chou <mcchou@chromium.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <22D4931F-A15D-4ECE-9EBC-D080EF6430E2@holtmann.org>
References: <20200709140928.Bluez.1.I9181af521cf0fba8f4315c9b89975848d437d6dd@changeid>
To:     Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Abhishek,

> Add Controller Suspend Event and Controller Resume Event to identify
> suspend or resume of the Bluetooth stack has occurred.
> 
> Also update Device Disconnected Event to indicate a new disconnect
> reason: "Connection terminated by local host for suspend"
> 
> Reviewed-by: Alain Michaud <alainm@chromium.org>
> Reviewed-by: Miao-chen Chou <mcchou@chromium.org>
> ---
> 
> doc/mgmt-api.txt | 53 ++++++++++++++++++++++++++++++++++++++++++++++++
> 1 file changed, 53 insertions(+)
> 
> diff --git a/doc/mgmt-api.txt b/doc/mgmt-api.txt
> index ca0d38469..f79c0222c 100644
> --- a/doc/mgmt-api.txt
> +++ b/doc/mgmt-api.txt
> @@ -3834,6 +3834,7 @@ Device Disconnected Event
> 		2	Connection terminated by local host
> 		3	Connection terminated by remote host
> 		4	Connection terminated due to authentication failure
> +		5	Connection terminated by local host for suspend
> 
> 	Note that the local/remote distinction just determines which side
> 	terminated the low-level connection, regardless of the
> @@ -4577,3 +4578,55 @@ Advertisement Monitor Removed Event
> 
> 	The event will only be sent to management sockets other than the
> 	one through which the command was sent.
> +
> +
> +Controller Suspend Event
> +========================
> +
> +	Event code:		0x002d
> +	Controller Index:	<controller_id>
> +	Event Parameters:	Suspend_State (1 octet)
> +
> +	This event indicates that the controller is suspended for host suspend.
> +
> +	Possible values for the Suspend_State parameter:
> +		0	Running (not disconnected)
> +		1	Disconnected and not scanning
> +		2	Page scanning and/or passive scanning.
> +
> +	The value 0 is used for the running state and may be sent if the
> +	controller could not be configured to suspend properly.

does it make sense to send a suspend event with state suspend not succeeded. That doesn’t really fit well.

> +
> +	This event will be sent to all management sockets.
> +
> +
> +Controller Resume Event
> +=======================
> +
> +	Event code:		0x002e
> +	Controller Index:	<controller_id>
> +	Event Parameters:	Address (6 octets)
> +				Address_Type (1 octet)
> +				Wake_Reason (1 octet)
> +
> +	This event indicates that the controller has resumed from suspend.
> +
> +	Possible values for the Wake_Reason parameter:
> +		0	Unexpected Event
> +		1	Resume from non-Bluetooth wake source
> +		2	Connection Request (BR/EDR)
> +		3	Connection Complete (BR/EDR)
> +		4	LE Advertisement
> +		5	LE Direct Advertisement
> +		6	LE Extended Advertisement
> +
> +	We expect that only peer reconnections should wake us from the suspended
> +	state. Any other events that cause a wakeup will be marked as Unexpected
> +	Event.
> +
> +	If the Wake_Reason was any of the expected wake reasons (values 2-6),
> +	the address of the peer device that caused the event will be shared in
> +	Address and Address_Type. Otherwise, Address and Address_Type will both
> +	be zero.

So I would be using Wake_Reason as first argument. However do you need all this distinction. For example the Device Connected event could gain an extra Flags bit for wakeup. I would especially not make any distinction between the advertising types.

I am in principal fine telling bluetoothd when suspend / resume happened, but letting HCI event specifics bleed into the mgmt API is not really helpful.

Regards

Marcel

