Return-Path: <cyrus@holtmann.org>
Date: Fri, 15 Aug 2014 14:03:24 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] android: Fix memory leak
Message-ID: <20140815110324.GA13558@t440s.lan>
References: <1408098640-18166-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1408098640-18166-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On Fri, Aug 15, 2014, Andrei Emeltchenko wrote:
> protos gets allocated and needs to be freed
> ---
>  android/bluetooth.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)

Applied. Thanks.

Johan
