Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1249589381.21101.22.camel@localhost.localdomain>
References: <1249588984-9043-1-git-send-email-jaikumar@google.com>
	<1249589381.21101.22.camel@localhost.localdomain>
From: Jaikumar Ganesh <jaikumar@google.com>
Date: Thu, 6 Aug 2009 14:00:30 -0700
Message-ID: <e8892a6a0908061400h4b07c3c5pcaa7992026dc90c@mail.gmail.com>
Subject: Re: [PATCH] Modify PBAP SDP record.
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org, Zhu Lan <mtcb47@motorola.com>
Content-Type: multipart/mixed; boundary=00163630f1d71ad0d804707f6a1a
List-ID: <linux-bluetooth.vger.kernel.org>

--00163630f1d71ad0d804707f6a1a
Content-Type: multipart/alternative; boundary=00163630f1d71ad0cf04707f6a18

--00163630f1d71ad0cf04707f6a18
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hi Marcel,

On Thu, Aug 6, 2009 at 1:09 PM, Marcel Holtmann <marcel@holtmann.org> wrote:

> Hi Jaikumar,
>
> > Fix to pass PTS case TC_SDAS_BV_03_I(since PTS3.2 update2).
> > The code tried to append the UINT type value to the supported
> > respositories.  However, the wrong function sdp_seq_alloc()
> > was used. This function adds 2 redundant bytes (SDP_SEQ8 as
> > 0x35, seq) ahead of 0x08, so that latest PTS IOPT will fail.
> > According to spec, PBAP attributes should report 0x08 0x01
> > or 0x08 0x03 right after 0x0314. The correct function to use
> > is sdp_data_alloc(), with clean 0x08 0x01 appended as
> > SDP_ATTR_SUPPORTED_REPOSITORIES.
> > ---
> >  tools/sdptool.c |    9 ++-------
> >  1 files changed, 2 insertions(+), 7 deletions(-)
>
> can I get a version of this patch that applies cleanly when using git am
> please.


Attached.

Thanks

>
>
> Regards
>
> Marcel
>
>
>

--00163630f1d71ad0cf04707f6a18
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Marcel,<br><br><div class=3D"gmail_quote">On Thu, Aug 6, 2009 at 1:09 PM=
, Marcel Holtmann <span dir=3D"ltr">&lt;<a href=3D"mailto:marcel@holtmann.o=
rg">marcel@holtmann.org</a>&gt;</span> wrote:<br><blockquote class=3D"gmail=
_quote" style=3D"border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt=
 0pt 0.8ex; padding-left: 1ex;">

Hi Jaikumar,<br>
<div class=3D"im"><br>
&gt; Fix to pass PTS case TC_SDAS_BV_03_I(since PTS3.2 update2).<br>
&gt; The code tried to append the UINT type value to the supported<br>
&gt; respositories. =A0However, the wrong function sdp_seq_alloc()<br>
&gt; was used. This function adds 2 redundant bytes (SDP_SEQ8 as<br>
&gt; 0x35, seq) ahead of 0x08, so that latest PTS IOPT will fail.<br>
&gt; According to spec, PBAP attributes should report 0x08 0x01<br>
&gt; or 0x08 0x03 right after 0x0314. The correct function to use<br>
&gt; is sdp_data_alloc(), with clean 0x08 0x01 appended as<br>
&gt; SDP_ATTR_SUPPORTED_REPOSITORIES.<br>
&gt; ---<br>
&gt; =A0tools/sdptool.c | =A0 =A09 ++-------<br>
&gt; =A01 files changed, 2 insertions(+), 7 deletions(-)<br>
<br>
</div>can I get a version of this patch that applies cleanly when using git=
 am<br>
please.</blockquote><div><br>Attached.<br><br>Thanks <br></div><blockquote =
class=3D"gmail_quote" style=3D"border-left: 1px solid rgb(204, 204, 204); m=
argin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;"><br>
<br>
Regards<br>
<font color=3D"#888888"><br>
Marcel<br>
<br>
<br>
</font></blockquote></div><br>

--00163630f1d71ad0cf04707f6a18--

--00163630f1d71ad0d804707f6a1a
Content-Type: text/x-diff; charset=US-ASCII; name="0001-Modify-PBAP-SDP-record.patch"
Content-Disposition: attachment;
	filename="0001-Modify-PBAP-SDP-record.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_fy1z0u2h0

