Return-Path: <cyrus@holtmann.org>
Date: Thu, 10 Mar 2011 11:21:37 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Claudio Takahasi <claudio.takahasi@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/2] Extend Characteristic Write to support Write
 Without Response
Message-ID: <20110310092137.GA9363@jh-x301>
References: <1299697431-7670-1-git-send-email-claudio.takahasi@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1299697431-7670-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Claudio,

On Wed, Mar 09, 2011, Claudio Takahasi wrote:
> If callback is not informed, Write Command will be used to execute
> a Write Without Response sub-procedure. Error is not returned by the
> server no matter the result of the operation.
> ---
>  attrib/gatt.c |    8 ++++++--
>  1 files changed, 6 insertions(+), 2 deletions(-)

Both patches have been pushed upstream. Thanks.

Johan
