Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 00/16] android/gatt: Improve robustness in Gatt Client
Date: Fri, 27 Feb 2015 16:35:12 +0100
Message-ID: <1700104.J3KWP9YFvK@uw000953>
In-Reply-To: <1424943583-30061-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1424943583-30061-1-git-send-email-lukasz.rymanowski@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Łukasz,

On Thursday 26 of February 2015 10:39:27 Lukasz Rymanowski wrote:
> This set improves robustness on searching services, characteristics,
> descriptors and included services.
> 
> Issue found on UPF50.
> 
> There is 4 test showing issue and after each test there is a fix for that.
> 
> Last 5 patches is a same fix for shared/gatt-helpers. I did not write special
> test for it as we will test it once we make Android to use it shared code.
> Anyway, this change does not brake gatt unit tests
> 
> Lukasz Rymanowski (16):
>   android/tester-gatt: Add robustness test for search services
>   attrib/gatt: Improve robustness on search primary services
>   android/tester-gatt: Add robustness test for get characteristic
>   attrib/gatt: Minor refactor in char_discovered_cb
>   attrib/gatt: Improve robustness when searching for characteristics
>   android/gatt: Check status on get characteristic callback
>   android/tester: Add robustness test for get descriptor
>   attrib/gatt: Minor refactor in desc_discovered_cb
>   attrib/gatt: Improve robustness when searching for descriptors
>   android/tester: Add robustness test for get included services
>   attrib/gatt: Improve robustness when searching for included services
>   shated/gatt-helpers: Improve robustness of search service
>   shared/gatt-helpers: Improve robustness of get characteristics
>   shared/gatt-helpers: Improve robustness of get include services
>   shared/gatt-helpers: Improve robustness read by type request
>   shared/gatt-helpers: Improve robustness of get descriptors
> 
>  android/gatt.c            |   8 +++
>  android/tester-gatt.c     | 128 ++++++++++++++++++++++++++++++++++++++++++++++
>  attrib/gatt.c             |  93 +++++++++++++++++++++++++++++----
>  src/shared/gatt-helpers.c |  89 +++++++++++++++++++++++++++++---
>  4 files changed, 302 insertions(+), 16 deletions(-)
> 
Patches 1-11 are now applied, thanks.

-- 
Best regards, 
Szymon Janc
