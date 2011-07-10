Return-Path: <cyrus@holtmann.org>
Date: Sun, 10 Jul 2011 10:58:43 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: lukasz.rymanowski@gmail.com
Cc: linux-bluetooth@vger.kernel.org, pkorn@gmx.net,
	luiz.dentz@gmail.com
Subject: Re: [PATCH] Fix for headset state callback
Message-ID: <20110710075843.GE1808@dell.ger.corp.intel.com>
References: <1310105569-23441-1-git-send-email-lukasz.rymanowski@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1310105569-23441-1-git-send-email-lukasz.rymanowski@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lucasz,

On Fri, Jul 08, 2011, lukasz.rymanowski@gmail.com wrote:
> Headset watch is not registered per device. Therefore, when headset
> disconnects, there is need to check for which audio device it is
> called.
> ---
>  audio/media.c     |    7 ++++++-
>  audio/transport.c |    5 +++++
>  audio/transport.h |    1 +
>  3 files changed, 12 insertions(+), 1 deletions(-)

Applied. Thanks.

Johan
