Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20110311212758.GA8147@jh-x301>
References: <1299829612-3704-1-git-send-email-lkslawek@gmail.com>
	<1299829612-3704-4-git-send-email-lkslawek@gmail.com>
	<20110311111313.GA20128@jh-x301>
	<AANLkTikJaxmK3pjyptv0xSfb10ivFSu49GdGRTJrXdhP@mail.gmail.com>
	<20110311144855.GA23826@jh-x301>
	<20110311212758.GA8147@jh-x301>
Date: Mon, 14 Mar 2011 15:27:21 +0100
Message-ID: <AANLkTikTfnHGqmbG1_8kfsbzpBOHuYB51TghF-5QoEe0@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] Add detection of MAP function in OBEX requests
From: Slawomir Bochenski <lkslawek@gmail.com>
To: Slawomir Bochenski <lkslawek@gmail.com>,
	linux-bluetooth@vger.kernel.org
Cc: Johan Hedberg <johan.hedberg@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

I will start with some introduction.

*** How MAP obexd plugin works? ***

Service driver and MIME driver are split between mas.c and messages-*.c.
mas.c makes the actual obexd plugin, i.e. there are OBEX_PLUGIN_DEFINE,
obex_service_driver and obex_mime_type_driver there.

In order to support different message storages the actual data accessing
is done in messages-*.c files (a symbolic link messages.c to one of them
is made during ./configure phase, as it is also done in PBAP plugin). I
will refer to this one as "backend".

There is only one mime driver here, as OBEX request type and OBEX type
header is used in MAP merely to select operation to perform. This
operation in MAP specification is called function. Processing of the
incoming headers and response is done in the same fashion for each one of
them, thus one driver handling all requests to MAP target is enough.

Backend in many ways resembles service plugin/mime type driver pair.

So there are messages_init() and messages_exit() to give backend the
chance to do its own initialization during MAP startup. Converting it to
plugin on its own wouldn't make much sense, as it is fully functional
only in context of MAP plugin (i.e. mas.c). Calling messages_init()
manually from MAP plugin init() function also allows MAP plugin to stop
from loading if the messages backend is non-functional.

There is also messages_connect() and messages_disconnect() which are
called from service driver ->connect() and ->disconnect() respectively.
Session awareness is needed for doing connection-specific processing, for
example storing (un)read status per client (which is required by MAP
specification). The message_connect() call returns pointer which is in
turn passed to all other in-session functions of backend.

The low-level processing which would be the same regardless of storage in
use are done in mas.c. When receiving get/put request, mas.c determines
operation to perform (MAP function) and parses application parameters
headers. Then as in case of other obexd services
obex_(get|put)_stream_start gets called which in turn triggers MIME
driver's ->open().

As I mentioned, the MIME driver functionality is split between mas.c and
backend. So actual MIME driver open() elects appropriate callback for MAP
function in question and calls messages_open() which does the rest of the
job of preparing I/O for the request. It however does not pass the same
data it gets, as some preliminary processing has been already done - so
message_open() gets requested opcode (MAP function), input parameters,
storage for output parameters, OBEX name header value and callback
address. This callback is used to return data asynchronously.

The data in callback is returned in a structure specific to selected MAP
function and optionally wakes the I/O. Callback code takes the structure,
formats it into a stream for sending and appends this to output buffer.
So for example, in GetMessagesListing case, callback gets struct with
metadata of messages in folder and makes an XML from it.

Simultaneously MIME driver read()-s are called (as driven by OpenOBEX
streaming mode) and they pass to the caller what's in the buffer, or
return -EAGAIN if buffer is empty and callback did not set the flag
informing that the operation is already finished.

At the end of the request or at any time if the request is aborted MIME
driver close() is called which in turn calls messages_close() to free
it's data or stop any pending actions (for example D-Bus calls if backend
uses D-Bus).


==========================================

So to answer Johan's doubts.

Current design makes some things easier. For instance request abortion,
as there is messages_open() and messages_close() and close already knows
what to close because of fid (function id) presence. In case of what
Johan wants either I would have to make 14 functions in global name space
(7 MAP functions, equivalent of close and open for any single one of
them) or use 7
identical "open" functions and one single close, which will rely on
hidden function id stored internally in backend. Latter would make ugly
asymmetry in plugin code, as in MIME driver open() there would be called
one of those 7 functions and in close() only messages_close() (or
cancel?) for which relation to one of previous functions would not be
clear from mas.c perspective.

And of course each of these "open" functions and also each of
these "close" functions would have the same prototype and would do the
same thing from the caller view.

What I'm trying to say is that the abstraction is rewarding also from the
service plugin point, and putting backend logic behind something almost
like mime driver is well...  logical, as it almost follows mime driver
work flow, it is just a little bit too crippled to be real mime driver on
its own so mime->open() does what it can (it does the low level OBEX
things) and then calls for assistance from messages_open(). And
messages_open does the rest of opening but not using low level mime-like
open() semantics, but MAP semantics.

Err... I said "also" because implementing backend is easier too. It can
simply return error for any MAP function it does not want to support
right away from messages_open and it also makes it immune to further
addition of new MAP functions.

And even though MAP calls its functions, well, functions, they are not
exactly the same as C functions they are more like an opcodes selecting
what to do with data presented. And this data is always of the same
structure.

The way it is now, MIME driver and thus plugin code is kept short and sweet.