RnJvbSBkMDAyY2MyZmRlYTYxYjgzNjcwOWJjZjc3MzU2NzllMDAxOGQ5ODI2IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBaaHUgTGFuIDxtdGNiNDdAbW90b3JvbGEuY29tPgpEYXRlOiBN
b24sIDMgQXVnIDIwMDkgMTc6MTk6MzkgKzA4MDAKU3ViamVjdDogW1BBVENIXSBNb2RpZnkgUEJB
UCBTRFAgcmVjb3JkLgoKRml4IHRvIHBhc3MgUFRTIGNhc2UgVENfU0RBU19CVl8wM19JKHNpbmNl
IFBUUzMuMiB1cGRhdGUyKS4KVGhlIGNvZGUgdHJpZWQgdG8gYXBwZW5kIHRoZSBVSU5UIHR5cGUg
dmFsdWUgdG8gdGhlIHN1cHBvcnRlZApyZXNwb3NpdG9yaWVzLiAgSG93ZXZlciwgdGhlIHdyb25n
IGZ1bmN0aW9uIHNkcF9zZXFfYWxsb2MoKQp3YXMgdXNlZC4gVGhpcyBmdW5jdGlvbiBhZGRzIDIg
cmVkdW5kYW50IGJ5dGVzIChTRFBfU0VROCBhcwoweDM1LCBzZXEpIGFoZWFkIG9mIDB4MDgsIHNv
IHRoYXQgbGF0ZXN0IFBUUyBJT1BUIHdpbGwgZmFpbC4KQWNjb3JkaW5nIHRvIHNwZWMsIFBCQVAg
YXR0cmlidXRlcyBzaG91bGQgcmVwb3J0IDB4MDggMHgwMQpvciAweDA4IDB4MDMgcmlnaHQgYWZ0
ZXIgMHgwMzE0LiBUaGUgY29ycmVjdCBmdW5jdGlvbiB0byB1c2UKaXMgc2RwX2RhdGFfYWxsb2Mo
KSwgd2l0aCBjbGVhbiAweDA4IDB4MDEgYXBwZW5kZWQgYXMKU0RQX0FUVFJfU1VQUE9SVEVEX1JF
UE9TSVRPUklFUy4KLS0tCiB0b29scy9zZHB0b29sLmMgfCAgICA5ICsrLS0tLS0tLQogMSBmaWxl
cyBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDcgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEv
dG9vbHMvc2RwdG9vbC5jIGIvdG9vbHMvc2RwdG9vbC5jCmluZGV4IDhiMTIyYjkuLmQwYTU2ZTIg
MTAwNjQ0Ci0tLSBhL3Rvb2xzL3NkcHRvb2wuYworKysgYi90b29scy9zZHB0b29sLmMKQEAgLTE4
MjksNyArMTgyOSw3IEBAIHN0YXRpYyBpbnQgYWRkX3BiYXAoc2RwX3Nlc3Npb25fdCAqc2Vzc2lv
biwgc3ZjX2luZm9fdCAqc2kpCiAJc2RwX3JlY29yZF90IHJlY29yZDsKIAl1aW50OF90IGNoYW4g
PSBzaS0+Y2hhbm5lbCA/IHNpLT5jaGFubmVsIDogMTk7CiAJc2RwX2RhdGFfdCAqY2hhbm5lbDsK
LQl1aW50OF90IGZvcm1hdHNbXSA9IHsweDAzfTsKKwl1aW50OF90IGZvcm1hdHNbXSA9IHsweDAx
fTsKIAl2b2lkICpkdGRzW3NpemVvZihmb3JtYXRzKV0sICp2YWx1ZXNbc2l6ZW9mKGZvcm1hdHMp
XTsKIAl1bnNpZ25lZCBpbnQgaTsKIAl1aW50OF90IGR0ZCA9IFNEUF9VSU5UODsKQEAgLTE4Njks
MTIgKzE4NjksNyBAQCBzdGF0aWMgaW50IGFkZF9wYmFwKHNkcF9zZXNzaW9uX3QgKnNlc3Npb24s
IHN2Y19pbmZvX3QgKnNpKQogCWFwcm90byA9IHNkcF9saXN0X2FwcGVuZCgwLCBhcHNlcSk7CiAJ
c2RwX3NldF9hY2Nlc3NfcHJvdG9zKCZyZWNvcmQsIGFwcm90byk7CiAKLQotCWZvciAoaSA9IDA7
IGkgPCBzaXplb2YoZm9ybWF0cyk7IGkrKykgewotCQlkdGRzW2ldID0gJmR0ZDsKLQkJdmFsdWVz
W2ldID0gJmZvcm1hdHNbaV07Ci0JfQotCXNmbGlzdCA9IHNkcF9zZXFfYWxsb2MoZHRkcywgdmFs
dWVzLCBzaXplb2YoZm9ybWF0cykpOworCXNmbGlzdCA9IHNkcF9kYXRhX2FsbG9jKGR0ZCxmb3Jt
YXRzKTsKIAlzZHBfYXR0cl9hZGQoJnJlY29yZCwgU0RQX0FUVFJfU1VQUE9SVEVEX1JFUE9TSVRP
UklFUywgc2ZsaXN0KTsKIAogCXNkcF9zZXRfaW5mb19hdHRyKCZyZWNvcmQsICJPQkVYIFBob25l
Ym9vayBBY2Nlc3MgU2VydmVyIiwgMCwgMCk7Ci0tIAoxLjYuMi4zCgo=
--00163630f1d71ad0d804707f6a1a--
