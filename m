Return-Path: <cyrus@holtmann.org>
Date: Mon, 4 Nov 2013 20:11:48 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Giovanni Campagna <scampa.giovanni@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v2] hid2hci: fix regression in /dev format after moving
 away from libusb
Message-ID: <20131104181148.GA11186@x220.p-661hnu-f1>
References: <1380798229-4319-1-git-send-email-scampa.giovanni@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1380798229-4319-1-git-send-email-scampa.giovanni@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Giovanni,

On Thu, Oct 03, 2013, Giovanni Campagna wrote:
> The paths under /dev, in the default udev configuration, are formatted
> with two leading zeros, but the number obtained from sysfs don't have
> them, so we must convert them to integers and reformat them.
> ---
>  tools/hid2hci.c | 15 +++++++++------
>  1 file changed, 9 insertions(+), 6 deletions(-)

Applied. Thanks.

Johan
