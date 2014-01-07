Return-Path: <cyrus@holtmann.org>
Date: Tue, 7 Jan 2014 20:30:03 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcin Kraglak <marcin.kraglak@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCHv2 4/5] emulator/bthost: Add initial rfcomm handling
Message-ID: <20140107183003.GD18725@x220.p-661hnu-f1>
References: <1389092354-32544-1-git-send-email-marcin.kraglak@tieto.com>
 <1389092354-32544-4-git-send-email-marcin.kraglak@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1389092354-32544-4-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcin,

On Tue, Jan 07, 2014, Marcin Kraglak wrote:
> +		l2conn = btconn_find_l2cap_conn_by_scid(conn, cid);
> +		if (l2conn->psm == 0x0003)

Looks like there a missing NULL check for the return value of
btconn_find_l2cap_conn_by_scid.

Johan
