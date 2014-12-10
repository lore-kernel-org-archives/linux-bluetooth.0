Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1418137907-16981-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1418137907-16981-1-git-send-email-lukasz.rymanowski@tieto.com>
Date: Wed, 10 Dec 2014 09:23:50 +0200
Message-ID: <CABBYNZL=N5qKL1QUy7-P_+om-3+g+Bh9jxMg2g-FzQsK5C+-hA@mail.gmail.com>
Subject: Re: [PATCH 00/25] android/gatt: Fix HOG connect/disconnect
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lukasz,

On Tue, Dec 9, 2014 at 5:11 PM, Lukasz Rymanowski
<lukasz.rymanowski@tieto.com> wrote:
> When testing HOG against PTS we got failing testes if devices were
> not bonded before the test.
> With those patches this issue is not valid anymore.
>
> This set address couple of issues:
> * Some minor fixes found during work on those patches (first 4 patches)
>
> * Changed GATT behaviour during dedicated bonding. Now GATT will not start
> search services until bonding is done. That fixes PTS connection issue
> (patches 5-8)
>
> * Tracking of GATT operations in hog/dis/bas/scpp. After I solved PTS
> connection issue I could very easily observe many of crashes in BfA when
> disconnecting HOG during service search session. This is because HOG
> talks directly to gattrib and clear his attrib instance on HOG disconnect
> even there are ongoing GATT operations. Patches 9 - 25 solve this issue.

I remember applying a patch from Arman that should have fixed the
problem above: shared/att: cancel_all before calling disconnect cb. In
any if that doesn't really solve the problem the client should cancel
their pending operations before releasing its reference which means no
callback should be called after that.

> Lukasz Rymanowski (25):
>   android/bluetooth: Minor typo fix
>   android/bluetooth: Minor fix, add missing NULL assignment
>   android/gatt: Fix for setting conn timeout
>   android/hog: Minor coding style fixes
>   android/bluetooth: Add possibility to register for bonded event
>   android/gatt: Add paired cb to gatt.c
>   android/bluetooth: Add API to check if device is bonding
>   android/gatt: Improve LE connection after pair
>   android/hog: Add support to track gatt operations
>   android/hog: Cancel all GATT operations on disconnect
>   android/hog: Add guards to the callbacks
>   android/hog: Keep track on primary and include service search
>   android/hog: Keep track on discover characteristic and descriptors
>   android/hog: Keep track on read/write char and descr
>   android/bas: Add queue to keep track on GATT operations
>   android/bas: Keep track read/write GATT operations
>   android/bas: Keep track on discover characteristic and descriptor
>   android/bas: Add guard to GATT callbacks
>   android/dis: Add queue to keep track on GATT operations
>   android/dis: Keep track on discover and read characteristic
>   android/dis: Add guard for GATT callbacks
>   android/scpp: Add queue to keep GATT operations
>   android/scpp: Keep track on discover characteristic and descriptor
>   android/scpp: Keep track on write operation
>   android/scpp: Add guard for GATT callbacks
>
>  android/bas.c       | 192 +++++++++++++++++++++++--
>  android/bluetooth.c |  52 ++++++-
>  android/bluetooth.h |   5 +
>  android/dis.c       | 123 +++++++++++++++-
>  android/gatt.c      |  70 ++++++++-
>  android/hog.c       | 401 +++++++++++++++++++++++++++++++++++++++++++++-------
>  android/scpp.c      | 171 ++++++++++++++++++++--
>  7 files changed, 932 insertions(+), 82 deletions(-)
>
> --
> 1.8.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Luiz Augusto von Dentz
