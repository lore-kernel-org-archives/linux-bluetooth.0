Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Re: Jerky MX900 mouse movement with 2.6.7-mh1,
	hidp and hidd
From: Marcel Holtmann <marcel@holtmann.org>
To: Vesa Halttunen <vesuri@jormas.com>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <1087763282.1232.17.camel@pc.vesuri.net>
References: <1087757523.839.10.camel@pc.vesuri.net>
	 <1087767604.4781.52.camel@pegasus>  <1087760721.1232.5.camel@pc.vesuri.net>
	 <1087770579.4781.59.camel@pegasus> <1087763282.1232.17.camel@pc.vesuri.net>
Content-Type: text/plain
Message-Id: <1087765554.4781.67.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Sun, 20 Jun 2004 23:05:55 +0200

Hi Vesa,

> > you really should, because I have seen that HID devices don't really
> > like if they can't switch into sniff mode. And if you don't enable role
> > switch your host can't become the master and so can't join your mouse
> > and keyboard into one piconet. Thus you get a scatternet and this can
> > cause troubles.
> 
> I'm sorry but I don't know how. Could someone tell me?

actually if you use the default hcid.conf from bluez-utils-2.7 and
startup hcid this should be all done at device init. If not, then you
must use "hciconfig hci0 lp ..." for it.

hci0:   Type: USB
        BD Address: 00:02:xx:xx:xx:xx ACL MTU: 384:8  SCO MTU: 64:8
        Link policy: RSWITCH HOLD SNIFF PARK 

> hcitool con shows the keyboard and the mouse as follows:
> Connections:
>         > ACL ..:..:..:..:..:.. handle 44 state 1 lm MASTER
>         > ACL ..:..:..:..:..:.. handle 41 state 1 lm MASTER

This is the outgoing case and that is never a problem. But the devices
reconnect and then you will see two slaves and this means scatternet.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by The 2004 JavaOne(SM) Conference
Learn from the experts at JavaOne(SM), Sun's Worldwide Java Developer
Conference, June 28 - July 1 at the Moscone Center in San Francisco, CA
REGISTER AND SAVE! http://java.sun.com/javaone/sf Priority Code NWMGYKND
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
