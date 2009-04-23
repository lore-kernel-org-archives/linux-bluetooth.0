Return-Path: <cyrus@holtmann.org>
Date: Thu, 23 Apr 2009 15:42:07 +0300
From: Johan Hedberg <johan.hedberg@nokia.com>
To: Scott Talbot <psyc@stalbot.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Fix sending AVRCP button released passthrough messages
Message-ID: <20090423124207.GA8492@localhost>
References: <1240487616-8920-1-git-send-email-psyc@stalbot.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
In-Reply-To: <1240487616-8920-1-git-send-email-psyc@stalbot.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Scott,

On Thu, Apr 23, 2009, Scott Talbot wrote:
>Set the high bit in the op value for the button released event rather
>than clearing the entire field.
>---
> audio/control.c |    2 +-
> 1 files changed, 1 insertions(+), 1 deletions(-)
>
>diff --git a/audio/control.c b/audio/control.c
>index e0451e7..5cc4a31 100644
>--- a/audio/control.c
>+++ b/audio/control.c
>@@ -937,7 +937,7 @@ static int avctp_send_passthrough(struct control *control, uint8_t op)
> 
> 	/* Button release */
> 	avctp->transaction = transaction++;
>-	operands[0] &= 0x80;
>+	operands[0] |= 0x80;
> 
> 	return write(sk, buf, sizeof(buf));
> }

Yeah, stupid mistake by me (though headsets I tested with didn't seem to 
mind this). Thanks for catching it! The patch is now pushed upstream.

Johan

