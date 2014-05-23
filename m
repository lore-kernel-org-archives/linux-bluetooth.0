Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1400543083-28811-1-git-send-email-andrzej.kaczmarek@tieto.com>
References: <1400543083-28811-1-git-send-email-andrzej.kaczmarek@tieto.com>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Date: Fri, 23 May 2014 09:47:33 +0200
Message-ID: <CAF3PWx22JS5nCnHp+XLCb_1xY4L4p3e+X4P+M1GH6jN43T5U+Q@mail.gmail.com>
Subject: Re: [RFC 00/11] Connection parameters D-Bus API
To: linux-bluetooth <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

ping...


On 20 May 2014 01:44, Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com> wrote:
> Hi,
>
> Following patches add possibility for applications to have RSSI and TX
> power data for connected device. This uses recently introduced mgmt
> command Get Connection Information.
>
> There are 3 new properties for RSSI, current TX power and max TX power.
> Polling for RSSI and TX power can be enabled via Start-/Stop- methods
> in a manner similar to discovery on adapter. Max TX power is read once
> when device is connected and obviously does not change.
>
> As for now polling interval is set to arbitrary chosen value of 2secs,
> but perhapts this could be configurable via main.conf entry.
>
>
> Andrzej Kaczmarek (9):
>   core: Add ConnectionRSSI property
>   core: Add ConnectionTXPower property
>   core: Add ConnectionTXPowerMax property
>   core: Make connection properties exist only when connected
>   core: Read max TX power when device connected
>   shared: Fix queue_find to accept const ptr as match data
>   core: Add API to start/stop connection monitoring
>   core: Store list of monitored devices in adapter
>   core: Poll for connection info
>
> Lukasz Rymanowski (2):
>   doc: Update RSSI property description.
>   doc: Introduce connection monitoring API
>
>  doc/device-api.txt |  56 +++++++++++
>  src/adapter.c      | 205 +++++++++++++++++++++++++++++++++++++++++
>  src/adapter.h      |   7 ++
>  src/device.c       | 265 +++++++++++++++++++++++++++++++++++++++++++++++++++++
>  src/device.h       |   3 +
>  src/shared/queue.c |   4 +-
>  src/shared/queue.h |   2 +-
>  7 files changed, 539 insertions(+), 3 deletions(-)
>
> --
> 1.9.3
>
