Return-Path: <cyrus@holtmann.org>
From: "Mat Martineau" <mathewm@codeaurora.org>
To: "'Gustavo F. Padovan'" <gustavo@padovan.org>,
	<linux-bluetooth@vger.kernel.org>
References: <1268699189-2910-1-git-send-email-gustavo@padovan.org> <1268699189-2910-2-git-send-email-gustavo@padovan.org>
In-Reply-To: <1268699189-2910-2-git-send-email-gustavo@padovan.org>
Subject: RE: [PATCH 2/4] Bluetooth: Fix remote and local txWindow roles on L2CAP
Date: Tue, 16 Mar 2010 10:00:44 -0700
Message-ID: <000301cac52a$3816ff50$a844fdf0$@org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Gustavo -

> -----Original Message-----
> From: linux-bluetooth-owner@vger.kernel.org [mailto:linux-bluetooth-
> owner@vger.kernel.org] On Behalf Of Gustavo F. Padovan
> Sent: Monday, March 15, 2010 5:26 PM
> To: linux-bluetooth@vger.kernel.org
> Cc: marcel@holtmann.org; gustavo@padovan.org
> Subject: [PATCH 2/4] Bluetooth: Fix remote and local txWindow roles on
> L2CAP
> 
> L2CAP was misusing the values of txWindow. Now the remote txWindow is used
> on the acknowledgement of I-frames and the local txWindow on the sending
> of I-frames. It also renames pi->num_to_ack to a better name:
> pi->num_acked.
> 

The XMIT state table for ERTM shows that I-Frames are not sent with the
RemWindow-Full condition, so either the previous implementation was correct
or the naming of remote & local txWindow in l2cap.c is opposite of that in
the spec.


Regards,
Mat Martineau
Qualcomm Innovation Center, Inc.,
A member of the Code Aurora Forum

