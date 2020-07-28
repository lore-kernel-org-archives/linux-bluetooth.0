Return-Path: <SRS0=dFGF=BH=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56AF1C433DF
	for <linux-bluetooth@archiver.kernel.org>; Tue, 28 Jul 2020 07:16:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3BA82207E8
	for <linux-bluetooth@archiver.kernel.org>; Tue, 28 Jul 2020 07:16:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727858AbgG1HQE convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 28 Jul 2020 03:16:04 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:55604 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727097AbgG1HQE (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 28 Jul 2020 03:16:04 -0400
Received: from marcel-macbook.fritz.box (p4ff9f430.dip0.t-ipconnect.de [79.249.244.48])
        by mail.holtmann.org (Postfix) with ESMTPSA id 70898CECCD;
        Tue, 28 Jul 2020 09:26:03 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: [Bluez PATCH v2] doc: Add Suspend and Resume events
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20200714125120.Bluez.v2.1.I9181af521cf0fba8f4315c9b89975848d437d6dd@changeid>
Date:   Tue, 28 Jul 2020 09:16:01 +0200
Cc:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        chromeos-bluetooth-upstreaming 
        <chromeos-bluetooth-upstreaming@chromium.org>,
        linux-bluetooth@vger.kernel.org,
        Alain Michaud <alainm@chromium.org>,
        Miao-chen Chou <mcchou@chromium.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <7E48B539-556A-4C34-B5B6-092422FCC87D@holtmann.org>
References: <20200714125120.Bluez.v2.1.I9181af521cf0fba8f4315c9b89975848d437d6dd@changeid>
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
> Changes in v2:
> - Moved Wake_Reason to first value
> - Reduced Wake_Reason to not Bluetooth, unexpected event and remote wake
> 
> doc/mgmt-api.txt | 48 ++++++++++++++++++++++++++++++++++++++++++++++++
> 1 file changed, 48 insertions(+)
> 
> diff --git a/doc/mgmt-api.txt b/doc/mgmt-api.txt
> index ca0d38469..e7a713824 100644
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
> @@ -4577,3 +4578,50 @@ Advertisement Monitor Removed Event
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
> +
> +	This event will be sent to all management sockets.
> +
> +
> +Controller Resume Event
> +=======================
> +
> +	Event code:		0x002e
> +	Controller Index:	<controller_id>
> +	Event Parameters:	Wake_Reason (1 octet)
> +				Address (6 octets)
> +				Address_Type (1 octet)
> +
> +	This event indicates that the controller has resumed from suspend.
> +
> +	Possible values for the Wake_Reason parameter:
> +		0	Resume from non-Bluetooth wake source
> +		1	Wake due to unexpected event
> +		2	Remote wake due to peer device connection
> +
> +	Currently, we expect that only peer reconnections should wake us from
> +	the suspended state. Any other events that occurred while the system
> +	should have been suspended results in wake due to unexpected event.
> +
> +	If the Wake_Reason is Remote wake due to connection, the address of the
> +	peer device that caused the event will be shared in Address and
> +	Address_Type. Otherwise, Address and Address_Type will both be zero.
> +
> +	This event will be sent to all management sockets.

so far so good. I am going to have second look once you have RFC implementation to review.

Regards

Marcel

