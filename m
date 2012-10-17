Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <15890511.ludKIz2NbJ@uw000953>
References: <1350391036-29997-1-git-send-email-szymon.janc@tieto.com>
	<CABBYNZLbX__mxzwvZMOd3noCeoJTRrXshFTEovM9Tco4bziLRg@mail.gmail.com>
	<15890511.ludKIz2NbJ@uw000953>
Date: Wed, 17 Oct 2012 10:48:36 +0200
Message-ID: <CABBYNZKQWy2CmM2FLZyw24UXEo202SsHymK-jzGF+k2dmg6brw@mail.gmail.com>
Subject: Re: [PATCH] avdtp: Fix crash on connection lost
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Szymon Janc <szymon.janc@tieto.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: multipart/mixed; boundary=0016e68ee0b31fe4ea04cc3d56de
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

--0016e68ee0b31fe4ea04cc3d56de
Content-Type: text/plain; charset=ISO-8859-1

Hi Szymon,

On Wed, Oct 17, 2012 at 9:28 AM, Szymon Janc <szymon.janc@tieto.com> wrote:
> On Tuesday 16 of October 2012 20:34:47 Luiz Augusto von Dentz wrote:
>> Hi Szymon,
>
> Hi Luiz,
>
>> >         if (session->io) {
>> >                 g_io_channel_shutdown(session->io, FALSE, NULL);
>> > @@ -1173,8 +1172,6 @@ static void connection_lost(struct avdtp *session, int err)
>> >                 session->io = NULL;
>> >         }
>> >
>> > -       avdtp_set_state(session, AVDTP_SESSION_STATE_DISCONNECTED);
>>
>> This is actually the one that we need in case we got disconnect by
>> remote after discovery completes. avctp.c has a similar structure to
>> handler such states, but without the refcounting all is much simpler.
>
> OK
>
>>
>> >         if (session->io_id) {
>> >                 g_source_remove(session->io_id);
>> >                 session->io_id = 0;
>> > @@ -1221,9 +1218,6 @@ void avdtp_unref(struct avdtp *session)
>> >
>> >                 if (session->io)
>> >                         set_disconnect_timer(session);
>> > -               else if (!session->free_lock) /* Drop the local ref if we
>> > -                                                aren't connected */
>> > -                       session->ref--;
>> >         }
>> >
>> >         if (session->ref > 0)
>> > --
>> > 1.7.9.5
>>
>> We should probably get rid of the free_lock as well.
>
> Well, this is what this patch does, doesn't it?:)

What about the attached patch, it should fix the references for good
by using the dc_timer when the reference drops to 0, I just need to
check if 1 second is enough to cover all cases including the ones
where the remote device connects but doesn't setup any stream, with
the devices I have 1 second seems enough.

-- 
Luiz Augusto von Dentz

--0016e68ee0b31fe4ea04cc3d56de
Content-Type: application/octet-stream;
	name="0001-AVDTP-Do-not-keep-a-internal-reference.patch"
Content-Disposition: attachment;
	filename="0001-AVDTP-Do-not-keep-a-internal-reference.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_h8e6ylhb0

