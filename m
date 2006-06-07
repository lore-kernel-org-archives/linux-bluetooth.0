Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
To: bluez-devel@lists.sourceforge.net
From: Robert Wlaschin <robertw@healthhero.com>
Date: Wed, 7 Jun 2006 16:36:15 +0000 (UTC)
Message-ID: <loom.20060607T182956-173@post.gmane.org>
References: <F23ABFFDB8261D40A6F6D30EA014882501CE8E24@VS6.EXCHPROD.USA.NET>
	<1149664409.22472.1.camel@localhost>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] rfcomm (utils)
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

Marcel Holtmann <marcel <at> holtmann.org> writes:

> 
> Hi Robert,
> 
> > In poking around in \bluez-utils-2.21\rfcomm\main.c, I noticed in
> > several functions (including print_dev_list) there seems to be a malloc
> > statement but no corresponding free.  Is this the recommended way to
> > handle the rfcomm_dev_list_req structures?
> 
> this seems to be a bug, but I would prefer you actually check the latest
> version from CVS instead of an old package and be more specific of the
> cases you are talking about. Otherwise we can fix them.
> 
> Regards
> 
> Marcel
> 

Marcel,

After reading some of the other posts I came to find out that diff -u is the
preferred format.  This is using utils/rfcomm/main.c v 1.18 from the CVS 
repository.

--- bluez-utils/rfcomm/main.c.orig 2006-06-07 09:20:23.180048500 -0700
+++ bluez-utils/rfcomm/main.c.new  2006-06-07 09:21:34.899257500 -0700
@@ -132,11 +132,14 @@
 
        if (ioctl(ctl, RFCOMMGETDEVLIST, (void *) dl) < 0) {
                perror("Can't get device list");
+               free(dl);
                exit(1);
        }
 
        for (i = 0; i < dl->dev_num; i++)
                print_dev_info(di + i);
+
+       free(dl);
 }
 
 static int create_dev(int ctl, int dev, uint32_t flags, bdaddr_t *bdaddr, int
argc, char **argv)
@@ -243,12 +246,15 @@
 
        if (ioctl(ctl, RFCOMMGETDEVLIST, (void *) dl) < 0) {
                perror("Can't get device list");
+               free(dl);
                exit(1);
        }
 
        for (i = 0; i < dl->dev_num; i++)
                release_dev(ctl, (di + i)->id, 0);
 
+       free(dl);
+
        return 0;
 }

Thanks,
Robert



_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
