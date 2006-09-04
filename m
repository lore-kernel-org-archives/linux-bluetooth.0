Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <5f30e2610609041513o8a2709bifd465e61e946261@mail.gmail.com>
Date: Mon, 4 Sep 2006 17:13:17 -0500
From: "Jeff Wilson" <jazzbotley@gmail.com>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1157318936.32195.9.camel@aeonflux.holtmann.net>
MIME-Version: 1.0
References: <5f30e2610609021024j205f6a51id3d4b3c0f9129a3e@mail.gmail.com>
	<1157318936.32195.9.camel@aeonflux.holtmann.net>
Subject: Re: [Bluez-devel] off-by-one bugfix for sdp_data_alloc
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

Oh, I get it.  I was looking at where it was published
(sdp_set_info_attr), but now I see where it's queried (from `sdptool
browse`).  So maybe this patch is more appropriate.

     Regards,
      Jeff


--- bluez-libs-3.4/src/sdp.c    2006-08-24 20:16:12.000000000 -0500
+++ bluez-libs-3.4/src/sdp.c.mod        2006-09-04 17:07:56.000000000 -0500
@@ -1148,13 +1148,13 @@
 {
        sdp_data_t *d = sdp_data_get(rec, SDP_ATTR_SVCNAME_PRIMARY);
        if (d)
-               printf("Service Name: %s\n", d->val.str);
+               printf("Service Name: %.*s\n", d->unitSize, d->val.str);
        d = sdp_data_get(rec, SDP_ATTR_SVCDESC_PRIMARY);
        if (d)
-               printf("Service Description: %s\n", d->val.str);
+               printf("Service Description: %.*s\n", d->unitSize, d->val.str);
        d = sdp_data_get(rec, SDP_ATTR_PROVNAME_PRIMARY);
        if (d)
-               printf("Service Provider: %s\n", d->val.str);
+               printf("Service Provider: %.*s\n", d->unitSize, d->val.str);
 }

 #ifdef SDP_DEBUG


On 9/3/06, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi Jeff,
>
> > The following patch against bluez-libs-3.4 fixes a problem where the
> > last character of a null-terminated string is lost.  Adding the +1
> > accounts for and preserves the null terminator.
>
> the SDP strings are not NULL terminated strings. They a prefixed with a
> length value. So what is the reason for storing the NULL terminator in
> the records? Show me an example what actually goes wrong here.
>
> Regards
>
> Marcel
>
>
>
> -------------------------------------------------------------------------
> Using Tomcat but need to do more? Need to support web services, security?
> Get stuff done quickly with pre-integrated technology to make your job easier
> Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
> http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel
>

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
