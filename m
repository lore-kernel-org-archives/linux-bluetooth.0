Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1301480292-25370-2-git-send-email-johan.hedberg@gmail.com>
References: <1301480292-25370-1-git-send-email-johan.hedberg@gmail.com>
	<1301480292-25370-2-git-send-email-johan.hedberg@gmail.com>
Date: Wed, 30 Mar 2011 09:51:42 -0400
Message-ID: <AANLkTi=BZhjKvCBon7qhS0tCPkABmv7to39UhoaQE1a8@mail.gmail.com>
Subject: Re: [PATCH 2/2] Bluetooth: Add mgmt_remote_name event
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: johan.hedberg@gmail.com
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

On Wed, Mar 30, 2011 at 6:18 AM,  <johan.hedberg@gmail.com> wrote:
> From: Johan Hedberg <johan.hedberg@nokia.com>
>
> This patch adds a new remote_name event to the Management interface
> which is sent every time the name of a remote device is resolved (over
> BR/EDR).

Just wondering if we could ever reuse this for LE. For LE (and GATT
over BR/EDR ?), I believe the "remote device name resolution" is done
by looking at the GAP "Device Name" characteristic after a service
discovery (see spec page 1739).

The advertising data may contain the "full" device name as well, but
it is not mandatory to include it. GAP Device Name OTOH is mandatory.

Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
