Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20120410091320.GA6124@x220>
References: <1333955251-8377-1-git-send-email-hemant.gupta@stericsson.com>
	<20120410091320.GA6124@x220>
Date: Tue, 10 Apr 2012 15:28:20 +0530
Message-ID: <CACj007=DC4gon83DoNTLn-X8gG+ehojwY7E-bVP3YxMkLvhFKA@mail.gmail.com>
Subject: Re: [PATCH] mgmtops: Handle Start Discovery Complete in case of failure
From: Hemant Gupta <hemantgupta.ste@gmail.com>
To: Hemant Gupta <hemant.gupta@stericsson.com>,
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

On Tue, Apr 10, 2012 at 2:43 PM, Johan Hedberg <johan.hedberg@gmail.com> wrote:
> Hi Hemant,
>
> On Mon, Apr 09, 2012, Hemant Gupta wrote:
>> +     if (len != sizeof(*type)) {
>> +             error("start_discovery_complete event size mismatch "
>> +                   "(%zu != %zu)", len, sizeof(*type));
>
Sorry, but I thought we need to allign to the opening brace. Will
update it in next patch.

> The above line should be indented only with tabs. You're using tabs +
> spaces.
>
>> +     if (index > max_index) {
>> +             error("Unexpected index %u in start_discovery_complete",
>> +                   index);
>> +             return;
>> +     }
>> +
>> +     if (!status)
>> +             return;
>> +
>> +     DBG("hci%u type%d status%d", index, *type, status);
>
> Could you move this DBG statement above the index < max_index and add
> spaces after "type" and "status" (hci%u is the only exception since
> that's how adapters are named). Also, the format specifiers should be %u
> since both type and status are unsigned.
>
Thanks, will update this in next patch.

>> +     adapter = manager_find_adapter_by_id(index);
>> +
>> +     if (adapter)
>
> Remove the empty line between the adapter assignment and the
> if-statement (this applies to any function call and a test for its
> result; there should be no empty line between them).
>
Thanks will update this in next patch.
> Johan
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Best Regards
Hemant Gupta
ST-Ericsson India
