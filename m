Return-Path: <cyrus@holtmann.org>
Date: Wed, 17 Nov 2010 12:15:26 +0000
From: Johan Hedberg <johan.hedberg@gmail.com>
To: liang yu <iamyuliang@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: Does OBEX authentication works in OPP?
Message-ID: <20101117121526.GA16972@jh-x301>
References: <AANLkTikTyH+3LLbr=ytu+9jcE8Sk_wTqdRyn9jwK821a@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <AANLkTikTyH+3LLbr=ytu+9jcE8Sk_wTqdRyn9jwK821a@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Wed, Nov 17, 2010, liang yu wrote:
> According to the Bluetooth SIG profile OBEX authentication is not used
> in OPP. But in source code of Obexd-0.36/plugins/opp.c, the function
> opp_chkput invokes manager_request_authorization. Does this mean that
> in your implementation it is still checked OBEX authentication in opp?
>     Doea anybody give me some tips.

The code you found (and as the function name also implies) is about
authorization and not authentication. So no, OBEX authentication is not
used with OPP.

Johan
