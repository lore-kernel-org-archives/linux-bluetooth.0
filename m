Return-Path: <cyrus@holtmann.org>
Date: Mon, 4 Aug 2014 14:30:49 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v4 0/6] android/gatt: Make usage of kernel auto connect
 feat.
Message-ID: <20140804113049.GA27808@t440s.lan>
References: <1407148459-20125-1-git-send-email-lukasz.rymanowski@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1407148459-20125-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lukasz,

On Mon, Aug 04, 2014, Lukasz Rymanowski wrote:
> Following patches add support to BfA to use kernel auto connect list
> when mgmt interface is 1.7 or highier.
> 
> Tested on PC with latest kernel.
> 
> v2: Fix in Patch 5/6. Forgot one if check
> v3: Rebase + whitespace fix
> v4: Handle Johan comment
> 
> Note: For android new backports are needed. Will be done early next week.
> 
> Lukasz Rymanowski (6):
>   android/bluetooth: Add flag for kernel connection control
>   android/bluetooth: Add API to add device to auto connect list
>   android/bluetooth: Add API to remove device from auto connect list
>   android/gatt: Refactor trigger connection function.
>   android/gatt: Use kernel auto connect feature if possible
>   android/bluetooth: Clear auto connect list on startup
> 
>  android/bluetooth.c | 101 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>  android/bluetooth.h |   6 ++++
>  android/gatt.c      |  70 ++++++++++++++++++++++++++++--------
>  3 files changed, 162 insertions(+), 15 deletions(-)

All patches have been applied. Thanks.

Johan
