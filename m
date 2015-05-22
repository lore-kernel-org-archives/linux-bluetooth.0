Return-Path: <cyrus@holtmann.org>
From: Gowtham Anandha Babu <gowtham.ab@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: cpgs@samsung.com, 'Luiz Augusto von Dentz' <luiz.dentz@gmail.com>
References: <1432047664-23655-1-git-send-email-gowtham.ab@samsung.com>
In-reply-to: <1432047664-23655-1-git-send-email-gowtham.ab@samsung.com>
Subject: RE: [PATCH  0/5] Use tester framework for unit-tests
Date: Fri, 22 May 2015 15:50:41 +0530
Message-id: <000801d09478$fa0851e0$ee18f5a0$@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Ping.

> -----Original Message-----
> From: linux-bluetooth-owner@vger.kernel.org [mailto:linux-bluetooth-
> owner@vger.kernel.org] On Behalf Of Gowtham Anandha Babu
> Sent: Tuesday, May 19, 2015 8:31 PM
> To: linux-bluetooth@vger.kernel.org
> Cc: bharat.panda@samsung.com; cpgs@samsung.com; Gowtham Anandha
> Babu
> Subject: [PATCH 0/5] Use tester framework for unit-tests
> 
> Used the tester framework for unit-tests to produce much better results.
> 
> Gowtham Anandha Babu (5):
>   unit/test-ringbuf: Use tester framework
>   unit/test-textfile: Use tester framework
>   unit/test-queue: Use tester framework
>   unit/test-lib: Use tester framework
>   unit/test-uuid: Use tester framework
> 
>  Makefile.am          |   8 ++--
>  unit/test-lib.c      | 106
+++++++++++++++++++++++++++++--------------------
> --
>  unit/test-queue.c    |  55 ++++++++++++++++----------
>  unit/test-ringbuf.c  |  31 ++++++++-------  unit/test-textfile.c |  49
> +++++++++++-------------
>  unit/test-uuid.c     |  52 ++++++++++++++-----------
>  6 files changed, 170 insertions(+), 131 deletions(-)
> 
> --
> 1.9.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth"
in
> the body of a message to majordomo@vger.kernel.org More majordomo
> info at  http://vger.kernel.org/majordomo-info.html

