Return-Path: <cyrus@holtmann.org>
Date: Tue, 18 Oct 2011 13:30:59 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: =?iso-8859-1?Q?Fr=E9d=E9ric?= Danis
	<frederic.danis@linux.intel.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v4] fix implicit declaration of 'g_slist_free_full'
Message-ID: <20111018103059.GA24843@fusion.localdomain>
References: <1318932653-15433-1-git-send-email-frederic.danis@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1318932653-15433-1-git-send-email-frederic.danis@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Frédéric,

On Tue, Oct 18, 2011, Frédéric Danis wrote:
> audio/avrcp.c: In function 'avrcp_unregister':
> audio/avrcp.c:1253: error: implicit declaration of function 'g_slist_free_full'
> 
> thermometer/thermometer.c: In function 'destroy_char':
> thermometer/thermometer.c:79: error: implicit declaration of function 'g_slist_free_full'
> ---
>  audio/avrcp.c             |    2 +-
>  thermometer/thermometer.c |    5 +++++
>  2 files changed, 6 insertions(+), 1 deletions(-)

Applied. Thanks.

Btw, to be consistent with the commit history, in the future please
start the commit message with a capital letter, i.e. "Fix.." instead of
"fix..".

Johan
