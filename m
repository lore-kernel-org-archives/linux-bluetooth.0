Return-Path: <cyrus@holtmann.org>
Date: Tue, 29 Oct 2013 14:19:45 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Szymon Janc <szymon.janc@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v3 4/5] android/hal: Add support for handling pin request
 event
Message-ID: <20131029121945.GA1008@x220.p-661hnu-f1>
References: <1383047562-4799-1-git-send-email-szymon.janc@tieto.com>
 <1383047562-4799-5-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1383047562-4799-5-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

On Tue, Oct 29, 2013, Szymon Janc wrote:
> ---
>  android/hal-bluetooth.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)

I've applied the first three patches in this set, but are you sure the
following isn't prone to unaligned access issues:

> +	bt_bdaddr_t *addr = (bt_bdaddr_t *) ev->bdaddr;
> +	bt_bdname_t *name = (bt_bdname_t *) ev->name;

I.e. wouldn't this be an issue if the expected alignment of bt_bdaddr_t
and bt_bdname_t pointers is different from the alignment of ev->bdaddr
and ev->name.

Johan
