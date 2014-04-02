Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAHrH25QBL52xfM4Qnk=NE1xn3RX2Bwxq_i0osDDCoi4egO2tkg@mail.gmail.com>
References: <CAHrH25QBL52xfM4Qnk=NE1xn3RX2Bwxq_i0osDDCoi4egO2tkg@mail.gmail.com>
Date: Wed, 2 Apr 2014 16:43:21 -0300
Message-ID: <CAKT1EBfqP75+XJWkLt2yvkdEBVmNRmFC1_T667LAnuBrNFBxuQ@mail.gmail.com>
Subject: Re: Removing GAttrib.
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: Arman Uguray <armansito@chromium.org>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Arman:

On Thu, Mar 20, 2014 at 7:13 PM, Arman Uguray <armansito@chromium.org> wrote:
> Hi all,
>
> I've been working on adding the client-side GATT API to BlueZ
> src/gatt. It occurred to me (both as I delved into the code and after
> discussions with Claudio Takahasi) that combining the "struct io"
> based abstraction used by the new btd_attribute and the current
> connection management that depends on GAttrib gets a bit messy. For
> client mode alone, handling both incoming connections from a remote
> device, and issuing outgoing read/write and primary/characteristic
> discovery requests CAN be done with GAttrib, but the btd_attribute
> abstraction appears to be cleaner I would prefer to keep the client
> and server mode implementations consistent.
>
> To that end, I'd like to figure out what's the best way to approach
> this. Clearly, the GAttrib dependency runs deep: the API provided in
> attrib/gatt.h uses GAttrib and is used by src/device.c and pretty much
> all the GATT based profile implementations. The profiles seem to use
> the callback interface defined in src/attio.h which is how src/device
> allows the profiles to access it's internal GAttrib instance.
> attrib/gatt.h is also currently used by gatttool.

Remove GAttrib completely from the source will not be easy. You could
try to restrict the usage of GAttrib to src/gatt.c
Move discovery to src/gatt.c introduces another problem: probe
profiles/services, reply properly for Pair() and ConnectProfiles(),
helpers to access attributes of a given service, ...

Probably, we will not be able to remote ATTIO immediately. ATTIO
abstraction will be replaced by mgmt commands proposed by "[RFC] doc:
Connection Parameters Command". Keep re-connections working with old
kernels will be tricky.

>
> Anderson Lizardo and I had some discussions about this and he
> mentioned that one of the earlier ideas was to simply replace GAttrib
> with struct io. Another thing that he mentioned is to keep the code in
> src/gatt restricted to handling client and server side read/write
> requests (i.e. attribute access abstraction) and put no discovery
> related logic there.
>
> So my question is, how do we want to do this refactor? Do we basically
> want to have all references to GAttrib replaced with struct io,
> keeping the API in attrib/gatt and the callbacks in src/attio the same
> but using struct io instead of GAttrib? Or do we want a more revised
> API?

My suggestion is start with small cleanups & improvements, as you
probably noticed the code related to BLE & GATT is not easy to
understand.

My understanding was GIOChannel usage is not encouraged anymore, we
should use "struct io" instead. So, replace GIOChannel  by struct io
could be a good starting point.
(please confirm with Johan)

Regards,
Claudio
