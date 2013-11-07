Return-Path: <cyrus@holtmann.org>
Date: Thu, 7 Nov 2013 17:11:10 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Szymon Janc <szymon.janc@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/3] android: Rename a2dp HAL related IPC API to match
 service name
Message-ID: <20131107151110.GD23283@x220.p-661hnu-f1>
References: <1383820057-15728-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1383820057-15728-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

On Thu, Nov 07, 2013, Szymon Janc wrote:
> Use 'Android HAL name' string from IPC doc as base for names.
> ---
>  android/a2dp.c    | 10 ++++++----
>  android/hal-av.c  | 16 ++++++++--------
>  android/hal-msg.h | 18 ++++++++++--------
>  3 files changed, 24 insertions(+), 20 deletions(-)

Seems like this one (maybe others in this set too) needs rebasing as it
doesn't apply right now.

Johan
