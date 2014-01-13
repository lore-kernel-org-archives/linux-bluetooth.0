Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20140113084845.GE27885@x220.p-661hnu-f1>
References: <1389600554-20669-1-git-send-email-szymon.janc@tieto.com>
	<20140113084845.GE27885@x220.p-661hnu-f1>
Date: Mon, 13 Jan 2014 07:13:35 -0400
Message-ID: <CAJdJm_NMf_VpC0JpcGi8KbcMg7BxF3zQ_iP9vk3q+voh6uCpJw@mail.gmail.com>
Subject: Re: [PATCH 1/2] tools: Fix build error in seq2bseq
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Szymon Janc <szymon.janc@tieto.com>,
	BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=windows-1252
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon/Johan,

On Mon, Jan 13, 2014 at 4:48 AM, Johan Hedberg <johan.hedberg@gmail.com> wrote:
> Hi Szymon,
>
> On Mon, Jan 13, 2014, Szymon Janc wrote:
>> Don't ignore return value of write. This fix following build error on
>> Ubuntu:
>>
>> tools/seq2bseq.c: In function ‘convert_line’:
>> tools/seq2bseq.c:52:8: error: ignoring return value of ‘write’,
>>      declared with attribute warn_unused_result [-Werror=unused-result]
>>    write(fd, &val, 1);
>> ---
>>  tools/seq2bseq.c | 10 +++++++---
>>  1 file changed, 7 insertions(+), 3 deletions(-)
>
> Both patches have been applied. Thanks.


I sent a similar patch a few hours ago (which was not applied). There
you can see the caller of convert_line() also needs to be changed to
break the parsing loop. I was also printing the error with perror
(similar to other places on the file).


Best Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
