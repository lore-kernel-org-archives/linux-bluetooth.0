Return-Path: <cyrus@holtmann.org>
Date: Wed, 27 Jul 2011 14:52:35 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Slawomir Bochenski <lkslawek@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH obexd] Fix finding mime driver by type
Message-ID: <20110727115235.GA3162@dell>
References: <1311245799-8662-1-git-send-email-lkslawek@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1311245799-8662-1-git-send-email-lkslawek@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Slawek,

On Thu, Jul 21, 2011, Slawomir Bochenski wrote:
> IrOBEX specification chap. 2.2.3 states that the Type header is an ASCII
> null-terminated string which values are case insensitive (as it is also
> defined by RFC 1521).
> ---
>  src/mimetype.c |    9 ++++++++-
>  1 files changed, 8 insertions(+), 1 deletions(-)

Applied. Thanks.

Johan
