Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: "Phulari, Mallikarjun" <mallikarjun.phulari@intel.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: RE: [PATCH] Bluetooth : Errata Service Release 8 Erratum 3253
Date: Fri, 21 Sep 2018 04:37:40 +0000
Message-ID: <70C091497DE2844DBD9E143B2282ABDA9BE5DA@BGSMSX105.gar.corp.intel.com>
References: <1537350714-32105-1-git-send-email-mallikarjun.phulari@intel.com>,<CABBYNZ+CAujgpF_8T_xyeu=+Zfzkocuwb5Df0YMT9YDv7M9-4w@mail.gmail.com>
In-Reply-To: <CABBYNZ+CAujgpF_8T_xyeu=+Zfzkocuwb5Df0YMT9YDv7M9-4w@mail.gmail.com>
Content-Type: multipart/mixed;
        boundary="_002_70C091497DE2844DBD9E143B2282ABDA9BE5DABGSMSX105garcorpi_"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

--_002_70C091497DE2844DBD9E143B2282ABDA9BE5DABGSMSX105garcorpi_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi Luiz,=0A=
Please find the new patch with review comments incorporated.=0A=
=0A=
*I have added the Page number of Core Specification for reference in the co=
mmit message and included the "signed of by" in the patch.=0A=
=0A=
*L2CAP_CR_INVALID_SCID and L2CAP_CR_SCID_IN_USE are specific to LE with dif=
ferent result values as:=0A=
 L2CAP_CR_INVALID_SCID  -  0x0009=0A=
 L2CAP_CR_SCID_IN_USE   -  0x000A=0A=
