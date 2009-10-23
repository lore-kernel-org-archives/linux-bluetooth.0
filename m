Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <2d5a2c100910230649u1946e632qa4c50b33b6654218@mail.gmail.com>
References: <1256253562-22532-1-git-send-email-jaikumar@google.com>
	<2d5a2c100910230649u1946e632qa4c50b33b6654218@mail.gmail.com>
From: Jaikumar Ganesh <jaikumar@google.com>
Date: Fri, 23 Oct 2009 08:17:51 -0700
Message-ID: <e8892a6a0910230817l6f096f70s4de1fe534799de86@mail.gmail.com>
Subject: Re: [PATCH] Update SDP storage records when a record is deleted.
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: multipart/mixed; boundary=000325579eb2511d8604769bb8b7
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

--000325579eb2511d8604769bb8b7
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Luiz:

On Fri, Oct 23, 2009 at 6:49 AM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi,
>
> On Thu, Oct 22, 2009 at 8:19 PM, Jaikumar Ganesh <jaikumar@google.com> wr=
ote:
> > =A0 =A0 =A0 =A0for (list =3D uuids; list; list =3D list->next)
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0device->uuids =3D g_slist_remove(device-=
>uuids, list->data);
>
> It looks like to me this would be the proper place to remove the
> records from the storage, since we are updating the uuids list there
> is no big deal to redo that in another function.
>
> So it would look like this:
>
> diff --git a/src/device.c b/src/device.c
> index 6cb9641..708e069 100644
> --- a/src/device.c
> +++ b/src/device.c
> @@ -1134,8 +1134,6 @@ static void device_remove_drivers(struct
> btd_device *device, GSList *uuids)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0next =3D list->next;
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0for (uuid =3D driver->uuids; *uuid; uuid++=
) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 sdp_record_t *rec;
> -
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (!g_slist_find_custom(u=
uids, *uuid,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0(GCompareFunc) strcasecmp))
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0continue;
> @@ -1148,15 +1146,6 @@ static void device_remove_drivers(struct
> btd_device *device, GSList *uuids)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0driver_data);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0g_free(driver_data);
>
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 rec =3D find_record_in_list=
(records, *uuid);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!rec)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> -
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 delete_record(srcaddr, dsta=
ddr, rec->handle);
> -
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 records =3D sdp_list_remove=
(records, rec);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 sdp_record_free(rec);
> -
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0break;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0}
> @@ -1164,8 +1153,19 @@ static void device_remove_drivers(struct
> btd_device *device, GSList *uuids)
> =A0 =A0 =A0 =A0if (records)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0sdp_list_free(records, (sdp_free_func_t) s=
dp_record_free);
>
> - =A0 =A0 =A0 for (list =3D uuids; list; list =3D list->next)
> + =A0 =A0 =A0 for (list =3D uuids; list; list =3D list->next) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 sdp_record_t *rec;
> +
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0device->uuids =3D g_slist_remove(device->u=
uids, list->data);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 rec =3D find_record_in_list(records, list->=
data);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!rec)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 delete_record(srcaddr, dstaddr, rec->handle=
);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 records =3D sdp_list_remove(records, rec);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 sdp_record_free(rec);
> + =A0 =A0 =A0 }
> =A0}
>
> =A0static void services_changed(struct btd_device *device)
>

My mail to linux bluetooth bounced yesterday.  Sending it again.

    The req->profiles_removed gets updated from device->uuids.
However, in the case, where we are paired with the remote device and
we unpair and then repair, since we will free device->uuids on the
unpair, the req->profiles_removed won't get updated after the SDP
query on repair. And so we would need to update the storage from
device->uuids.

Since req->profiles_removed would be empty, device_remove_drivers
won't get called. Also I believe it makes sense to have 2 functions,
even though there is slight overhead, since the deletion of SDP
records from storage, and removing device_probe_drivers are 2 distinct
operations.

   Coding style, cast issue, memory leak fixed, patch attached.

>
> --
> Luiz Augusto von Dentz
> Engenheiro de Computa=E7=E3o

--000325579eb2511d8604769bb8b7
Content-Type: application/octet-stream;
	name="0002-Update-SDP-storage-records-when-a-record-is-deleted.patch"
Content-Disposition: attachment;
	filename="0002-Update-SDP-storage-records-when-a-record-is-deleted.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_g1535s850

