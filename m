Return-Path: <cyrus@holtmann.org>
Date: Sat, 1 Dec 2012 11:13:45 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ v2 1/2] input: Fix emitting a signal for a
 non-existant interface
Message-ID: <20121201091345.GB2501@x220.P-661HNU-F1>
References: <1354322217-11219-1-git-send-email-vinicius.gomes@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1354322217-11219-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Vinicius,

On Fri, Nov 30, 2012, Vinicius Costa Gomes wrote:
> When the 'org.bluez.Input' interface was removed, this should have been
> removed as well, now it is causing a segmentation fault.
> ---
>  profiles/input/device.c | 6 ------
>  1 file changed, 6 deletions(-)

Both patches have been applied. Thanks.

Johan
