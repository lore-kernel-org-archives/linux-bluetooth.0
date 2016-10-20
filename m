Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <1476929018-29947-1-git-send-email-puthik@chromium.org>
References: <1476929018-29947-1-git-send-email-puthik@chromium.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 20 Oct 2016 14:20:06 +0300
Message-ID: <CABBYNZ+eyouaz=zf0O-_B_JkLBnV2Pv7ooBturjz41nNOvUFPw@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] Expose AdvertisingFlags in Device API
To: Puthikorn Voravootivat <puthik@chromium.org>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Thu, Oct 20, 2016 at 5:03 AM,  <puthik@chromium.org> wrote:
> From: Puthikorn Voravootivat <puthik@chromium.org>
>
> v2:
> Address Marcel's review to make it more future proof by making it array{byte}.
>
> v3:
> Mark AdvertisingFlags as experimental
>
> Puthikorn Voravootivat (2):
>   doc/device-api: Add AdvertisingFlags
>   core: Add implementation of AdvertisingFlags
>
>  doc/device-api.txt |  4 ++++
>  src/adapter.c      |  2 ++
>  src/device.c       | 37 +++++++++++++++++++++++++++++++++++++
>  src/device.h       |  1 +
>  4 files changed, 44 insertions(+)
>
> --
> 2.8.0.rc3.226.g39d4020

Applied, thanks.

-- 
Luiz Augusto von Dentz
