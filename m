Return-Path: <cyrus@holtmann.org>
Date: Wed, 24 Aug 2011 12:45:11 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: "Gustavo F. Padovan" <padovan@profusion.mobi>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] adapter: add Trusted to DeviceFound signal
Message-ID: <20110824094511.GA21202@dell>
References: <1313698511-13365-1-git-send-email-padovan@profusion.mobi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1313698511-13365-1-git-send-email-padovan@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gustavo,

On Thu, Aug 18, 2011, Gustavo F. Padovan wrote:
> doc says that this signal is has the same parameters as GetProperties
> reply.
> ---
> 
> Not sure if this is really need. It at least could save a call to GetProperties
> 
>  src/adapter.c |    7 +++++--
>  1 files changed, 5 insertions(+), 2 deletions(-)

Applied. Thanks.

Johan
