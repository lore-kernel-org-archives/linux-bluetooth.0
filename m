Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAJdJm_O5Og9+3EfB3RgT1c2oF-B1rrQvRi3dGzpHZ3c0j=NXMg@mail.gmail.com>
References: <1380291161-10232-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
	<1380291161-10232-13-git-send-email-Andrei.Emeltchenko.news@gmail.com>
	<CAJdJm_O5Og9+3EfB3RgT1c2oF-B1rrQvRi3dGzpHZ3c0j=NXMg@mail.gmail.com>
Date: Fri, 27 Sep 2013 13:21:08 -0400
Message-ID: <CAJdJm_M8mkzKfjQv1p5D9RshhpxjTc0VLKotmFUCgu-GCLUzXw@mail.gmail.com>
Subject: Re: [RFC 12/16] android: Add cap to bind to port < 1024
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On Fri, Sep 27, 2013 at 1:17 PM, Anderson Lizardo
<anderson.lizardo@openbossa.org> wrote:
>> +       DBG("%s: capset(): Success", __func__);

The line above seems unnecessary (there are already error/debug
messages on every code path on this function and this one does not add
any extra information).

Best Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
