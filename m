Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH v2] Bluetooth: Fix possible NULL pointer dereference
From: Marcel Holtmann <marcel@holtmann.org>
To: Waldemar Rymarkiewicz <waldemar.rymarkiewicz@tieto.com>
Cc: linux-bluetooth@vger.kernel.org, padovan@profusion.mobi,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Waldemar Rymarkiewicz <waldemar.rymarkiewicz@gmail.com>
Date: Fri, 23 Sep 2011 10:05:06 +0200
In-Reply-To: <1316764890-11806-1-git-send-email-waldemar.rymarkiewicz@tieto.com>
References: <1316764890-11806-1-git-send-email-waldemar.rymarkiewicz@tieto.com>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <1316765111.1937.136.camel@aeonflux>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Waldemar,

> Checking conn->pending_sec_level if there is no connection leads to potential
> null pointer dereference. Don't process pin_code_request_event at all if no
> connection exists.
> 
> Signed-off-by: Waldemar Rymarkiewicz <waldemar.rymarkiewicz@gmail.com>

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel


