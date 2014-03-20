Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Thu, 20 Mar 2014 15:13:55 -0700
Message-ID: <CAHrH25QBL52xfM4Qnk=NE1xn3RX2Bwxq_i0osDDCoi4egO2tkg@mail.gmail.com>
Subject: Removing GAttrib.
From: Arman Uguray <armansito@chromium.org>
To: BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi all,

I've been working on adding the client-side GATT API to BlueZ
src/gatt. It occurred to me (both as I delved into the code and after
discussions with Claudio Takahasi) that combining the "struct io"
based abstraction used by the new btd_attribute and the current
connection management that depends on GAttrib gets a bit messy. For
client mode alone, handling both incoming connections from a remote
device, and issuing outgoing read/write and primary/characteristic
discovery requests CAN be done with GAttrib, but the btd_attribute
abstraction appears to be cleaner I would prefer to keep the client
and server mode implementations consistent.

To that end, I'd like to figure out what's the best way to approach
this. Clearly, the GAttrib dependency runs deep: the API provided in
attrib/gatt.h uses GAttrib and is used by src/device.c and pretty much
all the GATT based profile implementations. The profiles seem to use
the callback interface defined in src/attio.h which is how src/device
allows the profiles to access it's internal GAttrib instance.
attrib/gatt.h is also currently used by gatttool.

Anderson Lizardo and I had some discussions about this and he
mentioned that one of the earlier ideas was to simply replace GAttrib
with struct io. Another thing that he mentioned is to keep the code in
src/gatt restricted to handling client and server side read/write
requests (i.e. attribute access abstraction) and put no discovery
related logic there.

So my question is, how do we want to do this refactor? Do we basically
want to have all references to GAttrib replaced with struct io,
keeping the API in attrib/gatt and the callbacks in src/attio the same
but using struct io instead of GAttrib? Or do we want a more revised
API?

Any input/suggestion will be appreciated. Once we know what exactly it
is that we want with this code, we can come up with a plan to
deprecate GAttrib.

Thanks!
Arman