RnJvbSA0NWZjNzE0NDYwYjgyYzBiM2Q4MmQ3M2QwMDU4MmQ5YTU2MThkMjY3IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBKYWlrdW1hciBHYW5lc2ggPGphaWt1bWFyQGdvb2dsZS5jb20+
CkRhdGU6IFRodSwgMjIgT2N0IDIwMDkgMTY6MTc6MTcgLTA3MDAKU3ViamVjdDogW1BBVENIXSBV
cGRhdGUgU0RQIHN0b3JhZ2UgcmVjb3JkcyB3aGVuIGEgcmVjb3JkIGlzIGRlbGV0ZWQuCgpXaGVu
IGEgU0RQIHJlY29yZCBpcyBkZWxldGVkIGF0IHRoZSByZW1vdGUgZW5kLCB3ZSB1cGRhdGUKdGhl
IHN0b3JhZ2Ugb25seSBpZiB3ZSBoYXZlIGEgZGV2aWNlIGRyaXZlciByZWdpc3RlcmVkIGZvciB0
aGF0IFVVSUQuClVwZGF0ZSB0aGUgY2FjaGUgaW4gYWxsIGNhc2VzLgotLS0KIHNyYy9kZXZpY2Uu
YyB8ICAgNTIgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKystLS0tLS0tLS0tLS0tLS0t
LS0tLQogMSBmaWxlcyBjaGFuZ2VkLCAzMiBpbnNlcnRpb25zKCspLCAyMCBkZWxldGlvbnMoLSkK
CmRpZmYgLS1naXQgYS9zcmMvZGV2aWNlLmMgYi9zcmMvZGV2aWNlLmMKaW5kZXggNjNmMzVkZS4u
MmIwYzgwYSAxMDA2NDQKLS0tIGEvc3JjL2RldmljZS5jCisrKyBiL3NyYy9kZXZpY2UuYwpAQCAt
MTExMCwxMyArMTExMCwxNSBAQCB2b2lkIGRldmljZV9wcm9iZV9kcml2ZXJzKHN0cnVjdCBidGRf
ZGV2aWNlICpkZXZpY2UsIEdTTGlzdCAqcHJvZmlsZXMpCiAJfQogfQogCi1zdGF0aWMgdm9pZCBk
ZXZpY2VfcmVtb3ZlX2RyaXZlcnMoc3RydWN0IGJ0ZF9kZXZpY2UgKmRldmljZSwgR1NMaXN0ICp1
dWlkcykKK3N0YXRpYyB2b2lkIHVwZGF0ZV9zZXJ2aWNlX3JlY29yZHMoc3RydWN0IGJ0ZF9kZXZp
Y2UgKmRldmljZSkKIHsKIAlzdHJ1Y3QgYnRkX2FkYXB0ZXIgKmFkYXB0ZXIgPSBkZXZpY2VfZ2V0
X2FkYXB0ZXIoZGV2aWNlKTsKLQlHU0xpc3QgKmxpc3QsICpuZXh0OwotCWNoYXIgc3JjYWRkclsx
OF0sIGRzdGFkZHJbMThdOwogCWJkYWRkcl90IHNyYzsKLQlzZHBfbGlzdF90ICpyZWNvcmRzOwor
CXNkcF9saXN0X3QgKnJlY29yZHMsICpzZXE7CisJc2RwX3JlY29yZF90ICpyZWM7CisJY2hhciBz
cmNhZGRyWzE4XSwgZHN0YWRkclsxOF07CisJR1NMaXN0ICpsOworCWNvbnN0IGNoYXIgKnV1aWQ7
CiAKIAlhZGFwdGVyX2dldF9hZGRyZXNzKGFkYXB0ZXIsICZzcmMpOwogCWJhMnN0cigmc3JjLCBz
cmNhZGRyKTsKQEAgLTExMjQsNiArMTEyNiwyOCBAQCBzdGF0aWMgdm9pZCBkZXZpY2VfcmVtb3Zl
X2RyaXZlcnMoc3RydWN0IGJ0ZF9kZXZpY2UgKmRldmljZSwgR1NMaXN0ICp1dWlkcykKIAogCXJl
Y29yZHMgPSByZWFkX3JlY29yZHMoJnNyYywgJmRldmljZS0+YmRhZGRyKTsKIAorCWZvciAobCA9
IGRldmljZS0+dXVpZHM7IGw7IGwgPSBsLT5uZXh0KSB7CisJCXV1aWQgPSBsLT5kYXRhOworCQly
ZWMgPSBmaW5kX3JlY29yZF9pbl9saXN0KHJlY29yZHMsIHV1aWQpOworCQlpZiAocmVjKSB7CisJ
CQlyZWNvcmRzID0gc2RwX2xpc3RfcmVtb3ZlKHJlY29yZHMsIHJlYyk7CisJCQlzZHBfcmVjb3Jk
X2ZyZWUocmVjKTsKKwkJfQorCX0KKworCWZvciAoc2VxID0gcmVjb3Jkczsgc2VxOyBzZXEgPSBz
ZXEtPm5leHQpIHsKKwkJcmVjID0gc2VxLT5kYXRhOworCQlkZWxldGVfcmVjb3JkKHNyY2FkZHIs
IGRzdGFkZHIsIHJlYy0+aGFuZGxlKTsKKwl9CisKKwlpZiAocmVjb3JkcykKKwkJc2RwX2xpc3Rf
ZnJlZShyZWNvcmRzLCAoc2RwX2ZyZWVfZnVuY190KSBzZHBfcmVjb3JkX2ZyZWUpOworfQorCitz
dGF0aWMgdm9pZCBkZXZpY2VfcmVtb3ZlX2RyaXZlcnMoc3RydWN0IGJ0ZF9kZXZpY2UgKmRldmlj
ZSwgR1NMaXN0ICp1dWlkcykKK3sKKwlHU0xpc3QgKmxpc3QsICpuZXh0OworCiAJZGVidWcoIlJl
bW92ZSBkcml2ZXJzIGZvciAlcyIsIGRldmljZS0+cGF0aCk7CiAKIAlmb3IgKGxpc3QgPSBkZXZp
Y2UtPmRyaXZlcnM7IGxpc3Q7IGxpc3QgPSBuZXh0KSB7CkBAIC0xMTM0LDM2ICsxMTU4LDIyIEBA
IHN0YXRpYyB2b2lkIGRldmljZV9yZW1vdmVfZHJpdmVycyhzdHJ1Y3QgYnRkX2RldmljZSAqZGV2
aWNlLCBHU0xpc3QgKnV1aWRzKQogCQluZXh0ID0gbGlzdC0+bmV4dDsKIAogCQlmb3IgKHV1aWQg
PSBkcml2ZXItPnV1aWRzOyAqdXVpZDsgdXVpZCsrKSB7Ci0JCQlzZHBfcmVjb3JkX3QgKnJlYzsK
LQogCQkJaWYgKCFnX3NsaXN0X2ZpbmRfY3VzdG9tKHV1aWRzLCAqdXVpZCwKIAkJCQkJKEdDb21w
YXJlRnVuYykgc3RyY2FzZWNtcCkpCiAJCQkJY29udGludWU7CiAKLQkJCWRlYnVnKCJVVUlEICVz
IHdhcyByZW1vdmVkIGZyb20gZGV2aWNlICVzIiwKLQkJCQkJCQkqdXVpZCwgZHN0YWRkcik7CisJ
CQlkZWJ1ZygiVVVJRCAlcyB3YXMgcmVtb3ZlZCBmcm9tIGRldmljZSBwYXRoICVzIiwKKwkJCQkJ
CQkqdXVpZCwgZGV2aWNlLT5wYXRoKTsKIAogCQkJZHJpdmVyLT5yZW1vdmUoZGV2aWNlKTsKIAkJ
CWRldmljZS0+ZHJpdmVycyA9IGdfc2xpc3RfcmVtb3ZlKGRldmljZS0+ZHJpdmVycywKIAkJCQkJ
CQkJZHJpdmVyX2RhdGEpOwogCQkJZ19mcmVlKGRyaXZlcl9kYXRhKTsKIAotCQkJcmVjID0gZmlu
ZF9yZWNvcmRfaW5fbGlzdChyZWNvcmRzLCAqdXVpZCk7Ci0JCQlpZiAoIXJlYykKLQkJCQlicmVh
azsKLQotCQkJZGVsZXRlX3JlY29yZChzcmNhZGRyLCBkc3RhZGRyLCByZWMtPmhhbmRsZSk7Ci0K
LQkJCXJlY29yZHMgPSBzZHBfbGlzdF9yZW1vdmUocmVjb3JkcywgcmVjKTsKLQkJCXNkcF9yZWNv
cmRfZnJlZShyZWMpOwotCiAJCQlicmVhazsKIAkJfQogCX0KIAotCWlmIChyZWNvcmRzKQotCQlz
ZHBfbGlzdF9mcmVlKHJlY29yZHMsIChzZHBfZnJlZV9mdW5jX3QpIHNkcF9yZWNvcmRfZnJlZSk7
Ci0KIAlmb3IgKGxpc3QgPSB1dWlkczsgbGlzdDsgbGlzdCA9IGxpc3QtPm5leHQpCiAJCWRldmlj
ZS0+dXVpZHMgPSBnX3NsaXN0X3JlbW92ZShkZXZpY2UtPnV1aWRzLCBsaXN0LT5kYXRhKTsKIH0K
QEAgLTEzMzMsNiArMTM0Myw4IEBAIHN0YXRpYyB2b2lkIHNlYXJjaF9jYihzZHBfbGlzdF90ICpy
ZWNzLCBpbnQgZXJyLCBncG9pbnRlciB1c2VyX2RhdGEpCiAJaWYgKHJlcS0+cHJvZmlsZXNfcmVt
b3ZlZCkKIAkJZGV2aWNlX3JlbW92ZV9kcml2ZXJzKGRldmljZSwgcmVxLT5wcm9maWxlc19yZW1v
dmVkKTsKIAorCXVwZGF0ZV9zZXJ2aWNlX3JlY29yZHMoZGV2aWNlKTsKKwogCS8qIFByb3BhZ2F0
ZSBzZXJ2aWNlcyBjaGFuZ2VzICovCiAJc2VydmljZXNfY2hhbmdlZChyZXEtPmRldmljZSk7CiAK
LS0gCjEuNi4yLjMKCg==
--000325579eb2511d8604769bb8b7--
