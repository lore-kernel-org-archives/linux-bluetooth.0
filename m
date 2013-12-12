Return-Path: <cyrus@holtmann.org>
Date: Thu, 12 Dec 2013 09:57:34 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] l2cap-tester: Close sk in error path
Message-ID: <20131212075734.GA1966@x220.p-661hnu-f1>
References: <1386834508-9929-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1386834508-9929-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On Thu, Dec 12, 2013, Andrei Emeltchenko wrote:
> This fixes resource leak warnings.
> ---
>  tools/l2cap-tester.c | 2 ++
>  1 file changed, 2 insertions(+)

Applied. Thanks.

Johan
