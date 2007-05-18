Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="----_=_NextPart_001_01C79981.3B9D380E"
Date: Fri, 18 May 2007 21:17:53 +0200
Message-ID: <CE5216C10C83944D9FD37B65CD33F3970CF4E1@mplex01.mpl.access-company.com>
References: <200705170207.52710.bluez-devel@huitl.de>	<d89ddf300705162042j1850b997wd069bae29e813d29@mail.gmail.com>	<200705171521.38889.bluez-devel@huitl.de>	<464C7616.9070900@nnytech.net><d89ddf300705180613u5c24ed8brab0acf3f7ee65280@mail.gmail.com>
	<464DCCC4.90300@nnytech.net>
From: "Frederic Dalleau" <Frederic.Dalleau@access-company.com>
To: <feig@nnytech.net>,
        "BlueZ development" <bluez-devel@lists.sourceforge.net>
Subject: [Bluez-devel] RE :  Frequent headset disconnects
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

This is a multi-part message in MIME format.

------_=_NextPart_001_01C79981.3B9D380E
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi,
I did some recent changes and there are things to solve.
I don't have access to a linux computer right now.=20
In your case, enclosing the write call in a while loop may help.

do {
            if ((written =3D write(a2dp->sk, a2dp->buf, a2dp->len)) !=3D =

a2dp->len) {
                        // Return the error
                        result =3D written;
            }
} while(written<0 && errno=3D=3DEAGAIN);

Remove the DBG call.

However, it may burn cpu time if you don't wait a little before =
retrying.


The best solution would be to find why the packet must be resent.
Let us know if you get something.

Frederic.


-------- Message d'origine--------
De: bluez-devel-bounces@lists.sourceforge.net de la part de John Feig
Date: ven. 18/05/2007 17:56
=C0: BlueZ development
Objet : Re: [Bluez-devel] Frequent headset disconnects
=20
Brad Midgley wrote:
> *John
>
> *
>
>
>     I've been using the a2dpd app for a couple of weeks now, and
>     really like
>     it. I have a few issues though, with the main one being that after =
a
>     couple of minutes of playback, my headphones (HT820) turn off
>
>
> it looks like alsa_transfer_raw returns -1 once and then a2dpd closes=20
> the connection. Maybe we should be checking for an error state that=20
> indicates we can retry or maybe we should retry a few times =
regardless.
>
> it could be the set turns off because of the way we terminate the=20
> connection. This is mostly Frederic's playground but I remember=20
> locking up headsets with a2play by accidentally sending data on the=20
> stream fd after we had signaled a stream close on the control fd.
>
> brad
Brad, thank you for the reply. To try to understand this, you're saying=20
that when I get:

a2dp_transfer_raw: Wrote -1 not 603 bytes (sbc.len=3D118)
transfer_outgoing_packets: Error in transfer (transfer=3D-1)

The issue could be that the headset is expecting a value of a certain=20
length, and since the value -1 is not that length, the headset doens't=20
like that, and shuts down? If this is the case, where should I look to=20
change that value, and what should it be changed to? I wouldn't mind=20
sending some dummy data and have it drop out for a second once in a=20
while, as long as I don't have to keep restarting the thing. At least it =

would be a temporary fix.

I found the IF block in a2dpd_output_a2dp.c:

