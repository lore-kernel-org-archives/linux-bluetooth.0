Return-Path: <cyrus@holtmann.org>
Date: Tue, 10 Jul 2012 18:50:57 -0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: =?iso-8859-1?Q?Jo=E3o?= Paulo Rechi Vita <jprvita@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ] hog: HID I/O driver
Message-ID: <20120710215057.GA5001@x220>
References: <1341947825-14789-2-git-send-email-jprvita@openbossa.org>
 <1341955486-11189-1-git-send-email-jprvita@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1341955486-11189-1-git-send-email-jprvita@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi João Paulo,

On Tue, Jul 10, 2012, João Paulo Rechi Vita wrote:
> uHID is HID I/O driver that makes possible to implement HID I/O drivers in
> user-space. It works similar to the uinput but it is initialized with a HID
> descriptor and deals with raw HID reports.
> 
> This commit uses uHID to create a HID device for the remote HoG device and
> to tranfers HID reports to HID subsystem.
> ---
>  profiles/input/hog_device.c |   89 ++++++++++++++++++++++++++++--------
>  profiles/input/uhid-copy.h  |  104 +++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 174 insertions(+), 19 deletions(-)
>  create mode 100644 profiles/input/uhid-copy.h

Applied (after several tweaks). Thanks.

Johan
