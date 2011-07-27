Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAE-CKujoGHF+8PgnhKZyXdQ1+eVjYzcaFVFsAR+BcnhwBCT2Eg@mail.gmail.com>
References: <1311624955-22360-1-git-send-email-anderson.lizardo@openbossa.org>
	<1311624955-22360-5-git-send-email-anderson.lizardo@openbossa.org>
	<CAE-CKujoGHF+8PgnhKZyXdQ1+eVjYzcaFVFsAR+BcnhwBCT2Eg@mail.gmail.com>
Date: Wed, 27 Jul 2011 08:47:50 -0300
Message-ID: <CAJdJm_NxEwDmpaJ-pwxKpFC-3krjm-T5Wh75petNMjcbg31xQA@mail.gmail.com>
Subject: Re: [PATCH BlueZ 4/5] Register primary service for Immediate Alert
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: mike tsai <mikeyhtsai@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mike,

On Tue, Jul 26, 2011 at 9:08 PM, mike tsai <mikeyhtsai@gmail.com> wrote:
> [MT] a couple things here, first, should the attrib_db_add function
> allow input parameters  "wgardrite_cb" and "read_cb"?

Currently, you can register read/write callbacks by assigning the
return value of attrib_db_add() (struct attribute *) to a variable and
then assigning its ->write_cb and ->read_cb. e.g.

struct attribute *a = attrib_db_add(...);
a->read_cb = <some_function>;
a->write_cb = <another_function>;

But we are designing a new data structure for representing attributes,
which should mainly simplify the way we currently handle Client
Characteristic Configuration on the attribute server, attribute
storage and read/write callbacks. Currently, our database is just a
single GSList of "struct attribute", with no way to represent
relationship between attributes. This "flat" architecture has made
code which handles semantics for client characteristic configuration
too complex.

We should send a proposal (RFC) some point between this and next week.

>        second, should this function register a write_cb for immediate
> alert characteristic? so if the client writes a value to this
> characteristic, the write_cb can be called?  And I think a signal will
> be sent to application that has registered with immediate alert
> service?

In a full Proximity Reporter implementation, yes. But note that this
first version is solely for testing our Proximity Monitor. Those
interested on implementing a full monitor can of course extend/improve
it further :). Patches are welcome.

Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
