Return-Path: <cyrus@holtmann.org>
Subject: Re: Regarding bluetooth-testing.git
From: Marcel Holtmann <marcel@holtmann.org>
To: sreevani medhahal <sreevani.medhahal@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <c2a31c480902100232v56deddemc92aa954c38ef66f@mail.gmail.com>
References: <c2a31c480902100232v56deddemc92aa954c38ef66f@mail.gmail.com>
Content-Type: text/plain
Date: Tue, 10 Feb 2009 16:35:48 +0100
Message-Id: <1234280148.12847.28.camel@californication>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Sreevani,

>  I would like to know if bluetooth-testing git repository has all the
> fixes for bluetooth modules, following kernel version 2.6.27 . ie., i
> want to know if i use linux kernel 2.6.27 & apply all the patches in
> bluetooth-testing git ,then will this kernel have all the fixes for
> all the  known issues(only  those issues whose patches were reviewed &
> acknowledged by Marcel).

depends on what happened between 2.6.27 and 2.6.29-rc4. I would have to
check, but I guess we had additional patches and all patches from
bluetooth-testing.git depend on them. You need to backport the whole
include/net/bluetooth, net/bluetooth and drivers/bluetooth at minimum.
Maybe some extra generic kernel infrastructure if we depend on it.

Regards

Marcel


