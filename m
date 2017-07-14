Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: DBUS API: Retrieve current MTU used by remote device
From: Jonah Petri <jonah@sense.com>
In-Reply-To: <CABBYNZ+Y_b+-nm+Msg1nQvCbtqbFXk=BMF4gpYXrzFsPCeQAMA@mail.gmail.com>
Date: Fri, 14 Jul 2017 08:02:22 -0400
Cc: Olivier MARTIN <olivier@labapart.com>,
        Felix Schulthess <felix.schulthess@scs.ch>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Message-Id: <D40CE853-16BD-4211-9817-D9B036A57E39@sense.com>
References: <0fef8015e74a2a96af45c36e9c67dc36@labapart.com>
 <9c9da882-fd5b-dfa1-447e-a6f05b341f97@scs.ch>
 <a4919190d5de8c7c3d25f1ea81772513@labapart.com>
 <CABBYNZLp-1gxGftHQBT_q5pdrxW_fdBoKYMQSmMOS+bZWwk=NQ@mail.gmail.com>
 <1dd40da57a55b3c36be7c5a52c99bbaf@labapart.com>
 <CABBYNZ+4=VSb9=wjWj+uRYLDYGSWJm7HiNEYjpL+d3B-2O+QyQ@mail.gmail.com>
 <2a737c7472be1df26a5d570f609cf377@labapart.com>
 <CABBYNZ+Y_b+-nm+Msg1nQvCbtqbFXk=BMF4gpYXrzFsPCeQAMA@mail.gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


>=20
>> Exposing the ATT MTU through Bluez D-BUS API would solve my issue =
even if it
>> is a workaround in term of GATT specification. For diagnostic =
purpose, it
>> might still be helpful to have the MTU exposed in D-BUS API.
>> I am happy to have a try to add the support for ATT MTU to Bluez =
D-BUS
>> Device API myself if you think it is feasible and the patches will be
>> accepted (obviously after being approved on the mailing-list).
>=20
> It would have the same treatment as AcquireWrite and AcquireNotify so
> at the start it would probably be marked as experimental. Note that

I have a patch for this exact need (reading the negotiated MTU), which I =
can submit later today for consideration.

Jonah=
