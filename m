Return-Path: <cyrus@holtmann.org>
Date: Wed, 6 Oct 2010 23:40:28 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Claudio Takahasi <claudio.takahasi@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/2] Change Battery Service on attribute sample server
Message-ID: <20101006214028.GA21610@jh-x301>
References: <1286397594-12366-1-git-send-email-claudio.takahasi@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1286397594-12366-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Claudio,

On Wed, Oct 06, 2010, Claudio Takahasi wrote:
> Add an optional Client Characteristic Configuration attribute for
> Battery State to control which clients want notification/indication
> when this attribute value changes.
> ---
>  attrib/example.c |    7 ++++++-
>  1 files changed, 6 insertions(+), 1 deletions(-)

Pushed upstream. Thanks.

Johan
