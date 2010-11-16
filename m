Return-Path: <cyrus@holtmann.org>
Date: Tue, 16 Nov 2010 13:34:05 +0000
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Rafal Michalski <michalski.raf@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v2] Fix pull phonebook with non-zero offset parameter
Message-ID: <20101116133405.GA10566@jh-x301>
References: <1289817700-32136-1-git-send-email-michalski.raf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1289817700-32136-1-git-send-email-michalski.raf@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Rafal,

On Mon, Nov 15, 2010, Rafal Michalski wrote:
> For non-zero liststartoffset parameter, contacts which index was before
> offset were indexed more than once (e.g. when contact had more than one
> phone number or address etc.), so pulling was started earlier - before
> offset index was reached. This patch fix this problem and each contact
> is indexed only once.
> ---
>  plugins/phonebook-tracker.c |    9 ++++++++-
>  1 files changed, 8 insertions(+), 1 deletions(-)

Pushed upstream. Thanks.

Johan
