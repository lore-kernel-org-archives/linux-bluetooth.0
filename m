Return-Path: <cyrus@holtmann.org>
Message-ID: <1332613802.1870.66.camel@aeonflux>
Subject: Re: [PATCH 1/4] Bluetooth: Add definitions and struct members for
 new ERTM state machine
From: Marcel Holtmann <marcel@holtmann.org>
To: Mat Martineau <mathewm@codeaurora.org>
Cc: linux-bluetooth@vger.kernel.org, padovan@profusion.mobi,
	pkrystad@codeaurora.org
Date: Sat, 24 Mar 2012 11:30:02 -0700
In-Reply-To: <1332547018-19468-2-git-send-email-mathewm@codeaurora.org>
References: <1332547018-19468-1-git-send-email-mathewm@codeaurora.org>
	 <1332547018-19468-2-git-send-email-mathewm@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mat,

> Adds some missing values for control field parsing, additional data
> for the new state machine, and enumerations for states, incoming
> packet classification, and state machine events.
> 
> Signed-off-by: Mat Martineau <mathewm@codeaurora.org>
> ---
>  include/net/bluetooth/l2cap.h |   49 +++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 49 insertions(+)

looks fine to me. I assume that all entries here will be used in the
future.

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel


