Return-Path: <cyrus@holtmann.org>
Date: Fri, 14 Jan 2011 11:54:19 +0000
From: Johan Hedberg <johan.hedberg@gmail.com>
To: lkslawek@gmail.com
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCHv2] Fix plugin close & disconnect functions call order
Message-ID: <20110114115419.GA20354@jh-x301>
References: <1294999445-3768-1-git-send-email-lkslawek@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1294999445-3768-1-git-send-email-lkslawek@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Slawek,

On Fri, Jan 14, 2011, lkslawek@gmail.com wrote:
> From: Slawomir Bochenski <lkslawek@gmail.com>
> 
> Normally during an OBEX session, calling sequence
> 
> service->connect - [driver->open - driver->close]* - service->disconnect
> 
> is kept. The only exception to this when the connection is reset
> (when no ABORT was sent) during transfer. Then the sequence is:
> 
> service->connect - [driver->open - driver->close]* - driver->open -
> service->disconnect - driver->close
> 
> This patch fixes it, so memory managament of session/transfer data in
> service plugin can be easier.
> ---
>  src/obex.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)

Pushed upstream. Thanks.

Johan
