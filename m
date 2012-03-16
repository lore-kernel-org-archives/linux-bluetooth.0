Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <F82830D409D80E4881C83250E051B74B4A07AD30@banasiexm01.ASIA.ROOT.PRI>
References: <F0070FBC0FB3174D8D11444EB2D5B0260B44D1AB@DNCE02.ent.ti.com>
	<CAKT1EBcVv1ya0ArmgwNh968O9QSsQD6oNy1poJDeNgg_V=iuog@mail.gmail.com>
	<F0070FBC0FB3174D8D11444EB2D5B0260B44D4A1@DNCE02.ent.ti.com>
	<F82830D409D80E4881C83250E051B74B4A079B44@banasiexm01.ASIA.ROOT.PRI>
	<F82830D409D80E4881C83250E051B74B4A079C84@banasiexm01.ASIA.ROOT.PRI>
	<F82830D409D80E4881C83250E051B74B4A079CA2@banasiexm01.ASIA.ROOT.PRI>
	<CACJA=fWYJrSaqq4b5CmuRT2gX6kH9spxE7kBn0uzPdpHmQHDiQ@mail.gmail.com>
	<F82830D409D80E4881C83250E051B74B4A07AB92@banasiexm01.ASIA.ROOT.PRI>
	<CAAngNMbbMN9nY2+c2m-Ad-ORkDQkrCEuB_+VQvDBEkKb0ga3VQ@mail.gmail.com>
	<F82830D409D80E4881C83250E051B74B4A07AD30@banasiexm01.ASIA.ROOT.PRI>
Date: Fri, 16 Mar 2012 10:56:47 -0300
Message-ID: <CAKT1EBeh3UruCytRmoqv31g3RZVNKScECLt0u02qmM=YTHfmeg@mail.gmail.com>
Subject: Re: HID Over GATT implementation
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: Vijaykumar Dadmode <Vijaykumar.Dadmode@csr.com>
Cc: Joao Paulo Rechi Vita <jprvita@openbossa.org>,
	Andre Guedes <andre.guedes@openbossa.org>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	"Ganir, Chen" <chen.ganir@ti.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Vijay,

On Fri, Mar 16, 2012 at 3:44 AM, Vijaykumar Dadmode
<Vijaykumar.Dadmode@csr.com> wrote:
> Hi,
>
>>>>> <Vijaykumar.Dadmode@csr.com> wrote:
>>> > Hi Andre,
>>> >
>>> >>> Hi Vijay,
>>
>>>> Is this implementation public anywhere?
>>>
>>> No its not!
>>>
>
>>> Are you planning to make it public, or is it just an internal
>>> prototype or something like this?
>
> It was a internal prototype, yes I can submit the code if the design is approved.

There is a thread in the linux-input ML discussing how to provide HID
low level driver from the userspace. Subject is "User space raw hid
support".
The architecture that you are proposing is not aligned with it.

It is possible to continue the userspace development using gadget hid
(with some hacks) while the HoG/HID kernel is being defined.
We did experiments using real BLE keyboards. Let me know if you need
instructions to test it.

BR,
Claudio.
