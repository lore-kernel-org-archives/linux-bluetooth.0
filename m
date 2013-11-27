Return-Path: <cyrus@holtmann.org>
Date: Wed, 27 Nov 2013 12:54:23 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 5/6] android/hal-sock: Check uuid before dereference
Message-ID: <20131127105423.GB16389@x220.p-661hnu-f1>
References: <1385474750-18331-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1385474750-18331-5-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1385474750-18331-5-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On Tue, Nov 26, 2013, Andrei Emeltchenko wrote:
> uuid might be NULL and channel might be specified which makes it
> valid case for Android. This adds check for uuid and service name.
> ---
>  android/hal-sock.c | 18 ++++++++++++++----
>  1 file changed, 14 insertions(+), 4 deletions(-)

This patch has been applied. Thanks.

Johan
