Return-Path: <cyrus@holtmann.org>
Content-Type: multipart/mixed; boundary=----------L9vnCCjuxgkxvPFwNfo7LB
To: "Johan Hedberg" <johan.hedberg@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, ovasik@redhat.com,
	stlman@poczta.fm
Subject: Re: [PATCH 1/8] Off-by-one(two) error in form factor detection
References: <op.v0avzhpah52hc0@dhcp-25-209.brq.redhat.com>
 <20110822082933.GD11306@dell>
Date: Tue, 23 Aug 2011 07:07:32 +0200
MIME-Version: 1.0
From: "Pavel Raiskup" <praiskup@redhat.com>
Message-ID: <op.v0nhuunjh52hc0@dhcp-25-209.brq.redhat.com>
In-Reply-To: <20110822082933.GD11306@dell>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

------------L9vnCCjuxgkxvPFwNfo7LB
Content-Type: text/plain; charset=utf-8; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit

Hi Johan,

> On Tue, Aug 16, 2011, Pavel Raiskup wrote:
>> Indexing of chassis_map array has to be done like that:
>>     chassis_map[chassis_type * 2 - 1]
>>
>> because if not, everything is shifted by one. When (e.g.) chassis_type
>> is 0x04 result should be "Low Profile Desktop" =>  "desktop" (not a
>> "Pizza Box" => "server"). Lets see the 2.6.1 document on:
>>
>> http://www.dmtf.org/standards/smbios
>> ---
>>  plugins/formfactor.c |    2 +-
>>  1 files changed, 1 insertions(+), 1 deletions(-)
>
> The patch doesn't apply (probably due to your email client splitting
> lines). You might want to consider using git send-email instead:

sorry for that, I'll use send-email for the next time. For now I'm sending
patches again as attachment because I don't want to break this thread.
------------L9vnCCjuxgkxvPFwNfo7LB
Content-Disposition: attachment; filename=0001-Off-by-one-two-error-in-form-factor-detection.patch
Content-Type: application/octet-stream; name=0001-Off-by-one-two-error-in-form-factor-detection.patch
Content-Transfer-Encoding: Base64

RnJvbSBhMDI4Y2I2ZGE1NGU5YjNjZmY4MzAxNTA4NDJhMTJmYWVkNmE3ODYwIE1v
biBTZXAgMTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBQYXZlbCBSYWlza3VwIDxwcmFp
c2t1cEByZWRoYXQuY29tPgpEYXRlOiBUaHUsIDExIEF1ZyAyMDExIDEzOjM2OjI1
ICswMjAwClN1YmplY3Q6IFtQQVRDSCAxLzhdIE9mZi1ieS1vbmUodHdvKSBlcnJv
ciBpbiBmb3JtIGZhY3RvciBkZXRlY3Rpb24KCkluZGV4aW5nIG9mIGNoYXNzaXNf
bWFwIGFycmF5IGhhcyB0byBiZSBkb25lIGxpa2UgdGhhdDoKICAgIGNoYXNzaXNf
bWFwW2NoYXNzaXNfdHlwZSAqIDIgLSAxXQoKYmVjYXVzZSBpZiBub3QsIGV2ZXJ5
dGhpbmcgaXMgc2hpZnRlZCBieSBvbmUuIFdoZW4gKGUuZy4pIGNoYXNzaXNfdHlw
ZQppcyAweDA0IHJlc3VsdCBzaG91bGQgYmUgIkxvdyBQcm9maWxlIERlc2t0b3Ai
ID0+ICAiZGVza3RvcCIgKG5vdCBhCiJQaXp6YSBCb3giID0+ICJzZXJ2ZXIiKS4g
TGV0cyBzZWUgdGhlIDIuNi4xIGRvY3VtZW50IG9uOgoKaHR0cDovL3d3dy5kbXRm
Lm9yZy9zdGFuZGFyZHMvc21iaW9zCi0tLQogcGx1Z2lucy9mb3JtZmFjdG9yLmMg
fCAgICAyICstCiAxIGZpbGVzIGNoYW5nZWQsIDEgaW5zZXJ0aW9ucygrKSwgMSBk
ZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9wbHVnaW5zL2Zvcm1mYWN0b3IuYyBi
L3BsdWdpbnMvZm9ybWZhY3Rvci5jCmluZGV4IDMzYThiMzIuLjNiMzE5MjcgMTAw
NjQ0Ci0tLSBhL3BsdWdpbnMvZm9ybWZhY3Rvci5jCisrKyBiL3BsdWdpbnMvZm9y
bWZhY3Rvci5jCkBAIC0xMDQsNyArMTA0LDcgQEAgc3RhdGljIGludCBmb3JtZmFj
dG9yX3Byb2JlKHN0cnVjdCBidGRfYWRhcHRlciAqYWRhcHRlcikKIAkJcmV0dXJu
IDA7CiAJfQogCi0JZm9ybWZhY3RvciA9IGNoYXNzaXNfbWFwW2NoYXNzaXNfdHlw
ZSAqIDIgKyAxXTsKKwlmb3JtZmFjdG9yID0gY2hhc3Npc19tYXBbY2hhc3Npc190
eXBlICogMiAtIDFdOwogCWlmIChmb3JtZmFjdG9yICE9IE5VTEwpIHsKIAkJaWYg
KGdfc3RyX2VxdWFsKGZvcm1mYWN0b3IsICJsYXB0b3AiKSA9PSBUUlVFKQogCQkJ
bWlub3IgfD0gKDEgPDwgMikgfCAoMSA8PCAzKTsKLS0gCjEuNy40LjQKCg==

------------L9vnCCjuxgkxvPFwNfo7LB--

