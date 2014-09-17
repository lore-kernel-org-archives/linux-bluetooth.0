Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Wed, 17 Sep 2014 20:10:24 +0530
Message-ID: <CABL=VJNsGRmz1wvhFxn79_zesYjo3oD5tdrXEy_9vqB9Q7Bd_g@mail.gmail.com>
Subject: Missing of SCO packet indications
From: Vinod Rayapudi <vinodrayapudi@gmail.com>
To: linux-bluetooth@vger.kernel.org, autoanswer@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi All,

I have an Issue w.r.t SCO packets.

I have connected a phone which support both A2DP and Handsfree profiles.
During call, I don't see any sco packet indication.

I have added logs in Bluez- 'unix.c' file.

>From the logs I understood that, all SCO packet indications and
initiations like BT_GET_CAPABILITIES ,BT_OPEN ,BT_SET_CONFIGURATION
and BT_START_STREAM etc are triggered from client_cb() callback
function.
In this case, I don't see any such kind of packet transmission.
How to correct this behavior ?

If the phone has both active A2DP and Handsfree connections, then this
issue occurs.

Can anyone help me, how to correct this issue.


Thanks & Regards,
Vinod.
