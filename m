Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <4765B7BC10CB4C488A56C73E15D6FBA31DA381A6A5@EXDCVYMBSTM005.EQ1STM.local>
References: <4765B7BC10CB4C488A56C73E15D6FBA31DA376A45B@EXDCVYMBSTM005.EQ1STM.local>
	<AANLkTimZk4FrRBGSp=W1LciZnrwjAqmm3k71tLA4AEYV@mail.gmail.com>
	<4765B7BC10CB4C488A56C73E15D6FBA31DA381A6A5@EXDCVYMBSTM005.EQ1STM.local>
Date: Mon, 17 Jan 2011 14:27:43 -0300
Message-ID: <AANLkTinjXceSM7NDVqWyyDGfgvtmAaFbMXdz829g311c@mail.gmail.com>
Subject: Re: [PATCH] HCI Commands for LE White List
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: Sumit Kumar BAJPAI <sumitkumar.bajpai@stericsson.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Sumit,

<snip>

> Is using a separate variable err for return type of a function problem here?
I didn't understand your question here.
hci_* functions return 0 on success or -1 on failure. On failure errno
can be read to get the error number.

> I could see same coding style of defining a variable to carry the error status in hcitool.c function cmd_lecc.
> Please confirm.
The coding style issue is the if else:
At this point "else" is not needed: there is a "exit(1)" inside the
"if" block. But if you need else the correct coding style is:
...
} else {
...

Instead of
...
}
else {
...

<snip>

>> > +       err = hci_le_remove_from_white_list(dd, bdaddr ,bdaddr_type);
>> > +       if (err < 0) {
>> > +               perror("Cant remove from white list");
>> > +               exit(1);
>> > +       }
>> > +        else {
>> > +               printf("Device removed from white list");
>> > +       }
>> > +
>> > +       hci_close_dev(dd);
>> Same coding style issue and close "dd"
>>
>
>
> Ok. Good point. But I could still find premature returns on error conditions via exits at several places in hcitool.c. Can I submit a separate patch for rectifying all such error conditions too?

sure!

Claudio
