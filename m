Return-Path: <cyrus@holtmann.org>
Date: Wed, 18 Jan 2012 14:22:20 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Hemant Gupta <hemant.gupta@stericsson.com>
Cc: linux-bluetooth@vger.kernel.org,
	Hemant Gupta <hemantgupta.ste@gmail.com>
Subject: Re: [PATCH v1 1/1] Add KeyboardDisplay IO Capability
Message-ID: <20120118122220.GD6655@x220>
References: <1326701202-23977-1-git-send-email-hemant.gupta@stericsson.com>
 <1326701202-23977-2-git-send-email-hemant.gupta@stericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1326701202-23977-2-git-send-email-hemant.gupta@stericsson.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Hemant,

On Mon, Jan 16, 2012, Hemant Gupta wrote:
> This patch adds suppport for KeyboardDisplay IO capability in BlueZ.
> It is ensured that the new capability is set only if management
> interface is being used. For hciops Keyboarddisplay capability is
> mapped to DisplayYesNo.
> ---
>  plugins/hciops.c |    8 +++++++-
>  src/adapter.c    |    3 +++
>  2 files changed, 10 insertions(+), 1 deletions(-)

Applied. Thanks.

Johan
