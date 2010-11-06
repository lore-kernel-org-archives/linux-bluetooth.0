Return-Path: <cyrus@holtmann.org>
Date: Sat, 6 Nov 2010 12:56:17 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Elvis =?iso-8859-1?Q?Pf=FCtzenreuter?= <epx@signove.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/2] Add Application property to HealthChannel
Message-ID: <20101106105617.GA18590@jh-x301>
References: <1288793188-11514-1-git-send-email-epx@signove.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1288793188-11514-1-git-send-email-epx@signove.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Elvis,

On Wed, Nov 03, 2010, Elvis Pfützenreuter wrote:
> This patch adds the Application property to HealthChannel, which
> allows to unambiguously relate a channel to an application.
> 
> This property is useful when there are several processes interested
> in accepting HealthChannels but device address is not sufficient
> criteria to engage upon, or ignore, the ChannelConnected signal.
> Having the application path allows to determine role and data type,
> in the context of the process that has created that application.
> ---
>  doc/health-api.txt |    5 +++++
>  health/hdp.c       |    3 +++
>  2 files changed, 8 insertions(+), 0 deletions(-)

Both patches have been pushed upstream. Thanks.

Johan
