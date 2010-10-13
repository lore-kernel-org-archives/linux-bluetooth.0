Return-Path: <cyrus@holtmann.org>
Date: Wed, 13 Oct 2010 19:59:05 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Claudio Takahasi <claudio.takahasi@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/2] Disable automatic notification/indication in the
 attribute server
Message-ID: <20101013165905.GA9636@jh-x301>
References: <1286459639-25194-1-git-send-email-claudio.takahasi@openbossa.org>
 <1286987539-25833-1-git-send-email-claudio.takahasi@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1286987539-25833-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Claudio,

On Wed, Oct 13, 2010, Claudio Takahasi wrote:
> Attribute server shall not send automatic indication/notification
> messages if the client didn't request them. Client shall use Client
> /Server Characteristic Configuration descriptors to be notified about
> attribute changes. If the server doesn't support these descriptors,
> the client shall implement a polling mechanism to check for attribute
> value changes.
> ---
>  TODO                |    7 ------
>  src/attrib-server.c |   60 ++++----------------------------------------------
>  2 files changed, 5 insertions(+), 62 deletions(-)

Thanks. The patch is now upstream.

Johan
