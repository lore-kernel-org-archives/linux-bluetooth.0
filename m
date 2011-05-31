Return-Path: <cyrus@holtmann.org>
Date: Tue, 31 May 2011 09:07:42 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Waldemar Rymarkiewicz <waldemar.rymarkiewicz@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v2 2/3] Fix return value in send_message
Message-ID: <20110531060742.GB15916@dell.ger.corp.intel.com>
References: <1306749575-21119-1-git-send-email-waldemar.rymarkiewicz@tieto.com>
 <1306749575-21119-2-git-send-email-waldemar.rymarkiewicz@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1306749575-21119-2-git-send-email-waldemar.rymarkiewicz@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Waldek,

On Mon, May 30, 2011, Waldemar Rymarkiewicz wrote:
>  	gstatus = g_io_channel_write_chars(conn->io, buf, size, &written,
> -						&gerr);
> +									&gerr);

I know this is a little bit nitpicking, but I prefer keeping the commit
history clean and the commits and their messages consistent. This change
has nothing to do with the commit message. You'll probably want to merge
it with your third coding style cleanup patch.

Johan
