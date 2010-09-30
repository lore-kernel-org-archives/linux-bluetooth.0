Return-Path: <cyrus@holtmann.org>
Date: Thu, 30 Sep 2010 23:22:33 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Rafal Michalski <michalski.raf@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Change "websiteUrl" query field to more general
Message-ID: <20100930202233.GA27886@jh-x301>
References: <1285854113-13649-1-git-send-email-michalski.raf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1285854113-13649-1-git-send-email-michalski.raf@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Rafal,

On Thu, Sep 30, 2010, Rafal Michalski wrote:
> "websiteUrl" query field is replaced by more general "url" because
> previously web address wasn't downloaded in each case.
> ---
>  plugins/phonebook-tracker.c |   12 ++++++------
>  1 files changed, 6 insertions(+), 6 deletions(-)

The patch has been pushed upstream. Thanks.

Johan
