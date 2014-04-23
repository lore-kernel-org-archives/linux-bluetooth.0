Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v2 0/5]android/gatt: GATT Client write types support
Date: Wed, 23 Apr 2014 15:19:18 +0200
Message-ID: <1947887.Wb3RGBOdof@leonov>
In-Reply-To: <1397735868-19092-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1397735868-19092-1-git-send-email-lukasz.rymanowski@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Łukasz,

On Thursday 17 of April 2014 13:57:43 Lukasz Rymanowski wrote:
> This patch set adds support for different write types.
> For this I had to expose some additional API from attrib.
> 
> Only signed write left to implement.
> 
> v2:
> * Rebase
> * Remove double empty line from gatt.h as Szymon pointed out
> 
> Lukasz Rymanowski (5):
>   attrib: Add API for reliable write
>   attrib: Expose write execute
>   android/gatt: Add support for reliable write
>   android/gatt: Add support for write execute
>   android/gatt: Add support for write without response
> 
>  android/gatt.c | 113
> ++++++++++++++++++++++++++++++++++++++++++++++++--------- attrib/gatt.c  | 
> 24 ++++++++++++
>  attrib/gatt.h  |   8 ++++
>  3 files changed, 128 insertions(+), 17 deletions(-)

All patches applied, thanks.

-- 
BR
Szymon Janc
