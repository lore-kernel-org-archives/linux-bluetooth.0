Return-Path: <cyrus@holtmann.org>
Message-ID: <1334162966.16897.122.camel@aeonflux>
Subject: Re: [RFC] BITE test case TP/SEC/SEM/BV-10-C fails
From: Marcel Holtmann <marcel@holtmann.org>
To: Hemant Gupta <hemantgupta.ste@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	Hemant Gupta <hemant.gupta@stericsson.com>,
	Naresh Gupta <naresh.gupta@stericsson.com>
Date: Wed, 11 Apr 2012 18:49:26 +0200
In-Reply-To: <CACj007=jwOuFXOwXX9z+24KT_WvrCmFrVFp8ru_ncMuQriqYMQ@mail.gmail.com>
References: <CACj007=jwOuFXOwXX9z+24KT_WvrCmFrVFp8ru_ncMuQriqYMQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Hemant,

> I have found a regression issue with latest kernel code. I am trying
> to execute the test case for GAP TP/SEC/SEM/BV-10-C using BITE.
> Below is the test purpose
> 
> 5.4.4.6 TP/SEC/SEM/BV-10-C Security Mode 4 - Master
> Verify that the IUT disconnects the connection if the initiating side
> sends the L2CAP_ConnectReq without first enabling encryption. IUT has
> 2.1 Host and 2.1 Con-troller. Tester has 2.1 Host and 2.1 Controller.
> 
> As per my analysis,
> 1) Host is sending HCI Disconnect request before L2CAP_ConnectReq is
> sent from BITE Tester (It sends it after 5 seconds).
> 2) This HCI Disconnect is initiated after 4 secs (approx), from host
> side, since there is no other request received from Remote side after
> creating ACL.
> 
> static inline void hci_conn_put(struct hci_conn *conn)
> {
> .......
> 			if (conn->state == BT_CONNECTED) {
> 				timeo = msecs_to_jiffies(conn->disc_timeout);
> 				if (!conn->out)
> 					timeo *= 2;
> .......
> }
> 
> Here conn->disc_timeout = HCI_DISCONN_TIMEOUT = 2 Secs.
> 
> I checked that this timeout has been changed in new kernel, and
> earlier code, the mulitplication factor for incoming connection was
> timeo *= 5 (20 even before).
> 
> After increasing the timeout for hci disconnect to more than 5
> seconds, test case TP/SEC/SEM/BV-10-C passes.
> Could you confirm if this is acceptable fix to pass the test case.

can we get the BITE tester fixed. It is stupid that it waits 5 seconds
before sending the L2CAP_Connect_Req. File an errata against the BITE
tester.

I know that we passed this test case before and I tracked the timeout
change back to a commit from me from 2009:

commit 052b30b0a8eec8db5b18ad49effdf2a9ba4c1e1a
Author: Marcel Holtmann <marcel@holtmann.org>
Date:   Sun Apr 26 20:01:22 2009 +0200

    Bluetooth: Add different pairing timeout for Legacy Pairing

So clearly 3 years ago, this is a breakage in the BITE tester now.
Someone else would have noticed in this time frame.

Regards

Marcel


