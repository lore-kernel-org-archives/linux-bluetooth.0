Return-Path: <cyrus@holtmann.org>
Date: Wed, 22 Sep 2010 10:47:40 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Elvis =?iso-8859-1?Q?Pf=FCtzenreuter?= <epx@signove.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/2] Add BT read clock and get conn handle to hciops
Message-ID: <20100922074740.GA7051@jh-x301>
References: <1285118546-29558-1-git-send-email-epx@signove.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1285118546-29558-1-git-send-email-epx@signove.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Elvis,

On Tue, Sep 21, 2010, Elvis Pfützenreuter wrote:
> ---
>  plugins/hciops.c |   44 ++++++++++++++++++++++++++++++++++++++++++++
>  src/adapter.c    |   25 +++++++++++++++++++++++++
>  src/adapter.h    |    9 +++++++++
>  3 files changed, 78 insertions(+), 0 deletions(-)

Thanks. the patch has been pushed upstream. I also pushed another patch
to cleanup error variable usage in hciops.

Johan
