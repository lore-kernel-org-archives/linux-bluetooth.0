Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Bluetooth device missing after kernel recompile
From: Marcel Holtmann <marcel@holtmann.org>
To: Mick Wever <hair@netbeans.org>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <pan.2004.03.29.08.17.54.697624@netbeans.org>
References: <pan.2004.03.29.08.17.54.697624@netbeans.org>
Content-Type: text/plain
Message-Id: <1080556737.2281.217.camel@pegasus>
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
Date: Mon, 29 Mar 2004 12:38:57 +0200

Hi Mick,

> After recompiling my kernel (2.6) bluetooth has stopped working for me.
> lsmod gives me the required modules.
> When I type 'hcitool scan' I get:
> "Device is not available.: Success".
> And 'hcitool inq' gives me:
> "Inquiring ...
> Inquiry failed.: No such device".
> 'hcitool dev' does not output any devices.

this means that your device is not detected. Does it show up in lsmod?
What kernel do you have changed? What do lspci say?

> What am I missing? What is the /dev device file that is used? How do I
> create the local device again if that is what's needed?

Come on, do you ever created the eth0 device under /dev? This is
networking, so no device nodes are needed.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
