Return-Path: <cyrus@holtmann.org>
Message-ID: <50A0E5D7.7090609@tieto.com>
Date: Mon, 12 Nov 2012 13:04:39 +0100
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH] gatt: Update characteristic names translation table
References: <1352475687-15070-1-git-send-email-andrzej.kaczmarek@tieto.com> <CAJdJm_OHoqsec-H=hWqUOD0pHcpAyrR4=TCLaSSx1wORgohBxg@mail.gmail.com>
In-Reply-To: <CAJdJm_OHoqsec-H=hWqUOD0pHcpAyrR4=TCLaSSx1wORgohBxg@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Anderson,

On 11/12/2012 12:41 PM, Anderson Lizardo wrote:
> Hi Andrzej,
>
> On Fri, Nov 9, 2012 at 11:41 AM, Andrzej Kaczmarek
> <andrzej.kaczmarek@tieto.com> wrote:
>> ---
>>   attrib/client.c | 44 ++++++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 44 insertions(+)
>
> Most characteristics you are adding here come from profiles which have
> not been adopted yet, so they are not publicly available.
>
> I would first wait for their adoption before adding here, as AFAIK it
> is still possible that their UUIDs might change before final adoption.

Sure, agree. I'll send v2 in a moment which will include only 
characteristics from already adopted profiles.

BR,
Andrzej
