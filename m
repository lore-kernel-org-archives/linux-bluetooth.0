Return-Path: <cyrus@holtmann.org>
Message-ID: <370999.25109.qm@web52601.mail.re2.yahoo.com>
References: <91473.91180.qm@web52605.mail.re2.yahoo.com> <1262969995.2233.5.camel@localhost.localdomain>
Date: Fri, 8 Jan 2010 11:05:51 -0800 (PST)
From: Ed Tsang <netdesign_98@yahoo.com>
Subject: Re: bluetooth-sendto dbus-timeout
To: Bastien Nocera <hadess@hadess.net>
Cc: Bluettooth Linux <linux-bluetooth@vger.kernel.org>
In-Reply-To: <1262969995.2233.5.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Bastien,
   I tried gnome-bluetooth 2.28.1, similar situation, when remote Nokia phone user don't response, got "Did not receive ..."

Cheers.
Ed



----- Original Message ----
From: Bastien Nocera <hadess@hadess.net>
To: Ed Tsang <netdesign_98@yahoo.com>
Cc: Bluettooth Linux <linux-bluetooth@vger.kernel.org>
Sent: Fri, January 8, 2010 11:59:55 AM
Subject: Re: bluetooth-sendto dbus-timeout

On Fri, 2010-01-08 at 08:51 -0800, Ed Tsang wrote:
> Hi, 
> Hope one of you expert could help me on this.
> I am trying to use bluetooth-sendto (bluz-gnome) to push files to
> remote and record detail of the result (e.g. cannot connect to SDP,
> cannot locate the opp .....). I was able to go into the obex-client to
> get more detail when the transfer fail.  But when the remote (user) do
> not response to the connection request, I got a
> DBUS_GERROR_REMOTE_EXCEPTION (Did not receive a reply...). 
>    I am guessing the method timeout, but it was too fast (prefer to
> give the remote device user more time). 
>   Is there a way to increase the timeout value to a much much larger
> number?
>   Is there a time out on the obexd side on the SDP connect and rfcomm
> connect in case the user do not response to the connection request. 

bluez-gnome is old, and its bluetooth-sendto has a number of known bugs.
Try with the latest version of gnome-bluetooth instead.

Cheers

--
To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html



      __________________________________________________________________
Get the name you've always wanted @ymail.com or @rocketmail.com! Go to http://ca.promos.yahoo.com/jacko/
