Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <EF441CC3-EFCF-4A2A-8ADF-D9F6FF262E4D@holtmann.org>
References: <1391339801-587-1-git-send-email-andrzej.kaczmarek@tieto.com>
	<1391339801-587-12-git-send-email-andrzej.kaczmarek@tieto.com>
	<CAJdJm_OCbUjZVEoNL1y7911zk3QgsQKmQjAJfQh15fhLeTGutA@mail.gmail.com>
	<EF441CC3-EFCF-4A2A-8ADF-D9F6FF262E4D@holtmann.org>
Date: Sun, 2 Feb 2014 16:12:29 -0400
Message-ID: <CAJdJm_MOuYKxtotn1XSqwdsHUUSs8cBuXTRRJ9f6L=U7DS---w@mail.gmail.com>
Subject: Re: [PATCH 11/11] android/tester: Make bt_callbacks thread-safe
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>,
	BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Sun, Feb 2, 2014 at 12:55 PM, Marcel Holtmann <marcel@holtmann.org> wrote:
> I have to agree. We might better spawn processes for this. Our emulator code was never designed to be thread safe and never will be. We are just hiding the real problem here and it will break somewhere else later on.

One thing I've been experimenting with is to use android/haltest to
"script" the tests. It is not as fine grained as implementing your own
HAL interfaces, but I believe it will allow me to implement most tests
I want (I just started writing the tests).

(BTW, if anyone is doing something similar with haltest, let me know!)

Best Regards,
-- 
Anderson Lizardo
http://www.indt.org/?lang=en
INdT - Manaus - Brazil
