Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <BANLkTim1bbjPbzG+=gvBua2Y7OM=YTdeNA@mail.gmail.com>
References: <1307957658-11330-3-git-send-email-lkslawek@gmail.com>
	<1307964277-12590-1-git-send-email-lkslawek@gmail.com>
	<BANLkTim1bbjPbzG+=gvBua2Y7OM=YTdeNA@mail.gmail.com>
Date: Tue, 14 Jun 2011 08:58:33 +0200
Message-ID: <BANLkTinJkDZq2a+Z78p1wMAHdC1cO4ngPw@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] Fix handling asynchronous plugin reads
From: Slawomir Bochenski <lkslawek@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Tue, Jun 14, 2011 at 8:33 AM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>> +       if (ret == -EAGAIN) {
>> +               suspend_get(os, os->obex, os->obj);
>> +       } else if (ret < 0) {
>>                os_set_response(os->obj, err);
>>                OBEX_CancelRequest(os->obex, TRUE);
>> -       } else
>> +       } else {
>>                OBEX_ResumeRequest(os->obex);
>> +       }
>
> One line statements do not need {
Kernel coding style states that this is not true when another branch
in the if-else has more than one statement. Then braces should be used
for all branches.
>
>> -       return FALSE;
>> +       if (os->suspended)
>> +               return TRUE;
>> +       else
>> +               return FALSE;
>>  }
>
> I guess here you can just return os->suspended.
I guess I can.

-- 
Slawomir Bochenski
