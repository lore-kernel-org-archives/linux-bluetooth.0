Return-Path: <cyrus@holtmann.org>
Date: Tue, 8 Jan 2013 13:57:32 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Mikel Astiz <mikel.astiz.oss@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, claudio.takahasi@openbossa.org,
	Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: Re: [PATCH v0 0/2] Media API clarifications
Message-ID: <20130108115732.GA8622@x220.ger.corp.intel.com>
References: <1357638065-19156-1-git-send-email-mikel.astiz.oss@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1357638065-19156-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mikel,

On Tue, Jan 08, 2013, Mikel Astiz wrote:
> The documentation of BlueZ 5.0 is lacking some details affecting the
> Media API, specially regarding the control of HFP/HSP volume.
> 
> There is no known implementation of MediaTransport1 at this point so
> updating the documentation with two new optional properties could be
> in practice done without updating the interface suffix.
> 
> Besides, the error codes returned by Acquire() and TryAcquire() are
> convenient to implement proper error logging in the client side.
> 
> Mikel Astiz (2):
>   media: Add HFP/HSP gains to transport API
>   media: Clarify Acquire/TryAcquire error cases
> 
>  doc/media-api.txt          | 32 +++++++++++++++++++++++++++++++-
>  profiles/audio/transport.c |  2 +-
>  2 files changed, 32 insertions(+), 2 deletions(-)

Both patches have been applied. Thanks.

Johan
