Return-Path: <cyrus@holtmann.org>
Date: Fri, 15 Nov 2013 20:24:56 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v5 0/4] Fixes for incoming connection and bonding
Message-ID: <20131115182456.GA15452@x220.p-661hnu-f1>
References: <1384538641-1873-1-git-send-email-lukasz.rymanowski@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1384538641-1873-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lukasz,

On Fri, Nov 15, 2013, Lukasz Rymanowski wrote:
> V5:
> Fixes according to Johan comments
> 
> V4:
> Added device name caching in device list
> Changes according to Johan comments
> 
> V3:
> Removed adapter bonding state
> Added device list in order to track bonding state per device.
> Fix for incoming legacy paring. We act here same as Bluedroid.
> 
> V2:
> Bonding state added.
> 
> V1:
> With those patches it is possible to bond from remote device and in addition
> you will see the name of remote device on Android pairing request pop up.
> 
> 
> Lukasz Rymanowski (4):
>   android: Update bond state on incoming bonding
>   android: Cache device name on device list.
>   android: Update bond state on auth and connect failed
>   android: Change TODO with explaining comment
> 
>  android/bluetooth.c | 212 ++++++++++++++++++++++++++++++++++++++++++----------
>  1 file changed, 173 insertions(+), 39 deletions(-)

All patches have been applied. Thanks.

I did need to do some (minor) coding style tweaks for 2/4 though.

Johan
