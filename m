Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.2 \(1874\))
Subject: Re: [PATCH] tools: fix headers for bcm43xx
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1398090058-2966-1-git-send-email-ncopa@alpinelinux.org>
Date: Mon, 21 Apr 2014 11:20:25 -0700
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <CBEB55B4-D5B1-4C9E-AA29-63D2F72B5F61@holtmann.org>
References: <1398090058-2966-1-git-send-email-ncopa@alpinelinux.org>
To: Natanael Copa <ncopa@alpinelinux.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Natanael,

> PATH_MAX is defined in limits.h so includ it explicitly.
> 
> This fixes the following compile error on musl libc (Alpine Linux):
> tools/hciattach_bcm43xx.c: In function 'bcm43xx_locate_patch':
> tools/hciattach_bcm43xx.c:313:14: error: 'PATH_MAX' undeclared (first use in this function)
>    char path[PATH_MAX];
>                  ^
> 
> Signed-off-by: Natanael Copa <ncopa@alpinelinux.org>

our userspace code is not using Signed-off-by.

Regards

Marcel

