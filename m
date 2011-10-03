Return-Path: <cyrus@holtmann.org>
Date: Mon, 3 Oct 2011 11:51:45 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ] Fix memory corruption when decoding Read Response
 PDU
Message-ID: <20111003085145.GC8956@fusion.localdomain>
References: <1317236492-13064-1-git-send-email-anderson.lizardo@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1317236492-13064-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lizardo,

On Wed, Sep 28, 2011, Anderson Lizardo wrote:
> A bogus (or hostile) Proximity Reporter device may send a TX Power value
> bigger than the buffer used. Therefore, create a temporary buffer with
> the maximum size, and check for the length before using the value.
> 
> Note that all other current users of the dec_read_resp() already do
> this. Another option would be to change dec_read_resp() to accept a
> buffer length, but this would break external code, so it is avoided for
> now.
> ---
>  proximity/monitor.c |   11 ++++++++---
>  1 files changed, 8 insertions(+), 3 deletions(-)

Applied. Thanks.

Have you considered changing the API so that the caller could tell the
function the size of the supplied buffer?

Another thing (though unrelated to this patch) I noticed: whenever you
have variables that denote some kind of size and are not directly bound
to fixed-length fields in PDU's, please use size_t or ssize_t. Feel free
to send patches to fix such issues in your code.

Johan
