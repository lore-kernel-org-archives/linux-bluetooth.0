Return-Path: <cyrus@holtmann.org>
Date: Tue, 27 Sep 2011 11:32:01 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: "Gustavo F. Padovan" <padovan@profusion.mobi>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/2] serial: fix DBus message reply
Message-ID: <20110927083201.GJ3952@dell>
References: <1315937765-32168-1-git-send-email-padovan@profusion.mobi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1315937765-32168-1-git-send-email-padovan@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gustavo,

On Tue, Sep 13, 2011, Gustavo F. Padovan wrote:
> From: "Gustavo F. Padovan" <padovan@profusion.mobi>
> 
> If reply is NULL we have a crash.
> ---
>  serial/port.c |    6 ++----
>  1 files changed, 2 insertions(+), 4 deletions(-)

Both patches applied. Thanks.

Johan
