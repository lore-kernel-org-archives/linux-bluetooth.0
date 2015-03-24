Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2070.6\))
Subject: Re: [PATCH 0/6] Add unit tests for the advertising mgmt API
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1426906378-14804-1-git-send-email-armansito@chromium.org>
Date: Mon, 23 Mar 2015 17:54:32 -0700
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <A5799740-B8A9-4BCF-AF19-2E207211A4B6@holtmann.org>
References: <1426906378-14804-1-git-send-email-armansito@chromium.org>
To: Arman Uguray <armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Arman,

> This patch sets adds unit tests for the new Add/Remove Advertising mgmt
> commands and related events.
> 
> Arman Uguray (6):
>  lib: Provide data structures for Add/Remove Advertising
>  tools/mgmt-tester: Add Advertising test cases
>  tools/mgmt-tester: Remove Advertising test cases
>  tools/mgmt-tester: Add Advertising scan response test cases
>  tools/mgmt-tester: Add Advertising timeout test cases
>  doc/test-coverage.txt: Update mgmt-tester test count
> 
> doc/test-coverage.txt |   2 +-
> lib/mgmt.h            |  33 +++
> tools/mgmt-tester.c   | 618 ++++++++++++++++++++++++++++++++++++++++++++++++++
> 3 files changed, 652 insertions(+), 1 deletion(-)

all 6 patches have been applied.

Regards

Marcel

