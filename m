Return-Path: <cyrus@holtmann.org>
Date: Mon, 18 Oct 2010 17:24:19 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Daniel =?iso-8859-1?Q?=D6rstadius?= <daniel.orstadius@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Fix process pending request if transfer canceled
Message-ID: <20101018142419.GA20951@jh-x301>
References: <AANLkTikmpwse=s3Z5+RzgrPCSy-qVhYkLxA1kRZrECnJ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <AANLkTikmpwse=s3Z5+RzgrPCSy-qVhYkLxA1kRZrECnJ@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Daniel,

On Mon, Oct 18, 2010, Daniel Örstadius wrote:
> If the call to the Request method of the obex client agent returns
> with an error (for example if the transfer is rejected), call
> function session_terminate_transfer instead of unregister_transfer
> to both unregister the transfer and handle the pending request.
> ---
>  client/session.c |   11 ++++++++++-
>  1 files changed, 10 insertions(+), 1 deletions(-)

Pushed upstream. Thanks.

Johan
