Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Fri, 20 Mar 2015 13:36:36 +0100
Message-ID: <CAMv5GbcJU+QhJVQBFsyK1szEqBE+XK5AqdzAzVKMHwAQ7V5fww@mail.gmail.com>
Subject: Adding extension flag support for BNEP control messages
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
To: linux-bluetooth <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

I'am thinking about adding BNEP extension flag handling to BNEP
control messages which is mandatory (BNEP spec. 3.3 says: "This packet
type is mandatory to recognize and respond to accordingly, whereas the
implied functionality to do command is optional and
does not have to be supported by all devices.") and I want to share my
knowledge with you and get any suggestions/comments if something will
be not understood fully or wrong.

At beginning I want to say that prepared internally by me patch set.
allows to pass mandatory PTS test case TC_CTRL_BV_19_C.

BNEP spec. 2.6.3.1 Specifically nb. 4 says: "The initiating device's
BNEP_SETUP_CONNECTION_REQUEST_MSG MAY contain extension headers."

By now we don't support mandatory extension flag for control messages
(this is mandatory to support, . I want to create patch implementing
this feature however there is a lot of things to discuss.

Now scenario for control frame (let's start from receiver - listening
on socket):
1) Connection is initiated (listen on socket or connect to)
2) First received frame is BNEP_SETUP_CONN_REQ

If any of those steps will finalize with errors BNEP setup response
with error code will be send:
{
3) Setup frame is decoded and appropriate BNEP setup response message is sent
4) bnep connection is added in kernel - interface (starting session -
now we are able to process received/transmit data),
5) bnep interface is added to bridge interface
6) interface is setting up (IFF_UP + IFF_MULTICAST flag is set)
}

7) now while receiving control message kernel handle it but extended
header data is ignored (no response to it).
7b) any response for received connection request is with status "BNEP
connection is not allowed"

My RFC proposal/improvement:
1) Connection is initiated (listen on socket or connect to)
2) First received frame is peeked (frame stays in socket buffer)

If any of those steps will finish with errors BNEP setup response with
error code will be send:
{
3) Setup frame is decoded. In case of setup error, appropriate BNEP
setup response error message is sent.
4) bnep connection is added in kernel - interface (starting session).
Connection add is done via ioctl. Optional a BNEP setup connection
request handling flag is set in ioctl msg (bnep session holds this
flags), which tells kernel to handle BNEP setup connection request.
}
4b) Now kernel can process overdue BNEP setup connection request and
extension headers (if it's possible to add BNEP iterface, it means
that BNEP connection is established - In this case we will send BNEP
setup successful response. This is possible with BNEP setup connection
set up flag, otherwise it behaves as in old scenario). After
successful setup BNEP setup connection request flag is cleared,

If any of those steps will finish with errors - BNEP connection should
be dropped
{
5) bnep interface is added to bridge interface
6) interface is setting up (IFF_UP + IFF_MULTICAST flag is set)
}

7) Further control messages are fully handled, even with extension flags
7b) In case of repeated/resend BNEP setup request frame we will
response that "BNEP connection is not allowed", since it's already
established and linked with bridge


Assuming: prepared by my patch set allows to pass PTS test regarding -
necessary support for extended flag support in control messages. I'll
try to prepare a patch/patches if there will be agreement for
presented upper solution.

BR,
Grzegorz Kolodziejczyk
