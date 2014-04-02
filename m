Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAKT1EBfqP75+XJWkLt2yvkdEBVmNRmFC1_T667LAnuBrNFBxuQ@mail.gmail.com>
References: <CAHrH25QBL52xfM4Qnk=NE1xn3RX2Bwxq_i0osDDCoi4egO2tkg@mail.gmail.com>
	<CAKT1EBfqP75+XJWkLt2yvkdEBVmNRmFC1_T667LAnuBrNFBxuQ@mail.gmail.com>
Date: Wed, 2 Apr 2014 13:58:37 -0700
Message-ID: <CAHrH25TeYWXMxQPqBGd9YnNWw+y5sYT+k4e-88hu_SRtFYWY+g@mail.gmail.com>
Subject: Re: Removing GAttrib.
From: Arman Uguray <armansito@chromium.org>
To: Claudio Takahasi <claudio.takahasi@openbossa.org>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Claudio,

> Remove GAttrib completely from the source will not be easy. You could
> try to restrict the usage of GAttrib to src/gatt.c
> Move discovery to src/gatt.c introduces another problem: probe
> profiles/services, reply properly for Pair() and ConnectProfiles(),
> helpers to access attributes of a given service, ...

My understanding of the ConnectProfile() D-Bus method was that it
pretty much only applies to BR/EDR. Even with GATT over BR/EDR I don't
know if this method makes sense as connecting to a specific remote
profile is not something you would do in LE. You would instead read
several GATT services and interact with all of them based on the
profile you're implementing. Maybe we can add D-Bus methods to
interact with specific GATT service UUIDs in the future but I don't
know if ConnectProfile fits into the overall BLE scheme, though please
correct me if I'm wrong.

As for the reply to pairing, I don't think much would change. The only
reason for moving discovery to src/gatt.c is to restrict usage of
GAttrib to src/gatt.c. In effect, what we would do is add a function,
e.g. btd_gatt_discover_primary, which would be, from the perspective
of src/device.c, a thin wrapper around gatt_discover_primary. Instead
of directly storing a list of gatt_primary, btd_device would now store
a list of btd_attribute (or handle) of its primary services. Initially
we would leave probing the way it is but we would have the profiles
use new functions in src/gatt to access characteristics and
descriptors, instead of using GAttrib directly.

As for the auto-connect case, whether or not we want to re-discover
all GATT services is something that I'm not sure about. We can always
think about this later, though.

> Probably, we will not be able to remote ATTIO immediately. ATTIO
> abstraction will be replaced by mgmt commands proposed by "[RFC] doc:
> Connection Parameters Command". Keep re-connections working with old
> kernels will be tricky.

Probably not. We can, however, try to at least remove the GAttrib
dependency from attio. With new discovery accessors in src/gatt, the
GAttrib pointer in attio_connect_cb would become unnecessary.

> My suggestion is start with small cleanups & improvements, as you
> probably noticed the code related to BLE & GATT is not easy to
> understand.
>
> My understanding was GIOChannel usage is not encouraged anymore, we
> should use "struct io" instead. So, replace GIOChannel  by struct io
> could be a good starting point.
> (please confirm with Johan)

Afaict the primary piece of code concerning attribute discovery that
uses GIOChannel consists of the bt_io functions in btio/btio.*. If
Johan agrees, we could start by replacing GIOChannel with struct io in
btio/btio. Once we do this, we would make GAttrib use struct io
instead of GIOChannel as the initial step of the refactor. Let me know
if this is a good approach.

-Arman
