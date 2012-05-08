Return-Path: <cyrus@holtmann.org>
Date: Tue, 8 May 2012 13:18:55 -0700
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Tom Gundersen <teg@jklm.no>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/2] systemd: don't order against syslog.target
Message-ID: <20120508201855.GA7204@x220.hpllc.com>
References: <1336083713-8417-1-git-send-email-teg@jklm.no>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1336083713-8417-1-git-send-email-teg@jklm.no>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Tom,

On Fri, May 04, 2012, Tom Gundersen wrote:
> This was only needed in old versions of systemd. All messages are logged
> by default to the journal now, no ordering required.
> 
> Signed-off-by: Tom Gundersen <teg@jklm.no>
> ---
>  src/bluetooth.service.in |    2 --
>  1 file changed, 2 deletions(-)

Both patches have been pushed upstream. Thanks.

Btw, I had to remove the Signed-off-by stuff since we don't use that for
user space patches.

Johan
