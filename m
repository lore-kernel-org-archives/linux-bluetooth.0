Return-Path: <cyrus@holtmann.org>
Date: Tue, 24 Jul 2012 11:34:58 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Claudio Takahasi <claudio.takahasi@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ] serial: Remove serial test script
Message-ID: <20120724093458.GA8836@x220.ice.intel.com>
References: <1342715766-22943-1-git-send-email-claudio.takahasi@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1342715766-22943-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Claudio,

On Thu, Jul 19, 2012, Claudio Takahasi wrote:
> ---
>  test/test-serial |   58 ------------------------------------------------------
>  1 files changed, 0 insertions(+), 58 deletions(-)
>  delete mode 100755 test/test-serial

Both of your test-* patches are missing the necessary updates to
Makefile.tools. Please fix and resend.

Johan
