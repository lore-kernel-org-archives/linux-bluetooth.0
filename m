Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <0551C926975A174EA8972327741C7889EDA6385B@RS-MBS01.realsil.com.cn>
References: <CADnq5_PvCCWpx-+zbvxHC_SRG3Yq-n7wqy59ymGb=GUmm3Bkdw@mail.gmail.com>
 <0551C926975A174EA8972327741C7889EDA6385B@RS-MBS01.realsil.com.cn>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 22 Aug 2017 22:53:22 -0400
Message-ID: <CADnq5_Og8CKNLgk0A=iXLzz=dV0JWX=F7RtmyrsCdWoZcCoJvA@mail.gmail.com>
Subject: =?UTF-8?B?UmU6IOetlOWkjTogUlRMODgyMkJFIEJsdWV0b290aCBkZXZpY2U=?=
To: =?UTF-8?B?6ZmG5pyx5Lyf?= <alex_lu@realsil.com.cn>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "Larry.Finger@lwfinger.net" <Larry.Finger@lwfinger.net>
Content-Type: multipart/mixed; boundary="94eb2c1a3900b6498c055762d0bf"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

--94eb2c1a3900b6498c055762d0bf
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 22, 2017 at 10:21 PM, =E9=99=86=E6=9C=B1=E4=BC=9F <alex_lu@real=
sil.com.cn> wrote:
> Hi Alex Deucher,
> The rtl8821a_config.bin is not necessary.
> It is used for some special settings, such as bdaddr, sco over pcm/hci, e=
tc.

Thanks for clarifying.  How about the attached patch to make it clear
which config firmwares are optional?


Alex

