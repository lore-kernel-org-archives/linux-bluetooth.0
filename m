Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20140317094331.GA19520@localhost.P-661HNU-F1>
References: <20140313030007.557A6100A6E@puck.mtv.corp.google.com>
	<20140317094331.GA19520@localhost.P-661HNU-F1>
Date: Mon, 17 Mar 2014 07:39:32 -0400
Message-ID: <CAJdJm_O8GnFP3tzw3GKQz0c0rGU5CYh9zeCvsKbF7Yq2CW2NKg@mail.gmail.com>
Subject: Re: [PATCH] uHIDP: HIDP in userspace
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Petri Gynther <pgynther@google.com>,
	BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Mon, Mar 17, 2014 at 5:43 AM, Johan Hedberg <johan.hedberg@gmail.com> wrote:
>>  static gboolean intr_watch_cb(GIOChannel *chan, GIOCondition cond, gpointer data)
>>  {
>>       struct input_device *idev = data;
>>       char address[18];
>>
>> +     if ((cond & G_IO_IN) && hidp_recv_intr_data(chan, idev) &&
>> +                                                     (cond == G_IO_IN)) {
>> +             return TRUE;
>> +     }
>
> This is cramming a bit too many things into the same if-statement.
> Please split it up, e.g. something like:
>
> if ((cond & G_IO_IN) && !hidp_recv_intr_data(chan, idev))
>         goto failed;
>
> /* No exceptions just incoming data  */
> if (cond == G_IO_IN)
>         return TRUE;

Actually, as the original expression was "if ((cond & G_IO_IN) && ...
&& (cond == G_IO_IN))", "cond & G_IO_IN" became no-op. checking
GIOCondition cond with "==" is rarely correct (IMHO), so better review
the logic here.

Best Regards,
-- 
Anderson Lizardo
http://www.indt.org/?lang=en
INdT - Manaus - Brazil
