Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20110726103623.GA5470@dell>
References: <1311155904-20104-1-git-send-email-radoslawjablonski@gmail.com>
	<20110726103623.GA5470@dell>
Date: Tue, 26 Jul 2011 13:07:10 +0200
Message-ID: <CADUB2Y66LROsZYO=Z__yr-UfawKNPg6hfTb_s8ZvwnN-Bn233A@mail.gmail.com>
Subject: Re: [PATCH obexd] Show owner vcard in phonebook pb pull
From: Radek <radoslawjablonski@gmail.com>
To: Radoslaw Jablonski <radoslawjablonski@gmail.com>,
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

On Tue, Jul 26, 2011 at 12:36 PM, Johan Hedberg <johan.hedberg@gmail.com> wrote:
> Hi Radek,
>
> On Wed, Jul 20, 2011, Radoslaw Jablonski wrote:
>> Previously 'owner' vcard was visible in vcardlisting of 'pb' but not
>> in result of pull 'pb' phonebook. Due to that, vcardlisting and pull
>> operations were returning different number of results (also return
>> values of PhonebookSize request were inconsistent)
>> ---
>>  plugins/phonebook-tracker.c |    2 --
>>  1 files changed, 0 insertions(+), 2 deletions(-)
>
> The patch itself seems fine, but before applying I just wanna
> double-check if your git author email change from @nokia.com to
> @gmail.com is intentional (all your patches so far have been with
> @nokia.com).
Yes, that change of email is intentional - all my patches now will be sent
using gmail account (network configutation issues - problem with using
@nokia account outside Finland:) )

BR,
Radek
>
> Johan
>
