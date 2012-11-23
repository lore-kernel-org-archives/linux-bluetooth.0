Return-Path: <cyrus@holtmann.org>
Date: Fri, 23 Nov 2012 23:28:48 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ 1/2] hog: Fix potencial segfault when sending a
 output report
Message-ID: <20121123212848.GA5061@x220.P-661HNU-F1>
References: <1353697709-6497-1-git-send-email-vinicius.gomes@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1353697709-6497-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Vinicius,

On Fri, Nov 23, 2012, Vinicius Costa Gomes wrote:
> As UHID is not notified when the device is disconnected, it may be
> possible that an output report is forwarded when the device is not
> connected, one example, would be when the caps lock key is pressed on
> another keyboard.
> ---
>  profiles/input/hog_device.c | 3 +++
>  1 file changed, 3 insertions(+)

Both patches have been applied. Thanks.

Johan
