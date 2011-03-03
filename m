Return-Path: <cyrus@holtmann.org>
Message-ID: <4D6F358B.9020603@Atheros.com>
Date: Thu, 3 Mar 2011 12:00:35 +0530
From: Suraj Sumangala <suraj@Atheros.com>
MIME-Version: 1.0
To: "Gustavo F. Padovan" <padovan@profusion.mobi>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: updating unacked_frames counter during retransmission
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gustavo,

I have a question regarding the ERTM implementation.

Should we be incrementing the "l2cap_pinfo.unacked_frames" variable if 
we are retransmitting a frame?

Won't this cause the same frame to be accounted twice?

If there are too many retransmissions, will there be a chance that 
"unacked_frames" could cross 0xFF and over flow.


Correct me if I have missed anything.

Regards
Suraj

