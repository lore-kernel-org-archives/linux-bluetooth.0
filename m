Return-Path: <cyrus@holtmann.org>
Date: Sat, 9 May 2009 11:59:25 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: Security mode 3 pairing acceptor broken with current
	bluetooth-testing
Message-ID: <20090509085925.GA4205@jh-x301>
References: <20090508234902.GA6615@jh-x301> <1241827683.4903.78.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1241827683.4903.78.camel@localhost.localdomain>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Fri, May 08, 2009, Marcel Holtmann wrote:
> what is the time between the PIN code request and the cancel command?

It is almost immediate. Here's the timings before your patch:

1241826073.405723 > HCI Event: Connect Request (0x04) plen 10
1241826073.405782 < HCI Command: Accept Connection Request (0x01|0x0009) plen 7
1241826073.407540 > HCI Event: Command Status (0x0f) plen 4
1241826073.569728 > HCI Event: Role Change (0x12) plen 8
1241826073.717728 > HCI Event: Link Key Request (0x17) plen 6
1241826073.718103 < HCI Command: Link Key Request Negative Reply (0x01|0x000c) plen 6
1241826073.719726 > HCI Event: Command Complete (0x0e) plen 10
1241826073.720548 > HCI Event: PIN Code Request (0x16) plen 6
1241826073.732176 < HCI Command: Create Connection Cancel (0x01|0x0008) plen 6

> --- a/net/bluetooth/hci_conn.c
> +++ b/net/bluetooth/hci_conn.c
> @@ -171,7 +171,7 @@ static void hci_conn_timeout(unsigned long arg)
>         switch (conn->state) {
>         case BT_CONNECT:
>         case BT_CONNECT2:
> -               if (conn->type == ACL_LINK)
> +               if (conn->type == ACL_LINK && conn->out)
>                         hci_acl_connect_cancel(conn);
>                 else
>                         hci_acl_disconn(conn, 0x13);
> 
> The above patch might fixes it. However without the timing between the
> commands, I don't know what triggers it.

Thanks for the patch. Unfortunately it doesn't fix the issue, though it does
show that it is this hci_conn_timeout function that's to blame of the
situation. Here's what happens with your patch:

1241859026.835365 < HCI Command: Accept Connection Request (0x01|0x0009) plen 7
1241859026.837313 > HCI Event: Command Status (0x0f) plen 4
1241859026.999322 > HCI Event: Role Change (0x12) plen 8
1241859027.147328 > HCI Event: Link Key Request (0x17) plen 6
1241859027.147583 < HCI Command: Link Key Request Negative Reply (0x01|0x000c) plen 6
1241859027.149329 > HCI Event: Command Complete (0x0e) plen 10
1241859027.150324 > HCI Event: PIN Code Request (0x16) plen 6
1241859027.164053 < HCI Command: Disconnect (0x01|0x0006) plen 3

One problem here is that from the host perspective there's no ACL yet
since there hasn't been any "connect complete" event. So HCI_Disconnect is
incorrect in this case and doesn't even have a real handle to give so it
looks like (hcidump -V):

< HCI Command: Disconnect (0x01|0x0006) plen 3
    handle 0 reason 0x13
    Reason: Remote User Terminated Connection

I'll do some investigation later today to try to figure out why this
timeout function gets immediately triggered.

Johan
