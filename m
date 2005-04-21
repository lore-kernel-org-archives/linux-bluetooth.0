Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
Content-Type: text/plain
Message-Id: <1114094787.32265.11.camel@pegasus>
Mime-Version: 1.0
Subject: [Bluez-devel] Support for stored link keys
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Thu, 21 Apr 2005 16:46:26 +0200

Hi Folks,

the new support for storing the link keys in an ASCII base format
under /var/lib/bluetooth is now part of the bluez-utils-2.16 release and
I am now thinking of adding support for stored link keys. This would be
very useful for people in multi-boot environments, I think.

However there are some other things first, that should be addressed. The
path for /var/lib/bluetooth is hardcoded into hcid/storage.c at the
moment and that is a bad think. I actually forgot to think about that
problem before I released it.

In the long term there will be config options for the embedded guys to
fully override all storage parameters, but that is future talk. What I
wanna do now is use ${localstatedir} to define the storage place at
compilation time. This means you can add --localstatedir=/var to your
configure command. Do you think that is the right way? Another thing is
if we should use /var/lib64/bluetooth on 64-bit platforms? What is the
deal for the /var directory on these architectures?

Now back to the stored link keys issue. I think about adding a "key"
option to hciconfig which allows you to list all link keys and also to
move specific ones (specified by a BD_ADDR) for storage on the chip. The
question is what should we do with the link key in the linkkeys storage
file? Keep it or delete it afterwards?

I also wanna let hcid retrieve all stored link keys when a new device is
plugged in or configured. Should we then store these keys in the
linkkeys file or cache them only in memory? What we get from link key
notify is obvious a valid key, but the stored ones could be wrong. On
the other side you can also put invalid keys in the linkkeys file very
easy.

Please post your thoughts.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by: New Crystal Reports XI.
Version 11 adds new functionality designed to reduce time involved in
creating, integrating, and deploying reporting solutions. Free runtime info,
new features, or free trial, at: http://www.businessobjects.com/devxi/728
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
