Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1418831357-23100-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1418831357-23100-1-git-send-email-lukasz.rymanowski@tieto.com>
Date: Fri, 19 Dec 2014 10:57:01 -0200
Message-ID: <CABBYNZJ5u+tCXC=LyMwiTKN0s7KxcUnbcT+BxmDqKQmTAMiTMQ@mail.gmail.com>
Subject: Re: [PATCH v2 00/19] android/gatt: Fix HOG connect/disconnect
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lukasz,

On Wed, Dec 17, 2014 at 1:48 PM, Lukasz Rymanowski
<lukasz.rymanowski@tieto.com> wrote:
> When testing HOG against PTS we got failing testes if devices were
> not bonded before the test.
> With those patches this issue is not valid anymore.
>
> This set address couple of issues:
> * Some minor fixes found during work on those patches (first 2 patches)
>
> * Changed GATT behaviour during dedicated bonding. Now GATT will not start
> search services until bonding is done. That fixes PTS connection issue
> (patches 3-6)
>
> * Tracking of GATT operations in hog/dis/bas/scpp. After I solved PTS
> connection issue I could very easily observe many of crashes in BfA when
> disconnecting HOG during service search session. This is because HOG
> talks directly to gattrib and clear his attrib instance on HOG disconnect
> even there are ongoing GATT operations. Patches 7 - 19 solve this issue
>
>
> v2:
> * Remove couple of not needed patches
> * Note that this series should go on top of: [PATCH 0/2] attrib/gattrib: Add tracking request id
> * some minor self review cleanups
>
>
> Lukasz Rymanowski (19):
>   android/bluetooth: Minor typo fix
>   android/bluetooth: Minor fix, add missing NULL assignment
>   android/bluetooth: Add possibility to register for bonded event
>   android/gatt: Add paired cb to gatt.c
>   android/bluetooth: Add API to check if device is bonding
>   android/gatt: Improve LE connection after pair
>   android/hog: Add support to track gatt operations
>   android/hog: Cancel all GATT operations on disconnect
>   android/hog: Keep track on primary and include service search
>   android/hog: Keep track on discover characteristic and descriptors
>   android/hog: Keep track on read/write char and descr
>   android/bas: Add queue to keep track on GATT operations
>   android/bas: Keep track read/write GATT operations
>   android/bas: Keep track on discover characteristic and descriptor
>   android/dis: Add queue to keep track on GATT operations
>   android/dis: Keep track on discover and read characteristic
>   android/scpp: Add queue to keep GATT operations
>   android/scpp: Keep track on discover characteristic and descriptor
>   android/scpp: Keep track on write operation
>
>  android/bas.c       | 171 ++++++++++++++++++++++++++--
>  android/bluetooth.c |  52 ++++++++-
>  android/bluetooth.h |   5 +
>  android/dis.c       | 108 +++++++++++++++++-
>  android/gatt.c      |  67 ++++++++++-
>  android/hog.c       | 322 ++++++++++++++++++++++++++++++++++++++++++++--------
>  android/scpp.c      | 150 ++++++++++++++++++++++--
>  7 files changed, 801 insertions(+), 74 deletions(-)
>
> --
> 1.8.4

Applied, thanks. I took the opportunity and synchronized the
implementation with profiles/input/hog.c


-- 
Luiz Augusto von Dentz
