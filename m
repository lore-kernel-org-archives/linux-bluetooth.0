Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Fri, 27 Apr 2012 15:53:58 -0500
Message-ID: <CAB7rCTiT6m368AReu0mbVVp+Ptc9frQLXp+AvsOY8csyKiVEhg@mail.gmail.com>
Subject: TP/SIG/SMG/BI-02-C failure
From: Mike <puffy.taco@gmail.com>
To: linux-bluetooth <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

I am experiencing a failure on TP/SIG/SMG/BI-02-C "To verify that the
IUT (ACP) is able to discard a corrupted stream discover command
received by the INT."  The test claims that "No message is sent to the
upper layers and no response is generated." and the problem I have is
that the disconnect_timeout function is sending its own DISCOVER_CMD
after the timeout.  This apparently is invalid.

For those who are more familiar with the position of
"remove_disconnect_timer(session);" in session_cb, does it make sense
to move that outside the AVDTP_MSG_TYPE_COMMAND block so that even the
invalid discover command (general reject) turns off the timer?

Mike