RnJvbSAzOTMxMmNmMDlmYWM3MDA1MDVkZWI3YmFiZDEyOWJlYzFiNGUyNmRjIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBMdWl6IEF1Z3VzdG8gdm9uIERlbnR6IDxsdWl6LnZvbi5kZW50
ekBpbnRlbC5jb20+CkRhdGU6IFR1ZSwgMTYgT2N0IDIwMTIgMjM6MDk6NTMgKzAzMDAKU3ViamVj
dDogW1BBVENIIEJsdWVaXSBBVkRUUDogRG8gbm90IGtlZXAgYSBpbnRlcm5hbCByZWZlcmVuY2UK
CkRvbid0IGluaXRpYWxpemUgcmVmZXJlbmNlIHdpdGggMSwgaW5zdGVhZCBhbHdheXMgc3RhcnQg
ZGlzY29ubmVjdCB0aW1lcgp3aGVuIHJlZmVyZW5jZSBkcm9wcyB0byAwLCBzbyBpbiBjYXNlIG5v
Ym9keSByZWNsYWltcyB0aGUgc2Vzc2lvbiBpdAphdXRvbWF0aWNhbGx5IGRpc2Nvbm5lY3QgYWZ0
ZXIgMSBzZWNvbmQgYW5kIGZyZWVzIHRoZSBtZW1vcnkuCi0tLQogYXVkaW8vYXZkdHAuYyB8IDEx
NCArKysrKysrKysrKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tCiAxIGZpbGUgY2hhbmdlZCwgNTAgaW5zZXJ0aW9ucygrKSwgNjQgZGVsZXRpb25zKC0pCgpk
aWZmIC0tZ2l0IGEvYXVkaW8vYXZkdHAuYyBiL2F1ZGlvL2F2ZHRwLmMKaW5kZXggYmQ5MWNiNi4u
ZTM1YjMyNCAxMDA2NDQKLS0tIGEvYXVkaW8vYXZkdHAuYworKysgYi9hdWRpby9hdmR0cC5jCkBA
IC0zODgsNyArMzg4LDYgQEAgc3RydWN0IGF2ZHRwX3N0cmVhbSB7CiAKIHN0cnVjdCBhdmR0cCB7
CiAJaW50IHJlZjsKLQlpbnQgZnJlZV9sb2NrOwogCiAJdWludDE2X3QgdmVyc2lvbjsKIApAQCAt
NzgwLDggKzc3OSw5IEBAIHN0YXRpYyB2b2lkIGF2ZHRwX3NldF9zdGF0ZShzdHJ1Y3QgYXZkdHAg
KnNlc3Npb24sCiAJfQogfQogCi1zdGF0aWMgdm9pZCBzdHJlYW1fZnJlZShzdHJ1Y3QgYXZkdHBf
c3RyZWFtICpzdHJlYW0pCitzdGF0aWMgdm9pZCBzdHJlYW1fZnJlZSh2b2lkICpkYXRhKQogewor
CXN0cnVjdCBhdmR0cF9zdHJlYW0gKnN0cmVhbSA9IGRhdGE7CiAJc3RydWN0IGF2ZHRwX3JlbW90
ZV9zZXAgKnJzZXA7CiAKIAlzdHJlYW0tPmxzZXAtPmluZm8uaW51c2UgPSAwOwpAQCAtMTE0OCwz
MyArMTE0OCwzMCBAQCBzdGF0aWMgaW50IGF2ZHRwX2NhbmNlbF9hdXRob3JpemF0aW9uKHN0cnVj
dCBhdmR0cCAqc2Vzc2lvbikKIAlyZXR1cm4gMDsKIH0KIAotc3RhdGljIHZvaWQgY29ubmVjdGlv
bl9sb3N0KHN0cnVjdCBhdmR0cCAqc2Vzc2lvbiwgaW50IGVycikKK3N0YXRpYyB2b2lkIHNlcF9m
cmVlKGdwb2ludGVyIGRhdGEpCiB7Ci0JY2hhciBhZGRyZXNzWzE4XTsKLQotCWJhMnN0cigmc2Vz
c2lvbi0+ZHN0LCBhZGRyZXNzKTsKLQlEQkcoIkRpc2Nvbm5lY3RlZCBmcm9tICVzIiwgYWRkcmVz
cyk7CisJc3RydWN0IGF2ZHRwX3JlbW90ZV9zZXAgKnNlcCA9IGRhdGE7CiAKLQlpZiAoZXJyICE9
IEVBQ0NFUykKLQkJYXZkdHBfY2FuY2VsX2F1dGhvcml6YXRpb24oc2Vzc2lvbik7CisJZ19zbGlz
dF9mcmVlX2Z1bGwoc2VwLT5jYXBzLCBnX2ZyZWUpOworCWdfZnJlZShzZXApOworfQogCi0Jc2Vz
c2lvbi0+ZnJlZV9sb2NrID0gMTsKK3N0YXRpYyB2b2lkIGF2ZHRwX2ZyZWUoc3RydWN0IGF2ZHRw
ICpzZXNzaW9uKQoreworCXN0cnVjdCBhdmR0cF9zZXJ2ZXIgKnNlcnZlcjsKIAotCWZpbmFsaXpl
X2Rpc2NvdmVyeShzZXNzaW9uLCBlcnIpOworCURCRygiJXAiLCBzZXNzaW9uKTsKIAotCWdfc2xp
c3RfZm9yZWFjaChzZXNzaW9uLT5zdHJlYW1zLCAoR0Z1bmMpIHJlbGVhc2Vfc3RyZWFtLCBzZXNz
aW9uKTsKLQlzZXNzaW9uLT5zdHJlYW1zID0gTlVMTDsKKwlnX3NsaXN0X2ZyZWVfZnVsbChzZXNz
aW9uLT5zdHJlYW1zLCBzdHJlYW1fZnJlZSk7CiAKLQlzZXNzaW9uLT5mcmVlX2xvY2sgPSAwOwor
CWlmIChzZXNzaW9uLT5zdGF0ZSAhPSBBVkRUUF9TRVNTSU9OX1NUQVRFX0RJU0NPTk5FQ1RFRCkK
KwkJYXZkdHBfc2V0X3N0YXRlKHNlc3Npb24sIEFWRFRQX1NFU1NJT05fU1RBVEVfRElTQ09OTkVD
VEVEKTsKIAogCWlmIChzZXNzaW9uLT5pbykgewogCQlnX2lvX2NoYW5uZWxfc2h1dGRvd24oc2Vz
c2lvbi0+aW8sIEZBTFNFLCBOVUxMKTsKIAkJZ19pb19jaGFubmVsX3VucmVmKHNlc3Npb24tPmlv
KTsKLQkJc2Vzc2lvbi0+aW8gPSBOVUxMOwogCX0KIAotCWF2ZHRwX3NldF9zdGF0ZShzZXNzaW9u
LCBBVkRUUF9TRVNTSU9OX1NUQVRFX0RJU0NPTk5FQ1RFRCk7Ci0KIAlpZiAoc2Vzc2lvbi0+aW9f
aWQpIHsKIAkJZ19zb3VyY2VfcmVtb3ZlKHNlc3Npb24tPmlvX2lkKTsKIAkJc2Vzc2lvbi0+aW9f
aWQgPSAwOwpAQCAtMTE4Myw2OSArMTE4MCw1OCBAQCBzdGF0aWMgdm9pZCBjb25uZWN0aW9uX2xv
c3Qoc3RydWN0IGF2ZHRwICpzZXNzaW9uLCBpbnQgZXJyKQogCWlmIChzZXNzaW9uLT5kY190aW1l
cikKIAkJcmVtb3ZlX2Rpc2Nvbm5lY3RfdGltZXIoc2Vzc2lvbik7CiAKLQlpZiAoc2Vzc2lvbi0+
cmVmICE9IDEpCi0JCWVycm9yKCJjb25uZWN0aW9uX2xvc3Q6IHJlZiBjb3VudCBub3QgMSBhZnRl
ciBhbGwgY2FsbGJhY2tzIik7Ci0JZWxzZQotCQlhdmR0cF91bnJlZihzZXNzaW9uKTsKLX0KKwlh
dmR0cF9jYW5jZWxfYXV0aG9yaXphdGlvbihzZXNzaW9uKTsKIAotc3RhdGljIHZvaWQgc2VwX2Zy
ZWUoZ3BvaW50ZXIgZGF0YSkKLXsKLQlzdHJ1Y3QgYXZkdHBfcmVtb3RlX3NlcCAqc2VwID0gZGF0
YTsKKwlzZXJ2ZXIgPSBzZXNzaW9uLT5zZXJ2ZXI7CiAKLQlnX3NsaXN0X2ZyZWVfZnVsbChzZXAt
PmNhcHMsIGdfZnJlZSk7Ci0JZ19mcmVlKHNlcCk7Ci19CisJc2VydmVyLT5zZXNzaW9ucyA9IGdf
c2xpc3RfcmVtb3ZlKHNlcnZlci0+c2Vzc2lvbnMsIHNlc3Npb24pOwogCi12b2lkIGF2ZHRwX3Vu
cmVmKHN0cnVjdCBhdmR0cCAqc2Vzc2lvbikKLXsKLQlzdHJ1Y3QgYXZkdHBfc2VydmVyICpzZXJ2
ZXI7CisJaWYgKHNlc3Npb24tPnJlcSkKKwkJcGVuZGluZ19yZXFfZnJlZShzZXNzaW9uLT5yZXEp
OwogCi0JaWYgKCFzZXNzaW9uKQotCQlyZXR1cm47CisJZ19zbGlzdF9mcmVlX2Z1bGwoc2Vzc2lv
bi0+c2Vwcywgc2VwX2ZyZWUpOwogCi0Jc2Vzc2lvbi0+cmVmLS07CisJZ19mcmVlKHNlc3Npb24t
PmJ1Zik7CiAKLQlEQkcoIiVwOiByZWY9JWQiLCBzZXNzaW9uLCBzZXNzaW9uLT5yZWYpOworCWdf
ZnJlZShzZXNzaW9uKTsKK30KIAotCWlmIChzZXNzaW9uLT5yZWYgPT0gMSkgewotCQlpZiAoc2Vz
c2lvbi0+c3RhdGUgPT0gQVZEVFBfU0VTU0lPTl9TVEFURV9DT05ORUNUSU5HICYmCi0JCQkJCQkJ
CXNlc3Npb24tPmlvKSB7Ci0JCQlhdmR0cF9jYW5jZWxfYXV0aG9yaXphdGlvbihzZXNzaW9uKTsK
LQkJCWdfaW9fY2hhbm5lbF9zaHV0ZG93bihzZXNzaW9uLT5pbywgVFJVRSwgTlVMTCk7Ci0JCQln
X2lvX2NoYW5uZWxfdW5yZWYoc2Vzc2lvbi0+aW8pOwotCQkJc2Vzc2lvbi0+aW8gPSBOVUxMOwot
CQkJYXZkdHBfc2V0X3N0YXRlKHNlc3Npb24sCi0JCQkJCUFWRFRQX1NFU1NJT05fU1RBVEVfRElT
Q09OTkVDVEVEKTsKLQkJfQorc3RhdGljIHZvaWQgY29ubmVjdGlvbl9sb3N0KHN0cnVjdCBhdmR0
cCAqc2Vzc2lvbiwgaW50IGVycikKK3sKKwljaGFyIGFkZHJlc3NbMThdOwogCi0JCWlmIChzZXNz
aW9uLT5pbykKLQkJCXNldF9kaXNjb25uZWN0X3RpbWVyKHNlc3Npb24pOwotCQllbHNlIGlmICgh
c2Vzc2lvbi0+ZnJlZV9sb2NrKSAvKiBEcm9wIHRoZSBsb2NhbCByZWYgaWYgd2UKLQkJCQkJCSBh
cmVuJ3QgY29ubmVjdGVkICovCi0JCQlzZXNzaW9uLT5yZWYtLTsKLQl9CisJYmEyc3RyKCZzZXNz
aW9uLT5kc3QsIGFkZHJlc3MpOworCURCRygiRGlzY29ubmVjdGVkIGZyb20gJXMiLCBhZGRyZXNz
KTsKIAotCWlmIChzZXNzaW9uLT5yZWYgPiAwKQorCWlmIChlcnIgIT0gRUFDQ0VTKQorCQlhdmR0
cF9jYW5jZWxfYXV0aG9yaXphdGlvbihzZXNzaW9uKTsKKworCWlmIChzZXNzaW9uLT5yZWYgPT0g
MCkgeworCQlhdmR0cF9mcmVlKHNlc3Npb24pOwogCQlyZXR1cm47CisJfQogCi0Jc2VydmVyID0g
c2Vzc2lvbi0+c2VydmVyOworCWdfc2xpc3RfZm9yZWFjaChzZXNzaW9uLT5zdHJlYW1zLCAoR0Z1
bmMpIHJlbGVhc2Vfc3RyZWFtLCBzZXNzaW9uKTsKKwlzZXNzaW9uLT5zdHJlYW1zID0gTlVMTDsK
IAotCURCRygiJXA6IGZyZWVpbmcgc2Vzc2lvbiBhbmQgcmVtb3ZpbmcgZnJvbSBsaXN0Iiwgc2Vz
c2lvbik7CisJZmluYWxpemVfZGlzY292ZXJ5KHNlc3Npb24sIGVycik7CiAKLQlpZiAoc2Vzc2lv
bi0+ZGNfdGltZXIpCi0JCXJlbW92ZV9kaXNjb25uZWN0X3RpbWVyKHNlc3Npb24pOworCWF2ZHRw
X3NldF9zdGF0ZShzZXNzaW9uLCBBVkRUUF9TRVNTSU9OX1NUQVRFX0RJU0NPTk5FQ1RFRCk7Cit9
CiAKLQlzZXJ2ZXItPnNlc3Npb25zID0gZ19zbGlzdF9yZW1vdmUoc2VydmVyLT5zZXNzaW9ucywg
c2Vzc2lvbik7Cit2b2lkIGF2ZHRwX3VucmVmKHN0cnVjdCBhdmR0cCAqc2Vzc2lvbikKK3sKKwlp
ZiAoIXNlc3Npb24pCisJCXJldHVybjsKIAotCWlmIChzZXNzaW9uLT5yZXEpCi0JCXBlbmRpbmdf
cmVxX2ZyZWUoc2Vzc2lvbi0+cmVxKTsKKwlzZXNzaW9uLT5yZWYtLTsKIAotCWdfc2xpc3RfZnJl
ZV9mdWxsKHNlc3Npb24tPnNlcHMsIHNlcF9mcmVlKTsKKwlEQkcoIiVwOiByZWY9JWQiLCBzZXNz
aW9uLCBzZXNzaW9uLT5yZWYpOwogCi0JZ19mcmVlKHNlc3Npb24tPmJ1Zik7CisJaWYgKHNlc3Np
b24tPnJlZiA+IDApCisJCXJldHVybjsKIAotCWdfZnJlZShzZXNzaW9uKTsKKwlzZXRfZGlzY29u
bmVjdF90aW1lcihzZXNzaW9uKTsKIH0KIAogc3RydWN0IGF2ZHRwICphdmR0cF9yZWYoc3RydWN0
IGF2ZHRwICpzZXNzaW9uKQpAQCAtMjIzMSw3ICsyMjE3LDcgQEAgc3RhdGljIGdib29sZWFuIHNl
c3Npb25fY2IoR0lPQ2hhbm5lbCAqY2hhbiwgR0lPQ29uZGl0aW9uIGNvbmQsCiAJCQlnb3RvIGZh
aWxlZDsKIAkJfQogCi0JCWlmIChzZXNzaW9uLT5yZWYgPT0gMSAmJiAhc2Vzc2lvbi0+c3RyZWFt
cyAmJiAhc2Vzc2lvbi0+cmVxKQorCQlpZiAoc2Vzc2lvbi0+cmVmID09IDAgJiYgIXNlc3Npb24t
PnN0cmVhbXMgJiYgIXNlc3Npb24tPnJlcSkKIAkJCXNldF9kaXNjb25uZWN0X3RpbWVyKHNlc3Np
b24pOwogCiAJCWlmIChzZXNzaW9uLT5zdHJlYW1zICYmIHNlc3Npb24tPmRjX3RpbWVyKQpAQCAt
MjM4Myw3ICsyMzY5LDcgQEAgc3RhdGljIHN0cnVjdCBhdmR0cCAqYXZkdHBfZ2V0X2ludGVybmFs
KGNvbnN0IGJkYWRkcl90ICpzcmMsIGNvbnN0IGJkYWRkcl90ICpkc3QKIAogCXNlc3Npb24tPnNl
cnZlciA9IHNlcnZlcjsKIAliYWNweSgmc2Vzc2lvbi0+ZHN0LCBkc3QpOwotCXNlc3Npb24tPnJl
ZiA9IDE7CisJc2V0X2Rpc2Nvbm5lY3RfdGltZXIoc2Vzc2lvbik7CiAJLyogV2UgZG9uJ3QgdXNl
IGF2ZHRwX3NldF9zdGF0ZSgpIGhlcmUgc2luY2UgdGhpcyBpc24ndCBhIHN0YXRlIGNoYW5nZQog
CSAqIGJ1dCBqdXN0IHNldHRpbmcgb2YgdGhlIGluaXRpYWwgc3RhdGUgKi8KIAlzZXNzaW9uLT5z
dGF0ZSA9IEFWRFRQX1NFU1NJT05fU1RBVEVfRElTQ09OTkVDVEVEOwotLSAKMS43LjExLjQKCg==
--0016e68ee0b31fe4ea04cc3d56de--
