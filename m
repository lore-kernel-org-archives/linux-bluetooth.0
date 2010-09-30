Return-Path: <cyrus@holtmann.org>
Date: Thu, 30 Sep 2010 13:49:53 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Rafal Michalski <michalski.raf@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Fix handlig for gboolean mce_bt_set field
Message-ID: <20100930104953.GA13544@jh-x301>
References: <1285842160-4127-1-git-send-email-michalski.raf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1285842160-4127-1-git-send-email-michalski.raf@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Rafal,

On Thu, Sep 30, 2010, Rafal Michalski wrote:
> Expression (sigvalue & MCE_RADIO_STATE_BLUETOOTH) is invalid because it makes
> wrong assumption about that it evaluates to TRUE, when bit
> MCE_RADIO_STATE_BLUETOOTH is set. In this case, assignment
> mce_bt_set = (sigvalue & MCE_RADIO_STATE_BLUETOOTH) makes that gboolean
> "mce_bt_set" receives value equal 8 instead of TRUE (equal 1). So condition in
> "if (mce_bt_set == powered)" statement will never evaluate to true because
> gboolean "powered" receives only TRUE (equal 1) or FALSE (equal 0) value.
> We should remember that gboolean type is not bool type in C++ sense.
> It's simply typedef of gint (int), so assignmnet:
> mce_bt_set = (sigvalue & MCE_RADIO_STATE_BLUETOOTH) is valid for compiler but
> in our case it makes a bug. So normalization (double negation) in assignment:
> mce_bt_set = !!(sigvalue & MCE_RADIO_STATE_BLUETOOTH) preserves that
> "mce_bt_set" will receive only TRUE or FALSE value.
> ---
>  plugins/maemo6.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)

Thanks. The patch has been pushed upstream with a much simplified commit
message (the above is really quite complicated to read compared to the
simplicity of the actual fix).

Johan
