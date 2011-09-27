Return-Path: <cyrus@holtmann.org>
Date: Tue, 27 Sep 2011 11:22:41 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Antti Julku <antti.julku@nokia.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ] Add support for blacklisting events
Message-ID: <20110927082241.GB3952@dell>
References: <1311854423-1471-1-git-send-email-antti.julku@nokia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1311854423-1471-1-git-send-email-antti.julku@nokia.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Antti,

On Thu, Jul 28, 2011, Antti Julku wrote:
> Add support for mgmt interface events for device blocking/unblocking.
> Kernel sends a mgmt event when a device has been blocked by another
> management socket or with ioctl command (e.g. by hciconfig).
> 
> Parameter update_only is added to device_block/unblock functions in
> device.c to avoid code copying. When update_only is true, blocking
> command is not sent to kernel, but only device status is updated and
> dbus signal is sent.
> ---
>  lib/mgmt.h        |   10 +++++++++
>  plugins/mgmtops.c |   54 +++++++++++++++++++++++++++++++++++++++++++++++++++++
>  src/device.c      |   27 +++++++++++++++----------
>  src/device.h      |    5 ++++
>  src/event.c       |   26 +++++++++++++++++++++++++
>  src/event.h       |    2 +
>  6 files changed, 113 insertions(+), 11 deletions(-)

Applied. Thanks.

Johan
