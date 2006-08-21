Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <8712867d0608211020y4247cda2hd2ed14f2c05a62d8@mail.gmail.com>
Date: Mon, 21 Aug 2006 12:20:42 -0500
From: "Jaime Alberto Silva" <jaimealbertosilva@gmail.com>
To: "BlueZ users" <bluez-users@lists.sourceforge.net>
In-Reply-To: <BAY112-F62602D74DC8BC513D55C4E9400@phx.gbl>
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_79110_8519546.1156180842267"
References: <BAY112-F193F49DA8B7C4EF7C0A893E9400@phx.gbl>
	<BAY112-F62602D74DC8BC513D55C4E9400@phx.gbl>
Subject: Re: [Bluez-users] pairing was gone, cant pair
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

------=_Part_79110_8519546.1156180842267
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

I'm having the same problem in Debian etch, since the last update on
last saturday (19 aug) neither my nokia 6670  or my Palm Tungsten T1
can't locate the PC via bluetooth, when I run hcitool scan It locates
both devices but the devices can't locate the PC. I'm also using the
hcid.conf file that comes with the packages and according to the
manual the PC must be discoverable.

On 8/20/06, bram diederik <daft_dutch@hotmail.com> wrote:
> an other phone can see my oc and can pair. i think my phone is dieing on me.
>
>
>
> >From: "bram diederik" <daft_dutch@hotmail.com>
> >Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
> >To: bluez-users@lists.sourceforge.net
> >Subject: [Bluez-users] pairing was gone, cant pair
> >Date: Mon, 21 Aug 2006 00:52:09 +0200
> >
> >I wanted to backup my phonebook again with bluetooth ofc.
> >but the pairing wasnt working any more. tryed any thing. at the end i
> >apt-get --purged <the lot>
> >and then reinstalled.
> >
> >still i cant pair.
> >the phone cant find the computer, and the computer can find the phone but
> >the default key is not accepted.
> >
> >Im using debian sid. and at the moment the config files are the standard
> >configs of apt-get
> >
> >I hope some one can help me with this.
> >chears
> >
> >bram diederik
> >
> >
> >
> >-------------------------------------------------------------------------
> >Using Tomcat but need to do more? Need to support web services, security?
> >Get stuff done quickly with pre-integrated technology to make your job
> >easier
> >Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
> >http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
> >_______________________________________________
> >Bluez-users mailing list
> >Bluez-users@lists.sourceforge.net
> >https://lists.sourceforge.net/lists/listinfo/bluez-users
>
>
>
> -------------------------------------------------------------------------
> Using Tomcat but need to do more? Need to support web services, security?
> Get stuff done quickly with pre-integrated technology to make your job easier
> Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
> http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users
>


-- 
Jaime Alberto Silva       L I N U X       .~.
                                   The Choice     /V\
                                    of a GNU      / ( ) \
                                   Generation    ^^-^^

------=_Part_79110_8519546.1156180842267
Content-Type: application/octet-stream; name=hcid.conf
Content-Transfer-Encoding: base64
X-Attachment-Id: f_er54711v
Content-Disposition: attachment; filename="hcid.conf"

IwojIEhDSSBkYWVtb24gY29uZmlndXJhdGlvbiBmaWxlLgojCgojIEhDSWQgb3B0aW9ucwpvcHRp
b25zIHsKCSMgQXV0b21hdGljYWxseSBpbml0aWFsaXplIG5ldyBkZXZpY2VzCglhdXRvaW5pdCB5
ZXM7CgoJIyBTZWN1cml0eSBNYW5hZ2VyIG1vZGUKCSMgICBub25lIC0gU2VjdXJpdHkgbWFuYWdl
ciBkaXNhYmxlZAoJIyAgIGF1dG8gLSBVc2UgbG9jYWwgUElOIGZvciBpbmNvbWluZyBjb25uZWN0
aW9ucwoJIyAgIHVzZXIgLSBBbHdheXMgYXNrIHVzZXIgZm9yIGEgUElOCgkjCglzZWN1cml0eSBh
dXRvOwoKCSMgUGFpcmluZyBtb2RlCgkjICAgbm9uZSAgLSBQYWlyaW5nIGRpc2FibGVkCgkjICAg
bXVsdGkgLSBBbGxvdyBwYWlyaW5nIHdpdGggYWxyZWFkeSBwYWlyZWQgZGV2aWNlcwoJIyAgIG9u
Y2UgIC0gUGFpciBvbmNlIGFuZCBkZW55IHN1Y2Nlc3NpdmUgYXR0ZW1wdHMKCXBhaXJpbmcgbXVs
dGk7CgoJIyBEZWZhdWx0IFBJTiBjb2RlIGZvciBpbmNvbWluZyBjb25uZWN0aW9ucwoJcGFzc2tl
eSAiMTIzNCI7Cn0KCiMgRGVmYXVsdCBzZXR0aW5ncyBmb3IgSENJIGRldmljZXMKZGV2aWNlIHsK
CSMgTG9jYWwgZGV2aWNlIG5hbWUKCSMgICAlZCAtIGRldmljZSBpZAoJIyAgICVoIC0gaG9zdCBu
YW1lCgluYW1lICIlaC0lZCI7CgoJIyBMb2NhbCBkZXZpY2UgY2xhc3MKCWNsYXNzIDB4M2UwMTAw
OwoKCSMgRGVmYXVsdCBwYWNrZXQgdHlwZQoJI3BrdF90eXBlIERIMSxETTEsSFYxOwoKCSMgSW5x
dWlyeSBhbmQgUGFnZSBzY2FuCglpc2NhbiBlbmFibGU7IHBzY2FuIGVuYWJsZTsKCgkjIERlZmF1
bHQgbGluayBtb2RlCgkjICAgbm9uZSAgIC0gbm8gc3BlY2lmaWMgcG9saWN5IAoJIyAgIGFjY2Vw
dCAtIGFsd2F5cyBhY2NlcHQgaW5jb21pbmcgY29ubmVjdGlvbnMKCSMgICBtYXN0ZXIgLSBiZWNv
bWUgbWFzdGVyIG9uIGluY29taW5nIGNvbm5lY3Rpb25zLAoJIyAgICAgICAgICAgIGRlbnkgcm9s
ZSBzd2l0Y2ggb24gb3V0Z29pbmcgY29ubmVjdGlvbnMKCWxtIGFjY2VwdDsKCgkjIERlZmF1bHQg
bGluayBwb2xpY3kKCSMgICBub25lICAgIC0gbm8gc3BlY2lmaWMgcG9saWN5CgkjICAgcnN3aXRj
aCAtIGFsbG93IHJvbGUgc3dpdGNoCgkjICAgaG9sZCAgICAtIGFsbG93IGhvbGQgbW9kZQoJIyAg
IHNuaWZmICAgLSBhbGxvdyBzbmlmZiBtb2RlCgkjICAgcGFyayAgICAtIGFsbG93IHBhcmsgbW9k
ZQoJbHAgcnN3aXRjaCxob2xkLHNuaWZmLHBhcms7Cn0K
------=_Part_79110_8519546.1156180842267
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
------=_Part_79110_8519546.1156180842267
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

------=_Part_79110_8519546.1156180842267--
