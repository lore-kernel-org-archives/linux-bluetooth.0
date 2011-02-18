Return-Path: <cyrus@holtmann.org>
Subject: Re: [RFC v2 00/14] Store UUID-128 on host order
Mime-Version: 1.0 (Apple Message framework v1082)
Content-Type: text/plain; charset=us-ascii
From: =?iso-8859-1?Q?Elvis_Pf=FCtzenreuter?= <epx@signove.com>
In-Reply-To: <1298068173-16518-1-git-send-email-claudio.takahasi@openbossa.org>
Date: Fri, 18 Feb 2011 21:51:51 -0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <52607D7B-2C13-414B-877E-158898E37F69@signove.com>
References: <1298068173-16518-1-git-send-email-claudio.takahasi@openbossa.org>
To: Claudio Takahasi <claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


On Feb 18, 2011, at 8:29 PM, Claudio Takahasi wrote:

> It must NOT be included in the next release until proper testing.
> 
> Any good soul wants to test it if I am not breaking SDP?

I volunteer for that if you give me some time.

> 
> The following patches convert the internal UUID128 values representation
> to host order. Currently, SDP functions use host order to store UUID-16
> /UUID32 and network order to store UUID-128 values. The reason is to
> keep the consistency and re-use the UUID functions for ATT protocol
> which uses little endian.
> 
> Changes from the first RFC:
> - Changes sdptool
> - Changes SDP XML parsing function
> - Changes attribute example
> 
> Claudio Takahasi (14):
>  Move 64 and 128 bits byte order functions to bluetooth.h
>  Use host byte order when converting UUID16/32 to UUID128
>  Add att_get_u128
>  Convert UUID128 value to host order when extracting SDP data
>  Convert to network order before use it on sdp_uuid128_to_uuid
>  Convert from host to network order before to print UUID128 values
>  Convert from network to host order on bt_string2uuid function
>  Change UUID128 host order on SDP PDU generation function
>  Replace UUID128 values from char array to uint128_t on sdptool
>  Create UUID128 on host order on sdptool
>  Change SDP XML parser to create UUID128 values on host order
>  Convert from little endian to host order when parsing EIR data
>  Add att_put_u128
>  Change Attribute example to create UUID128 on host order
> 
> attrib/att.c         |   16 ++++--
> attrib/att.h         |   17 ++++++
> attrib/example.c     |   24 +++++---
> attrib/gatt.c        |   14 +++--
> attrib/gatttool.c    |    6 ++-
> attrib/interactive.c |    1 +
> health/hdp_manager.c |    1 +
> health/mcap_sync.c   |   17 ------
> lib/bluetooth.h      |   41 ++++++++++++++
> lib/sdp.c            |  108 ++++++++++++++-----------------------
> lib/sdp.h            |    4 --
> src/event.c          |    6 +--
> src/glib-helper.c    |   31 ++++++-----
> src/sdp-xml.c        |   74 +++++++++++--------------
> test/hciemu.c        |   16 ------
> tools/sdptool.c      |  145 ++++++++++++++++++++++++++++++-------------------
> 16 files changed, 280 insertions(+), 241 deletions(-)
> 
> -- 
> 1.7.4.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

