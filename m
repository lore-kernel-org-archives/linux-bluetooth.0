Return-Path: <cyrus@holtmann.org>
Date: Fri, 1 Nov 2013 14:07:43 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [RFC] android/daemon: Update CoD and RSSI only when they exist
Message-ID: <20131101120743.GB27892@x220.p-661hnu-f1>
References: <1383306399-13750-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1383306399-13750-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On Fri, Nov 01, 2013, Andrei Emeltchenko wrote:
> This avoid sending zeroed Class of Device and making it unidentified.
> ...
>  prop[0]: type=BT_PROPERTY_CLASS_OF_DEVICE len=4 val=000000
>  prop[1]: type=BT_PROPERTY_REMOTE_RSSI len=1 val=-75
>  prop[2]: type=BT_PROPERTY_BDNAME len=249 val=Microsoft Bluetooth Number Pad
> ...
> ---
>  android/adapter.c |   30 +++++++++++++++++-------------
>  1 file changed, 17 insertions(+), 13 deletions(-)

Applied. Thanks.

Johan
