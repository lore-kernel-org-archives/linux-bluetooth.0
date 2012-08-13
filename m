Return-Path: <cyrus@holtmann.org>
Date: Mon, 13 Aug 2012 13:29:07 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] input: Fix crash when connecting HID keyboard
Message-ID: <20120813102907.GC22250@x220.ger.corp.intel.com>
References: <1343738904-12556-1-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1343738904-12556-1-git-send-email-andrzej.kaczmarek@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrzej,

On Tue, Jul 31, 2012, Andrzej Kaczmarek wrote:
> hidp_add_connection should return after setting up security watch when
> connecting HID keyboard, otherwise req will be freed and encrypt_notify
> callback will receive invalid pointer.
> ---
>  profiles/input/device.c | 2 ++
>  1 file changed, 2 insertions(+)

Applied. Thanks.

Johan
