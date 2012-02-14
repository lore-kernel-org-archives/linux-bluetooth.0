Return-Path: <cyrus@holtmann.org>
Date: Tue, 14 Feb 2012 14:13:44 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Claudio Takahasi <claudio.takahasi@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ] attrib-server: Fix invalid read
Message-ID: <20120214121344.GB10506@x220.ger.corp.intel.com>
References: <1328803341-28049-1-git-send-email-claudio.takahasi@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1328803341-28049-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Claudio,

On Thu, Feb 09, 2012, Claudio Takahasi wrote:
> This patch fixes an invalid read for incoming connections when
> the remote initiates the link disconnection.
> ---
>  src/attrib-server.c |    1 -
>  1 files changed, 0 insertions(+), 1 deletions(-)

Applied. Thanks.

Johan
