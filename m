Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] New Bluetooth kernel patches available
From: Marcel Holtmann <marcel@holtmann.org>
To: Aaron Klish <aklish1@urbana.css.mot.com>
Cc: Aaron Klish <AKLISH1@motorola.com>,
   BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <Pine.GSO.4.20.0312181152220.13041-100000@wombat.urbana.css.mot.com>
References: 
	 <Pine.GSO.4.20.0312181152220.13041-100000@wombat.urbana.css.mot.com>
Content-Type: text/plain
Message-Id: <1071770615.2605.15.camel@pegasus>
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
Date: Thu, 18 Dec 2003 19:03:35 +0100

Hi Aaron,

>   We have found a few problems through our initial qualification efforts and
> hopefully we'll be able to release info/patches for those soon.  More of the
> current problems stem from SDP and not the kernel though.  

the SDP code will undergo a complete rewrite, but at the moment only the
client side is ready. However we are also taking SDP patches for the
current version, because I haven't set any date where the new Bluetooth
library should be ready.

If you found bugs in the kernel layers, please go with them first and
always include a binary hcidump, so we can check what was going on.

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
