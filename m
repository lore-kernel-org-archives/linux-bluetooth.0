Return-Path: <cyrus@holtmann.org>
Date: Tue, 31 Jul 2012 11:01:20 -0300
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] input: Fix crash when connecting HID keyboard
Message-ID: <20120731140120.GA18931@samus>
References: <1343738904-12556-1-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1343738904-12556-1-git-send-email-andrzej.kaczmarek@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrzej,

On 14:48 Tue 31 Jul, Andrzej Kaczmarek wrote:
> hidp_add_connection should return after setting up security watch when
> connecting HID keyboard, otherwise req will be freed and encrypt_notify
> callback will receive invalid pointer.
> ---

Patch looks good. Ack.

[snip]


Cheers,
-- 
Vinicius
