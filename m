Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.2\))
Subject: Re: [PATCH] sdp: Fix requests with invalid size
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1404158326-12178-1-git-send-email-arakhov@chromium.org>
Date: Mon, 30 Jun 2014 22:18:05 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <5382E942-D849-40EB-BA9A-F36BDD5B6888@holtmann.org>
References: <1403929003-31639-1-git-send-email-arakhov@chromium.org> <1404158326-12178-1-git-send-email-arakhov@chromium.org>
To: Artem Rakhov <arakhov@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Artem,

> This patch fixes processing of SDP requests which have wrong PDU size in header.
> 
> Every SDP request consists of two parts: header and data.
> Header always contains 3 values: request code (identifies it's type),
> transaction ID (in order to match response with request), and data's size.
> 
> According to Bluetooth specification, when the data's size is wrong,
> SDP server should return SDP_ErrorResponse with "Invalid PDU Size" parameter.
> But now the server doesn't respond at all, and corresponding socket on
> client's side crashes.
> 
> The patch actually reverts commit 388761cdc8f8a1293bb0b1a5bd576b5fb41616ca,
> because the size of request should be checked inside handle_request() function
> in order to be able to respond with SDP_ErrorResponse, instead of stopping
> the connection.
> ---
> src/sdpd-server.c | 6 +++++-
> 1 file changed, 5 insertions(+), 1 deletion(-)

patch has been applied.

Regards

Marcel

