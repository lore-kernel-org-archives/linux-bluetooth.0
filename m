Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Tue, 25 Jan 2011 15:07:30 -0400
Message-ID: <AANLkTikrjgmAK9pzoJtnNJwQHraiaCnb8XVP55gAEKeH@mail.gmail.com>
Subject: Read Characteristic Value vs. Read Long Characteristic Values
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: BlueZ development <linux-bluetooth@vger.kernel.org>,
	Brian Gix <bgix@codeaurora.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Brian,

On the implementation you did for Long Characteristic value read, you
integrated the Read Blob Request handling into the existing "Read
Characteristic Value" implementation. From my understanding of the
code, the read blob request is issued if the response PDU size is
greater than or equal to LE ATT_MTU (23).

The problem I see with this approach is that if the client knows that
the characteristic value is exactly 22 bytes (which makes total PDU
size equal to 23 with the opcode), a spurious read blob request (and
corresponding response) is sent. How could we avoid this overhead?

My idea was to separate the procedures, having a "Read Long
Characteristic Value" and revert Read Characteristic Value to read
only the first ATT_MTU - 1 bytes as before. For characteristic values
which the client knows to be within ATT_MTU - 1 bytes (of if it only
cares about these bytes at the time) it would use the latter. For
cases where value length is unknown, it would use the former.

This would also allow us to better map to GATT procedures and have
fine control on the client implementation and on our test tool
(igatttool).

Any other ideas?
-- 
Anderson Lizardo
OpenBossa Labs - INdT
Manaus - Brazil
