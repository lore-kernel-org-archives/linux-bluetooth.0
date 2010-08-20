Return-Path: <cyrus@holtmann.org>
Date: Fri, 20 Aug 2010 13:31:12 +0300
From: Ville Tervo <ville.tervo@nokia.com>
To: ext Anderson Briglia <anderson.briglia@openbossa.org>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH v2] Bluetooth: Implement LE Set Advertise Enable cmd
Message-ID: <20100820103112.GA1835@null.mobile.lnx.nokia.com>
References: <1282232558-14472-1-git-send-email-anderson.briglia@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1282232558-14472-1-git-send-email-anderson.briglia@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Thu, Aug 19, 2010 at 05:42:38PM +0200, ext Anderson Briglia wrote:
> This patch implements LE Set Advertise Enable command for dual mode and
> Low Energy hci controllers. It also adds new HCI flags in order to
> indicate the Advertising state for userland applications and kernel
> itself.
> 
> Signed-off-by: Anderson Briglia <anderson.briglia@openbossa.org>
> ---
>  include/net/bluetooth/hci.h |    6 ++++++
>  net/bluetooth/hci_event.c   |   27 +++++++++++++++++++++++++++
>  2 files changed, 33 insertions(+), 0 deletions(-)

Patch looks good to me, but I don't have working hardware to verify it currently.


-- 
Ville
