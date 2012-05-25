Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CABBYNZK6_vVyE7L9pWudM9eC8mfpVjRov83O3wWPBhip5tS=LQ@mail.gmail.com>
References: <1337940693-3417-1-git-send-email-mikel.astiz.oss@gmail.com>
	<1337940693-3417-5-git-send-email-mikel.astiz.oss@gmail.com>
	<CABBYNZK6_vVyE7L9pWudM9eC8mfpVjRov83O3wWPBhip5tS=LQ@mail.gmail.com>
Date: Fri, 25 May 2012 12:57:16 +0200
Message-ID: <CANT-zCUekb1RL6dM8pvyTx3F8cF1Tv8zvUezedBYS7axa4pc5w@mail.gmail.com>
Subject: Re: [PATCH obexd v1 04/16] client-doc: Add transfer event-reporting signals
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	Mikel Astiz <mikel.astiz@bmw-carit.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Fri, May 25, 2012 at 12:50 PM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> Hi Mikel,
>
> On Fri, May 25, 2012 at 1:11 PM, Mikel Astiz <mikel.astiz.oss@gmail.com> wrote:
>> From: Mikel Astiz <mikel.astiz@bmw-carit.de>
>>
>> These signals replace the old agent-based notification mechanism.
>> ---
>>  doc/client-api.txt |    9 +++++++++
>>  1 files changed, 9 insertions(+), 0 deletions(-)
>>
>> diff --git a/doc/client-api.txt b/doc/client-api.txt
>> index cc25543..527df05 100644
>> --- a/doc/client-api.txt
>> +++ b/doc/client-api.txt
>> @@ -322,6 +322,15 @@ Signals            PropertyChanged(string name, variant value)
>>                        This signal indicates a changed value of the given
>>                        property.
>>
>> +               void Complete()
>> +
>> +                       Informs that the transfer has completed successfully.
>> +
>> +               void Error(string message)
>> +
>> +                       Informs that the transfer has been terminated because
>> +                       of some error.
>> +
>
> To avoid any possible confusion I would leave a single signal to tell
> it is complete e.g. Complete(string message), as for the error Johan
> suggested something more meaningful like D-Bus error which both error
> code and error message e.g. Complete(string code, string message),
> actually maybe we should give some other detail when the transfer is
> completed such as file location and other properties that might be
> useful since once this signal is emitted the transfer is gone so there
> is no way to retrieve this information again.

OK, I will change to Complete(string code, string message), although I
have to say I don't like it very much.

So in that case, we would emit Complete("", "") in case of success, right?

Regarding returning transfer properties, that should not be necessary
because, as we already discussed, the idea was to return these
properties in the transfer-initiating method.

Cheers,
Mikel
