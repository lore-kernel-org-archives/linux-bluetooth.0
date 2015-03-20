Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1426758991-20055-1-git-send-email-szymon.janc@tieto.com>
References: <1426758991-20055-1-git-send-email-szymon.janc@tieto.com>
Date: Fri, 20 Mar 2015 12:41:12 +0200
Message-ID: <CABBYNZ+zgytAXwVyYS2TkGKe2r+8ByFbHAE-SAko8xT9N4AfcQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] Improve robustness in Gatt Client
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Szymon Janc <szymon.janc@tieto.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

On Thu, Mar 19, 2015 at 11:56 AM, Szymon Janc <szymon.janc@tieto.com> wrote:
> Hi,
>
> this is fixed and rebased version of Lukasz's patches from few weeks back.
>
> From original cover letter:
> Last 5 patches is a same fix for shared/gatt-helpers. I did not write special
> test for it as we will test it once we make Android to use it shared code.
> Anyway, this change does not brake gatt unit tests
>
>
> BR
> Szymon
>
> Lukasz Rymanowski (5):
>   shated/gatt-helpers: Improve robustness of search service
>   shared/gatt-helpers: Improve robustness of get characteristics
>   shared/gatt-helpers: Improve robustness of get include services
>   shared/gatt-helpers: Improve robustness read by type request
>   shared/gatt-helpers: Improve robustness of get descriptors
>
>  src/shared/gatt-helpers.c | 89 +++++++++++++++++++++++++++++++++++++++++++----
>  1 file changed, 83 insertions(+), 6 deletions(-)
>
> --
> 1.9.3

Pushed, thanks.


-- 
Luiz Augusto von Dentz
