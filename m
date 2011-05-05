Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <AFCDDB4A3EA003429EEF1E7B211FDBBA3395937A4C@EXDCVYMBSTM005.EQ1STM.local>
References: <BANLkTimKJNo9WgwkfC2Hci-dW6kjF3VWGw@mail.gmail.com>
	<20110419180425.GA2476@joana>
	<AFCDDB4A3EA003429EEF1E7B211FDBBA3395937A4C@EXDCVYMBSTM005.EQ1STM.local>
Date: Thu, 5 May 2011 17:13:56 +0300
Message-ID: <BANLkTikr_vG90mt37W6eDYcgjteM9tu7-Q@mail.gmail.com>
Subject: Re: BT 3.0 HS Support in BlueZ
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Arun Kumar SINGH <arunkr.singh@stericsson.com>
Cc: "Gustavo F. Padovan" <padovan@profusion.mobi>,
	Anurag Gupta <anurag1303@gmail.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Thu, May 5, 2011 at 10:26 AM, Arun Kumar SINGH
<arunkr.singh@stericsson.com> wrote:
> Hi Gustavo,
>
>>> Does anybody know if
>>bluetooth 3.0 HS spec is
>>supported in BlueZ?
>>> Is AMP supported in BlueZ?
>>
>>There is two different
>>implementations, one by
>>Atheros and another by QuIC.
>>Both never reach upstream,
>>if you look to the list logs
>>you will find them.
>
>
> Any hopes of getting this unified version upstream anytime in near future? I guess this has been on the cards for some time now given that merge process started last august.
>
> I am trying to understand the options other folks may have, who may be interested in having 3.0 support in Bluez. Rewriting entire 3.0 support from scratch may be one thing that should be avoided as long as current upstreaming activity doesn't end up in a dead trail.  Which I assume, it hadn't.

Well I would like to test something with obexd/obex-client to see how
we could indicate that high speed is necessary, so it would be very
welcoming if somebody step up and try to make a plan to integrate this
work upstream, otherwise we gonna have to either start from scratch or
pick one that seems to fit best in upstream.


-- 
Luiz Augusto von Dentz
Computer Engineer
