Return-Path: <cyrus@holtmann.org>
Message-ID: <1312990866.4e42a6925110a@netmail.pipex.net>
Date: Wed, 10 Aug 2011 16:41:06 +0100
From: dave higton <davehigton@dsl.pipex.com>
To: linux-bluetooth@vger.kernel.org
Subject: Bluetooth encryption algorithms
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

My friend Google has been of no help, and my searches
through the bluez source have not found what I was
looking for: information, and ideally source code,
for the Bluetooth encryption algorithms.

I'm trying to create a simple Bluetooth stack for
RISC OS.  Rather than attempt to port an existing
open source stack, I'm trying to write from scratch
as far as possible.  This may be a naive idea, but I
want to do it as much for the educational value to me
as for the end product.

I have been able to perform an inquiry, get the names
of discoverable devices, and perform the first step
of pairing.  So far, so good - and, yes, that's the
easy stuff.

So if anyone can point me to sources of information
detailed and explicit enough to show me how Bluetooth
encryption and decryption are done, I would very much
appreciate it.  I have the Bluetooth core specification,
but I'm not confident that I can implement correctly
from it alone.  I'm also looking for test data, ideally
for each step through each algorithm.

If there is a book that covers the subject in enough
detail, I'd be happy to buy it.

Tia,

Dave