>
> Thanks,
> BRs,
> Alex Lu.
>
> -----=E9=82=AE=E4=BB=B6=E5=8E=9F=E4=BB=B6-----
> =E5=8F=91=E4=BB=B6=E4=BA=BA: Alex Deucher [mailto:alexdeucher@gmail.com]
> =E5=8F=91=E9=80=81=E6=97=B6=E9=97=B4: 2017=E5=B9=B48=E6=9C=8823=E6=97=A5 =
10:09
> =E6=94=B6=E4=BB=B6=E4=BA=BA: linux-bluetooth@vger.kernel.org; =E9=99=86=
=E6=9C=B1=E4=BC=9F; Larry.Finger@lwfinger.net
> =E4=B8=BB=E9=A2=98: RTL8822BE Bluetooth device
>
> I have this device, but the driver requires a firmware file
> (rtl8821a_config.bin) which does not seem to exist.  Looking at the code[=
1], there appear to be several firmware config files for variants of this d=
evice:
> + switch (lmp_subver) {
> + case RTL_ROM_LMP_8723B:
> + cfg_name =3D "rtl_bt/rtl8723b_config.bin"; break; case
> + RTL_ROM_LMP_8821A:
> + cfg_name =3D "rtl_bt/rtl8821a_config.bin"; break; case
> + RTL_ROM_LMP_8761A:
> + cfg_name =3D "rtl_bt/rtl8761a_config.bin"; break; case
> + RTL_ROM_LMP_8822B:
> + cfg_name =3D "rtl_bt/rtl8822b_config.bin"; break;
> However, the only file that seem to actually exist is rtl8822b_config.bin=
.  Does anyone know where to get the others?
>
> Thanks,
>
> Alex
>
> [1] https://patchwork.kernel.org/patch/9323749/
>
> ------Please consider the environment before printing this e-mail.

--94eb2c1a3900b6498c055762d0bf
Content-Type: text/x-patch; charset="US-ASCII";
	name="0001-btrtl-Make-it-clear-what-config-firmware-is-optional.patch"
Content-Disposition: attachment;
	filename="0001-btrtl-Make-it-clear-what-config-firmware-is-optional.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_j6ofcts60

RnJvbSBiMjc3ZGRlYTgzZTRkYTk5OTQ5ZmE0MGFlZTU4N2NjZGJhODA3ZTQzIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBbGV4IERldWNoZXIgPGFsZXhkZXVjaGVyQGdtYWlsLmNvbT4K
RGF0ZTogVHVlLCAyMiBBdWcgMjAxNyAyMjo0NTo0OCAtMDQwMApTdWJqZWN0OiBbUEFUQ0hdIGJ0
cnRsOiBNYWtlIGl0IGNsZWFyIHdoYXQgY29uZmlnIGZpcm13YXJlIGlzIG9wdGlvbmFsCgpTb21l
IG9mIHRoZSBidCBjb25maWcgZmlybXdhcmVzIGFyZSBvcHRpb25hbC4gIFRoZXkgYXJlCm9ubHkg
dXNlZCBmb3Igc3BlY2lhbCBzZXR0aW5ncy4gIE1ha2UgaXQgY2xlYXIgaWYgdGhlCmZpcm13YXJl
IGlzIG9wdGlvbmFsIG9yIG5vdCBkdXJpbmcgbG9hZGluZy4KClNpZ25lZC1vZmYtYnk6IEFsZXgg
RGV1Y2hlciA8YWxleGRldWNoZXJAZ21haWwuY29tPgotLS0KIGRyaXZlcnMvYmx1ZXRvb3RoL2J0
cnRsLmMgfCA4ICsrKysrLS0tCiAxIGZpbGUgY2hhbmdlZCwgNSBpbnNlcnRpb25zKCspLCAzIGRl
bGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvYmx1ZXRvb3RoL2J0cnRsLmMgYi9kcml2
ZXJzL2JsdWV0b290aC9idHJ0bC5jCmluZGV4IDgyNzkwOTQuLmVjOWEwZDEgMTAwNjQ0Ci0tLSBh
L2RyaXZlcnMvYmx1ZXRvb3RoL2J0cnRsLmMKKysrIGIvZHJpdmVycy9ibHVldG9vdGgvYnRydGwu
YwpAQCAtMjY4LDEyICsyNjgsMTQgQEAgc3RhdGljIGludCBydGxfZG93bmxvYWRfZmlybXdhcmUo
c3RydWN0IGhjaV9kZXYgKmhkZXYsCiAJcmV0dXJuIHJldDsKIH0KIAotc3RhdGljIGludCBydGxf
bG9hZF9jb25maWcoc3RydWN0IGhjaV9kZXYgKmhkZXYsIGNvbnN0IGNoYXIgKm5hbWUsIHU4ICoq
YnVmZikKK3N0YXRpYyBpbnQgcnRsX2xvYWRfY29uZmlnKHN0cnVjdCBoY2lfZGV2ICpoZGV2LCBj
b25zdCBjaGFyICpuYW1lLCB1OCAqKmJ1ZmYsCisJCQkgICBib29sIGNvbmZpZ19uZWVkZWQpCiB7
CiAJY29uc3Qgc3RydWN0IGZpcm13YXJlICpmdzsKIAlpbnQgcmV0OwogCi0JQlRfSU5GTygiJXM6
IHJ0bDogbG9hZGluZyAlcyIsIGhkZXYtPm5hbWUsIG5hbWUpOworCUJUX0lORk8oIiVzOiBydGw6
IGxvYWRpbmcgJXMgY29uZmlnICVzIiwgaGRldi0+bmFtZSwKKwkJY29uZmlnX25lZWRlZCA/ICJy
ZXF1aXJlZCIgOiAib3B0aW9uYWwiLCBuYW1lKTsKIAlyZXQgPSByZXF1ZXN0X2Zpcm13YXJlKCZm
dywgbmFtZSwgJmhkZXYtPmRldik7CiAJaWYgKHJldCA8IDApCiAJCXJldHVybiByZXQ7CkBAIC0z
NTEsNyArMzUzLDcgQEAgc3RhdGljIGludCBidHJ0bF9zZXR1cF9ydGw4NzIzYihzdHJ1Y3QgaGNp
X2RldiAqaGRldiwgdTE2IGxtcF9zdWJ2ZXIsCiAJfQogCiAJaWYgKGNmZ19uYW1lKSB7Ci0JCWNm
Z19zeiA9IHJ0bF9sb2FkX2NvbmZpZyhoZGV2LCBjZmdfbmFtZSwgJmNmZ19idWZmKTsKKwkJY2Zn
X3N6ID0gcnRsX2xvYWRfY29uZmlnKGhkZXYsIGNmZ19uYW1lLCAmY2ZnX2J1ZmYsIGNvbmZpZ19u
ZWVkZWQpOwogCQlpZiAoY2ZnX3N6IDwgMCkgewogCQkJY2ZnX3N6ID0gMDsKIAkJCWlmIChjb25m
aWdfbmVlZGVkKQotLSAKMi41LjUKCg==
--94eb2c1a3900b6498c055762d0bf--
