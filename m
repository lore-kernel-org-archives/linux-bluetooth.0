Return-Path: <cyrus@holtmann.org>
Date: Thu, 11 Nov 2010 11:26:04 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] hcitool: Bring up device before sending commands over
 socket
Message-ID: <20101111092604.GA3225@jh-x301>
References: <1289327397-21935-1-git-send-email-anderson.lizardo@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1289327397-21935-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Tue, Nov 09, 2010, Anderson Lizardo wrote:
> The Texas specific initialization code sends HCI commands over the
> bluetooth socket, but does not bring up the device. This gives these
> errors when running "hciattach /dev/ttyUSB0 texas":
> 
> Found a Texas Instruments' chip!
> Firmware file : /lib/firmware/TIInit_XX.Y.ZZ.bts
> Loaded BTS script version 1
> Cannot send hci command to socket: Network is down
> Can't initialize device: Network is down
> ---
>  tools/hciattach_ti.c |    7 +++++++
>  1 files changed, 7 insertions(+), 0 deletions(-)

Since no one has objected to this I went ahead and pushed it upstream
(after doing s/hcitool/hciattach/ to the summary).

Johan
