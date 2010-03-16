Return-Path: <cyrus@holtmann.org>
From: "Mat Martineau" <mathewm@codeaurora.org>
To: "'Gustavo F. Padovan'" <gustavo@padovan.org>
Cc: <linux-bluetooth@vger.kernel.org>
References: <1268699189-2910-1-git-send-email-gustavo@padovan.org>	 <000001cac51b$9563e060$c02ba120$@org> <6b53b1991003160830s72c84d97m28900de9cbb1302c@mail.gmail.com>
In-Reply-To: <6b53b1991003160830s72c84d97m28900de9cbb1302c@mail.gmail.com>
Subject: RE: [PATCH 1/4] Bluetooth: Add sockopt configuration for txWindow on 	L2CAP
Date: Tue, 16 Mar 2010 09:26:56 -0700
Message-ID: <000201cac525$7f363040$7da290c0$@org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>



> -----Original Message-----
> From: linux-bluetooth-owner@vger.kernel.org
> Sent: Tuesday, March 16, 2010 8:30 AM
> To: Mat Martineau
> Cc: linux-bluetooth@vger.kernel.org
> Subject: Re: [PATCH 1/4] Bluetooth: Add sockopt configuration for txWindow
on L2CAP
> 
> Hi Mat,
> 
> On Tue, Mar 16, 2010 at 12:15 PM, Mat Martineau
> <mathewm@codeaurora.org> wrote:
> > Gustavo -
> >
> >> -----Original Message-----
> >> From: linux-bluetooth-owner@vger.kernel.org [mailto:linux-bluetooth-
> >> owner@vger.kernel.org] On Behalf Of Gustavo F. Padovan
> >> Sent: Monday, March 15, 2010 5:26 PM
> >> To: linux-bluetooth@vger.kernel.org
> >> Cc: marcel@holtmann.org; gustavo@padovan.org
> >> Subject: [PATCH 1/4] Bluetooth: Add sockopt configuration for txWindow
> >> on L2CAP
> >>
> >> Now can set/get Transmission Window size via sockopt.
> >
> > It would be better to use __u16 for the Tx Window size, so we can use
> > extended window sizes in the future.  This is important for AMP, where
the
> > amount of data in-flight can be large enough for the extended Tx Window
to
> > matter.
> 
> It's better to update it to __u16 when we actually implement the
> Extended Tx Window.

The advantage of doing it now is that the data type visible to userspace
will not ever have to change.  Applications using these sockopts will not
want to worry about this parameter being different types on different kernel
versions.  Since this value needs to be range-checked anyway (normal Tx
Window must fit in 6 bits), there isn't much downside to going with __u16
for the sockopt interface now.  Extended Tx Window support is coming in the
near term.

Another possibility is that we determine the Tx Window automatically, and
have no sockopt interface for it.  The current window of 63 could continue
to be used for BR/EDR connections, and each AMP controller type could have a
sensible extended Tx Window that considers its data rate and round trip
time.


Regards,
Mat Martineau
Qualcomm Innovation Center, Inc.,
A member of the Code Aurora Forum


