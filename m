Return-Path: <cyrus@holtmann.org>
Date: Tue, 7 Jan 2014 10:43:47 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] btmon: Fix compiler warnings
Message-ID: <20140107084347.GA9155@x220.p-661hnu-f1>
References: <1389081946-28347-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1389081946-28347-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On Tue, Jan 07, 2014, Andrei Emeltchenko wrote:
> When building for Android this fixes following warnings:
> ...
> monitor/ellisys.c: In function 'ellisys_inject_hci':
> monitor/ellisys.c:159:2: warning: implicit declaration of function 'writev'
> [-Wimplicit-function-declaration]
> ...
> ---
>  monitor/ellisys.c | 1 +
>  1 file changed, 1 insertion(+)

Applied. Thanks.

Johan
