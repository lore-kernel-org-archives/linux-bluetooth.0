Return-Path: <cyrus@holtmann.org>
Date: Fri, 27 Mar 2009 22:49:54 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Nick Pelly <npelly@google.com>, linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] AVDTP Qualification: Use GENERAL_REJECT instead of
	REJECT for unknown command.
Message-ID: <20090327204954.GA2306@jh-x301>
References: <35c90d960903271323w6f206741ya366a11464461235@mail.gmail.com> <20090327204820.GA2222@jh-x301>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20090327204820.GA2222@jh-x301>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Fri, Mar 27, 2009, Johan Hedberg wrote:
> > From: Nick Pelly <npelly@google.com>
> > Date: Fri, 27 Mar 2009 12:57:45 -0700
> > Subject: [PATCH 1/2] AVCTP qualification: Handle more error codes.
> 
> This one has been pushed upstream. Thanks.

Sorry, that was supposed to refer to the other patch. The general reject one
doesn't look right. There's no message type of 0x01 according to AVDTP 1.2. The
way I interpret it is that general reject should use the normal reject message
type.

Johan
