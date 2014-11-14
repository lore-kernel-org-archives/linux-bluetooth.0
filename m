Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1415900357-27027-1-git-send-email-jamuraa@chromium.org>
References: <1415900357-27027-1-git-send-email-jamuraa@chromium.org>
Date: Fri, 14 Nov 2014 14:46:55 +0200
Message-ID: <CABBYNZKeSpBJNWw0wYBU6ES6O0wAyU0XyNHkn=f6A2FSONqa_Q@mail.gmail.com>
Subject: Re: [PATCH BlueZ v2 0/4] android fixes and bt_att shim
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Michael Janssen <jamuraa@chromium.org>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Michael,

On Thu, Nov 13, 2014 at 7:39 PM, Michael Janssen <jamuraa@chromium.org> wrote:
> This patchset fixes some issues with Android GATT testing, a minor
> issue with Android GATT exposed by the shim, and provides a
> GAttrib shim using bt_att.
>
> Passes all android/android-tester, unit/test-gattrib
>
> v1 -> v2:
>   * Address comments by Szymon Janc, Arman Uguray
>
> Michael Janssen (4):
>   android/tester-gatt: Fix search single PDUs
>   android/tester-gatt: deduplicate read-by-type PDUs
>   android/gatt: dummy callback for indications
>   GATT shim to src/shared bt_att
>
>  android/gatt.c        |   17
>  android/tester-gatt.c |  169 ++-----
>  attrib/gattrib.c      | 1096 +++++++++++++++-----------------------------------
>  3 files changed, 395 insertions(+), 887 deletions(-)
>
> --
> 2.1.0.rc2.206.gedb03e5

Ive applied 1-3, please check the comments about 4/4.


-- 
Luiz Augusto von Dentz
