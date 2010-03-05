Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <2d5a2c101003050503j4e9bf8a0hdd91c8af4a9bb5a4@mail.gmail.com>
References: <2d5a2c101003050503j4e9bf8a0hdd91c8af4a9bb5a4@mail.gmail.com>
Date: Fri, 5 Mar 2010 15:36:20 +0200
Message-ID: <2d5a2c101003050536q61f16c12xb67a985234b3619@mail.gmail.com>
Subject: Re: [PATCH] Fix error not being propagated properly
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: multipart/mixed; boundary=0016e6d644f5fe0b8f04810dcc33
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

--0016e6d644f5fe0b8f04810dcc33
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Now with the correct patch attached

On Fri, Mar 5, 2010 at 3:03 PM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> ---
> =A0audio/headset.c | =A0 =A04 ++--
> =A01 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/audio/headset.c b/audio/headset.c
> index 0176937..893edd0 100644
> --- a/audio/headset.c
> +++ b/audio/headset.c
> @@ -198,7 +198,7 @@ static DBusHandlerResult
> error_connection_attempt_failed(DBusConnection *conn,
> =A0{
> =A0 =A0 =A0 =A0return error_common_reply(conn, msg,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ERROR_INTERFACE ".Connecti=
onAttemptFailed",
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 err > 0 ? strerror(err) : "=
Connection attempt failed");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 err < 0 ? strerror(-err) : =
"Connection attempt failed");
> =A0}
>
> =A0static int rfcomm_connect(struct audio_device *device, headset_stream_=
cb_t cb,
> @@ -435,7 +435,7 @@ static void pending_connect_complete(struct
> connect_cb *cb, struct audio_device
> =A0{
> =A0 =A0 =A0 =A0struct headset *hs =3D dev->headset;
>
> - =A0 =A0 =A0 if (hs->pending->err)
> + =A0 =A0 =A0 if (hs->pending->err < 0)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0cb->cb(NULL, cb->cb_data);
> =A0 =A0 =A0 =A0else
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0cb->cb(dev, cb->cb_data);
> --
> 1.6.3.3
>
>
> --
> Luiz Augusto von Dentz
> Computer Engineer
>



--=20
Luiz Augusto von Dentz
Computer Engineer

--0016e6d644f5fe0b8f04810dcc33
Content-Type: text/x-patch; charset=US-ASCII;
	name="0011-Fix-error-not-being-propagated-properly.patch"
Content-Disposition: attachment;
	filename="0011-Fix-error-not-being-propagated-properly.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_g6f13p6e1

RnJvbSA1ZGQ1N2MyMzNhYTg4MWZhZWFhNmJmY2ExNDdhYmNkYjllMDRkYzkzIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBMdWl6IEF1Z3VzdG8gVm9uIERlbnR6IDxsdWl6LmRlbnR6LXZv
bkBub2tpYS5jb20+CkRhdGU6IEZyaSwgNSBNYXIgMjAxMCAxNTowMTo1OSArMDIwMApTdWJqZWN0
OiBbUEFUQ0ggMTEvMTFdIEZpeCBlcnJvciBub3QgYmVpbmcgcHJvcGFnYXRlZCBwcm9wZXJseQoK
LS0tCiBhdWRpby9oZWFkc2V0LmMgfCAgICA0ICsrLS0KIDEgZmlsZXMgY2hhbmdlZCwgMiBpbnNl
cnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2F1ZGlvL2hlYWRzZXQuYyBi
L2F1ZGlvL2hlYWRzZXQuYwppbmRleCAwMTc2OTM3Li44OTNlZGQwIDEwMDY0NAotLS0gYS9hdWRp
by9oZWFkc2V0LmMKKysrIGIvYXVkaW8vaGVhZHNldC5jCkBAIC0xOTgsNyArMTk4LDcgQEAgc3Rh
dGljIERCdXNIYW5kbGVyUmVzdWx0IGVycm9yX2Nvbm5lY3Rpb25fYXR0ZW1wdF9mYWlsZWQoREJ1
c0Nvbm5lY3Rpb24gKmNvbm4sCiB7CiAJcmV0dXJuIGVycm9yX2NvbW1vbl9yZXBseShjb25uLCBt
c2csCiAJCQlFUlJPUl9JTlRFUkZBQ0UgIi5Db25uZWN0aW9uQXR0ZW1wdEZhaWxlZCIsCi0JCQll
cnIgPiAwID8gc3RyZXJyb3IoZXJyKSA6ICJDb25uZWN0aW9uIGF0dGVtcHQgZmFpbGVkIik7CisJ
CQllcnIgPCAwID8gc3RyZXJyb3IoLWVycikgOiAiQ29ubmVjdGlvbiBhdHRlbXB0IGZhaWxlZCIp
OwogfQogCiBzdGF0aWMgaW50IHJmY29tbV9jb25uZWN0KHN0cnVjdCBhdWRpb19kZXZpY2UgKmRl
dmljZSwgaGVhZHNldF9zdHJlYW1fY2JfdCBjYiwKQEAgLTQzNSw3ICs0MzUsNyBAQCBzdGF0aWMg
dm9pZCBwZW5kaW5nX2Nvbm5lY3RfY29tcGxldGUoc3RydWN0IGNvbm5lY3RfY2IgKmNiLCBzdHJ1
Y3QgYXVkaW9fZGV2aWNlCiB7CiAJc3RydWN0IGhlYWRzZXQgKmhzID0gZGV2LT5oZWFkc2V0Owog
Ci0JaWYgKGhzLT5wZW5kaW5nLT5lcnIpCisJaWYgKGhzLT5wZW5kaW5nLT5lcnIgPCAwKQogCQlj
Yi0+Y2IoTlVMTCwgY2ItPmNiX2RhdGEpOwogCWVsc2UKIAkJY2ItPmNiKGRldiwgY2ItPmNiX2Rh
dGEpOwotLSAKMS42LjMuMwoK
--0016e6d644f5fe0b8f04810dcc33--
