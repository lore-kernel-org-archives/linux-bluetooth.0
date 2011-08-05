Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CACbkbUL-mP0iKtF2Z3fuUgF8bBfENHNOP7Dbj=KO=ZYTerao0g@mail.gmail.com>
References: <CACbkbULaTeWVtcpFxhUMRMO-r+QuKU8NkX7o5nQBXHKApJbqgQ@mail.gmail.com>
	<CAJdJm_N+vAPjAmTFLLH-p_iaiPjWF3aV-TAsUn6m8Vnbtfv1=w@mail.gmail.com>
	<CACbkbUL-mP0iKtF2Z3fuUgF8bBfENHNOP7Dbj=KO=ZYTerao0g@mail.gmail.com>
Date: Fri, 5 Aug 2011 07:10:38 -0400
Message-ID: <CAJdJm_NAabSBh75cvHHgyRSRirO6r5MQggPLLtCcC84SVRNqaA@mail.gmail.com>
Subject: Re: Security level for Primary Services discovery during pairing
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: VISHWANATH KM <a21174@motorola.com>
Cc: linux-bluetooth <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Fri, Aug 5, 2011 at 5:21 AM, VISHWANATH KM <a21174@motorola.com> wrote:
> As you mentioned in case if we don't want to trigger SMP we should use
> CreateDevice, but how do we know before calling CreateDevice or
> CreatePairedDevice if remote supports SMP or not. Does bluez exposes this
> info to app. We can use LE_Read_Remote_Used_Features only after LE ACL is
> established and that is done as part of either CreateDevice or
> CreatePairedDevice (bt_io_connect). Please clarify. thx

Now I understand your issue.

Currently, BlueZ (and kernel) does not support the "Features Exchange"
procedure described on message chart from Vol. 6 Part D Section 6.5
(page 2276). Actually, I could not find any other part of the Core 4.0
spec pointing to this procedure. Do you know where it is used, how it
is triggered and whether it is mandatory?

I think you have two options:

1) Always use CreateDevice(). Then if you want to issue SMP pairing,
you can change the BT_IO_SECLEVEL when connection with bt_io_connect()
(I haven't tested this lately, but I remember it used to work).

2) Extend the kernel Management API to allow Features Exchange. See
doc/mgmt-api.txt for the existing commands, to have an idea on how it
works (I recommend first sending an API proposal here to the list).

Also note that *all* currently adopted LE profiles (Find Me, Heart
Rate, Health Thermometer, Proximity) require that both sides
(initiator and acceptor) support Security Mode 1, Levels 2 or 3 (i.e.
SMP pairing is mandatory for them). So, if you are working with a
custom profile, you may need to implement the missing bits.

I would also like to hear from other BlueZ developers :). Any other ideas?

Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
