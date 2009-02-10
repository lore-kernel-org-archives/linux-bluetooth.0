Return-Path: <cyrus@holtmann.org>
Message-ID: <49916CC7.1070709@xyzw.org>
Date: Tue, 10 Feb 2009 04:02:15 -0800
From: Brian Rogers <brian@xyzw.org>
MIME-Version: 1.0
To: sreevani medhahal <sreevani.medhahal@gmail.com>
CC: linux-bluetooth@vger.kernel.org
Subject: Re: Regarding bluetooth-testing.git
References: <c2a31c480902100232v56deddemc92aa954c38ef66f@mail.gmail.com>
In-Reply-To: <c2a31c480902100232v56deddemc92aa954c38ef66f@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

sreevani medhahal wrote:
> hi,
>
>  I would like to know if bluetooth-testing git repository has all the
> fixes for bluetooth modules, following kernel version 2.6.27 . ie., i
> want to know if i use linux kernel 2.6.27 & apply all the patches in
> bluetooth-testing git ,then will this kernel have all the fixes for
> all the  known issues(only  those issues whose patches were reviewed &
> acknowledged by Marcel).
>   

If you applied all the patches in bluetooth-testing to your 2.6.27 
kernel, you'd have a 2.6.29-rc4 kernel with some additional 
Bluetooth-related patches on top of it. Branches in git still contain 
all history up to the point they were branched off. Also, if you cut off 
anything before the point the branch is based off (2.6.29-rc4), you'd be 
excluding any fixes applied between 2.6.27 and 2.6.29-rc4. They can't 
appear in the history again because you can't apply the same patch twice.

The following command will be useful to visualize changes since 2.6.27:
gitk bluetooth-testing/master ^v2.6.27 -- net/bluetooth drivers/bluetooth

(or you can pass the same parameters to 'git log')

Not everything is going to apply though, because some changes will 
depend on changes in other parts of the kernel that you're skipping by 
staying on 2.6.27. You'll probably have to settle for just 
cherry-picking the changes you need or running a more recent kernel.

