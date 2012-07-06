Return-Path: <cyrus@holtmann.org>
Date: Fri, 6 Jul 2012 12:18:27 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Jaganath Kanakkassery <jaganath.k@samsung.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v2 1/2] Bluetooth: Refactor PIN code rejection to use
 user_pairing_resp()
Message-ID: <20120706091827.GA10494@x220.ger.corp.intel.com>
References: <1341551602-1493-1-git-send-email-jaganath.k@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1341551602-1493-1-git-send-email-jaganath.k@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jaganath,

On Fri, Jul 06, 2012, Jaganath Kanakkassery wrote:
> Reuse user_pairing_resp() to send PIN code negative reply.
> 
> Signed-off-by: Jaganath Kanakkassery <jaganath.k@samsung.com>
> ---
>  net/bluetooth/mgmt.c |  155 +++++++++++++++++++++++---------------------------
>  1 files changed, 72 insertions(+), 83 deletions(-)

Would it be possible for you to do this patch without moving around the
functions? It'd make it easier to see that only the relevant bits are
changed.

Johan
