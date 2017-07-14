Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Date: Fri, 14 Jul 2017 16:45:50 +0200
From: Olivier MARTIN <olivier@labapart.com>
To: Jonah Petri <jonah@sense.com>
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Felix Schulthess <felix.schulthess@scs.ch>,
        linux-bluetooth@vger.kernel.org,
        linux-bluetooth-owner@vger.kernel.org
Subject: Re: DBUS API: Retrieve current MTU used by remote device
In-Reply-To: <D40CE853-16BD-4211-9817-D9B036A57E39@sense.com>
References: <0fef8015e74a2a96af45c36e9c67dc36@labapart.com>
 <9c9da882-fd5b-dfa1-447e-a6f05b341f97@scs.ch>
 <a4919190d5de8c7c3d25f1ea81772513@labapart.com>
 <CABBYNZLp-1gxGftHQBT_q5pdrxW_fdBoKYMQSmMOS+bZWwk=NQ@mail.gmail.com>
 <1dd40da57a55b3c36be7c5a52c99bbaf@labapart.com>
 <CABBYNZ+4=VSb9=wjWj+uRYLDYGSWJm7HiNEYjpL+d3B-2O+QyQ@mail.gmail.com>
 <2a737c7472be1df26a5d570f609cf377@labapart.com>
 <CABBYNZ+Y_b+-nm+Msg1nQvCbtqbFXk=BMF4gpYXrzFsPCeQAMA@mail.gmail.com>
 <D40CE853-16BD-4211-9817-D9B036A57E39@sense.com>
Message-ID: <2395c927887f4cc545149253a7828976@labapart.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jonah, Luiz and all,

On 14.07.2017 14:02, Jonah Petri wrote:
>> 
>>> Exposing the ATT MTU through Bluez D-BUS API would solve my issue 
>>> even if it
>>> is a workaround in term of GATT specification. For diagnostic 
>>> purpose, it
>>> might still be helpful to have the MTU exposed in D-BUS API.
>>> I am happy to have a try to add the support for ATT MTU to Bluez 
>>> D-BUS
>>> Device API myself if you think it is feasible and the patches will be
>>> accepted (obviously after being approved on the mailing-list).
>> 
>> It would have the same treatment as AcquireWrite and AcquireNotify so
>> at the start it would probably be marked as experimental. Note that
> 
> I have a patch for this exact need (reading the negotiated MTU), which
> I can submit later today for consideration.

I also started to look at adding this support this morning. But I had to 
interrupt my work. So I will be happy to have a look and review your 
patch as I have a clearer idea of the code now.

Thanks to Luiz and after doing a little break, I realised I need to 
change my application protocol to take advantage of AcquireWrite and 
AcquireNotify.
I am quite convince now I will have a better throughput using these 
methods than using my current application protocol.
