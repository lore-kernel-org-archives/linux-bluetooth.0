Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <F82830D409D80E4881C83250E051B74B47842A44@banasiexm01.ASIA.ROOT.PRI>
References: <F82830D409D80E4881C83250E051B74B47842A44@banasiexm01.ASIA.ROOT.PRI>
Date: Tue, 30 Aug 2011 09:14:15 -0300
Message-ID: <CAKT1EBcHZnwwhBO8RgjQEjyt4DSMCEZ7JWPf+B-Abf+05XsvCg@mail.gmail.com>
Subject: Re: GATT Dbus APIs Use.
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: Vijaykumar Dadmode <Vijaykumar.Dadmode@csr.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Vijay,

On Mon, Aug 29, 2011 at 10:29 AM, Vijaykumar Dadmode
<Vijaykumar.Dadmode@csr.com> wrote:
> Hi,
> Could you please let me know if there are any modules which makes use of the GATT Client Dbus APIs as mentioned in /doc/attribute-api.txt.
>
> I am happy to have some code references for the same.
>
> Thanks,
> Vijay

First of all you will need a kernel with SM and Interleaved discovery
patches. I sent an e-mail some weeks ago with repository references
and development status, search for "Re: Current status on BLE
development
" in the ML.

Generic API(attribute-api.txt) is working, use d-feet or test-attrib
to test the attribute API. BLE and BR/EDR use the same methods to
discover and "create" devices, call StartDiscovery() followed by
CreateDevice() or CreatePairedDevice() to "create" the device "object"
that you wanna read attributes.

Generic API needs some extra effort to fix some known issues, but in
general is functional. Let me know if you wanna test(force) over
BR/EDR, I have a small patch that allows it.

BR,
Claudio
