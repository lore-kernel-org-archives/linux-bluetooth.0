Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v2 0/3] android/bluetooth: Allow to start BlueZ in a single mode.
Date: Thu, 24 Apr 2014 10:36:47 +0200
Message-ID: <1620245.Ypbl0G4UED@leonov>
In-Reply-To: <1398272007-15338-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1398272007-15338-1-git-send-email-lukasz.rymanowski@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Łukasz,

On Wednesday 23 of April 2014 18:53:24 Lukasz Rymanowski wrote:
> With this patches it is possible to start Bluez in a single mode.
> 
> v2: Refactor of previous patch so we don't disable already enabled LE mode.
> It was actually not accodring to the spec.
> 
> Lukasz Rymanowski (3):
>   android/bluetooth: Add supported lmp settings to adapter struct
>   android/bluetooth: Do not enable BT LE by default
>   android/bluetooth: Make possible to start BlueZ in a single mode
> 
>  android/README          |  4 ++++
>  android/bluetooth.c     | 52
> +++++++++++++++++++++++++++++++++++++++++-------- android/bluetooth.h     |
>  2 +-
>  android/hal-bluetooth.c | 19 +++++++++++++++++-
>  android/hal-msg.h       |  2 ++
>  android/main.c          |  5 ++++-
>  6 files changed, 73 insertions(+), 11 deletions(-)

All patches applied, thanks.

-- 
BR
Szymon Janc
