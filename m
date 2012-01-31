Return-Path: <cyrus@holtmann.org>
Date: Tue, 31 Jan 2012 09:37:02 -0800
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ 1/6] event: Add type information to the mgmt
 "Device Connected" event
Message-ID: <20120131173702.GA13845@x220.amr.corp.intel.com>
References: <1328029853-21134-1-git-send-email-vinicius.gomes@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1328029853-21134-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Vinicius,

On Tue, Jan 31, 2012, Vinicius Costa Gomes wrote:
> In the case of incomming connections we have to know the type of
> the device that connected to us.
> 
> Through hciops we have the LE Connection Complete event, that
> information was lost when Management interface was being used.
> ---
>  plugins/hciops.c  |   30 +++++++++++++++++-------------
>  plugins/mgmtops.c |   29 +++++++++++++++--------------
>  src/device.c      |    8 ++++++++
>  src/device.h      |    1 +
>  src/event.c       |    4 +++-
>  src/event.h       |    2 +-
>  6 files changed, 45 insertions(+), 29 deletions(-)

All six patches have been applied. Thanks.

Please pay attention to your summary line lengths in the future.
Remember that git shortlog indents them by 6 characters so anything over
74 will look strange. I fixed it manually this time.

Johan
