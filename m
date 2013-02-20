Return-Path: <cyrus@holtmann.org>
Message-ID: <1361395208.1583.83.camel@aeonflux>
Subject: Re: [PATCH 06/16] Bluetooth: use l2cap_chan_ready() instead of
 duplicate code
From: Marcel Holtmann <marcel@holtmann.org>
To: Gustavo Padovan <gustavo@padovan.org>
Cc: linux-bluetooth@vger.kernel.org,
	Gustavo Padovan <gustavo.padovan@collabora.co.uk>
Date: Wed, 20 Feb 2013 22:20:08 +0100
In-Reply-To: <1361391103-30738-7-git-send-email-gustavo@padovan.org>
References: <1361391103-30738-1-git-send-email-gustavo@padovan.org>
	 <1361391103-30738-7-git-send-email-gustavo@padovan.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gustavo,

> l2cap_chan_ready() does exactly what we want here avoiding duplicate code.

what do we want here exactly. Why is l2cap_chan_ready() correct and has
no side effects. Why was the previous code wrong? There must have been a
reason.

Regards

Marcel


