Return-Path: <cyrus@holtmann.org>
Message-ID: <3b53a90114d801b0adba526895deed74.squirrel@www.codeaurora.org>
Date: Thu, 9 Dec 2010 05:54:07 -0800 (PST)
Subject: A2DP reconfigure with BMW Carkit (supporting multi streams)
     timeouts.
From: roystonr@codeaurora.org
To: linux-bluetooth@vger.kernel.org
Cc: skrovvid@codeaurora.org, rshaffer@codeaurora.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi All,

During the interop tests with BMW Carkit using DUT (Device under Test)
running Bluez stack, we observe that A2DP reconfiguration timeouts.

Scenario:
1)	Connect A2DP from DUT
2)	Start streaming
3)	Power down the BMW carkit
4)	Power on the BMW carkit
5)	A2DP streaming not resuming.

>From the sniffer logs, firstly we observe that the BMW carkit supports
multiple stream endpoints whereas the DUT supports only one. We observe
that after powering on, the BMW carkit(CK) was initiating an inbound A2DP
connection there by configuring the stream (INT and ACP SEID were 1 for
set configuration). Later on we observe that the DUT tries to reconfigure
the stream by sending a AVDTP_CLOSE as the stream had capabilities
differing from the remote device (CK in this case). The BMW CK rightly
acknowledges the AVDTP_CLOSE (here ACP SEID = 1). Following this the DUT
sends a stream configuration with INT SEID as 1 and ACP SEID as 2. To this
the remote CK doesn't respond.

We suspect this behaviour because the set configuration lastly send from
the DUT after an AVDTP_CLOSE should have been with ACP SEID as 1 and not
2. As per our understanding of the code, 2 is used as the ACP SEID because
avdtp_get_seps returns the 1st not in use SEP from the list that was
contructed based on the device capabalities retreived by the DUT from the
remote CK. It is observed that the DISCOVER response from the remote CK
provided SEID 2 info before 1.

Change expected:
avdtp_get_seps should be able to provide the SEP of the one used in the
AVDTP_CLOSE previously. But there weren't any previously closed streams
then provide the SEP which is not in use (as done currently).

Kindly let us know whether our understanding is right and can this be a
suspected cause of the issue seen. Correct if mistaken.

Regards,
Royston Rodrigues




