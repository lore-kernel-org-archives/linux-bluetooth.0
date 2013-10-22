Return-Path: <cyrus@holtmann.org>
Date: Tue, 22 Oct 2013 23:23:32 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Szymon Janc <szymon.janc@tieto.com>
Cc: linux-bluetooth@vger.kernel.org,
	Andrei Emeltchenko <andrei.emeltchenko@intel.com>
Subject: Re: [PATCH 1/6] android: Handle mgmt changed events
Message-ID: <20131022202332.GB18814@x220.p-661hnu-f1>
References: <1382460476-6604-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1382460476-6604-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

On Tue, Oct 22, 2013, Szymon Janc wrote:
> Add code handling changing adapter settings.
> ---
>  android/adapter.c | 129 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 129 insertions(+)

All patches have been applied, but I merged patch 5 into patch 2 before
that. Two things you should keep in mind about this:

1. It's not ok to introduce a bug in one patch and then fix it in
another when both patches are part of the same upstream submission (i.e.
just don't introduce the patch to begin with if you've already got a fix
for it).

2. Learn about git rebase -i and the "fixup" keyword. Fixing this issue
was extremely trivial using that.

Johan
