Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <938d66c7e3ba4933912f948240b2669f@FE-MBX1011.de.bosch.com>
References: <938d66c7e3ba4933912f948240b2669f@FE-MBX1011.de.bosch.com>
Date: Fri, 22 Jan 2016 15:33:34 +0200
Message-ID: <CABBYNZ+VyakQoiYV6=DkPux9ZCOB58BHRJGXU07UpxjzcJJr+Q@mail.gmail.com>
Subject: Re: [BUG] LEAdvertisingManager suffers from ObjectManager hierarchy
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: "Kasper Markus (ETAS-PSC/ECE1)" <Markus.Kasper@escrypt.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Markus,

On Thu, Jan 21, 2016 at 5:53 PM, Kasper Markus (ETAS-PSC/ECE1)
<Markus.Kasper@escrypt.com> wrote:
> Hi,
>
> I managed to get up my GATT Server using my patched BlueZ (I'm working on getting all clearances allowing me to contribute the patch to BlueZ, but this may take some weeks).
> Meanwhile I added the advertisement part to my code and found the LEAdvertisementManager1 to suffer from a similar problem as the GattManager:
> The DBUS ObjectManager is required to be in the same path as the managed objects. Luiz fixed a similar issue for the GattManager with his Patch from January, 5th by introducing the Application API.
> I'll again try to identify a solution for patching my working copy of BlueZ, but it may take a while until I am able to share it.

Actually LEAdvertisementManager1.RegisterAdvertisement does no
actually require ObjectManager, so the following shall probably work:

iff --git a/src/advertising.c b/src/advertising.c
index 59c8c3d..4b87d42 100644
--- a/src/advertising.c
+++ b/src/advertising.c
@@ -591,7 +591,7 @@ static struct advertisement
*advertisement_create(DBusConnection *conn,
                return NULL;

        ad = new0(struct advertisement, 1);
-       ad->client = g_dbus_client_new_full(conn, sender, path, path);
+       ad->client = g_dbus_client_new_full(conn, sender, path, NULL);
        if (!ad->client)
                goto fail;

> Re contributing:
> Are the guidelines within the repository up to date: "HACKING" "doc/coding-style.txt" "doc/maintainer-guidelines"?
> I'm a bit confused about Marcels recent remark re signed-off-by.

This refer to userspace:

'Commit messages for bluez.git shall not contain Signed-off-by
signatures. They are not used in userspace and with that it is the
maintainers job to ensure they do not get committed to the repository.'

And this to the kernel only:

'For bluetooth.git and bluetooth-next.git The Signed-off-by process is
used and the signatures are required.'

Perhaps it is a good idea to remove any reference to the kernel since
that has it already documented in the kernel itself, this should
probably remove any confusion.

> As I do not have any experiences in contributing to open source projects:
> Other hints/specialties I should be aware of to prepare a clean patch are welcome.
> Especially, the "how/where to commit/send?" is not really clear to me.

It is mostly documented, and don't take any comments from the review
process as a personal offense, it is all for making the code as clean
possible.

-- 
Luiz Augusto von Dentz
