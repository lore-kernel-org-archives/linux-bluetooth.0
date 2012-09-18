Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <747C1E83C744F44E9ACFB89FAEEC2C7B23D4AD9596@EXDCVYMBSTM005.EQ1STM.local>
References: <747C1E83C744F44E9ACFB89FAEEC2C7B23D4A4EAC2@EXDCVYMBSTM005.EQ1STM.local>
 <747C1E83C744F44E9ACFB89FAEEC2C7B23D4AD9596@EXDCVYMBSTM005.EQ1STM.local>
From: "Arun K. Singh" <arunkat@gmail.com>
Date: Tue, 18 Sep 2012 11:38:20 +0530
Message-ID: <CAOnmHE_mHvQJO8AEnCUS-UoUDC9NXYgAhAiAxzNULeS9PGu6WA@mail.gmail.com>
Subject: Re: [PATCH BlueZ V6 1/5] AVRCP: Add TG Record to support AVRCP Browsing
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz, folks,

On Thu, Aug 30, 2012 at 10:38 AM, Vani-dineshbhai PATEL X
<vani.patel@stericsson.com> wrote:
>
> From 7e32aecb2b13c6398108932e98fdd68faf9315d8 Mon Sep 17 00:00:00 2001
> From: Vani Patel <vani.patel@stericsson.com>
> Date: Tue, 5 Jun 2012 13:44:30 +0530
> Subject: [PATCH BlueZ V6 1/5] AVRCP: Add TG Record to support AVRCP
> Browsing
>
> Adds SDP record to support browsing
> ---
> audio/avctp.c |    4 ++--
> audio/avctp.h |    3 ++-
> audio/avrcp.c |   28 ++++++++++++++++++++++++----
> 3 files changed, 28 insertions(+), 7 deletions(-)
>
> diff --git a/audio/avctp.c b/audio/avctp.c
> index 074eabd..a20dba9 100644
> --- a/audio/avctp.c
> +++ b/audio/avctp.c

Any chance that have you been able to take a look at these patches and review?

Thanks,
Arun
