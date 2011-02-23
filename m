Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20110223032154.GD16014@jh-x301>
References: <1298323843-31106-1-git-send-email-anderson.lizardo@openbossa.org>
	<1298408491-11154-1-git-send-email-anderson.lizardo@openbossa.org>
	<20110223032154.GD16014@jh-x301>
Date: Wed, 23 Feb 2011 11:28:11 -0300
Message-ID: <AANLkTi=AAxHpnUkn73L1dK0fOmEpj8dDPxzPFyFvMni3@mail.gmail.com>
Subject: Re: [PATCHv2 1/5] Add read/write callbacks to attribute server
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>,
	linux-bluetooth@vger.kernel.org
Cc: Johan Hedberg <johan.hedberg@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

On Wed, Feb 23, 2011 at 12:21 AM, Johan Hedberg <johan.hedberg@gmail.com> wrote:
> On Tue, Feb 22, 2011, Anderson Lizardo wrote:
>> +struct attribute;
>> +
>> +typedef uint8_t (*att_cb_t)(struct attribute *a, gpointer user_data);
>> +
>>  struct attribute {
>>       uint16_t handle;
>>       uuid_t uuid;
>>       int read_reqs;
>>       int write_reqs;
>> +     att_cb_t read_cb;
>> +     att_cb_t write_cb;
>> +     gpointer cb_user_data;
>>       int len;
>>       uint8_t data[0];
>>  };
>
> I'm not really a fan of the needed forward declaration here. I can't
> find you using "att_cb_t" anywhere else in your patches, so how about
> just having the full type of the callbacks inside the struct definition
> and skip the typedef completely?

Sure, I'll drop the typedef and send a v3.

Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
