Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <465AC8C7.1020502@imperial.ac.uk>
References: <4656FDE4.5070001@imperial.ac.uk> <465AC8C7.1020502@imperial.ac.uk>
Date: Mon, 28 May 2007 15:55:14 +0200
Message-Id: <1180360514.21432.102.camel@aeonflux.holtmann.net>
Mime-Version: 1.0
Subject: Re: [Bluez-users] hid keyboard events get lost
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Hi Konrad,

> just to let you know: the ``Freedom Universal Keyboard'' is working
> perfectly now, after applying some minor tweaks to the kernel:
> 
> 1. something to avoid the long negotiation for the mtu size, i commented
>    out the following lines in l2cap_build_conf_req
>    (net/bluetooth/l2cap.c):
> 
>    //	if (pi->imtu != L2CAP_DEFAULT_MTU)
>    //		l2cap_add_conf_opt(&ptr, L2CAP_CONF_MTU, 2, pi->imtu);
> 
>    yes i know, this might not be the way to go, but bt still works with
>    my mobile and the headset. maybe someone has an idea for a cleaner
>    solution?
> 
> 2. unfortunately the data coming from the keyboard is missing the first
>    byte telling us about keyboard input. in hidp_input_report
>    (net/bluetooth/hidp/core.c) insert the following
>    lines after variable declaration:
> 
>    if ( ( session->input->id.vendor == 0x045e ) &&
>         ( session->input->id.product == 0x0403 ) )
>      {
>      for ( i = 7; i >= 0; i -- ) skb->data[i + 1] = skb->data[i];
>      skb->data[0] = 0x01;
>      }
> 
>    again, is there a way to cope with this problem in a more generic
>    way?

I need one of these keyboard to actually find the correct to fix this.
While it might be likely that we need a HID quirk, I am not happy with
any weird changes in L2CAP without understanding the reasons for it.

Regards

Marcel



-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
