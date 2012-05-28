Return-Path: <cyrus@holtmann.org>
Date: Mon, 28 May 2012 18:29:44 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ v2] AVRCP: Fix not registering to VolumeChanged
 event again when notified
Message-ID: <20120528152944.GA28797@x220>
References: <1338203808-15142-1-git-send-email-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1338203808-15142-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Mon, May 28, 2012, Luiz Augusto von Dentz wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> The spec says:
> 
> "A registered notification gets changed on receiving CHANGED event
> notification. For a new notification additional NOTIFY command is
> expected to be sent."
> ---
> v2: Fix check to do logical AND not OR
> 
>  audio/avrcp.c |    9 ++++++++-
>  1 files changed, 8 insertions(+), 1 deletions(-)

Applied. Thanks.

Johan
