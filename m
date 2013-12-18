Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: "linux-bluetooth@vger.kernel.org development" <linux-bluetooth@vger.kernel.org>
Subject: Re: [RFC 0/4] android: Permanent storage support
Date: Wed, 18 Dec 2013 13:23:40 +0100
Message-ID: <1743761.bXhrtg3e4W@uw000953>
In-Reply-To: <3D8D935B-BE1E-4158-B2F5-8F49851A718C@holtmann.org>
References: <1387365660-25281-1-git-send-email-szymon.janc@tieto.com> <3D8D935B-BE1E-4158-B2F5-8F49851A718C@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

> Hi Szymon,
> 
> > This is first RFC for storage format for Android daemon.
> > 
> > Some highlights:
> > - storage is much simple in format than Linux daemon (no addresses in paths
> >  or filenames, only 1 adapter support etc)
> > - only info that requires persistency  over daemon lifetime from Framework
> >  perspective is stored
> > - settings file for adapter config
> > - devices file for remote device info (groups are remote devices addresses)
> > - Android storage path is /data/misc/bluez (I've decided to not use
> >  /data/misc/bluetooth to avoid any clashes as there still seems to be
> >  leftovers available in Android tree eg. there are still references to that
> >  directory in CTS testcases and init files of Android 4.4)
> 
> I would use /data/misc/bluetooth actually. Especially since the daemon is also called bluetoothd and not bluezd.
> 
> What is the impact on just using /data/misc/bluetooth and see if anything really breaks.

OK, this will require proper chown in device init.rc (as it is set to system/system
in system/core/rootdir/init.rc), but that would be needed for /data/misc/bluez path
anyway...

> 
> > I'm not sure how to handle storage on Linux host so for now it is set to
> > STORAGEDIR/android/ directory (if directory is missing it is not created
> > by daemon).
> 
> That is actually fine. Works for me.
> 
> > Storage format is as following sample:
> > 
> > settings file:
> > [General]
> > Address=20:68:9D:3A:52:5E
> > Name=BlueZ Android
> > DiscoverableTimeout=0
> > 
> > devices file:
> > [00:0D:3C:B1:C4:AC]
> > Type=0
> > Name=Nokia BH-503
> > Class=2360324
> > LinkKey=0x306A400930B0AE36D7AC45D8DC50F1A0
> 
> I would leave the 0x out of it. Just make it a hex encoded string.

OK.

> 
> > LinkKeyType=0
> > LinkKeyPINLength=4
> > Services=0x0000110B00001000800000805F9B34FB;0x0000110C00001000800000805F9B34FB;0x0000110E00001000800000805F9B34FB;0x0000111E00001000800000805F9B34FB;0x0000110800001000800000805F9B34FB;
> 
> Lets store these as UUID strings. We convert between them anyway.

We actually don't use strings in Android daemon and keep UUIDs as 16bytes
arrays (same format as HAL expects).
So we would first need to convert to bt_uuid_t to be able to use lib/uuid.h
uuid<->string helpers. We could also just add '-' where needed while converting
array to hexstring if that really improves readability.

> 
> > [00:1F:20:17:87:D7]
> > Type=0
> > Name=Bluetooth Laser Travel Mouse
> > Class=9600
> > LinkKey=0x3725CC552EAB8AB82D843BFEB14D2E47
> > LinkKeyType=0
> > LinkKeyPINLength=4
> > Services=0x0000112400001000800000805F9B34FB;0x0000120000001000800000805F9B34FB;
> > 
> > [40:B0:FA:39:FF:B8]
> > Type=0
> > Name=Nexus 4
> > Class=5898764
> > LinkKey=0x1E201EE8E82E1E50682622077D372F20
> > LinkKeyType=5
> > LinkKeyPINLength=0
> > Services=0x0000180100001000800000805F9B34FB;0x0000180000001000800000805F9B34FB;0x0000111200001000800000805F9B34FB;0x0000111F00001000800000805F9B34FB;0x0000110C00001000800000805F9B34FB;0x0000110A00001000800000805F9B34FB;0x0000110E00001000800000805F9B34FB;0x0000111600001000800000805F9B34FB;0x0000111500001000800000805F9B34FB;0x0000113200001000800000805F9B34FB;0x0000112F00001000800000805F9B34FB;0x0000110500001000800000805F9B34FB;
> > 
> > 
> > Comments are welcome.
> 
> I think the only discussion we could have is if we want to store them as 1 file per remote device or all devices in one file. I am personally fine with this approach since it is a limited scope with Android anyway. Also upgrading to a more complex storage later is easily possible.

FWIW, we could also always keep g_key_file in memory and only write on update
(to reduce reads). And that would be more complicated if we use multiple files.

-- 
BR
Szymon Janc
