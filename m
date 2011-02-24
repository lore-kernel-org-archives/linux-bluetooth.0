Return-Path: <cyrus@holtmann.org>
Date: Thu, 24 Feb 2011 18:59:37 -0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Fix test/test-attrib script
Message-ID: <20110224215937.GA3740@jh-x301>
References: <1298584020-14568-1-git-send-email-anderson.lizardo@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1298584020-14568-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lizardo,

On Thu, Feb 24, 2011, Anderson Lizardo wrote:
> Characteristics are not being fetched anymore when the device is
> created. Discover method needs to be called actively to discover the
> characteristics exposed by a given service.
> ---
>  test/test-attrib |   12 ++++++++----
>  1 files changed, 8 insertions(+), 4 deletions(-)

Pushed upstream. Thanks.

Johan
