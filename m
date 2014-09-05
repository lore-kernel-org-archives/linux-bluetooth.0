Return-Path: <cyrus@holtmann.org>
Date: Fri, 5 Sep 2014 23:31:46 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcin Kraglak <marcin.kraglak@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] shared/tester: Change handling of tester_setup_failed
 event
Message-ID: <20140905203146.GB31093@t440s.P-661HNU-F1>
References: <1409650483-24403-1-git-send-email-marcin.kraglak@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1409650483-24403-1-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcin,

On Tue, Sep 02, 2014, Marcin Kraglak wrote:
> If tester_setup_failed() was called, execute post_teardown() to clean
> data created in pre_setup phase. In some cases android-tester
> couldn't start daemon, and setup failed, but hciemu created in
> pre_setup was not removed.
> ---
>  src/shared/tester.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)

Applied. Thanks.

Johan
