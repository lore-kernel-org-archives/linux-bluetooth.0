Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <2de465760412230418552a4af6@mail.gmail.com>
From: Manjunath Prabhu <manjunath.mp@gmail.com>
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] get remote bt address
In-Reply-To: <1103803109.20258.79.camel@pegasus>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
References: <2de4657604122303546f813ecf@mail.gmail.com>
	 <1103803109.20258.79.camel@pegasus>
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Thu, 23 Dec 2004 17:48:53 +0530

Hi marcel,
yup, getpeername() works.....had done something silly.
i have 2 questions about BT products, 
the csr press release says BT-EDR chips are in market......have BT
dongles with EDR come into the market???
Also, which would be the best Bluetooth PCMCIA card , the ones with
linux drivers , for 2.6 kernels?

thanx once again,
regards,
manjunath

On Thu, 23 Dec 2004 12:58:29 +0100, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi Manjunath,
> 
> > I am using l2cap sockets. On the receiving side, i want to find out
> > the remote (sender's) bluetooth address. i do not have the dev_id or
> > handle of the sender which has already established a connection. I
> > want to get it in my c code, not using hcitool con or other means.
> > I am trying getpeername, but it doesn't seem to work. Hope you can
> > suggest something.
> 
> the getpeername() is the right function and it works. If not, then your
> code is wrong.
> 
> Regards
> 
> Marcel
> 
> -------------------------------------------------------
> SF email is sponsored by - The IT Product Guide
> Read honest & candid reviews on hundreds of IT Products from real users.
> Discover which products truly live up to the hype. Start reading now.
> http://productguide.itmanagersjournal.com/
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users
>


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
