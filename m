Return-Path: <cyrus@holtmann.org>
Date: Mon, 4 Nov 2013 14:37:38 -0200
From: Vinicius Costa Gomes <vcgomes@gmail.com>
To: Giovanni Campagna <scampa.giovanni@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v2] hid2hci: fix regression in /dev format after moving
 away from libusb
Message-ID: <20131104163738.GA31305@molly.amr.corp.intel.com>
References: <1380798229-4319-1-git-send-email-scampa.giovanni@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1380798229-4319-1-git-send-email-scampa.giovanni@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On 13:03 Thu 03 Oct, Giovanni Campagna wrote:
> From: Giovanni Campagna <gcampagna@src.gnome.org>
> 
> The paths under /dev, in the default udev configuration, are formatted
> with two leading zeros, but the number obtained from sysfs don't have
> them, so we must convert them to integers and reformat them.
> ---
>  tools/hid2hci.c | 15 +++++++++------
>  1 file changed, 9 insertions(+), 6 deletions(-)

Ack.


Cheers,
-- 
Vinicius
