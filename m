Return-Path: <cyrus@holtmann.org>
Message-ID: <574573.55804.qm@web94901.mail.in2.yahoo.com>
Date: Tue, 24 Nov 2009 17:26:52 +0530 (IST)
From: Pavan Savoy <pavan_savoy@yahoo.co.in>
Subject: Re: alternative to hci_ldisc for BT-UART
To: linux-bluetooth@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Currently there is a line discipline driver which works similar to hci_ldisc however it now, has exported a write function and takes in an skb in that and dumps it onto the UART.
when data is received, the 1st byte is checked for either of BT packets (event, sco, acl) if not it is forwarded to the 2nd driver (in this case FM driver).

with this BT apps can send/receive data as usual (over hci0 interface), and there can be an FM application working on a simple char device say /dev/radio (or a v4l2 device) and still talk to chip when BT is on.

Where should this driver be placed ? in the kernel source code ? If at all it's accepted by the community ?

regards,
Pavan

--- On Thu, 15/10/09, Pavan Savoy <pavan_savoy@yahoo.co.in> wrote:

> From: Pavan Savoy <pavan_savoy@yahoo.co.in>
> Subject: alternative to hci_ldisc for BT-UART
> To: linux-bluetooth@vger.kernel.org
> Date: Thursday, 15 October, 2009, 9:47 AM
> Hi,
> 
> Currently if the BT chip has an UART transport, it stops me
> from making of UART for any other purpose when BT is
> active.
> In combo-chip cases(BT/FM), the TTY line discipline has to
> be more generic so that any other driver can make use of
> that line discipline to send across data to chip.
> 
> Is this possible and valid ?
> 
> regards,
> Pavan
> 
> 
>       Connect more, do more and share more
> with Yahoo! India Mail. Learn more. http://in.overview.mail.yahoo.com/
> 


      The INTERNET now has a personality. YOURS! See your Yahoo! Homepage. http://in.yahoo.com/
