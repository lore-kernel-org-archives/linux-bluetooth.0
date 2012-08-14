Return-Path: <cyrus@holtmann.org>
Date: Tue, 14 Aug 2012 12:44:49 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: =?iso-8859-1?Q?Jo=E3o?= Paulo Rechi Vita <jprvita@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ 0/3] HoG: Add support for non-HID services
 encapsulated in the HID protocol
Message-ID: <20120814094449.GA5818@x220>
References: <1344860596-30617-1-git-send-email-jprvita@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1344860596-30617-1-git-send-email-jprvita@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi João Paulo,

On Mon, Aug 13, 2012, João Paulo Rechi Vita wrote:
> The HID protocol support encapsulating non-HID service data as reports. This
> patches adds support for this feature for HoG devices.
> 
> João Paulo Rechi Vita (3):
>   gatt: Add a new descriptor UUID
>   hog: discover External Report Reference descriptor
>   hog: discover the non-HID service characteristic
> 
>  attrib/gatt.h               |  1 +
>  profiles/input/hog_device.c | 96 ++++++++++++++++++++++++++++++++++++++-------
>  2 files changed, 83 insertions(+), 14 deletions(-)

All three patches have been applied. Thanks.

Johan
