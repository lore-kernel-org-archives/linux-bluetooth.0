Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <6aeb672b1002232333u54dbc04qd1f119cccef5febf@mail.gmail.com>
References: <6aeb672b1002232333u54dbc04qd1f119cccef5febf@mail.gmail.com>
Date: Wed, 24 Feb 2010 21:10:01 +0800
Message-ID: <6aeb672b1002240510k3e15dc09y8b55bd0b16e28910@mail.gmail.com>
Subject: Re: Read default link policy from main.conf - draft change for
	comments
From: Liang Bao <tim.bao@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: multipart/mixed; boundary=0016e647580c4ceed304805862ad
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

--0016e647580c4ceed304805862ad
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Here's the patch file. I move the assignment of default value to
init_defaults() and just remove HCI_LP_PARK if the configuration is
set to "true". By default, this configuation in main.conf is written
as "DisableParkState =3D false"

2010/2/24 Liang Bao <tim.bao@gmail.com>:
> I've added a configuration item DisableParkState in main.conf and let
> the bluetoothd check this. If it's set to true, the
> main_opts.link_policy will be HCI_LP_RSWITCH | HCI_LP_SNIFF |
> HCI_LP_HOLD, otherwise, it will be original one -
> HCI_LP_RSWITCH | HCI_LP_SNIFF | HCI_LP_HOLD | HCI_LP_PARK. Any comment
> on the code change or the way to configure? I just want to see if
> further improvement is necessary before I send out the patch. Thanks.
>
> diff --git a/data/main.conf b/data/main.conf
> index 8153eb2..b9b8fef 100644
> --- a/data/main.conf
> +++ b/data/main.conf
> @@ -57,3 +57,8 @@ ReverseServiceDiscovery =3D true
> =A0# Enable name resolving after inquiry. Set it to 'false' if you don't =
need
> =A0# remote devices name and want shorter discovery cycle. Defaults to 't=
rue'.
> =A0NameResolving =3D true
> +
> +# Disable park state support helps some bluetooth device stably connecte=
d, e.g.
> +# Motorola HF850 car-kit will lose connection or fail to setup SCO when =
it's
> +# in park state. Defaults to 'false'.
> +DisableParkState =3D true
>
> diff --git a/src/main.c b/src/main.c
> index ff423a4..e0ec7ce 100644
> --- a/src/main.c
> +++ b/src/main.c
> @@ -203,8 +203,15 @@ static void parse_config(GKeyFile *config)
>
> =A0 =A0 =A0 =A0main_opts.link_mode =3D HCI_LM_ACCEPT;
>
> =A0 =A0 =A0 =A0main_opts.link_policy =3D HCI_LP_RSWITCH | HCI_LP_SNIFF |
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 HCI_LP_HOLD | HCI_LP_PARK;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 HCI_LP_HOLD ;
> + =A0 =A0 =A0 =A0boolean =3D g_key_file_get_boolean(config, "General",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0"DisableParkState", &err);
> + =A0 =A0 =A0 =A0if (err)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0g_clear_error(&err);
> + =A0 =A0 =A0 =A0else if (!boolean)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 main_opts.link_policy |=3D HCI_LP_PARK;
> =A0}
>
>
>
>
> 2010/2/10 Liang Bao <tim.bao@gmail.com>:
>> Anyone could advice? Thanks.
>>
>> 2010/2/8 Liang Bao <tim.bao@gmail.com>:
>>> Hi,
>>>
>>> We noticed that currently BlueZ doesn't read link policy settings from
>>> main.conf as it does for other things such as General.Name or
>>> General.Class. It just enable everything in parse_config()
>>> (src/main.c). Is this just due to lack of use case or BlueZ does this
>>> intentionally for some reason? Thanks.
>>>
>>>
>>> 86 static void parse_config(GKeyFile *config)
>>> 87 {
>>> .....
>>> 206 =A0 =A0 =A0 =A0 main_opts.link_policy =3D HCI_LP_RSWITCH | HCI_LP_S=
NIFF |
>>> 207 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 HCI_LP_HOLD | HCI_LP_PARK;
>>> 208 }
>>>
>>
>

--0016e647580c4ceed304805862ad
Content-Type: text/x-diff; charset=US-ASCII;
	name="0001-Allow-disable-park-state-in-main.conf.patch"
Content-Disposition: attachment;
	filename="0001-Allow-disable-park-state-in-main.conf.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_g6255vf30

