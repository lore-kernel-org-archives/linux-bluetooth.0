Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20120410103306.GA9418@x220>
References: <1334052807-14320-1-git-send-email-hemant.gupta@stericsson.com>
	<20120410103306.GA9418@x220>
Date: Tue, 10 Apr 2012 17:17:10 +0530
Message-ID: <CACj007=tu=x=+A5xEP3Zan-rrZC6vQF+N4A8m5Lsh03iKWZzYg@mail.gmail.com>
Subject: Re: [PATCH v1] mgmtops: Handle Start Discovery Complete in case of failure
From: Hemant Gupta <hemantgupta.ste@gmail.com>
To: Hemant Gupta <hemant.gupta@stericsson.com>,
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

On Tue, Apr 10, 2012 at 4:03 PM, Johan Hedberg <johan.hedberg@gmail.com> wrote:
> Hi Hemant,
>
> On Tue, Apr 10, 2012, Hemant Gupta wrote:
>> This patch adds handling of start discovery complete event in cases
>> when discovery fails to get started.
>> ---
>>  plugins/mgmtops.c |   33 ++++++++++++++++++++++++++++++++-
>>  1 files changed, 32 insertions(+), 1 deletions(-)
>
> The patch is now applied but I still had to fix it up manually myself:
>
>> +static void start_discovery_complete(int sk, uint16_t index, uint8_t status,
>> +                                  void *buf, size_t len)
>
> Incorrect indentation above: you should indent with tabs as much as
> possible while remaining under the 80 character boundary.
>
>> +     if (len != sizeof(*type)) {
>> +             error("start_discovery_complete event size mismatch "
>> +                     "(%zu != %zu)", len, sizeof(*type));
>
> This should also be indented more.
>
>> +     DBG("type %u status %u", *type, status);
>
> Where did the hci%u go? I meant move the entire DBG statement here and
> not just part of it (it's perfectly fine to print the index value even
> though it's > max_index).
>
>> +     if (index > max_index) {
>> +             error("Unexpected index %u in start_discovery_complete",
>> +                     index);
>
> Incorrect indentation again (should be indented more)
>
>> +     DBG("hci%u", index);
>
> And the above should go away assuming that you move the entire statement
> to the new location.
>
Thanks for the comments, I will upload a new patch soon.

> I think we'll need to reexamine the user space coding style now that the
> kernel doesn't use a strict tabs-only approach anymore. But for now
> we're still following the style we've always used in user space.
>
> Johan
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Best Regards
Hemant Gupta
ST-Ericsson India
