Return-Path: <cyrus@holtmann.org>
Date: Tue, 27 Sep 2011 11:27:30 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Claudio Takahasi <claudio.takahasi@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ 1/2] Fix loop when setting adapter name
Message-ID: <20110927082730.GF3952@dell>
References: <1314981909-12966-1-git-send-email-claudio.takahasi@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1314981909-12966-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Claudio,

On Fri, Sep 02, 2011, Claudio Takahasi wrote:
> When management interface is enabled, name changed event comes when the
> adapter is initialized as consequence of the Read Local Name. Use the
> same function to set and handle event causes looping when bluetoothd
> starts if the name stored in the controller is different from the name
> provided by the adapter name plugin.
> 
> Splitting the adapter_update_local_name also fix the PropertyChanged
> (for Name) signal being sent before AdapterAdded.
> ---
>  plugins/adaptername.c |    6 +++---
>  plugins/hciops.c      |    2 +-
>  plugins/mgmtops.c     |    6 +++---
>  src/adapter.c         |   43 +++++++++++++++++++++++--------------------
>  src/adapter.h         |    3 ++-
>  5 files changed, 32 insertions(+), 28 deletions(-)

Both patches applied. Thanks.

Johan
