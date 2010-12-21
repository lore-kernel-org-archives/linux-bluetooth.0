Return-Path: <cyrus@holtmann.org>
Message-ID: <2c8fd2a055b2bc89623407a66d050c00.squirrel@www.codeaurora.org>
Date: Tue, 21 Dec 2010 09:35:41 -0800 (PST)
Subject: AVRCP connect failing with Interop headset-Buffalo
From: roystonr@codeaurora.org
To: linux-bluetooth@vger.kernel.org
Cc: "Luiz Augusto von Dentz" <luiz.dentz@gmail.com>,
	"Johan Hedberg" <johan.hedberg@gmail.com>, roystonr@codeaurora.org,
	rshaffer@codeaurora.org, skrovvid@codeaurora.org
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

During Interop testing with Buffalo headset (supporting A2DP+AVRCP), its
observed that the A2DP connection is failing.

>From the sniffer logs, it’s observed that the DUT (Device under test)
issues avrcp_connect even before the l2cap connections for avdtp transport
and signaling are completed. It’s also observed from the sniffer logs that
the remote side hasn’t responded to one of the DUT’s l2cap connection
request, before the DUT initiates the avrcp_connect.

As an experiment, by modifying the CONTROL_CONNECT_TIMEOUT (in device.c)
value from 2 to 5 seconds this issue with the mentioned headset is
avoided.

To my understanding, CONTROL_CONNECT_TIMEOUT controls the interval at
which the avrcp_connect is initiated from the DUT i.e. if the stream setup
is active then the timer is kicked in to delay the DUT side avrcp_connect.

Though by increasing the CONTROL_CONNECT_TIMEOUT value, this issue with
the headset under test is avoided. The ideal way would be to trigger the
DUT initiated avrcp_connect only after the l2cap connections are
completed. Correct me if my understanding is wrong.

Kindly provide reference as to how to control the DUT initiated
avrcp_connect only after ensuring that the l2cap connections are
completed. Or is it safe to the modify CONTROL_CONNECT_TIMEOUT value as
mentioned above.

Regards,
Royston Rodrigues.
"Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum."

