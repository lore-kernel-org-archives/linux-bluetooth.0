Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20101117121526.GA16972@jh-x301>
References: <AANLkTikTyH+3LLbr=ytu+9jcE8Sk_wTqdRyn9jwK821a@mail.gmail.com> <20101117121526.GA16972@jh-x301>
From: liang yu <iamyuliang@gmail.com>
Date: Wed, 17 Nov 2010 21:03:51 +0800
Message-ID: <AANLkTikz7pQoFu6z5d3tfQGCTRthirSsQBD7k4pQhtS9@mail.gmail.com>
Subject: Re: Does OBEX authentication works in OPP?
To: liang yu <iamyuliang@gmail.com>, linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Wed, Nov 17, 2010 at 8:15 PM, Johan Hedberg <johan.hedberg@gmail.com> wrote:
> Hi,
>
> On Wed, Nov 17, 2010, liang yu wrote:
>> According to the Bluetooth SIG profile OBEX authentication is not used
>> in OPP. But in source code of Obexd-0.36/plugins/opp.c, the function
>> opp_chkput invokes manager_request_authorization. Does this mean that
>> in your implementation it is still checked OBEX authentication in opp?
>>     Doea anybody give me some tips.
>
> The code you found (and as the function name also implies) is about
> authorization and not authentication. So no, OBEX authentication is not
> used with OPP.
>
> Johan
>
Get it .Thanks ,Hedberg
