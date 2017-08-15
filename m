Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Subject: Re: [PATCH v2] gdbus: Fix calling GetAll while GetManagedObject is
 pending
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Vinicius Costa Gomes <vinicius.gomes@intel.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
References: <20170814104602.32013-1-luiz.dentz@gmail.com>
 <87pobydq7u.fsf@intel.com>
 <CABBYNZJuvuR4zoODr=mHNg6DL_Wx92560g6CWGLHmpr92PQfyg@mail.gmail.com>
From: Kai Ruhnau <kai.ruhnau@target-sg.com>
Message-ID: <97ea0879-d151-b1e1-6071-7968b4a106de@target-sg.com>
Date: Tue, 15 Aug 2017 16:08:54 +0200
MIME-Version: 1.0
In-Reply-To: <CABBYNZJuvuR4zoODr=mHNg6DL_Wx92560g6CWGLHmpr92PQfyg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On 15.08.2017 10:22, Luiz Augusto von Dentz wrote:
> Hi,
>
> On Mon, Aug 14, 2017 at 8:16 PM, Vinicius Costa Gomes
> <vinicius.gomes@intel.com> wrote:
>> Hi Luiz,
>>
>> Luiz Augusto von Dentz <luiz.dentz@gmail.com> writes:
>>
>>> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>>>
>>> If proxies are created while the client is not ready put them into a
>>> pending list so only if they are not found in GetManagedObject reply
>>> call GetAll.
>>> ---
>>>   gdbus/client.c | 96 ++++++++++++++++++++++++++++++++++++-------------=
---------
>>>   1 file changed, 59 insertions(+), 37 deletions(-)
>>>
>> [...]
>>
>>
>>>        proxy =3D proxy_new(client, path, interface);
>>>        if (proxy =3D=3D NULL)
>>>                return NULL;
>>>
>> Just that nitpick, looking good.
> Applied.
>

Yay! I've applied the patch against 5.43 and don't get the SIGSEGV anymore.

Thanks and cheers,
Kai
--
Kai Ruhnau
Software Manager
T:+49 202 769302 19

Target Systemelektronik GmbH & Co. KG
Heinz-Fangman-Stra=C3=9Fe 4
42287 Wuppertal

Amtsgericht Wuppertal HRA 23898
Pers=C3=B6nlich haftende Gesellschafterin
Target Systemelektronik Beteiligungs GmbH
Heinz-Fangman-Stra=C3=9Fe 4, 42287 Wuppertal
Amtsgericht Wuppertal HRB 25346
Gesch=C3=A4ftsf=C3=BChrer: J=C3=BCrgen Stein
--
