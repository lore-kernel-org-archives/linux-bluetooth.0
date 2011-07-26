Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CADUB2Y66LROsZYO=Z__yr-UfawKNPg6hfTb_s8ZvwnN-Bn233A@mail.gmail.com>
References: <1311155904-20104-1-git-send-email-radoslawjablonski@gmail.com>
	<20110726103623.GA5470@dell>
	<CADUB2Y66LROsZYO=Z__yr-UfawKNPg6hfTb_s8ZvwnN-Bn233A@mail.gmail.com>
Date: Tue, 26 Jul 2011 14:14:32 +0300
Message-ID: <CABBYNZJoCtNXoGSzBE7LZyBggAjTZCY5NDnjUCoj-=-rjPO50A@mail.gmail.com>
Subject: Re: [PATCH obexd] Show owner vcard in phonebook pb pull
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Radek <radoslawjablonski@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Radek,

On Tue, Jul 26, 2011 at 2:07 PM, Radek <radoslawjablonski@gmail.com> wrote:
> Hi Johan,
>
> On Tue, Jul 26, 2011 at 12:36 PM, Johan Hedberg <johan.hedberg@gmail.com> wrote:
>> Hi Radek,
>>
>> On Wed, Jul 20, 2011, Radoslaw Jablonski wrote:
>>> Previously 'owner' vcard was visible in vcardlisting of 'pb' but not
>>> in result of pull 'pb' phonebook. Due to that, vcardlisting and pull
>>> operations were returning different number of results (also return
>>> values of PhonebookSize request were inconsistent)
>>> ---
>>>  plugins/phonebook-tracker.c |    2 --
>>>  1 files changed, 0 insertions(+), 2 deletions(-)
>>
>> The patch itself seems fine, but before applying I just wanna
>> double-check if your git author email change from @nokia.com to
>> @gmail.com is intentional (all your patches so far have been with
>> @nokia.com).
> Yes, that change of email is intentional - all my patches now will be sent
> using gmail account (network configutation issues - problem with using
> @nokia account outside Finland:) )

Just a tip, the author and the email do not need to be the same, if
you want you can configure gmail as your server/from maintaining the
author field.

-- 
Luiz Augusto von Dentz
