Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.1 \(1993\))
Subject: Re: [PATCH bluez-utils] Link mcaptest with -lrt
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1419856719-30526-1-git-send-email-thomas.petazzoni@free-electrons.com>
Date: Mon, 29 Dec 2014 09:40:04 -0800
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <B9CBBBC9-712D-4E23-8023-84DBE3BDE635@holtmann.org>
References: <1419856719-30526-1-git-send-email-thomas.petazzoni@free-electrons.com>
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Thomas,

> The mcaptest tool uses the profiles/health/mcap.c source file, which
> calls clock_getres(). This function is defined in librt, so mcaptest
> should be linked against librt, otherwise one gets link failures such
> as:
> 
> ld: profiles/health/mcap.o: undefined reference to symbol 'clock_getres@@GLIBC_2.2.5'
> ld: note: 'clock_getres@@GLIBC_2.2.5' is defined in DSO [...]/sysroot/lib64/librt.so.1 so try adding it to the linker command line
> [...]/sysroot/lib64/librt.so.1: could not read symbols: Invalid operation
> collect2: error: ld returned 1 exit status
> Makefile:4184: recipe for target 'tools/mcaptest' failed

the manpage clearly states to only link against -lrt when using glibc versions before 2.17. If we want to support older glibc, then this might need to be conditional via a configure test.

Regards

Marcel

