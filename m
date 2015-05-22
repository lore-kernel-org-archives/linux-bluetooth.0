Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <000801d09478$fa0851e0$ee18f5a0$@samsung.com>
References: <1432047664-23655-1-git-send-email-gowtham.ab@samsung.com>
	<000801d09478$fa0851e0$ee18f5a0$@samsung.com>
Date: Fri, 22 May 2015 14:19:38 +0300
Message-ID: <CABBYNZ+BUe-pDM_8YoajH_PQBR5-DJBW1-vV0d_81=8iDUBTng@mail.gmail.com>
Subject: Re: [PATCH 0/5] Use tester framework for unit-tests
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Gowtham Anandha Babu <gowtham.ab@samsung.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	cpgs@samsung.com
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gowtham,

On Fri, May 22, 2015 at 1:20 PM, Gowtham Anandha Babu
<gowtham.ab@samsung.com> wrote:
> Ping.
>
>> -----Original Message-----
>> From: linux-bluetooth-owner@vger.kernel.org [mailto:linux-bluetooth-
>> owner@vger.kernel.org] On Behalf Of Gowtham Anandha Babu
>> Sent: Tuesday, May 19, 2015 8:31 PM
>> To: linux-bluetooth@vger.kernel.org
>> Cc: bharat.panda@samsung.com; cpgs@samsung.com; Gowtham Anandha
>> Babu
>> Subject: [PATCH 0/5] Use tester framework for unit-tests
>>
>> Used the tester framework for unit-tests to produce much better results.
>>
>> Gowtham Anandha Babu (5):
>>   unit/test-ringbuf: Use tester framework
>>   unit/test-textfile: Use tester framework
>>   unit/test-queue: Use tester framework
>>   unit/test-lib: Use tester framework
>>   unit/test-uuid: Use tester framework
>>
>>  Makefile.am          |   8 ++--
>>  unit/test-lib.c      | 106
> +++++++++++++++++++++++++++++--------------------
>> --
>>  unit/test-queue.c    |  55 ++++++++++++++++----------
>>  unit/test-ringbuf.c  |  31 ++++++++-------  unit/test-textfile.c |  49
>> +++++++++++-------------
>>  unit/test-uuid.c     |  52 ++++++++++++++-----------
>>  6 files changed, 170 insertions(+), 131 deletions(-)
>>
>> --
>> 1.9.1
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth"
> in
>> the body of a message to majordomo@vger.kernel.org More majordomo
>> info at  http://vger.kernel.org/majordomo-info.html

Applied, thanks.



-- 
Luiz Augusto von Dentz
