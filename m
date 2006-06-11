Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <448C81FC.50509@xmission.com>
Date: Sun, 11 Jun 2006 14:50:04 -0600
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
References: <85cea3460606111303r218e088ek21d50709fce3c6df@mail.gmail.com>
In-Reply-To: <85cea3460606111303r218e088ek21d50709fce3c6df@mail.gmail.com>
Subject: Re: [Bluez-devel] btsco and connection problems
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Sweta

> [root@lirr ~]# hcitool info 00:07:A4:26:8D:3F
> Requesting information ...
> Can't create connection: Connection timed out

> [root@lirr ~]# btsco 00:07:A4:26:8D:3F
> Error: Failed to connect to SDP server: Function not implemented
> Assuming channel 2
> 
> Can't connect RFCOMM channel: Resource temporarily unavailable

something more fundamental is wrong with your setup if you can't get the
rfcomm channel connected or an sdp scan. is the headset in pairing mode
when you are trying this stuff?

make sure /etc/bluetooth/hcid.conf has not been customized, try
restarting the bluez utils, etc. that's the sort of thing I do, but
there are probably more systematic ways of narrowing down the problem.

brad


_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
