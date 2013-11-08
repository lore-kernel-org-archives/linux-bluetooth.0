Return-Path: <cyrus@holtmann.org>
Date: Fri, 8 Nov 2013 15:48:15 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCHv5 1/3] android: Create debug hal-utils helpers
Message-ID: <20131108134815.GB6488@x220.p-661hnu-f1>
References: <1383916561-9719-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1383916561-9719-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On Fri, Nov 08, 2013, Andrei Emeltchenko wrote:
> Create hal-utils helpers which helps to decode packets Android
> sends through HAL interface.
> ---
>  android/Android.mk        |    2 ++
>  android/Makefile.am       |    3 ++-
>  android/client/if-gatt.c  |    1 +
>  android/client/textconv.c |   42 ++------------------------------
>  android/client/textconv.h |    2 --
>  android/hal-utils.c       |   58 +++++++++++++++++++++++++++++++++++++++++++++
>  android/hal-utils.h       |   26 ++++++++++++++++++++
>  7 files changed, 91 insertions(+), 43 deletions(-)
>  create mode 100644 android/hal-utils.c
>  create mode 100644 android/hal-utils.h

This first patch has been applied, however I'm waiting for v6 of the
other two as we discussed offline.

Johan
