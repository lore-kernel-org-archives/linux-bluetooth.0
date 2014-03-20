Return-Path: <cyrus@holtmann.org>
Date: Thu, 20 Mar 2014 16:24:43 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ] obexd/client: Fix not being able cancel GET
 requests
Message-ID: <20140320142443.GC14172@t440s.lan>
References: <1395323451-31229-1-git-send-email-luiz.dentz@gmail.com>
 <1395323451-31229-2-git-send-email-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1395323451-31229-2-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Thu, Mar 20, 2014, Luiz Augusto von Dentz wrote:
> In case of GET operation the code does not use g_obex_get_req_pkt since
> the beggining to be able to read the header from the first response, this
> means that the request should be cancel with g_obex_cancel_req not with
> g_obex_cancel_transfer.
> ---
>  obexd/client/transfer.c | 18 ++++++++++++++++--
>  1 file changed, 16 insertions(+), 2 deletions(-)

Applied. Thanks.

Johan
