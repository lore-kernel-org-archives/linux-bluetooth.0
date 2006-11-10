Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <e1effdeb0611101009t24de879fk3bca7ed96821514e@mail.gmail.com>
Date: Fri, 10 Nov 2006 15:09:55 -0300
From: "Claudio Takahasi" <cktakahasi@gmail.com>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
In-Reply-To: <200611091149.13916.denis.kenzior@trolltech.com>
MIME-Version: 1.0
References: <200610231025.51818.denis.kenzior@trolltech.com>
	<200610241647.20895.denis.kenzior@trolltech.com>
	<1162214837.24333.69.camel@localhost>
	<200611091149.13916.denis.kenzior@trolltech.com>
Subject: Re: [Bluez-devel] Proposed DTD
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

On 11/8/06, Denis KENZIOR <denis.kenzior@trolltech.com> wrote:
> Marcel,
>
> On Monday 30 October 2006 23:27, Marcel Holtmann wrote:
> > Hi Denis,
> >
> >
> > to get this started, I like to see the method
> >
> > string GetRemoteServiceRecordAsXML(string address, uint32 handle)
> >
> > from the org.bluez.Adapter interface gets implemented and make it using
> > the simple service-record.dtd I put into the CVS.
>
> Here's a patch that imlements
>
> string GetRemoteServiceRecordAsXML(string address, uint32 handle)
>
> >
> > I choose to simplify the DTD a lot. After having a discussion about XML
>
> Yes, I saw this.  I have made some changes to the DTD however.  Mainly I've
> added the int* data types and have removed the 'data' type since it was not
> used anywhere anymore.
>
> > and binary representation from the SDP part of the specification, I am
> > pretty certain, that we should support both. The binary representation
> > will cover all tasks ever possible with SDP and it is the default. For
> > convenience we will additionally support XML as record description, but
> > it will only cover up to 90% of all cases, but it will be simpler to use
> > and easier to understand and that should be fine.
> >
>
> I'm concerned about this.  BlueZ dbus developers have explicitly and
> repeatedly stated that their intent is to make the dbus interface as
> high-level as possible.  This is why the interface is so nice and easy to
> use, particularly from languages other than C.  Binary SDP record
> representation/registration just does not fit.  I would strongly encourage
> that we adopt an XML format for both view and registration of SDP records,
> and that it should be the default.
>
> There's also the issue of GPL.  Anybody who wants to create such binary
> records and cannot link against the GPL'd libbluetooth would need to spend
> (perhaps considerable) time duplicating what is already there in order to
> produce such data structures.
>
> > This means that all length fields are not represented in XML. They will
> > be chosen automatically as needed. The same applies to the UUID. So it
> > leaves only int* and uint* where the actual size will be taken care of
> > as part of the type name.
>
> I totally agree with this and this was my original thought as well.  Hopefully
> the dtd is getting closer to being finalized.  This reminds me, do you still
> want to base sdptool on XML if an appropriate (no external dependency) parser
> is written?  I don't want to spend time on this unless it is wanted and the
> DTD is stabilized.
>
> Regards,
> Denis
>
>
> -------------------------------------------------------------------------
> Using Tomcat but need to do more? Need to support web services, security?
> Get stuff done quickly with pre-integrated technology to make your job easier
> Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
> http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
>
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel
>
>
>
>

Hi Denis,

the patch is in cvs now!

The sdp-xml.* were moved to common directory.

Some points to be improved:
1. append_and_grow_string: avoid a lot of strlen calls and string copy
2. Analyze if it is possible use sdp_buf_t instead of string_t
3. I got some system bus disconnection messages when calling
GetRemoteServiceRecordAsXML consecutively. We need fix this bug.

BR,
Claudio.
-- 
---------------------------------------------------------
Claudio Takahasi
Instituto Nokia de Tecnologia - INdT

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