It is already implemented.=0A=
=0A=
Thanks & Regards=0A=
Mallikarjun Phulari=0A=
=0A=
_____________________________________=0A=
From: Luiz Augusto von Dentz [luiz.dentz@gmail.com]=0A=
Sent: Wednesday, September 19, 2018 5:06 AM=0A=
To: Phulari, Mallikarjun=0A=
Cc: linux-bluetooth@vger.kernel.org=0A=
Subject: Re: [PATCH] Bluetooth : Errata Service Release 8 Erratum 3253=0A=
=0A=
Hi Mallikarjun,=0A=
=0A=
On Wed, Sep 19, 2018 at 12:51 PM, Mallikarjun Phulari=0A=
<mallikarjun.phulari@intel.com> wrote:=0A=
> L2CAP: Changes include the new result codes for the l2cap channel=0A=
> create/connect request. The new result code are:=0A=
> 0x0006 - sent in the response when the CID is not in valid dynamic range.=
=0A=
> 0x0007 sent in the response when the CID is already allocated.=0A=
=0A=
It would be a good idea to quote the erratum with page number where=0A=
the new errors come from. Btw, you should include a signed of by in=0A=
the kernel patches.=0A=
=0A=
> ---=0A=
>  include/net/bluetooth/l2cap.h |  6 ++++++=0A=
>  net/bluetooth/l2cap_core.c    | 12 ++++++++++++=0A=
>  2 files changed, 18 insertions(+)=0A=
>=0A=
> diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.=
h=0A=
> index 0697fd4..eb0c8d0 100644=0A=
> --- a/include/net/bluetooth/l2cap.h=0A=
> +++ b/include/net/bluetooth/l2cap.h=0A=
> @@ -284,6 +284,12 @@ struct l2cap_conn_rsp {=0A=
>  #define L2CAP_CR_INVALID_SCID  0x0009=0A=
>  #define L2CAP_CR_SCID_IN_USE   0x000A=0A=
>=0A=
> +/* connect/create channel results=0A=
> + * As per Erratum 3253=0A=
> + */=0A=
> +#define L2CAP_CR_BREDR_INVALID_SCID    0x0006=0A=
> +#define L2CAP_CR_BREDR_SCID_IN_USE     0x0007=0A=
=0A=
Weird, are L2CAP_CR_INVALID_SCID and L2CAP_CR_SCID_IN_USE specific to=0A=
LE? If they are we should probably fix their names.=0A=
=0A=
>  /* connect/create channel status */=0A=
>  #define L2CAP_CS_NO_INFO       0x0000=0A=
>  #define L2CAP_CS_AUTHEN_PEND   0x0001=0A=
> diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c=0A=
> index 9b7907e..85887df 100644=0A=
> --- a/net/bluetooth/l2cap_core.c=0A=
> +++ b/net/bluetooth/l2cap_core.c=0A=
> @@ -3814,9 +3814,21 @@ static struct l2cap_chan *l2cap_connect(struct l2c=
ap_conn *conn,=0A=
>         }=0A=
>=0A=
>         result =3D L2CAP_CR_NO_MEM;=0A=
> +       /* As per Erratum 3253, check the CID is in valid dynamic range a=
nd=0A=
> +        *  is not allocated already. Send the new result codes according=
ly=0A=
> +        */=0A=
> +=0A=
> +       /* Check for valid dynamic CID range */=0A=
> +       if (scid < L2CAP_CID_DYN_START || scid > L2CAP_CID_DYN_END) {=0A=
> +               result =3D L2CAP_CR_BREDR_INVALID_SCID;=0A=
> +               chan =3D NULL;=0A=
> +               goto response;=0A=
> +       }=0A=
>=0A=
>         /* Check if we already have channel with that dcid */=0A=
>         if (__l2cap_get_chan_by_dcid(conn, scid))=0A=
> +               result =3D L2CAP_CR_BREDR_SCID_IN_USE;=0A=
> +               chan =3D NULL;=0A=
>                 goto response;=0A=
=0A=
Missing { } above?=0A=
=0A=
>=0A=
>         chan =3D pchan->ops->new_connection(pchan);=0A=
> --=0A=
> 2.7.4=0A=
>=0A=
=0A=
=0A=
=0A=
--=0A=
Luiz Augusto von Dentz=0A=

--_002_70C091497DE2844DBD9E143B2282ABDA9BE5DABGSMSX105garcorpi_
Content-Type: text/x-patch;
	name="0001-Bluetooth-Errata-Service-Release-8-Erratum-3253.patch"
Content-Description: 0001-Bluetooth-Errata-Service-Release-8-Erratum-3253.patch
Content-Disposition: attachment;
	filename="0001-Bluetooth-Errata-Service-Release-8-Erratum-3253.patch";
	size=2689; creation-date="Fri, 21 Sep 2018 04:34:42 GMT";
	modification-date="Fri, 21 Sep 2018 04:34:42 GMT"
Content-Transfer-Encoding: base64

RnJvbSAzZDVlNzcxMmYyZDdhMWQ1OWFmNjNjNGIyYWFjNTQ3YWQ5ODI2NTg5IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBNYWxsaWthcmp1biBQaHVsYXJpIDxtYWxsaWthcmp1bi5waHVs
YXJpQGludGVsLmNvbT4KRGF0ZTogRnJpLCAyMSBTZXAgMjAxOCAwOToxODozNSArMDUzMApTdWJq
ZWN0OiBbUEFUQ0hdIEJsdWV0b290aCA6IEVycmF0YSBTZXJ2aWNlIFJlbGVhc2UgOCwgRXJyYXR1
bSAzMjUzCk1JTUUtVmVyc2lvbjogMS4wCkNvbnRlbnQtVHlwZTogdGV4dC9wbGFpbjsgY2hhcnNl
dD1VVEYtOApDb250ZW50LVRyYW5zZmVyLUVuY29kaW5nOiA4Yml0CgpMMkNBUDogTmV3IHJlc3Vs
dCB2YWx1ZXMKCTB4MDAwNiAtIENvbm5lY3Rpb24gcmVmdXNlZCDigJMgSW52YWxpZCBTb3VyY2Ug
Q0lECgkweDAwMDcgLSBDb25uZWN0aW9uIHJlZnVzZWQg4oCTIFNvdXJjZSBDSUQgYWxyZWFkeSBh
bGxvY2F0ZWQKCkFzIHBlciB0aGUgRVNSMDhfVjEuMC4wLCAxLjExLjIgRXJyYXR1bSAzMjUzLCBQ
YWdlIE5vLiA1NCwKIlJlbW90ZSBDSUQgaW52YWxpZCBJc3N1ZSIuCkFwcGxpZXMgdG8gQ29yZSBT
cGVjaWZpY2F0aW9uIHZlcnNpb25zOiBWNS4wLCBWNC4yLCB2NC4xLCB2NC4wLCBhbmQgdjMuMCAr
IEhTClZvbCAzLCBQYXJ0IEEsIFNlY3Rpb24gNC4yLCA0LjMsIDQuMTQsIDQuMTUuCgpDb3JlIFNw
ZWNpZmljYXRpb24gVmVyc2lvbiA1LjAsIFBhZ2UgTm8uMTc1MywgVGFibGUgNC42IGFuZApQYWdl
IE5vLiAxNzY3LCBUYWJsZSA0LjE0CgpOZXcgcmVzdWx0IHZhbHVlcyBhcmUgYWRkZWQgdG8gbDJj
YXAgY29ubmVjdC9jcmVhdGUgY2hhbm5lbCByZXNwb25zZSBhcwoweDAwMDYgLSBDb25uZWN0aW9u
IHJlZnVzZWQg4oCTIEludmFsaWQgU291cmNlIENJRAoweDAwMDcgLSBDb25uZWN0aW9uIHJlZnVz
ZWQg4oCTIFNvdXJjZSBDSUQgYWxyZWFkeSBhbGxvY2F0ZWQKClNpZ25lZC1vZmYtYnk6IE1hbGxp
a2FyanVuIFBodWxhcmkgPG1hbGxpa2FyanVuLnBodWxhcmlAaW50ZWwuY29tPgotLS0KIGluY2x1
ZGUvbmV0L2JsdWV0b290aC9sMmNhcC5oIHwgIDYgKysrKysrCiBuZXQvYmx1ZXRvb3RoL2wyY2Fw
X2NvcmUuYyAgICB8IDE3ICsrKysrKysrKysrKysrKystCiAyIGZpbGVzIGNoYW5nZWQsIDIyIGlu
c2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkKCmRpZmYgLS1naXQgYS9pbmNsdWRlL25ldC9ibHVl
dG9vdGgvbDJjYXAuaCBiL2luY2x1ZGUvbmV0L2JsdWV0b290aC9sMmNhcC5oCmluZGV4IDA2OTdm
ZDQuLmM3Zjk3Y2MgMTAwNjQ0Ci0tLSBhL2luY2x1ZGUvbmV0L2JsdWV0b290aC9sMmNhcC5oCisr
KyBiL2luY2x1ZGUvbmV0L2JsdWV0b290aC9sMmNhcC5oCkBAIC0yODQsNiArMjg0LDEyIEBAIHN0
cnVjdCBsMmNhcF9jb25uX3JzcCB7CiAjZGVmaW5lIEwyQ0FQX0NSX0lOVkFMSURfU0NJRAkweDAw
MDkKICNkZWZpbmUgTDJDQVBfQ1JfU0NJRF9JTl9VU0UJMHgwMDBBCiAKKy8qIGNvbm5lY3QvY3Jl
YXRlIGNoYW5uZWwgcmVzdWx0cworICogTmV3IHJlc3VsdCBjb2Rlc0FzIHBlciBFU1IwOF9WMS4w
LjAsIEVycmF0dW0gMzI1MworICovCisjZGVmaW5lIEwyQ0FQX0NSX0JSRURSX0lOVkFMSURfU0NJ
RAkweDAwMDYKKyNkZWZpbmUgTDJDQVBfQ1JfQlJFRFJfU0NJRF9JTl9VU0UJMHgwMDA3CisKIC8q
IGNvbm5lY3QvY3JlYXRlIGNoYW5uZWwgc3RhdHVzICovCiAjZGVmaW5lIEwyQ0FQX0NTX05PX0lO
Rk8JMHgwMDAwCiAjZGVmaW5lIEwyQ0FQX0NTX0FVVEhFTl9QRU5ECTB4MDAwMQpkaWZmIC0tZ2l0
IGEvbmV0L2JsdWV0b290aC9sMmNhcF9jb3JlLmMgYi9uZXQvYmx1ZXRvb3RoL2wyY2FwX2NvcmUu
YwppbmRleCBkMTdhNDczLi5kNjA1NzQ4IDEwMDY0NAotLS0gYS9uZXQvYmx1ZXRvb3RoL2wyY2Fw
X2NvcmUuYworKysgYi9uZXQvYmx1ZXRvb3RoL2wyY2FwX2NvcmUuYwpAQCAtMzgxNSw5ICszODE1
LDI0IEBAIHN0YXRpYyBzdHJ1Y3QgbDJjYXBfY2hhbiAqbDJjYXBfY29ubmVjdChzdHJ1Y3QgbDJj
YXBfY29ubiAqY29ubiwKIAogCXJlc3VsdCA9IEwyQ0FQX0NSX05PX01FTTsKIAorCS8qIEFzIHBl
ciBFU1IwOF9WMS4wLjAsIEVycmF0dW0gMzI1MywgY2hlY2sgdGhlIENJRCBpcyBpbiB2YWxpZAor
CSAqIGR5bmFtaWMgcmFuZ2UgYW5kIGlzIG5vdCBhbGxvY2F0ZWQgYWxyZWFkeS4KKwkgKiBTZW5k
IHRoZSBuZXcgcmVzdWx0IGNvZGVzIGFjY29yZGluZ2x5CisJICovCisKKwkvKiBDaGVjayBmb3Ig
dmFsaWQgZHluYW1pYyBDSUQgcmFuZ2UgKi8KKwlpZiAoc2NpZCA8IEwyQ0FQX0NJRF9EWU5fU1RB
UlQgfHwgc2NpZCA+IEwyQ0FQX0NJRF9EWU5fRU5EKSB7CisJCXJlc3VsdCA9IEwyQ0FQX0NSX0JS
RURSX0lOVkFMSURfU0NJRDsKKwkJY2hhbiA9IE5VTEw7CisJCWdvdG8gcmVzcG9uc2U7CisJfQor
CiAJLyogQ2hlY2sgaWYgd2UgYWxyZWFkeSBoYXZlIGNoYW5uZWwgd2l0aCB0aGF0IGRjaWQgKi8K
LQlpZiAoX19sMmNhcF9nZXRfY2hhbl9ieV9kY2lkKGNvbm4sIHNjaWQpKQorCWlmIChfX2wyY2Fw
X2dldF9jaGFuX2J5X2RjaWQoY29ubiwgc2NpZCkpIHsKKwkJcmVzdWx0ID0gTDJDQVBfQ1JfQlJF
RFJfU0NJRF9JTl9VU0U7CisJCWNoYW4gPSBOVUxMOwogCQlnb3RvIHJlc3BvbnNlOworCX0KIAog
CWNoYW4gPSBwY2hhbi0+b3BzLT5uZXdfY29ubmVjdGlvbihwY2hhbik7CiAJaWYgKCFjaGFuKQot
LSAKMi43LjQKCg==

--_002_70C091497DE2844DBD9E143B2282ABDA9BE5DABGSMSX105garcorpi_--
