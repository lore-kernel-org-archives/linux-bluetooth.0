Return-Path: <cyrus@holtmann.org>
Date: Mon, 21 Jul 2014 16:40:55 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCHv3] android/ipc: Rename connect_sco to get_fd
Message-ID: <20140721134055.GB5373@t440s.P-661HNU-F1>
References: <20140721085730.GB27596@t440s.lan>
 <1405936383-29130-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1405936383-29130-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On Mon, Jul 21, 2014, Andrei Emeltchenko wrote:
> SCO get connected through handsfree HAL and Audio SCO HAL only need to
> get SCO socket fd.
> ---
>  android/hal-sco.c       | 14 +++++++-------
>  android/handsfree.c     | 10 +++++-----
>  android/sco-ipc-api.txt |  6 +++---
>  android/sco-msg.h       |  4 ++--
>  4 files changed, 17 insertions(+), 17 deletions(-)

Applied. Thanks.

Johan
