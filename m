Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
From: Nathaniel McCallum <npmccallum@redhat.com>
Date: Tue, 27 Feb 2018 12:01:56 -0500
Message-ID: <CAOASepNEyEgQaxrqN1dbmEjqVzm8+VZABt-Gcx=jBCHJ-CAM+w@mail.gmail.com>
Subject: Clarification on Characteristic Flags
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The documentation in doc/gatt-api.txt specifies a number of flags that
control the security of the operations.[0] These flags contain no
documentation besides a reference to the Core Bluetooth Specification.

Unfortunately, the Core Specification has now changed and the
references no longer apply to the most recent documents. Further, even
if the references were correct, the documentation is also rather
opaque and presumes a lot of knowledge about Bluetooth to understand
the actual properties. An application developer cannot be presumed to
have this knowledge.

Additionally, some of the flags (I think secure-read and secure-write)
don't appear to have any corollary in the specification. Nor is it
clear what behavior they actually implement.

The combination of unclear documentation and critical security
properties is compounded by the unclear relationship between the
flags. For example, how should the following three flags be used
together: write, authenticated-signed-writes,
encrypt-authenticated-write? Does this mean that the unsigned writes,
signed writes and signed-and-encrypted writes are allowed and any one
of them may be chosen (leading to potential disclosure of sensitive
information)? Or does it mean that writes are allowed if they are
signed and encrypted?

Would it be possible to get some clear documentation on not only how
to use these flags but what security properties emerge from their use
in various combinations? I would hate for security issues to arise
because developers are using this API incorrectly. Thanks!

[0]: https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/doc/gatt-api.txt#n227