if (a2dp->sk > 0) {
    // Pause?
    // The value 0 have finally been tested ;)
    // However, we may safely simulate a failed write
    if (!a2dp->pause_writing) {
        // Send our data
            if ((written =3D write(a2dp->sk, a2dp->buf, a2dp->len)) !=3D =

a2dp->len) {
                // Error while sending data
                    DBG("Wrote %d not %d bytes (sbc.len=3D%d)", written, =

a2dp->len, a2dp->sbc.len);
                        // Return the error
                        result =3D written;
            }
...

That seems to be the only place that contains that string, that I could=20
find. I can't find out where the function "write" is defined either.

I'll keep looking, and if you guys can give me some suggestions of=20
things to try and what I should be looking at, I will and let you all=20
know how it goes.

Thanks again,
John


------_=_NextPart_001_01C79981.3B9D380E
Content-Type: application/ms-tnef;
	name="winmail.dat"
Content-Transfer-Encoding: base64

eJ8+IjYTAQaQCAAEAAAAAAABAAEAAQeQBgAIAAAA5AQAAAAAAADoAAEIgAcAGAAAAElQTS5NaWNy
b3NvZnQgTWFpbC5Ob3RlADEIAQ2ABAACAAAAAgACAAEEgAEAMAAAAFJFIDogW0JsdWV6LWRldmVs
XSBGcmVxdWVudCBoZWFkc2V0IGRpc2Nvbm5lY3RzAC0RAQWAAwAOAAAA1wcFABIAFQARADUABQBV
AQEggAMADgAAANcHBQASABUAEQA1AAUAVQEBCYABACEAAAA2MkVGQzA1NEQwRTQ4OTQzQUNEODAz
MjREMjRGMkMwRgA4BwEDkAYAHBEAADkAAAADACYAAAAAAAMANgAAAAAAQAA5AA44nTuBmccBHgA9
AAEAAAABAAAAAAAAAAIBRwABAAAAOAAAAGM9VVM7YT0gO3A9QWNjZXNzLUNvbXBhbnk7bD1NUExF
WDAxLTA3MDUxODE5MTc1M1otNDM2MzEAHgBJAAEAAAAvAAAAUmU6IFtCbHVlei1kZXZlbF0gRnJl
cXVlbnQgaGVhZHNldCBkaXNjb25uZWN0cwAAQABOAAC6fyZlmccBHgBaAAEAAAAqAAAAYmx1ZXot
ZGV2ZWwtYm91bmNlc0BsaXN0cy5zb3VyY2Vmb3JnZS5uZXQAAAACAVsAAQAAAHEAAAAAAAAAgSsf
pL6jEBmdbgDdAQ9UAgAAAABibHVlei1kZXZlbC1ib3VuY2VzQGxpc3RzLnNvdXJjZWZvcmdlLm5l
dABTTVRQAGJsdWV6LWRldmVsLWJvdW5jZXNAbGlzdHMuc291cmNlZm9yZ2UubmV0AAAAAAIBXAAB
AAAALwAAAFNNVFA6QkxVRVotREVWRUwtQk9VTkNFU0BMSVNUUy5TT1VSQ0VGT1JHRS5ORVQAAB4A
XQABAAAACgAAAEpvaG4gRmVpZwAAAAIBXgABAAAAOAAAAAAAAACBKx+kvqMQGZ1uAN0BD1QCAAAA
AEpvaG4gRmVpZwBTTVRQAGZlaWdAbm55dGVjaC5uZXQAAgFfAAEAAAAWAAAAU01UUDpGRUlHQE5O
WVRFQ0guTkVUAAAAHgBmAAEAAAAFAAAAU01UUAAAAAAeAGcAAQAAACoAAABibHVlei1kZXZlbC1i
b3VuY2VzQGxpc3RzLnNvdXJjZWZvcmdlLm5ldAAAAB4AaAABAAAABQAAAFNNVFAAAAAAHgBpAAEA
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
peaiqiIgCfBzIlHvpYVwcmkipkVoJDAEICIg+HduP1+ggUKEVHSzJiP/l4GWMnZUHiBwAiECHcQf
RP9pFKRTpkQoUGlBdkU9wXaz+x9iH+FvrEFD9CJCa0EeYMcdxIr2HoNkdW1skYtz9x/CIoM9wWQD
YCjgnVFhhf8RIFnBHmBygygDHcQoUy2R/3BBAiCkEQQgIgshEUXAk+D/NWIBkAAgJtZJBBFgqHIm
IP+jQXjWRAcjcA6wJBAFsArA+ykgRMB4KYseIAIQhkInEvxJRk6BiAEn82ECnUIkIXJfLRIuY5gr
K8ItFiCvXKBtwTBqMmFQgOI/xNv/QuKkVBFQIoNEwWRTYANrgfsOsB5gO5xVMiU9N3YRKQL/TJBm
cIrCB3A1oHhiZlELcO+OcidTNogrwiEtFAqwgPH+XydSIMEwTzJSBmC3oiXh/4tyNo8rvyzPLd8u
7y//MY8/nnQoVIr61x/RlzvhKCJ9miQlHmCastxxmz3ccCn+ImeB0rQmUNXt1CabpTpWf9q/Mf8z
D+R/NS82PzdMLu/okEIssRIJ4G0g839lAiD/ZHELUabTaUGQEgtxZwKxEv9BUCDBkpOGon8EHcRE
wmXCv3pBIlFEw7bCrbQnEmZPcfVDsyInUyKEcgEBTUEeYPdScCACv0wnJ9G683AC7OPzH8JIFnV5
BCB6Qk0wIqH3HqEeg+YAZx+BQ7Jro5bW/yDGfDOwxh4gdkj0BR+wqzH/stEDEAMgH8IogAVAP0In
wv8dxEfDZzBH8QVAnYAHkOi+f5LgH6F9UAuAHbVc2Ob0fQEAwAAAAB4ANRABAAAASAAAADxDRTUy
MTZDMTBDODM5NDREOUZEMzdCNjVDRDMzRjM5NzBDRjRFMUBtcGxleDAxLm1wbC5hY2Nlc3MtY29t
cGFueS5jb20+AB4AORABAAAACwEAADwyMDA3MDUxNzAyMDcuNTI3MTAuYmx1ZXotZGV2ZWxAaHVp
dGwuZGU+CTxkODlkZGYzMDA3MDUxNjIwNDJqMTg1MGI5OTd3ZDA2OWJhZTI5ZTgxM2QyOUBtYWls
LmdtYWlsLmNvbT4JPDIwMDcwNTE3MTUyMS4zODg4OS5ibHVlei1kZXZlbEBodWl0bC5kZT4JPDQ2
NEM3NjE2LjkwNzA5MDBAbm55dGVjaC5uZXQ+PGQ4OWRkZjMwMDcwNTE4MDYxM3U1YzI0ZWQ4YnJh
YjBhY2YzZjdlZTY1MjgwQG1haWwuZ21haWwuY29tPiA8NDY0RENDQzQuOTAzMDBAbm55dGVjaC5u
ZXQ+AAAeAEcQAQAAAA8AAABtZXNzYWdlL3JmYzgyMgAACwDyEAEAAAAfAPMQAQAAAGwAAABSAEUA
IAAlADMAQQAgAFsAQgBsAHUAZQB6AC0AZABlAHYAZQBsAF0AIABGAHIAZQBxAHUAZQBuAHQAIABo
AGUAYQBkAHMAZQB0ACAAZABpAHMAYwBvAG4AbgBlAGMAdABzAC4ARQBNAEwAAAALAPYQAAAAAEAA
BzA917r3fpnHAUAACDBywaY7gZnHAQMA3j+vbwAAAwDxPwwEAAAeAPg/AQAAABEAAABGcmVkZXJp
YyBEYWxsZWF1AAAAAAIB+T8BAAAAXwAAAAAAAADcp0DIwEIQGrS5CAArL+GCAQAAAAAAAAAvTz1B
Q0NFU1MtQ09NUEFOWS9PVT1NT05UUEVMTElFUi9DTj1SRUNJUElFTlRTL0NOPUZSRURFUklDLkRB
TExFQVUAAB4A+j8BAAAAFQAAAFN5c3RlbSBBZG1pbmlzdHJhdG9yAAAAAAIB+z8BAAAAHgAAAAAA
AADcp0DIwEIQGrS5CAArL+GCAQAAAAAAAAAuAAAAAwD9P+QEAAADABlAAAAAAAMAGkAAAAAAAwAd
QAAAAAADAB5AAAAAAB4AMEABAAAAEQAAAEZSRURFUklDLkRBTExFQVUAAAAAHgAxQAEAAAARAAAA
RlJFREVSSUMuREFMTEVBVQAAAAAeADJAAQAAACoAAABibHVlei1kZXZlbC1ib3VuY2VzQGxpc3Rz
LnNvdXJjZWZvcmdlLm5ldAAAAB4AM0ABAAAAEQAAAGZlaWdAbm55dGVjaC5uZXQAAAAAHgA4QAEA
AAARAAAARlJFREVSSUMuREFMTEVBVQAAAAAeADlAAQAAAAIAAAAuAAAAAwB2QP////8LACkAAAAA
AAsAIwAAAAAAAwAGEG3vz6ADAAcQ5AgAAAMAEBAAAAAAAwAREAAAAAAeAAgQAQAAAGUAAABISSxJ
RElEU09NRVJFQ0VOVENIQU5HRVNBTkRUSEVSRUFSRVRISU5HU1RPU09MVkVJRE9OVEhBVkVBQ0NF
U1NUT0FMSU5VWENPTVBVVEVSUklHSFROT1dJTllPVVJDQVNFLEVOAAAAAAIBfwABAAAASAAAADxD
RTUyMTZDMTBDODM5NDREOUZEMzdCNjVDRDMzRjM5NzBDRjRFMUBtcGxleDAxLm1wbC5hY2Nlc3Mt
Y29tcGFueS5jb20+AJsg

------_=_NextPart_001_01C79981.3B9D380E
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
------_=_NextPart_001_01C79981.3B9D380E
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

------_=_NextPart_001_01C79981.3B9D380E--
