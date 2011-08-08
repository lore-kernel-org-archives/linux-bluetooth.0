Return-Path: <cyrus@holtmann.org>
Date: Mon, 8 Aug 2011 13:36:24 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Claudio Takahasi <claudio.takahasi@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ 0/7] Proximity Monitor optimizations and checks
Message-ID: <20110808103624.GA16107@dell>
References: <1312396907-14524-1-git-send-email-claudio.takahasi@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1312396907-14524-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Claudio,

On Wed, Aug 03, 2011, Claudio Takahasi wrote:
> Dependency: "[PATCH BlueZ 0/3] Add Proximity Monitor properties" needs
> to be applied first.
> 
> The following patches contain optimizations and configuration checking
> based on proximity config file values.
> 
> Bruna Moreira (1):
>   Add enum for alert level values
> 
> Claudio Takahasi (6):
>   Parse handles when probing on Proximity
>   Request connection if Link or Path Loss is enabled
>   Write Link Loss alert if the service is enabled
>   Add utility function to convert alert levels
>   Add function to check invalid alert level value
>   Skip Link Loss handle discovery
> 
>  proximity/manager.c |   36 +++++++++-----
>  proximity/monitor.c |  137 ++++++++++++++++++++++++++++++++++-----------------
>  proximity/monitor.h |    3 +-
>  3 files changed, 118 insertions(+), 58 deletions(-)

Applied. Thanks.

Johan
