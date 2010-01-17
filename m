Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <f6c5b8d91001170441m1d0d8755x15147f92b85b477f@mail.gmail.com>
References: <f6c5b8d91001170441m1d0d8755x15147f92b85b477f@mail.gmail.com>
Date: Sun, 17 Jan 2010 18:20:42 +0530
Message-ID: <f6c5b8d91001170450n415bf083l5044e193014d8f85@mail.gmail.com>
Subject: A2DP multiple sink support
From: Anil Sasidharan <anilvpr@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=windows-1252
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,



                We are trying to use Bluecore BT module (from CSR) for
A2DP profile support. In the present use case, our device acts as a
A2DP SRC. We are able to stream 44.1kHz stereo audio to a A2DP
headset. Now the next use case scenarios that we would like to try out
in A2DP context are the following:



1.       A2DP multicast; where single SRC streams audio to multiple
SNKs (all of them paired and connected with the SRC at the same time)

2.       Send 2 different audio streams (from the same device) to 2
different A2DP SINK devices (2 headsets).



SRC1 -> SNK1     (music stream – 1)

SRC2 -> SNK2     (music stream – 2)



Here SRC1 and SRC2 are two logical A2DP sources using the same BT HW
module  (same physical BT module)



Both the A2DP headsets are paired and connected to the BT module on
our device at the same time.



It would be really helpful if someone can throw more light on this (If
the use cases mentioned above are viable, then how?)



Warm Regards,

Anil
