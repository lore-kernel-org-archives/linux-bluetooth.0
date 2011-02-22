Return-Path: <cyrus@holtmann.org>
Date: Tue, 22 Feb 2011 16:14:20 -0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/5] Add support for pcsuite lock file
Message-ID: <20110222191419.GA5469@jh-x301>
References: <1298367822-27766-1-git-send-email-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1298367822-27766-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Tue, Feb 22, 2011, Luiz Augusto von Dentz wrote:
> This should make others applications able to detect when pcsuite is
> connected.
> ---
>  plugins/ftp.c |  160 ++++++++++++++++++++++++++++++++++++++++++++++++++++++--
>  1 files changed, 154 insertions(+), 6 deletions(-)

Doesn't compile (ssize_t correct format string is %zd):

plugins/ftp.c: In function 'ftp_put':
plugins/ftp.c:288: error: format '%d' expects type 'int', but argument 6 has type 'ssize_t'

Also, all the added debug prints don't seem to relate to the commit
message in anyway. Probably better to split into a separate patch?

Johan
