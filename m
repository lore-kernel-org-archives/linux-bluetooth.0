Return-Path: <cyrus@holtmann.org>
Message-ID: <4D66A620.3040000@codeaurora.org>
Date: Thu, 24 Feb 2011 10:40:32 -0800
From: Brian Gix <bgix@codeaurora.org>
MIME-Version: 1.0
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
CC: Claudio Takahasi <claudio.takahasi@openbossa.org>,
	BlueZ development <linux-bluetooth@vger.kernel.org>
Subject: Re: "Conditional jump or move" errors on attrib_create_sdp()
References: <AANLkTimZKv2D3BZy+QWiutokQUGrnBWWT_uHQ0Lp06n8@mail.gmail.com>
In-Reply-To: <AANLkTimZKv2D3BZy+QWiutokQUGrnBWWT_uHQ0Lp06n8@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lizardo,

On 2/24/2011 9:56 AM, Anderson Lizardo wrote:
> Hi Brian,
>
> I just noticed "Conditional jump or move depends on uninitialised
> value(s)" errors when running bluez with valgrind:
>
> ==690== Conditional jump or move depends on uninitialised value(s)
> ==690==    at 0x4837EA0: sdp_set_service_id (sdp.c:2456)
> ==690==    by 0x166F79: attrib_create_sdp (attrib-server.c:133)
> ==690==    by 0x167436: register_core_services (attrib-server.c:856)
> ==690==    by 0x1675E3: attrib_server_init (attrib-server.c:902)
> ==690==    by 0x162424: main (main.c:462)
>
> Full log is attached, it was generated with:
>
> env G_SLICE=always-malloc valgrind bluetoothd -n -d
>
> Can you take a look at this? Thanks,


This can be fixed in one of about 3 ways:
1. Eliminate the call to sdp_set_service_id all together (it's not 
required by the specification)

2. Set the service ID to services UUID (doesn't service a useful purpose)

3. Let the profile deal with the SDP service ID. (same as 1 for now)

The offending code attempts to give the SDP record a "Service ID" which 
is not required by the specification, but is useful if there is more 
than one instance of the service being declared in SDP.

An example of this in the case of GATT might be Two Primary Battery 
meter services, where both would have the same service UUID, but one 
would be referring to a "Main" battery, and the other an "Aux" battery.

In LE mode, the Service ID is unavailable and would be superfluous 
because everything you need to know about the service can be determined 
from the other Attributes. Therefore, I think the argument can be made 
that specific instance information is equally superflous, and should not 
be included in the service record.

If there are no objections, I am just going to eliminate the call to 
sdp_set_service_id in the attribute server all together.


-- 
Brian Gix
bgix@codeaurora.org
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum
