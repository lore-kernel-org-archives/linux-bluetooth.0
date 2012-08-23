Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <50365374.2030605@globaledgesoft.com>
References: <5008F67F.5030604@globaledgesoft.com>
	<CACJA=fUW4a-B-1SGQmPbh+J5YKJ9bVEFbz8ZUezPOD3w0Hmsxw@mail.gmail.com>
	<502E56DF.3020103@globaledgesoft.com>
	<CAJdJm_P=4fbHXG7gFpYQht9NmD88nixzO95N-HsgYwUOMx+pig@mail.gmail.com>
	<502ED4E8.9040702@globaledgesoft.com>
	<CAJdJm_OBh4OzKJejongsaWm1mSx2GN5Yki3B4nYc6C2DbVS=nw@mail.gmail.com>
	<503503C1.6060805@globaledgesoft.com>
	<20120822151300.GA6746@samus>
	<50365374.2030605@globaledgesoft.com>
Date: Thu, 23 Aug 2012 15:09:15 -0400
Message-ID: <CAJdJm_Ntt7TtD+nrNLMnqZ08AiAv4_83eqWEcRPJ9fyaBeoXqg@mail.gmail.com>
Subject: Re: BLE - multiple connections
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Ajay KV <ajay.kv@globaledgesoft.com>
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>,
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ajay,

On Thu, Aug 23, 2012 at 11:59 AM, Ajay KV <ajay.kv@globaledgesoft.com> wrote:
>         Still not working  , getting the same old error. i just want to know
> , whether my dual-mode dongle allows this operation or not (Advertising
> mode+ connected mode)

Did you try my suggestion?

1) Enable LE adv on A
2) Connect from B to A
3) Try to enable LE adv on A (should give the error you are getting)
4) disconnect connection from A side (using hcitool ledc)
5) try to enable LE adv on A

if step (5) works, we have confirmation that a dual mode dongle in
slave mode is not accepting more than one active connection.

Anyway, I finally found the section from Core Spec v4.0, where it
clearly says that a LE device operating in slave mode does not accept
more than one connection (but a master device can create multiple
connections). See Vol. 6, Part B, Section 1.1.1 "State and Role
Combination Restrictions" (page 2195), specially second bullet. I copy
the relevant text here:

"""
The Link Layer may optionally support multiple state machines. If it
does support multiple state machines, the following state and role
restrictions shall apply.
* The Link Layer in the Connection State shall not operate in the
Master Role and Slave Role at the same time.
* The Link Layer in the Connection State operating in the Slave Role
shall have only one connection.
[...]
"""

That means you can't send connectable advertising from a slave LE
device if one connection is active.

Best regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
