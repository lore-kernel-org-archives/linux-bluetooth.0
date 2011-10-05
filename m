Return-Path: <cyrus@holtmann.org>
Date: Wed, 5 Oct 2011 18:05:33 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Claudio Takahasi <claudio.takahasi@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ 00/11] Re-connections triggered by platform event
Message-ID: <20111005150533.GA4111@fusion.localdomain>
References: <1317059308-20038-1-git-send-email-claudio.takahasi@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1317059308-20038-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Claudio,

On Mon, Sep 26, 2011, Claudio Takahasi wrote:
> Proposal to enable re-connection(for ATT) started by platform/user
> actions. eg: Screen unlocked.
> 
> Use case: When the user unlocks the screen, automatic re-connections for
> bonded devices will start. It will remain active for a short period of
> time(default 1 min).
> 
> Anderson Briglia (2):
>   Add display lock watcher on maemo6 plugin
>   Enable re-connection if reason is Timeout
> 
> Claudio Takahasi (9):
>   Remove timer to trigger connection attempts
>   Add set auto connect in device
>   Add continuous connection attempt
>   Add checking if profiles are requesting connection
>   Fix repeated connection attempt to the same remote
>   Disable automatic connections after 60 seconds
>   Set auto connect from maemo6 plugin
>   Add an interval between connection attempts
>   Add automatic connect timeout config option
> 
>  plugins/maemo6.c |   32 +++++++++++++++
>  src/adapter.c    |   40 +++++++++++++++++++
>  src/adapter.h    |    1 +
>  src/device.c     |  113 ++++++++++++++++++++++++++++++++++++++++--------------
>  src/device.h     |    1 +
>  src/hcid.h       |    1 +
>  src/main.c       |   12 ++++++
>  src/main.conf    |    6 +++
>  8 files changed, 177 insertions(+), 29 deletions(-)

All patches have been applied. Thanks.

Johan
