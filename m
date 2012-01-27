Return-Path: <cyrus@holtmann.org>
Date: Fri, 27 Jan 2012 12:31:41 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ] audio: fix not disabling local a2dp endpoints when
 unix socket is disabled
Message-ID: <20120127103141.GA24338@x220>
References: <1327613942-23745-1-git-send-email-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1327613942-23745-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Thu, Jan 26, 2012, Luiz Augusto von Dentz wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> Local endpoints can only be used when unix socket API is available
> ---
>  audio/a2dp.c |   15 +++++++--------
>  1 files changed, 7 insertions(+), 8 deletions(-)

Applied. Thanks.

Johan
