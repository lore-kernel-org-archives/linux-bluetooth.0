Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Tue, 13 Oct 2015 16:45:14 -0700
Message-ID: <CABOZqni1nLFJfq5Psj8L795sNfUPc5XgD0ofRXjTCe5XnRrzhg@mail.gmail.com>
Subject: Multiple client connections?
From: Mark Spruiell <mes@zeroc.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

We'd like to be able to establish multiple simultaneous client
connections to the same service, both from a single process and from
multiple processes. (Essentially, we'd like to create bluetooth socket
connections just like we can for regular TCP socket connections, for
example.)

My client does the following:

* Gets a private connection to the system bus
* Calls GetManagedObjects to locate the device corresponding to the
target address
* Calls RegisterProfile with a unique object path and the target UUID
* Calls ConnectProfile on the target device with the target UUID
* Receives a NewConnection call with the file descriptor
* Uses the file descriptor like a regular socket
* When finished, calls DisconnectProfile, waits for it to complete,
and closes the socket

This works correctly. However, when I try to start another instance of
the client process and connect to the same service, this second
connection attempt fails. The first connection remains active and
continues to work. This second client would have registered its own
client profile with a unique object path and the same target UUID.

Is it possible for a single host to establish multiple connections to
the same service?

Thanks,
Mark
