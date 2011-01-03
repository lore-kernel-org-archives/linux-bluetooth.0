Return-Path: <cyrus@holtmann.org>
Date: Mon, 3 Jan 2011 15:50:31 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Rafal Michalski <michalski.raf@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v2] Fix phonebook size issue
Message-ID: <20110103135031.GA14849@jh-x301>
References: <1294061644-7661-1-git-send-email-michalski.raf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1294061644-7661-1-git-send-email-michalski.raf@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Rafal,

On Mon, Jan 03, 2011, Rafal Michalski wrote:
> Previously, when only empty default owner vCard was available, phonebook
> default size equal to 1 was received and it was always counted when
> phonebook size requested. This patch makes that it is equal to 0 as it
> should be and it is not counted anymore when phonebook size requested.
> ---
>  plugins/phonebook-tracker.c |    3 +--
>  1 files changed, 1 insertions(+), 2 deletions(-)

Pushed upstream. Thanks.

Johan
