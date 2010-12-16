Return-Path: <cyrus@holtmann.org>
Date: Thu, 16 Dec 2010 21:47:35 +0200
From: Johan Hedberg <johan.hedberg@nokia.com>
To: Dmitriy Paliy <dmitriy.paliy@nokia.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Add AVDTP SRC stream send buffer size verification
Message-ID: <20101216194735.GB24203@jh-x301>
References: <1292406533-18574-1-git-send-email-dmitriy.paliy@nokia.com>
 <1292406533-18574-2-git-send-email-dmitriy.paliy@nokia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1292406533-18574-2-git-send-email-dmitriy.paliy@nokia.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Dmitriy,

On Wed, Dec 15, 2010, Dmitriy Paliy wrote:
> Functions get_send_buffer_size and set_send_buffer_size are added to
> avdpt.c.
> 
> get_send_buffer_size returns size of send buffer for a given socket
> on success or error code on failure. set_send_buffer_size sets size
> of send buffer for a given socket, and returns 0 on success or error
> code on failure.
> 
> Size of send buffer for L2CAP socket for SRC AVDTP stream is verified
> during establishment of a new transport channel. If the size is less
> than twice of outgoing L2CAP MTU, then it is considered as being
> insufficient to handle streaming data reliably.
> 
> In this case buffer size is increased to be twice of MTU size. Such
> fixes some IOP problems with car-kits that use large MTU for music
> playback.
> ---
>  audio/avdtp.c |   53 +++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 files changed, 53 insertions(+), 0 deletions(-)

Thanks. The patch has been pushed upstream.

Johan
