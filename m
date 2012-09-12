Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <5050644F.5040902@ti.com>
References: <1347349100-24228-1-git-send-email-chen.ganir@ti.com>
	<1347349100-24228-3-git-send-email-chen.ganir@ti.com>
	<CAAngNMbUQzxAdwo2JUjzrqkLGXFhpyRVqtz03u+3t3nfXcyxpg@mail.gmail.com>
	<50501416.90408@ti.com>
	<20120912084537.GA31700@x220.P-661HNU-F1>
	<5050644F.5040902@ti.com>
Date: Wed, 12 Sep 2012 06:57:20 -0400
Message-ID: <CAJdJm_NNR86qNnxm-CPFqfuu0sPkoQhqAZY6nGUKB6GYeJ2HAw@mail.gmail.com>
Subject: Re: [PATCH 02/10] battery: Implement Generic device battery
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Chen Ganir <chen.ganir@ti.com>
Cc: Joao Paulo Rechi Vita <jprvita@openbossa.org>,
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Chen,

On Wed, Sep 12, 2012 at 6:30 AM, Chen Ganir <chen.ganir@ti.com> wrote:
>> Both BtIO and GAttrib intend to mimic GLib-like libraries where this is
>> the convention. The plan is not to let this spread to the entire code
>> base (particularly with the likely move to libell in the long run), so
>> please don't use CamelCase.
>>
> Ok. So for the battery options i'll simply change it to battery_option. What
> about the convention for defining a function pointer ?

See the result of:

grep -r 'typedef.*(' *

on your bluez tree. As Johan mentioned, you should ignore the (few)
occurrences of camel case typedef declarations.

Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
