Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1298068173-16518-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1298068173-16518-1-git-send-email-claudio.takahasi@openbossa.org>
Date: Sat, 19 Feb 2011 20:07:38 +0200
Message-ID: <AANLkTinzZ+nNSx6qq0xMXO8ZVLt5r-r0pgcjRBa7MaxY@mail.gmail.com>
Subject: Re: [RFC v2 00/14] Store UUID-128 on host order
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Claudio Takahasi <claudio.takahasi@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Claudio,

On Sat, Feb 19, 2011 at 12:29 AM, Claudio Takahasi
<claudio.takahasi@openbossa.org> wrote:
> It must NOT be included in the next release until proper testing.
>
> Any good soul wants to test it if I am not breaking SDP?
>
> The following patches convert the internal UUID128 values representation
> to host order. Currently, SDP functions use host order to store UUID-16
> /UUID32 and network order to store UUID-128 values. The reason is to
> keep the consistency and re-use the UUID functions for ATT protocol
> which uses little endian.
>
> Changes from the first RFC:
>  - Changes sdptool
>  - Changes SDP XML parsing function
>  - Changes attribute example
>
> Claudio Takahasi (14):
>  Move 64 and 128 bits byte order functions to bluetooth.h
>  Use host byte order when converting UUID16/32 to UUID128
>  Add att_get_u128
>  Convert UUID128 value to host order when extracting SDP data
>  Convert to network order before use it on sdp_uuid128_to_uuid
>  Convert from host to network order before to print UUID128 values
>  Convert from network to host order on bt_string2uuid function
>  Change UUID128 host order on SDP PDU generation function
>  Replace UUID128 values from char array to uint128_t on sdptool
>  Create UUID128 on host order on sdptool
>  Change SDP XML parser to create UUID128 values on host order
>  Convert from little endian to host order when parsing EIR data
>  Add att_put_u128
>  Change Attribute example to create UUID128 on host order
>
>  attrib/att.c         |   16 ++++--
>  attrib/att.h         |   17 ++++++
>  attrib/example.c     |   24 +++++---
>  attrib/gatt.c        |   14 +++--
>  attrib/gatttool.c    |    6 ++-
>  attrib/interactive.c |    1 +
>  health/hdp_manager.c |    1 +
>  health/mcap_sync.c   |   17 ------
>  lib/bluetooth.h      |   41 ++++++++++++++
>  lib/sdp.c            |  108 ++++++++++++++-----------------------
>  lib/sdp.h            |    4 --
>  src/event.c          |    6 +--
>  src/glib-helper.c    |   31 ++++++-----
>  src/sdp-xml.c        |   74 +++++++++++--------------
>  test/hciemu.c        |   16 ------
>  tools/sdptool.c      |  145 ++++++++++++++++++++++++++++++-------------------
>  16 files changed, 280 insertions(+), 241 deletions(-)
>
> --
> 1.7.4.1

IMO it would be easier to have specific functions for uuid128 that can
take data in host order, so that we don't break existing API. Note
that the internal representation could be changed to host order, that
is fine, but then you convert the existing function to do the
conversion internally without breaking compatibility.

-- 
Luiz Augusto von Dentz
Computer Engineer
