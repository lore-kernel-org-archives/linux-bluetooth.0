Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20120329102232.GD23176@x220>
References: <1332948405-1104-1-git-send-email-chen.ganir@ti.com>
	<1332948405-1104-6-git-send-email-chen.ganir@ti.com>
	<20120329102232.GD23176@x220>
Date: Thu, 29 Mar 2012 06:45:30 -0400
Message-ID: <CAJdJm_PEh9FZBMojKujrdvTy4pGUZ3YVa39WrjecqOXY67Y-_g@mail.gmail.com>
Subject: Re: [PATCH v3 5/5] DeviceInfo: Read PNP ID
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: chen.ganir@ti.com, linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Chen/Johan,

On Thu, Mar 29, 2012 at 6:22 AM, Johan Hedberg <johan.hedberg@gmail.com> wrote:
> Hi Chen,
>
> On Wed, Mar 28, 2012, chen.ganir@ti.com wrote:
>> +     if (status != 0) {
>> +             DBG("value read failed: %s",
>> +                                                     att_ecode2str(status));
>
> Why is this split into two lines. The call can easily fit within 80
> chars with all of its parameters. Also, this should be error() and not
> DBG().
>
>> +     if (!dec_read_resp(pdu, len, value, &vlen)) {
>> +             DBG("Protocol error\n");
>
> This should be error() and the \n at the end should be removed.

Just to complement: if using error(), be sure to use a more meaningful
error message, because the source file and function name will not
appear on the log in this case.

E.g.
"Could not read PNP ID value: %s"
"ATT protocol error while reading PNP ID"

Also, there is no need to add "\n" to DBG() or error(), they are added
automatically.

Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
