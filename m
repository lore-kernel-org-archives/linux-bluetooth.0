Return-Path: <cyrus@holtmann.org>
Date: Wed, 30 Mar 2011 17:00:42 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 2/2] Bluetooth: Add mgmt_remote_name event
Message-ID: <20110330140042.GA28881@jh-x301>
References: <1301480292-25370-1-git-send-email-johan.hedberg@gmail.com>
 <1301480292-25370-2-git-send-email-johan.hedberg@gmail.com>
 <AANLkTi=BZhjKvCBon7qhS0tCPkABmv7to39UhoaQE1a8@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <AANLkTi=BZhjKvCBon7qhS0tCPkABmv7to39UhoaQE1a8@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Wed, Mar 30, 2011, Anderson Lizardo wrote:
> > This patch adds a new remote_name event to the Management interface
> > which is sent every time the name of a remote device is resolved (over
> > BR/EDR).
> 
> Just wondering if we could ever reuse this for LE. For LE (and GATT
> over BR/EDR ?), I believe the "remote device name resolution" is done
> by looking at the GAP "Device Name" characteristic after a service
> discovery (see spec page 1739).
> 
> The advertising data may contain the "full" device name as well, but
> it is not mandatory to include it. GAP Device Name OTOH is mandatory.

I suppose it can't be reused for LE. Btw, this event will *not* be sent
for advertising data or extended inquiry response data containing a
remote name. User space is expected to do that extraction from the data
(which comes in the mgmt_device_found event).

Johan
