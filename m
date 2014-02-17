Return-Path: <cyrus@holtmann.org>
Date: Mon, 17 Feb 2014 13:32:08 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcin Kraglak <marcin.kraglak@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 5/6] tools/rfcomm-tester: Add RFCOMM client read test case
Message-ID: <20140217113208.GE4004@x220.p-661hnu-f1>
References: <1392205301-4204-1-git-send-email-marcin.kraglak@tieto.com>
 <1392205301-4204-6-git-send-email-marcin.kraglak@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1392205301-4204-6-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcin,

On Wed, Feb 12, 2014, Marcin Kraglak wrote:
> +	sk = g_io_channel_unix_get_fd(io);
> +
> +
> +	if (client_data->data_len != read(sk, buf, client_data->data_len)) {

Coding style with the two consecutive empty lines above. Also consider a
separate ssize_t ret variable before the length comparison.

Johan
