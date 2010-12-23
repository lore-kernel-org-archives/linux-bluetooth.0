Return-Path: <cyrus@holtmann.org>
Date: Fri, 24 Dec 2010 00:40:10 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Sheldon Demario <sheldon.demario@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Add Broadcaster property in DeviceFound signal
Message-ID: <20101223224010.GB32310@jh-x301>
References: <1293139987-17536-1-git-send-email-sheldon.demario@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1293139987-17536-1-git-send-email-sheldon.demario@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Sheldon,

On Thu, Dec 23, 2010, Sheldon Demario wrote:
> Broadcaster property is required to distinguish the device role. If the remote
> is sending an advertising event, two possible roles are possible: Peripheral or
> Broadcaster.
> 
> This change is required to pass on qualification tests which require filtering
> Broadcasting devices during General Discovery Procedure.
> ---
>  doc/adapter-api.txt |    3 ++-
>  src/adapter.c       |    8 ++++++++
>  2 files changed, 10 insertions(+), 1 deletions(-)

Pushed upstream after I reformated your commit message to properly fit a
80 column wide terminal. Please pay attention to that in the future.

Johan
