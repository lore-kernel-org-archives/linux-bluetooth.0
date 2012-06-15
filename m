Return-Path: <cyrus@holtmann.org>
Date: Fri, 15 Jun 2012 12:27:44 -0300
From: Gustavo Padovan <gustavo@padovan.org>
To: Henrique Dante de Almeida <hdante@profusion.mobi>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH RFC] gdbus: Rename variables named "signal" (so that it
 can be compiled with -Wshadow)
Message-ID: <20120615152744.GA3158@joana>
References: <1339761848-7472-1-git-send-email-hdante@profusion.mobi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1339761848-7472-1-git-send-email-hdante@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Henrique,

* Henrique Dante de Almeida <hdante@profusion.mobi> [2012-06-15 09:04:08 -0300]:

> ---
>  gdbus/object.c |   39 +++++++++++++++++++++------------------
>  gdbus/watch.c  |    4 ++--
>  2 files changed, 23 insertions(+), 20 deletions(-)

Please keep the subject line of your patch with less than 72 chars. You could
split it like:

gdbus: Rename variables named "signal"

so that it can be compiled with -Wshadow

	Gustavo
