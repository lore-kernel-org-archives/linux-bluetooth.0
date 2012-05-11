Return-Path: <cyrus@holtmann.org>
Date: Fri, 11 May 2012 11:38:15 -0700 (PDT)
From: Mat Martineau <mathewm@codeaurora.org>
To: Gustavo Padovan <gustavo@padovan.org>
cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 4/4] Bluetooth: add a timer to L2CAP MSG_MORE code
In-Reply-To: <1336752974-7747-4-git-send-email-gustavo@padovan.org>
Message-ID: <alpine.DEB.2.02.1205111131570.17554@mathewm-linux>
References: <1336752974-7747-1-git-send-email-gustavo@padovan.org> <1336752974-7747-2-git-send-email-gustavo@padovan.org> <1336752974-7747-3-git-send-email-gustavo@padovan.org> <1336752974-7747-4-git-send-email-gustavo@padovan.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


On Fri, 11 May 2012, Gustavo Padovan wrote:

> There is now a 200 milliseconds limit for which L2CAP will wait for
> which L2CAP will wait before send the already queued data to the
> controller.
>
> Signed-off-by: Gustavo Padovan <gustavo@padovan.org>

A timeout like this makes sense with a streaming protocol, but not 
with a datagram protocol like L2CAP.  The application could be waiting 
on file I/O (especially on a flash filesystem), be waiting for another 
blocking call to return, or another resource-intensive application 
could be hogging the processor for a short time.  If an incomplete SDU 
gets sent out because of a timeout like this, the profile on the other 
side will see it as corrupt.  Better to keep the queued data 
indefinitely.

--
Mat Martineau
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum

