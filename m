Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CADUB2Y6fY1A2n1DrRH9enhKmTPvQZFnFCe0YbJ63t5QdiuRdkA@mail.gmail.com>
References: <1311155904-20104-1-git-send-email-radoslawjablonski@gmail.com>
	<CABBYNZLsJwUtxQvetkFf82__pDOiWCkLAq=FRfvt4sOYB9z9xw@mail.gmail.com>
	<CADUB2Y6fY1A2n1DrRH9enhKmTPvQZFnFCe0YbJ63t5QdiuRdkA@mail.gmail.com>
Date: Wed, 20 Jul 2011 14:13:17 +0300
Message-ID: <CABBYNZLKNLKMwDTTzKYkHwMdxj8fUhLBBWUn-qn1825ROgRRVA@mail.gmail.com>
Subject: Re: [PATCH obexd] Show owner vcard in phonebook pb pull
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Radek <radoslawjablonski@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Radek,

On Wed, Jul 20, 2011 at 2:08 PM, Radek <radoslawjablonski@gmail.com> wrote:
> Hi Luiz,
>
> On Wed, Jul 20, 2011 at 12:15 PM, Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
>> Hi Radek,
>>
>> On Wed, Jul 20, 2011 at 12:58 PM, Radoslaw Jablonski
>> <radoslawjablonski@gmail.com> wrote:
>>> Previously 'owner' vcard was visible in vcardlisting of 'pb'
>>> but not in result of pull 'pb' phonebook.
>>> Due to that, vcardlisting and pull operations were returning
>>> different number of results(also return values of PhonebookSize
>>> request were inconsistent)
>>> ---
>>>  plugins/phonebook-tracker.c |    2 --
>>>  1 files changed, 0 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/plugins/phonebook-tracker.c b/plugins/phonebook-tracker.c
>>> index d1f4cd7..29dd05c 100644
>>> --- a/plugins/phonebook-tracker.c
>>> +++ b/plugins/phonebook-tracker.c
>>> @@ -139,7 +139,6 @@
>>>  "WHERE {"                                                              \
>>>  "      ?_contact a nco:PersonContact ."                                \
>>>  "      OPTIONAL {?_contact nco:hasAffiliation ?_role .}"               \
>>> -"      FILTER (regex(str(?_contact), \"urn:uuid:\"))"                  \
>>>  "}"                                                                    \
>>>  "ORDER BY tracker:id(?_contact)"
>>>
>>> @@ -361,7 +360,6 @@ COMBINED_CONSTRAINT         \
>>>        "SELECT COUNT(?c) "                                             \
>>>        "WHERE {"                                                       \
>>>                "?c a nco:PersonContact ."                              \
>>> -               "FILTER (regex(str(?c), \"urn:uuid:\"))"                \
>>>        "}"
>>>
>>>  #define MISSED_CALLS_COUNT_QUERY                                       \
>>> --
>>> 1.7.0.4
>>
>> I wonder if we came to any conclusion about having the queries in
>> separate files, the way it is right now the queries only works for
>> harmattan which makes tracker backend harmattan specific as they are
>> hard coded in it, it is also much more convenient for testing if you
>> we can just change the queries without having to recompile every time.
>
> Yes, that makes sense. I can do little code refactoring to add "sparql query
> from file" support.
> But I would prefer to do little later with separate set of patches,
> after this patch will be in upstream. Hope that is acceptable:)

Sure, it just came to my mind that we had discussed doing this before,
so I decided to ask about it since this is somewhat related to the
fact that we hardcoded the queries in the code.


-- 
Luiz Augusto von Dentz
