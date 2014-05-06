Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CABBYNZLuRf89qgE6vV5PWZFZcB4em11_ySJnUXMGb+gSQ1djkw@mail.gmail.com>
References: <1399351563-25991-1-git-send-email-armansito@chromium.org>
	<CABBYNZLuRf89qgE6vV5PWZFZcB4em11_ySJnUXMGb+gSQ1djkw@mail.gmail.com>
Date: Tue, 6 May 2014 15:03:10 +0300
Message-ID: <CABBYNZ+82Kar9c-9mj2DSVM4MbrHDFMHhzhsTX65GYHEtZGCTg@mail.gmail.com>
Subject: Re: [PATCH 00/10] bt_att initial implementation
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Arman Uguray <armansito@chromium.org>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Arman,

On Tue, May 6, 2014 at 11:29 AM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> Hi Arman,
>
> On Tue, May 6, 2014 at 7:45 AM, Arman Uguray <armansito@chromium.org> wrote:
>> This patch set introduces "struct bt_att" which handles the transport logic for
>> interactions over the Attribute Protocol. struct bt_att is meant to be
>> connection-agnostic: It enables a new GATT/ATT stack based around src/shared/io,
>> so that the library internals of how the connection is managed (glib vs
>> mainloop) is not tied to the protocol implementation. bt_att will initially
>> support the client-side protocol and eventually extended to support the server
>> side.
>>
>> Major changes introduced in this patch-set:
>>   - src/shared/att.[h,cc], which introduces "struct bt_att", with initial
>>     support for client-initiated requests and asynchronous response handling via
>>     a callback.
>>   - unit/test-att, which defines unit tests for request/response using a
>>     socketpair.
>>   - tools/btatt, which is a command-line tool for debugging the Attribute
>>     Protocol.
>>
>> The majority of the above are introduced in patches 1 through 3, which consist
>> almost entirely of boilerplate taken from src/shared/mgmt.*, unit/test-mgmt, and
>> tools/btmgmt.c.
>>
>> The 9 patches introduced here are the initial portion of 20+ patches where each
>> ATT operation is implemented in groups of 3 patches:
>>   - 1 patch that implements the request/response or command in src/shared/att
>>   - 1 patch that adds a unit test to unit/test-att
>>   - 1 patch that adds a command for the request to tools/btatt
>>
>> Arman Uguray (10):
>>   src/shared/att: Introduce struct bt_att.
>>   unit/test-att: Add unit tests for src/shared/att.
>>   tools/btatt: Add command-line tool for ATT protocol testing.
>>   tools/btatt: Add "exchange-mtu" command.
>>   src/shared/att: Add "Find Information" request and response.
>>   unit/test-att: Add unit test for "Find Information" request/response.
>>   tools/btatt: Add "find-information" command.
>>   src/shared/att: Add "Find By Type Value" request and response.
>>   unit/test-att: Add unit test for "Find By Type Value"
>>     request/response.
>>   tools/btatt: Add "find-by-type-value" command.
>>
>>  Makefile.am      |  12 +-
>>  Makefile.tools   |  10 +-
>>  src/shared/att.c | 689 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
>>  src/shared/att.h | 124 ++++++++++
>>  tools/btatt.c    | 626 ++++++++++++++++++++++++++++++++++++++++++++++++++
>>  unit/test-att.c  | 473 ++++++++++++++++++++++++++++++++++++++
>>  6 files changed, 1932 insertions(+), 2 deletions(-)
>>  create mode 100644 src/shared/att.c
>>  create mode 100644 src/shared/att.h
>>  create mode 100644 tools/btatt.c
>>  create mode 100644 unit/test-att.c
>>
>> --
>> 1.9.1.423.g4596e3a
>
> Apparently you have ignored my comments regarding the API, it is
> probably not the best thing to base everything on mgmt API since that
> is a internal protocol which does not need encoding as everything is
> passed in host order, also unlike mgmt you have GATT on top o ATT so
> it is beneficial to use iovec in the API.

So I had a little chat offline with Johan regarding this and perhaps
you don't really need to introduce iovec into the API since GATT/ATT
framing is quite simple, so please ignore this comment.

> Regarding unit tests, I think you should take a look at test-av*, and
> there exists a test specification for ATT/GATT so we should start with
> it since is what PTS uses for qualification:
> https://www.bluetooth.org/docman/handlers/downloaddoc.ashx?doc_id=229871
>
> You can use the name and description of the unit test following the
> test specification:
>
> /TP/GAC/CL/BV-01-C: Verify that a Generic Attribute Profile client can
> generate an Exchange MTU Request command  to configure ATT_MTU over
> LE.

This is still relevant and perhaps it should involve testing gatt-db
as well since the testing spec also involves the server, which leads
to the question if we should keep them apart? I guess this should be
done in a single place since we will be controlling the fd, or the
idea is that bt_att should access gatt_db internally to handle
incoming requests?



-- 
Luiz Augusto von Dentz