RnJvbSAzMzFiMTIwMTUzYzA0Njk0YzczNTU2YzAyODc0NTZhMTE4NzQyNTFmIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBUaW0gQmFvIDx0aW0uYmFvQGdtYWlsLmNvbT4KRGF0ZTogV2Vk
LCAyNCBGZWIgMjAxMCAyMDo0ODoyOSArMDgwMApTdWJqZWN0OiBbUEFUQ0hdIEFsbG93IGRpc2Fi
bGUgcGFyayBzdGF0ZSBpbiBtYWluLmNvbmYKCkN1cnJlbnRseSBCbHVlWiBpcyBoYXJkLWNvZGlu
ZyB0aGUgZGVmYXVsdCBsaW5rIHBvbGljeSB0byBpbmNsdWRlCmhvbGQgbW9kZSwgcm9sZSBzd2l0
Y2gsIHNuaWZmIG1vZGUgYW5kIHBhcmsgc3RhdGUuIEhvd2V2ZXIsIHNvbWUKZGV2aWNlIHdpbGwg
aGF2ZSBwcm9ibGVtIHRvIG1haW50YWluIHRoZSBjb25uZWN0aW9uIG9yIHNldHVwIFNDTwppZiB0
aGV5IGFyZSBpbiBwYXJrIHN0YXRlLiBNYWtpbmcgdGhlIHBhcmsgc3RhdGUgY29uZmlndXJhYmxl
IGluCm1haW4uY29uZiBpbXByb3ZlcyBmbGV4aWJpbGl0eSBzbyBpdCBjYW4gYmUgZGlzYWJsZWQg
d2hlbiBuZWVkZWQuCgpTaWduZWQtb2ZmLWJ5OiBUaW0gQmFvIDx0aW0uYmFvQGdtYWlsLmNvbT4K
LS0tCiBzcmMvbWFpbi5jICAgIHwgICAxMyArKysrKysrKystLS0tCiBzcmMvbWFpbi5jb25mIHwg
ICAgNSArKysrKwogMiBmaWxlcyBjaGFuZ2VkLCAxNCBpbnNlcnRpb25zKCspLCA0IGRlbGV0aW9u
cygtKQoKZGlmZiAtLWdpdCBhL3NyYy9tYWluLmMgYi9zcmMvbWFpbi5jCmluZGV4IDAxNGQ4YjYu
Ljk3N2M4N2IgMTAwNjQ0Ci0tLSBhL3NyYy9tYWluLmMKKysrIGIvc3JjL21haW4uYwpAQCAtMjAx
LDEwICsyMDEsMTIgQEAgc3RhdGljIHZvaWQgcGFyc2VfY29uZmlnKEdLZXlGaWxlICpjb25maWcp
CiAJZWxzZQogCQltYWluX29wdHMubmFtZV9yZXNvbHYgPSBib29sZWFuOwogCi0JbWFpbl9vcHRz
LmxpbmtfbW9kZSA9IEhDSV9MTV9BQ0NFUFQ7Ci0KLQltYWluX29wdHMubGlua19wb2xpY3kgPSBI
Q0lfTFBfUlNXSVRDSCB8IEhDSV9MUF9TTklGRiB8Ci0JCQkJCQlIQ0lfTFBfSE9MRCB8IEhDSV9M
UF9QQVJLOworCWJvb2xlYW4gPSBnX2tleV9maWxlX2dldF9ib29sZWFuKGNvbmZpZywgIkdlbmVy
YWwiLAorCQkJCQkJIkRpc2FibGVQYXJrU3RhdGUiLCAmZXJyKTsKKwlpZiAoZXJyKQorCQlnX2Ns
ZWFyX2Vycm9yKCZlcnIpOworCWVsc2UgaWYgKGJvb2xlYW4pCisJCW1haW5fb3B0cy5saW5rX3Bv
bGljeSAmPSAofkhDSV9MUF9QQVJLKTsKIH0KIAogLyoKQEAgLTI3Niw2ICsyNzgsOSBAQCBzdGF0
aWMgdm9pZCBpbml0X2RlZmF1bHRzKHZvaWQpCiAJbWFpbl9vcHRzLnJlbWVtYmVyX3Bvd2VyZWQg
PSBUUlVFOwogCW1haW5fb3B0cy5yZXZlcnNlX3NkcCA9IFRSVUU7CiAJbWFpbl9vcHRzLm5hbWVf
cmVzb2x2ID0gVFJVRTsKKwltYWluX29wdHMubGlua19tb2RlID0gSENJX0xNX0FDQ0VQVDsKKwlt
YWluX29wdHMubGlua19wb2xpY3kgPSBIQ0lfTFBfUlNXSVRDSCB8IEhDSV9MUF9TTklGRiB8CisJ
CQkJSENJX0xQX0hPTEQgfCBIQ0lfTFBfUEFSSzsKIAogCWlmIChnZXRob3N0bmFtZShtYWluX29w
dHMuaG9zdF9uYW1lLCBzaXplb2YobWFpbl9vcHRzLmhvc3RfbmFtZSkgLSAxKSA8IDApCiAJCXN0
cmNweShtYWluX29wdHMuaG9zdF9uYW1lLCAibm9uYW1lIik7CmRpZmYgLS1naXQgYS9zcmMvbWFp
bi5jb25mIGIvc3JjL21haW4uY29uZgppbmRleCBiMjUyYTgyLi42Zjk3NWZjIDEwMDY0NAotLS0g
YS9zcmMvbWFpbi5jb25mCisrKyBiL3NyYy9tYWluLmNvbmYKQEAgLTUwLDMgKzUwLDggQEAgUmV2
ZXJzZVNlcnZpY2VEaXNjb3ZlcnkgPSB0cnVlCiAjIEVuYWJsZSBuYW1lIHJlc29sdmluZyBhZnRl
ciBpbnF1aXJ5LiBTZXQgaXQgdG8gJ2ZhbHNlJyBpZiB5b3UgZG9uJ3QgbmVlZAogIyByZW1vdGUg
ZGV2aWNlcyBuYW1lIGFuZCB3YW50IHNob3J0ZXIgZGlzY292ZXJ5IGN5Y2xlLiBEZWZhdWx0cyB0
byAndHJ1ZScuCiBOYW1lUmVzb2x2aW5nID0gdHJ1ZQorCisjIERpc2FibGUgcGFyayBzdGF0ZSBp
biBkZWZhdWx0IGxpbmsgcG9saWN5LiBTb21lIGRldmljZXMgaGF2ZSBjb25uZWN0aW9uCisjIHN0
YWJpbGl0eSBpc3N1ZSBvciBmYWlsIHRvIHNldHVwIFNDTyB3aGVuIHRoZSBsaW5rIGlzIGluIHBh
cmsgc3RhdGUuIERlZmF1bHRzCisjIHRvICdmYWxzZScuCitEaXNhYmxlUGFya1N0YXRlID0gZmFs
c2UKLS0gCjEuNS42LjMKCg==
--0016e647580c4ceed304805862ad--
