Return-Path: <cyrus@holtmann.org>
Date: Mon, 11 Jul 2011 15:52:54 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Dmitriy Paliy <dmitriy.paliy@nokia.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ v3] Fix unpair device when disconnected for No
 Bonding
Message-ID: <20110711125254.GA16751@dell.ger.corp.intel.com>
References: <1310386806-19305-1-git-send-email-dmitriy.paliy@nokia.com>
 <1310386806-19305-2-git-send-email-dmitriy.paliy@nokia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1310386806-19305-2-git-send-email-dmitriy.paliy@nokia.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Dmitriy,

On Mon, Jul 11, 2011, Dmitriy Paliy wrote:
> Fix Paired device property if 'No Bonding' authentication is used. It is
> set to be false when device is disconnected and no link key is stored.
> Otherwise, there can be cases when device is still valid and being
> claimed as paired without available bonding information.
> 
> For instanse, use of CreateDevice method call and obex client file
> transfer is such use case.
> ---
>  src/device.c |   19 ++++++++++++++++++-
>  src/device.h |    1 +
>  src/event.c  |    8 ++++++--
>  3 files changed, 25 insertions(+), 3 deletions(-)

Applied, and I also pushed a cleanup patch on top of it because
device_remove_bonding was essentially useless. One thing that I'm
thinking of is maybe it'd be better to get rid of the paired and bonded
booleans have a single enum for them since they are dependent on each
other and one combination of boolean values (!paired && bonded) is not
possible. Maybe something like the following inside struct btd_device:

	enum {
		DEVICE_PAIRING_STATUS_NONE,
		DEVICE_PAIRING_STATUS_PAIRED,
		DEVICE_PAIRING_STATUS_BONDED,
	} pairing_status;

Thoughts?

Johan
