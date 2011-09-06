Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CA+QXtDs+PJNYiCPwh=K7qoVVfZj3K5X6LNA6F9aZ1oWT8k0XLw@mail.gmail.com>
References: <1314805732-30418-1-git-send-email-frederic.dalleau@linux.intel.com>
	<1314805732-30418-3-git-send-email-frederic.dalleau@linux.intel.com>
	<CABBYNZK7HjoQC2gqeBbR7CSBC=w68ReFAVcnpAD8Nh0Yhm=O7g@mail.gmail.com>
	<CA+QXtDs+PJNYiCPwh=K7qoVVfZj3K5X6LNA6F9aZ1oWT8k0XLw@mail.gmail.com>
Date: Tue, 6 Sep 2011 12:46:05 +0300
Message-ID: <CABBYNZ+Lz0tfC8jUWR5nDhDPAVgwEchkh_5o77=JmkiU3DeqNQ@mail.gmail.com>
Subject: Re: [PATCH v4 2/4] Fix asynchronously run request stream cb
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: "Dalleau, Frederic" <frederic.dalleau@intel.com>
Cc: =?ISO-8859-1?Q?Fr=E9d=E9ric_Dalleau?=
	<frederic.dalleau@linux.intel.com>, linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Frederic,

2011/9/6 Dalleau, Frederic <frederic.dalleau@intel.com>:
> Hi Luiz,
>
>>> +       g_set_error(&gerr, BT_IO_ERROR, BT_IO_ERROR_FAILED, "Closed");
>>
>> We should probably create its own error domain instead of reusing
>> BT_IO_ERROR, besides that it looks ok.
>
> Should this domain be specific to gateway.c or more generic ?

I guess it can be local to gateway, right now we don't really use the
domain when printing the error message but in case we start doing then
this would give us a more granularity where the error comes from.

-- 
Luiz Augusto von Dentz
