Return-Path: <cyrus@holtmann.org>
Date: Thu, 24 Feb 2011 15:28:53 -0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Claudio Takahasi <claudio.takahasi@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Don't register GATT related SDP records if attrib
 server is disabled
Message-ID: <20110224182853.GC16528@jh-x301>
References: <1298484913-21415-1-git-send-email-claudio.takahasi@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1298484913-21415-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Claudio,

On Wed, Feb 23, 2011, Claudio Takahasi wrote:
> GATT related SDP records should not be added if "AttributeServer" option
> is false in the configuration file. Problem happens only when attribute
> plugin is enabled.
> ---
>  attrib/manager.c |   14 ++++++++------
>  1 files changed, 8 insertions(+), 6 deletions(-)

Pushed upstream. Thanks.

Johan
