Return-Path: <cyrus@holtmann.org>
Date: Sat, 9 Oct 2010 18:26:04 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: =?utf-8?B?UmFmYcWC?= Michalski <michalski.raf@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Reduction memory leaks in phonebook module
Message-ID: <20101009152604.GA18989@jh-x301>
References: <AANLkTinLGQj+CSGRK+UX2oVyCW-XOsq_U4ZQTYuYRC1n@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <AANLkTinLGQj+CSGRK+UX2oVyCW-XOsq_U4ZQTYuYRC1n@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Rafał,

On Fri, Oct 08, 2010, Rafał Michalski wrote:
> From 40399b62ec62569213948f7eb77fd39d1ff42ea1 Mon Sep 17 00:00:00 2001
> From: Rafal Michalski <michalski.raf@gmail.com>
> Date: Fri, 8 Oct 2010 15:16:50 +0200
> Subject: [PATCH] Reduction memory leaks in phonebook module
> 
> Memory, pointed by pointers home_addr and work_addr, is allocated
> temporarily and not freed. Only duplicates of this memory (made after
> invoking add_address function) are freed later.
> ---
>  plugins/phonebook-tracker.c |    3 +++
>  1 files changed, 3 insertions(+), 0 deletions(-)

Thanks. The patch has been pushed to the upstream obexd tree.

Johan
