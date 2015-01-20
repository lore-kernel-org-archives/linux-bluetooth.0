Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1421465191-1494-1-git-send-email-armansito@chromium.org>
References: <1421465191-1494-1-git-send-email-armansito@chromium.org>
Date: Tue, 20 Jan 2015 12:16:06 -0800
Message-ID: <CAHrH25RSoXhqBHGgLQR6CnBwS5TL29nG8G7uNqQOcyCcM6pemw@mail.gmail.com>
Subject: Re: [PATCH BlueZ 0/2] core: device: GATT fixes
From: Arman Uguray <armansito@chromium.org>
To: BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

> On Fri, Jan 16, 2015 at 7:26 PM, Arman Uguray <armansito@chromium.org> wrote:
> This patch fixes the following:
>
>   1. Bugs in GATT service browsing code-path that caused GAttrib-based
>   profiles to not work and caused D-Bus calls to "Pair" and/or "Connect"
>   to hang.
>
>   2. Reintroduced invalid service removal. This patch is the similar as
>   the one I submitted previously: it splits the UUID list into SDP and
>   GATT based lists and introduces new storage entries, except this patch
>   also includes a very simple migration mechanism from the existing
>   storage format to the new one.
>
>   The migration works by loading the UUIDs from the "Services" field and
>   delaying profile probing until connection establishment. Once a
>   connection is established and service discovery is performed, we
>   simply store the UUIDs in their new grouping and probe the profiles
>   and remove the previous entries. The legacy entries act as temporary
>   data that's fed into the Device1.UUIDs property but everything else
>   acts as if no services were discovered until connection.
>
> Arman Uguray (2):
>   core: device: Fix bug in device_browse_gatt
>   core: device: Fix broken GATT UUID management
>
>  plugins/sixaxis.c |   2 +-
>  src/adapter.c     |   8 +-
>  src/device.c      | 410 +++++++++++++++++++++++++++++++++++++++---------------
>  src/device.h      |   6 +-
>  4 files changed, 307 insertions(+), 119 deletions(-)
>
> --
> 2.2.0.rc0.207.ga3a616c
>

ping
