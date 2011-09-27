Return-Path: <cyrus@holtmann.org>
Date: Tue, 27 Sep 2011 12:29:15 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Claudio Takahasi <claudio.takahasi@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org,
	Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: Re: [PATCH BlueZ 1/4] Attrib server integration for outgoing
 connections
Message-ID: <20110927092915.GY3952@dell>
References: <1316438402-9982-1-git-send-email-claudio.takahasi@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1316438402-9982-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Claudio,

On Mon, Sep 19, 2011, Claudio Takahasi wrote:
> We need support for attaching a client connection to the attribute
> server because the server that we are connected may want to do
> something similar to a reverse service discovery, and we need to be
> able to receive indications and notifications.
> ---
>  plugins/gatt-example.c |    3 ++-
>  src/adapter.c          |    3 ++-
>  src/attrib-server.c    |   41 +++++++++++++++++++++++++++--------------
>  src/attrib-server.h    |    1 +
>  src/device.c           |   10 ++++++++--
>  5 files changed, 40 insertions(+), 18 deletions(-)

Patches 1 and 2 have been applied, but 3 and 4 fail to apply.
Please fix those.

Johan
