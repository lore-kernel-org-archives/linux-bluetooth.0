Return-Path: <cyrus@holtmann.org>
Message-ID: <1345194403.29868.39.camel@pohly-mobl1.fritz.box>
Subject: obexd client API
From: Patrick Ohly <patrick.ohly@intel.com>
To: Bluez <linux-bluetooth@vger.kernel.org>
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>,
	"Von Dentz, Luiz" <luiz.von.dentz@intel.com>
Date: Fri, 17 Aug 2012 11:06:43 +0200
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello all!

Luiz was so kind to discuss the client-api.txt in obexd 0.47 with me, in
particular the usage of temporary files and the Transfer objects. The
goal was to understand how to use that API correctly, so that race
conditions are avoided and errors are handled gracefully. This is
relevant for others, so let me summarize here.

Some relevant aspects of the API are not documented at the moment:
     1. The Transfer objects only exist as long as the transfer is still
        active.
     2. When a transfer fails before the data was transferred
        completely, the temporary file gets deleted by obexd. I am still
        a bit fuzzy whether that is the case for file names chosen by
        the client and for those chosen by obexd.
     3. When a client disconnects, obexd aborts the transfer and thus
        deletes an incomplete temporary file.

Because of point 1, a client has to listen to org.bluez.obex.Transfer
signals for all object paths and record that information. Otherwise
there is the following race condition:
     1. The client asks for a transfer.
     2. obexd replies with "transfer in progress" and the Transfer
        object path.
     3. Before the client gets a chance register a signal watch for that
        path, obexd sends the Complete() signal and destroys the object.
     4. If the client now waits for the signals of the object, it will
        wait forever.

To avoid this, the client could explicitly check properties of the
Transfer object. If it gets an error, it can conclude that the transfer
is no longer active. If the file still exists, the transfer must have
succeeded. But if it does not exist, the client doesn't know why the
transfer failed. I also find this kind of checking very speculative. The
error that the client gets for an invalid object path is undocumented.
For example, I believe I have seen errors about "interface not found"
instead of "object not found" (not necessarily in obexd).

A client developer could also decide that this race condition is
unlikely to happen and thus decide to not handle it; I find that a bit
risky.

I'm not sure whether it's worth changing the API. If yes, then how about
extending the life time of the Transfer object? obexd could keep it
alive until either the client quits or explicitly deletes the Transfer
object via a new method call. Then a client can (in this order)
subscribe to signals and query current properties of the object once to
detect state changes that it has missed.

Regarding the temporary files my main concern was about orphaned files
that no-one owns anymore. Here's one error scenario:
     1. The client requests a transfer into "foo".
     2. obexd finishes the transfer.
     3. The client dies before doing anything with the file.

To handle this, the client must ensure that there is some kind of
garbage collection for "foo" (when it is temporary) or that it is okay
to leave the file around (because the user expects that).

Again I can imagine refinements of the API that would help address some
of the concerns (like an explicit transfer of ownership), but short of
transferring file descriptors for files which were already unlinked
there are always error cases left which will leave files around (both
client and obexd might die).

As Luiz explained, using file descriptors was already discussed and
rejected for good reasons, so let's not reopen the discussion.

Would it be useful to extend the API specification with "how to use"
remarks so that users of it don't have to search the mailing list?

-- 
Best Regards, Patrick Ohly

The content of this message is my personal opinion only and although
I am an employee of Intel, the statements I make here in no way
represent Intel's position on the issue, nor am I authorized to speak
on behalf of Intel on this matter.


