Return-Path: <cyrus@holtmann.org>
Date: Wed, 27 Oct 2010 09:51:19 -0400
From: Johan Hedberg <johan.hedberg@gmail.com>
To: =?utf-8?B?UmFmYcWC?= Michalski <michalski.raf@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 2/2] Remove redundant code in phonebook module
Message-ID: <20101027135119.GB27339@jh-x301>
References: <AANLkTinnbp6DFvivhX1WC6cvE5G1tzTSV5VhNNphieqn@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <AANLkTinnbp6DFvivhX1WC6cvE5G1tzTSV5VhNNphieqn@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Rafal,

On Wed, Oct 27, 2010, Rafał Michalski wrote:
> Some extra code is redundant and not needed anymore. It is an effect
> of call history queries optimization.
> ---
>  plugins/phonebook-tracker.c |   18 ++----------------
>  1 files changed, 2 insertions(+), 16 deletions(-)

This patch has also been pushed upstream. Thanks.

Johan
