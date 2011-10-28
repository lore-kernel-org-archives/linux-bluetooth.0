Return-Path: <cyrus@holtmann.org>
Date: Fri, 28 Oct 2011 14:07:07 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Slawomir Bochenski <lkslawek@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH obexd] Fix crash on error in agent_request_reply
Message-ID: <20111028110707.GD15672@fusion.localdomain>
References: <1319797291-12248-1-git-send-email-lkslawek@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1319797291-12248-1-git-send-email-lkslawek@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Slawek,

On Fri, Oct 28, 2011, Slawomir Bochenski wrote:
> This fixes regression introduced by
> 63becff48820dc50a30ae495e286e858a886d9dd, causing obex-client to crash
> in cases of e.g. remote site rejecting pushed file.
> 
> The req->function set by user of agent API may request agent object
> deletion. This in turn checks if agent->pending is set and if it is,
> it tries to cancel the pending call and frees pending call data. As at
> this point we are already handling call response and we are going to
> free this pending call data, agent->pending can be set to NULL prior to
> calling req->function, thus preventing premature freeing of later
> dereferenced req.
> ---
>  client/agent.c |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletions(-)

Applied. Thanks.

Johan
