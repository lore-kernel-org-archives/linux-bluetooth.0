Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] bt3c for 2.6 kernel ?
From: Marcel Holtmann <marcel@holtmann.org>
To: Olivier Bornet <olivier.bornet@smartdata.ch>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <20040103005555.GA15894@smartdata.ch>
References: <20040103005555.GA15894@smartdata.ch>
Content-Type: text/plain
Message-Id: <1073094243.25261.85.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Sat, 03 Jan 2004 02:44:03 +0100

Hi Olivier,

> is someone planning to port bt3c for the 3Com cards to the 2.6 kernel ?

the bt3c_cs should be rewritten to use the request_firmware() interface.

> Another part not compiling on 2.6 is the bluefw. Is someone working on
> this ?

I don't wanna keep the bluefw program. For the Broadcom devices the new
bcm203x driver (from -mh2) can be used.

Regards

Marcel




-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
