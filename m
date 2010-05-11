Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <AANLkTiliG_XySAecN9JZ9cBt1rEc7IqtFB7ISaHP4yDb@mail.gmail.com>
References: <p2q793f89501005052222u4393c8dfhb55bea4454c454b9@mail.gmail.com>
	 <AANLkTinOD1ODHqYSWTLv5ho2ZYU-bfiJ1xYkWNlbgaZQ@mail.gmail.com>
	 <AANLkTiliG_XySAecN9JZ9cBt1rEc7IqtFB7ISaHP4yDb@mail.gmail.com>
Date: Tue, 11 May 2010 19:38:20 +0300
Message-ID: <AANLkTimmzTVsLBrID6XcRG4ZVNkO3HSoI7ixDFn7RdUd@mail.gmail.com>
Subject: Re: [bugreport]
From: Serhiy Kachaniuk <serzholino@gmail.com>
To: Vinicius Gomes <vinicius.gomes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

2010/5/11 Vinicius Gomes :
> This (the mailing list) is the correct place for bug reports.
>
> Someone here in the office has an ancient Bluetooth 1.2 dongle, which
> shows a similar problem. Now that you discovered that it is probably a
> regression and I can reproduce it, I will try to debug it.
>
> And it looks like that the hcidump logs that you attached in your
> first email got lost somehow.
They're attached to bugreport on launchpad
for bluez version 4.64 http://launchpadlibrarian.net/47890286/hcidump.txt
for bluez version 4.32 http://launchpadlibrarian.net/47890843/hcidump_old.txt
>
> Anyway, I think that the only information missing is your kernel version.

Kernel version seems irrelevant. Anyway, first version, when i
discovered this problem was 2.6.31. Now i use 2.6.32 and problem
persists.
