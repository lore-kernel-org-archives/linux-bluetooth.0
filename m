Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Wed, 11 Apr 2012 21:30:19 +0530
Message-ID: <CACj007=jwOuFXOwXX9z+24KT_WvrCmFrVFp8ru_ncMuQriqYMQ@mail.gmail.com>
Subject: [RFC] BITE test case TP/SEC/SEM/BV-10-C fails
From: Hemant Gupta <hemantgupta.ste@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Hemant Gupta <hemant.gupta@stericsson.com>,
	Naresh Gupta <naresh.gupta@stericsson.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

I have found a regression issue with latest kernel code. I am trying
to execute the test case for GAP TP/SEC/SEM/BV-10-C using BITE.
Below is the test purpose

5.4.4.6 TP/SEC/SEM/BV-10-C Security Mode 4 - Master
Verify that the IUT disconnects the connection if the initiating side
sends the L2CAP_ConnectReq without first enabling encryption. IUT has
2.1 Host and 2.1 Con-troller. Tester has 2.1 Host and 2.1 Controller.

As per my analysis,
1) Host is sending HCI Disconnect request before L2CAP_ConnectReq is
sent from BITE Tester (It sends it after 5 seconds).
2) This HCI Disconnect is initiated after 4 secs (approx), from host
side, since there is no other request received from Remote side after
creating ACL.

static inline void hci_conn_put(struct hci_conn *conn)
{
.......
			if (conn->state == BT_CONNECTED) {
				timeo = msecs_to_jiffies(conn->disc_timeout);
				if (!conn->out)
					timeo *= 2;
.......
}

Here conn->disc_timeout = HCI_DISCONN_TIMEOUT = 2 Secs.

I checked that this timeout has been changed in new kernel, and
earlier code, the mulitplication factor for incoming connection was
timeo *= 5 (20 even before).

After increasing the timeout for hci disconnect to more than 5
seconds, test case TP/SEC/SEM/BV-10-C passes.
Could you confirm if this is acceptable fix to pass the test case.

-- 
Best Regards
Hemant Gupta
ST-Ericsson India
