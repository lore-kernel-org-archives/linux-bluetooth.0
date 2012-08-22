Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1345237703-15342-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1345237703-15342-1-git-send-email-claudio.takahasi@openbossa.org>
Date: Wed, 22 Aug 2012 18:28:41 -0300
Message-ID: <CAKT1EBdUfD8yWpk+JFnxExmKXpPgp_Lmq=BE-hsG3+F5Xp+VAQ@mail.gmail.com>
Subject: Re: [PATCH BlueZ v0 0/5] HoG Suspend/Resume
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Fri, Aug 17, 2012 at 6:08 PM, Claudio Takahasi
<claudio.takahasi@openbossa.org> wrote:
> This patch series adds HID Control Point support. This control point
> allows the report host(BlueZ) to notify the report device(HoG device)
> when the host is entering or leaving the Suspend Mode.
>
> The low power Suspend Mode concept is implementation specific. This
> proposal adds the support for UPower backend. UPower signals Resuming
> /Sleeping are used to trigger the control point writing.
>
> Claudio Takahasi (5):
>   hog: Adds initial files for suspend support
>   hog: Add UPower Resuming/Suspending watch
>   hog: Add Suspend/Resume callbacks
>   hog: Move HoG device list to manager
>   hog: Add writting Control Point
>
>  Makefile.am                  |    3 +-
>  profiles/input/hog_device.c  |   73 ++++++++++++++++++++----------
>  profiles/input/hog_device.h  |    9 +++-
>  profiles/input/hog_manager.c |   69 ++++++++++++++++++++++++++++-
>  profiles/input/upower.c      |  101 ++++++++++++++++++++++++++++++++++++++++++
>  profiles/input/upower.h      |   29 ++++++++++++
>  6 files changed, 254 insertions(+), 30 deletions(-)
>  create mode 100644 profiles/input/upower.c
>  create mode 100644 profiles/input/upower.h
>
> --
> 1.7.8.6
>

ping ...

Regards,
Claudio
