Return-Path: <cyrus@holtmann.org>
Date: Fri, 18 Oct 2013 10:08:02 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Claudio Takahasi <claudio.takahasi@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ] core: Fix missing adapter address type
Message-ID: <20131018070802.GA23245@x220.p-661hnu-f1>
References: <1382014417-23930-1-git-send-email-claudio.takahasi@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1382014417-23930-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Claudio,

On Thu, Oct 17, 2013, Claudio Takahasi wrote:
> This patch fixes an invalid argument error when connecting to LE
> devices. Bind and connect address type must match.
> ---
>  src/device.c | 1 +
>  1 file changed, 1 insertion(+)

Applied. Thanks.

Johan
