Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] error on connect
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <4265329A.3030100@gmx.ch>
References: <425FFF54.6000701@gmx.ch> <1113607202.16433.42.camel@pegasus>
	 <42616275.1090103@gmx.ch> <1113682195.18450.0.camel@pegasus>
	 <4261BCFB.8040204@gmx.ch> <1113702363.18450.26.camel@pegasus>
	 <426237CF.5060604@gmx.ch>  <4263F8DF.1040400@gmx.ch>
	 <1113849662.16233.118.camel@pegasus>  <42651A2E.2080601@gmx.ch>
	 <1113923580.2469.7.camel@pegasus>  <426522C6.10700@gmx.ch>
	 <1113925620.2469.26.camel@pegasus>  <42652B35.7060803@gmx.ch>
	 <1113927187.2469.40.camel@pegasus>  <4265329A.3030100@gmx.ch>
Content-Type: text/plain
Message-Id: <1113929462.2469.52.camel@pegasus>
Mime-Version: 1.0
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
Date: Tue, 19 Apr 2005 18:51:02 +0200

Hi Marco,

> Do I get this right:
> - The ACL packet that cause the problem is sent before the connection is 
> etablished. This is ok and defined in the specification.

this is not ok and can also not happen since you only get the connection
handle from the connect complete event. In BlueZ this is indicated with
the hci_proto_connect_cfm() and only at that time the L2CAP layer starts
sending out its connect request. Please check the sender side again.

> - The received dongle is responsible to keep this packet back until the 
> connection is etablished and process them then.

In general yes, they should queue the data packet.

> - the csr dongles seem to handle this correct.

So far I've never seen this problem with a CSR dongle. Not even with the
very old ones.

> - the broadcom dongle seem to don't handle this correct. they probably 
> suffer a race condition. so they may work or may not work.

Maybe the stacks Broadcom tested their dongles with are needing some
time before they can send out the first ACL data packet. Or they do
other HCI tasks before they start L2CAP. However this is a problem with
the dongle, because the ACL data packet is not allowed at that time.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by: New Crystal Reports XI.
Version 11 adds new functionality designed to reduce time involved in
creating, integrating, and deploying reporting solutions. Free runtime info,
new features, or free trial, at: http://www.businessobjects.com/devxi/728
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
