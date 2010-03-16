Return-Path: <cyrus@holtmann.org>
Date: Tue, 16 Mar 2010 15:50:35 -0300
From: "Gustavo F. Padovan" <gustavo@padovan.org>
To: Mat Martineau <mathewm@codeaurora.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 2/4] Bluetooth: Fix remote and local txWindow roles on
 L2CAP
Message-ID: <20100316185035.GA32551@vigoh>
References: <1268699189-2910-1-git-send-email-gustavo@padovan.org>
 <1268699189-2910-2-git-send-email-gustavo@padovan.org>
 <000301cac52a$3816ff50$a844fdf0$@org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <000301cac52a$3816ff50$a844fdf0$@org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mat,

* Mat Martineau <mathewm@codeaurora.org> [2010-03-16 10:00:44 -0700]:

> Gustavo -
> 
> > -----Original Message-----
> > From: linux-bluetooth-owner@vger.kernel.org [mailto:linux-bluetooth-
> > owner@vger.kernel.org] On Behalf Of Gustavo F. Padovan
> > Sent: Monday, March 15, 2010 5:26 PM
> > To: linux-bluetooth@vger.kernel.org
> > Cc: marcel@holtmann.org; gustavo@padovan.org
> > Subject: [PATCH 2/4] Bluetooth: Fix remote and local txWindow roles on
> > L2CAP
> > 
> > L2CAP was misusing the values of txWindow. Now the remote txWindow is used
> > on the acknowledgement of I-frames and the local txWindow on the sending
> > of I-frames. It also renames pi->num_to_ack to a better name:
> > pi->num_acked.
> > 
> 
> The XMIT state table for ERTM shows that I-Frames are not sent with the
> RemWindow-Full condition, so either the previous implementation was correct
> or the naming of remote & local txWindow in l2cap.c is opposite of that in
> the spec.

Looks I misundestood the spec, I'll check that.

> 
> 
> Regards,
> Mat Martineau
> Qualcomm Innovation Center, Inc.,
> A member of the Code Aurora Forum
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Gustavo F. Padovan
http://padovan.org
