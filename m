Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20111020122745.GA29417@aemeltch-MOBL1>
References: <1319100817-8477-1-git-send-email-frederic.danis@linux.intel.com>
	<20111020111956.GA5742@fusion.localdomain>
	<20111020122745.GA29417@aemeltch-MOBL1>
Date: Thu, 20 Oct 2011 17:24:56 -0300
Message-ID: <CAJdJm_PvpKbNO84nETMFfrsRNwYdk763VvJswx1Hi52un4hRnA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] Simplify eir_parse function
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>,
	=?ISO-8859-1?Q?Fr=E9d=E9ric_Danis?=
	<frederic.danis@linux.intel.com>, linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

2011/10/20 Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>:
>> Just change this all to:
>>
>>               service.value.uuid32 = bt_get_unaligned(btohl(u32));
>
> btohl(bt_get_unaligned(u32))
> maybe we could also use get_u32() ?

There is also att_get_u32()  in attrib/att.h (exact same code). Maybe
we need some code reuse here :)

Regards,
--
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
