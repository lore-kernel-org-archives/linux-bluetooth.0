Return-Path: <cyrus@holtmann.org>
Date: Wed, 5 Oct 2011 17:40:06 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Slawomir Bochenski <lkslawek@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH obexd 1/4] Reverse order of calls in os_reset_session
Message-ID: <20111005144006.GC1370@fusion.localdomain>
References: <1317825160-21429-1-git-send-email-lkslawek@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1317825160-21429-1-git-send-email-lkslawek@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Slawek,

On Wed, Oct 05, 2011, Slawomir Bochenski wrote:
> This replaces:
> service->get/put, mime->open, ..., service->reset, mime->close
> logic, with a more appropriate:
> service->get/put, mime->open, ..., mime->close, service->reset
> ---
>  src/obex.c |    5 +++--
>  1 files changed, 3 insertions(+), 2 deletions(-)

Patches 1-3 have been applied. Thanks.

Johan
