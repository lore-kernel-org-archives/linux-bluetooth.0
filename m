Return-Path: <cyrus@holtmann.org>
Date: Wed, 6 Oct 2010 23:43:03 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Claudio Takahasi <claudio.takahasi@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 2/2] Client Characteristic Configuration on attribute
 server
Message-ID: <20101006214303.GB21610@jh-x301>
References: <1286397594-12366-1-git-send-email-claudio.takahasi@openbossa.org>
 <1286397594-12366-2-git-send-email-claudio.takahasi@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1286397594-12366-2-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Claudio,

On Wed, Oct 06, 2010, Claudio Takahasi wrote:
> Initial implementation of per client attribute configuration for the
> attribute server. Notification and indication shall be sent to the peer
> only if Client Characteristic Configuration bit field is set.
> ---
>  TODO                |    7 --
>  src/attrib-server.c |  194 +++++++++++++++++++++++++++++++++++---------------
>  src/storage.c       |   44 ++++++++++++
>  src/storage.h       |    4 +
>  4 files changed, 184 insertions(+), 65 deletions(-)

I feel a bit conflicted about this one. Do we really want to have a
generic storage for all characteristics? I'd think that it'd make sense
to let each service implementation take care of how to store their state
persistently (if it needs to be done at all).

Would it be possible for you to create a patch that fixes the
notification sending to clients that haven't subscribed for them but
leaves out the storage stuff?

Johan
