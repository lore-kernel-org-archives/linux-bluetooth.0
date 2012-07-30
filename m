Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAJyhjX1tPq0WCvZACf=sp6sCHoqwvOE2WZ3F8FwndJ5vmCRTQA@mail.gmail.com>
References: <1343420976-19921-1-git-send-email-eder.ruiz@openbossa.org>
	<CAJyhjX1tPq0WCvZACf=sp6sCHoqwvOE2WZ3F8FwndJ5vmCRTQA@mail.gmail.com>
Date: Mon, 30 Jul 2012 06:35:23 -0400
Message-ID: <CAJdJm_M_f2hEFqEcoW0SJrGbzPNNESSwXxDR=zZF_ruLo-x2RA@mail.gmail.com>
Subject: Re: [PATCH BlueZ 1/3] att: Add prepare write support
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Sergio Correia <lists@uece.net>
Cc: Eder Ruiz Maria <eder.ruiz@openbossa.org>,
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Sergio,

On Sat, Jul 28, 2012 at 9:47 PM, Sergio Correia <lists@uece.net> wrote:
>> +uint16_t enc_prep_write_req(uint16_t handle, uint16_t offset,
>> +                       const uint8_t *value, int vlen, uint8_t *pdu, int len)
>> +{
>> +       const uint16_t min_len = sizeof(pdu[0]) + sizeof(handle) +
>> +                                                               sizeof(offset);
>> +
>> +       if (pdu == NULL)
>> +               return 0;
>> +
>> +       if (len < min_len)
>> +               return 0;
>
> maybe it would be better to check the above conditions in a single if statement?

I think Eder is following the same style from the other similar
functions in the same file. I would suggest leaving these patches as
is and instead sending a separate patch changing this in all
functions, as a refactoring patch.

My two cents,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
