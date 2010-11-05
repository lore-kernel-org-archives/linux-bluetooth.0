Return-Path: <cyrus@holtmann.org>
Date: Fri, 5 Nov 2010 07:02:46 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Claudio Takahasi <claudio.takahasi@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Move set_nonblocking function to audio/unix.c
Message-ID: <20101105050246.GA25270@jh-x301>
References: <1288899810-18722-1-git-send-email-claudio.takahasi@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1288899810-18722-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Claudio,

On Thu, Nov 04, 2010, Claudio Takahasi wrote:
> ---
>  audio/unix.c      |   20 ++++++++++++++++++++
>  src/glib-helper.c |   20 --------------------
>  src/glib-helper.h |    2 --
>  3 files changed, 20 insertions(+), 22 deletions(-)

Pushed upstream. Thanks.

Johan
