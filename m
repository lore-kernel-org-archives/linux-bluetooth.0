Return-Path: <cyrus@holtmann.org>
Message-ID: <4EC522B3.5080607@bmw-carit.de>
Date: Thu, 17 Nov 2011 16:05:23 +0100
From: Mikel Astiz <mikel.astiz@bmw-carit.de>
MIME-Version: 1.0
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: D-Bus API of obex-client
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi all,

After some tests with the obex-client, I would like to ask some 
questions related to the D-Bus API:

1. Transfers for OBEX-specific mime types: in obc_transfer_register, 
these types are filtered out so no transfer is registered for them. Is 
this a matter of overhead only? I mean, for considerable transfers such 
as full phonebook downloads, it would still make sense to provide a 
transfer. First, you could track the progress, and second, you could 
cancel it. Am I missing any other reason not to want this registration?

2. External monitoring of the active transfers: currently the agent 
owning a session is the only component that is able to know about the 
ongoing transfers. However it could be interesting to signal these 
transfers publicly, so other "external" components can have knowledge of 
them. Typically a GUI could be showing the progress of a download (even 
though another component initiated it) but it could also be that certain 
components would like to react accordingly (example, cancel a download 
if A2DP starts).

In addition, this kind of API would be more consistent with the ones in 
BlueZ or oFono, meaning that any interested component can keep track 
(and modify) the state.

Cheers,
Mikel

