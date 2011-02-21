Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <AANLkTinzZ+nNSx6qq0xMXO8ZVLt5r-r0pgcjRBa7MaxY@mail.gmail.com>
References: <1298068173-16518-1-git-send-email-claudio.takahasi@openbossa.org>
	<AANLkTinzZ+nNSx6qq0xMXO8ZVLt5r-r0pgcjRBa7MaxY@mail.gmail.com>
Date: Mon, 21 Feb 2011 13:14:46 +0000
Message-ID: <AANLkTimjYJTVq5dgmisV8c74rZAvpmpHL=g78feOG-_T@mail.gmail.com>
Subject: Re: [RFC v2 00/14] Store UUID-128 on host order
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, Johan Hedberg <johan.hedberg@gmail.com>,
	Marcel Holtmann <marcel@holtmann.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Sat, Feb 19, 2011 at 6:07 PM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> Hi Claudio,
>
> On Sat, Feb 19, 2011 at 12:29 AM, Claudio Takahasi
> <claudio.takahasi@openbossa.org> wrote:
>> It must NOT be included in the next release until proper testing.
>>
>> Any good soul wants to test it if I am not breaking SDP?
>>
>> The following patches convert the internal UUID128 values representation
>> to host order. Currently, SDP functions use host order to store UUID-16
>> /UUID32 and network order to store UUID-128 values. The reason is to
>> keep the consistency and re-use the UUID functions for ATT protocol
>> which uses little endian.
>>
>> Changes from the first RFC:
>> =C2=A0- Changes sdptool
>> =C2=A0- Changes SDP XML parsing function
>> =C2=A0- Changes attribute example
>>
>> Claudio Takahasi (14):
>> =C2=A0Move 64 and 128 bits byte order functions to bluetooth.h
>> =C2=A0Use host byte order when converting UUID16/32 to UUID128
>> =C2=A0Add att_get_u128
>> =C2=A0Convert UUID128 value to host order when extracting SDP data
>> =C2=A0Convert to network order before use it on sdp_uuid128_to_uuid
>> =C2=A0Convert from host to network order before to print UUID128 values
>> =C2=A0Convert from network to host order on bt_string2uuid function
>> =C2=A0Change UUID128 host order on SDP PDU generation function
>> =C2=A0Replace UUID128 values from char array to uint128_t on sdptool
>> =C2=A0Create UUID128 on host order on sdptool
>> =C2=A0Change SDP XML parser to create UUID128 values on host order
>> =C2=A0Convert from little endian to host order when parsing EIR data
>> =C2=A0Add att_put_u128
>> =C2=A0Change Attribute example to create UUID128 on host order
>>
>> =C2=A0attrib/att.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 | =C2=A0 16 ++++--
>> =C2=A0attrib/att.h =C2=A0 =C2=A0 =C2=A0 =C2=A0 | =C2=A0 17 ++++++
>> =C2=A0attrib/example.c =C2=A0 =C2=A0 | =C2=A0 24 +++++---
>> =C2=A0attrib/gatt.c =C2=A0 =C2=A0 =C2=A0 =C2=A0| =C2=A0 14 +++--
>> =C2=A0attrib/gatttool.c =C2=A0 =C2=A0| =C2=A0 =C2=A06 ++-
>> =C2=A0attrib/interactive.c | =C2=A0 =C2=A01 +
>> =C2=A0health/hdp_manager.c | =C2=A0 =C2=A01 +
>> =C2=A0health/mcap_sync.c =C2=A0 | =C2=A0 17 ------
>> =C2=A0lib/bluetooth.h =C2=A0 =C2=A0 =C2=A0| =C2=A0 41 ++++++++++++++
>> =C2=A0lib/sdp.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| =C2=A0108 +++=
+++++++++++-----------------------
>> =C2=A0lib/sdp.h =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| =C2=A0 =C2=A0=
4 --
>> =C2=A0src/event.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| =C2=A0 =C2=A06 +--
>> =C2=A0src/glib-helper.c =C2=A0 =C2=A0| =C2=A0 31 ++++++-----
>> =C2=A0src/sdp-xml.c =C2=A0 =C2=A0 =C2=A0 =C2=A0| =C2=A0 74 +++++++++++--=
------------
>> =C2=A0test/hciemu.c =C2=A0 =C2=A0 =C2=A0 =C2=A0| =C2=A0 16 ------
>> =C2=A0tools/sdptool.c =C2=A0 =C2=A0 =C2=A0| =C2=A0145 ++++++++++++++++++=
++++++++++++-------------------
>> =C2=A016 files changed, 280 insertions(+), 241 deletions(-)
>>
>> --
>> 1.7.4.1
>
> IMO it would be easier to have specific functions for uuid128 that can
> take data in host order, so that we don't break existing API. Note
> that the internal representation could be changed to host order, that
> is fine, but then you convert the existing function to do the
> conversion internally without breaking compatibility.
>
> --
> Luiz Augusto von Dentz
> Computer Engineer
>

Yes, it is easier. It will be necessary to add a function to convert
from little endian to big endian for ATT when the data is received.
I am not changing the API, it changes only the internal
representation(to host order) of the UUID128 values.


We got "blessing" from Marcel to proceed with this change, but I can
implement the easier solution ;-)

Marcel/Johan: comments?

BR,
Claudio
