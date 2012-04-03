Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20120403110117.GA26728@x220.ger.corp.intel.com>
References: <1333126569-1606-1-git-send-email-hemant.gupta@stericsson.com>
	<20120403104114.GB23054@x220>
	<AA50405D3B026C488CB3DB0AADE6954020064F5D94@EXDCVYMBSTM005.EQ1STM.local>
	<20120403110117.GA26728@x220.ger.corp.intel.com>
Date: Tue, 3 Apr 2012 17:27:40 +0530
Message-ID: <CACj007nPnJwBO_P3jJ6UmB70vpdD756e+CVdZFcEqj4mZmjv8w@mail.gmail.com>
Subject: Re: [PATCH v1] Adapter: Fix Discovering state while Powering Off
From: Hemant Gupta <hemantgupta.ste@gmail.com>
To: Hemant GUPTA <hemant.gupta@stericsson.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	Hemant Gupta <hemantgupta.ste@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

On Tue, Apr 3, 2012 at 4:31 PM, Johan Hedberg <johan.hedberg@gmail.com> wrote:
> Hi Hemant,
>
> On Tue, Apr 03, 2012, Hemant GUPTA wrote:
>> -----Original Message-----
>> From: Johan Hedberg [mailto:johan.hedberg@gmail.com]
>> Sent: Tuesday, April 03, 2012 4:11 PM
>> To: Hemant GUPTA
>> Cc: linux-bluetooth@vger.kernel.org; Hemant Gupta
>> Subject: Re: [PATCH v1] Adapter: Fix Discovering state while Powering Off
>>
>> Hi Hemant,
>>
>> On Fri, Mar 30, 2012, Hemant Gupta wrote:
>> > This patch fixes the adater discovering state while powering off.
>> > Without this fix, BlueZ sends incorrect discovering state to upper
>> > layers while switching off.
>> > ---
>> >  src/adapter.c |    6 ++++++
>> >  1 files changed, 6 insertions(+), 0 deletions(-)
>> >
>> > diff --git a/src/adapter.c b/src/adapter.c index f8f46f8..eb9745f
>> > 100644
>> > --- a/src/adapter.c
>> > +++ b/src/adapter.c
>> > @@ -289,6 +289,12 @@ static int set_mode(struct btd_adapter *adapter, uint8_t new_mode,
>> >                     return err;
>> >
>> >             adapter->off_requested = TRUE;
>> > +           /*
>> > +            * Change the discovering state to FALSE, otherwise
>> > +            * inquiry fails to start if BT is switched off and then on
>> > +            * while inquiry is already active.
>> > +            */
>> > +           adapter->discovering = FALSE;
>> >
>> >             goto done;
>> >     }
>>
>> Wouldn't the right place to do this be in btd_adapter_stop()? (after sending the Discovering signal). Actually, wouldn't the right thing be to call adapter_set_discovering() in btd_adapter_stop?
>> Yes that looks like a good place. Regarding the call to adapter_set_discovering(), I had earlier thought of same, but seeing the code of adapter_set_discovering(), it will also set the out of range devices, and would emit device disappeared signal to upper layers, which might get wrong indication that some devices might have disappeared. So I thought that this would be anyways updated during the enxt time Inquiry is performed when BT is witched back on. What do you think about this ?
>
> If I hadn't written my email just a few minutes ago how on earth am I
> supposed to distinguish what's part of my original email and what you're
> written yourself!? Initially I thought that you had just forwarded my own
> email without adding anything extra but on closer inspection I noticed
> that you've in fact very obscurely included extra text there. You didn't
> include an empty line! (not that it would have helped much)
>
> Please configure your email client to use the standard '> ' way of
> quoting the email you're replying to. If you've ever not received
> replies to your emails this might be the reason: people simply didn't
> know that you had written something to them.
>
> About the original issue: sure, don't use adapter_set_discovering but
> add a adapter->discovering = FALSE; right after emiting the signal in
> btd_adapter_stop.
I have sent a new patch, please have a look.

> Johan

-- 
Best Regards
Hemant Gupta
ST-Ericsson India
