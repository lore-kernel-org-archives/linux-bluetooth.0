Return-Path: <cyrus@holtmann.org>
Date: Wed, 11 Jan 2012 16:56:26 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Sunil Kumar Behera <sunil.behera@samsung.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH obexd] PBAP: Fix possible invalid memory access
Message-ID: <20120111145626.GA32565@x220>
References: <1326179605-3380-1-git-send-email-sunil.behera@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1326179605-3380-1-git-send-email-sunil.behera@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Sunil,

On Tue, Jan 10, 2012, Sunil Kumar Behera wrote:
> Issue: As reported by static code analyzer (Coverity), if
> buffer is NULL and aparams is not NULL, then buffer gets
> dereferenced in string_read function.
> Fix: Application parameter is allocated only if maxlistcount
> is zero during phonebooksize request and buffer is allocated
> in case of pull phonebook request, hence modify logic to avoid
> application parameter check, as it is tightly coupled with
> maxlistcount.
> ---
>  plugins/pbap.c |    9 +++++----
>  1 files changed, 5 insertions(+), 4 deletions(-)

Applied. Thanks.

Johan
