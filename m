Return-Path: <cyrus@holtmann.org>
Date: Fri, 21 Oct 2011 11:15:25 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: =?iso-8859-1?Q?Fr=E9d=E9ric?= Danis
	<frederic.danis@linux.intel.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v3] Simplify eir_parse_uuid* functions
Message-ID: <20111021081525.GA30650@fusion.localdomain>
References: <1319115184-16116-1-git-send-email-frederic.danis@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1319115184-16116-1-git-send-email-frederic.danis@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Frédéric,

On Thu, Oct 20, 2011, Frédéric Danis wrote:
> ---
>  src/eir.c |   37 +++++++++++++++----------------------
>  1 files changed, 15 insertions(+), 22 deletions(-)

I made the g_free fix suggestion from Lizardo and applied the patch.
Thanks.

Johan
