Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20110217174806.GK10543@joana>
References: <4d5d2585.8f7edc0a.5af6.27d8@mx.google.com>
	<20110217174806.GK10543@joana>
Date: Thu, 17 Feb 2011 15:09:12 -0300
Message-ID: <AANLkTikmWhzcwAOs18uDV+KCH1LS9HYsHvQT1UUvK77O@mail.gmail.com>
Subject: Re: [RFCv2 1/4] Bluetooth: Implement advertising report meta event
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: "Gustavo F. Padovan" <padovan@profusion.mobi>
Cc: anderson.briglia@openbossa.org, linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gustavo,

On Thu, Feb 17, 2011 at 2:48 PM, Gustavo F. Padovan
<padovan@profusion.mobi> wrote:
>> +     for (i = 1; i < num_reports; i++) {
>> +             ev = (void *) (ev->data + ev->length + 1);
>
> You are not using i anywhere here.

It's used to iterate the for() itself, but it could be changed to e.g.:

while (--num_reports) {
...
}

It is pre-incremented to skip the first report as it was already
processed outside the loop.

Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
