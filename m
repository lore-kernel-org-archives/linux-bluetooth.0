Return-Path: <cyrus@holtmann.org>
Date: Fri, 4 Mar 2011 21:53:09 -0300
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: Suraj Sumangala <suraj@Atheros.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: updating unacked_frames counter during retransmission
Message-ID: <20110305005309.GB9005@joana>
References: <4D6F358B.9020603@Atheros.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4D6F358B.9020603@Atheros.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Suraj,

* Suraj Sumangala <suraj@Atheros.com> [2011-03-03 12:00:35 +0530]:

> Hi Gustavo,
> 
> I have a question regarding the ERTM implementation.
> 
> Should we be incrementing the "l2cap_pinfo.unacked_frames" variable if 
> we are retransmitting a frame?

No, if we are retransmitting a frame that means L2CAP didn't received an ack
for it and we are already accounting it in unacked_frames and there is no need
to increment unacked_frames in this case.

> 
> Won't this cause the same frame to be accounted twice?
> 
> If there are too many retransmissions, will there be a chance that 
> "unacked_frames" could cross 0xFF and over flow.

No, unacked_frames number is limited by the remote transmission window size.

-- 
Gustavo F. Padovan
http://profusion.mobi
