Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Sat, 12 Nov 2011 21:13:18 +0200
Message-ID: <CAOazyz3eNUvJ_ft9-+E05mFScT7S-t2=PirZ++x9O--q3ehAtg@mail.gmail.com>
Subject: [PATCH 2/2] Resolve parallel build builtin.h
From: Alon Bar-Lev <alon.barlev@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: multipart/mixed; boundary=20cf307f32542b15e604b18e6e4d
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

--20cf307f32542b15e604b18e6e4d
Content-Type: text/plain; charset=UTF-8

builtin.h is generated source, the priority of build should
be unconditional.

The dependency in plugin.$(OBJEXT) cannot be trusted also it
does not work for me.

Signed-off-by: Alon Bar-Lev <alon.barlev@gmail.com>
---

--20cf307f32542b15e604b18e6e4d
Content-Type: text/x-patch; charset=US-ASCII;
	name="0002-PATCH-Resolve-parallel-build-builtin.h.patch"
Content-Disposition: attachment;
	filename="0002-PATCH-Resolve-parallel-build-builtin.h.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_guwzttg50

RnJvbSAzOGEzNDYxZmRiM2UxZWViM2ZjOGIzOTgxZWRlMDgyMTEzZDNkMTE3IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBbG9uIEJhci1MZXYgPGFsb24uYmFybGV2QGdtYWlsLmNvbT4K
RGF0ZTogU2F0LCAxMiBOb3YgMjAxMSAyMDo1ODoxNiArMDIwMApTdWJqZWN0OiBbUEFUQ0ggMi8y
XSBbUEFUQ0hdIFJlc29sdmUgcGFyYWxsZWwgYnVpbGQgYnVpbHRpbi5oCgpidWlsdGluLmggaXMg
Z2VuZXJhdGVkIHNvdXJjZSwgdGhlIHByaW9yaXR5IG9mIGJ1aWxkIHNob3VsZApiZSB1bmNvbmRp
dGlvbmFsLgoKVGhlIGRlcGVuZGVuY3kgaW4gcGx1Z2luLiQoT0JKRVhUKSBjYW5ub3QgYmUgdHJ1
c3RlZCBhbHNvIGl0CmRvZXMgbm90IHdvcmsgZm9yIG1lLgoKU2lnbmVkLW9mZi1ieTogQWxvbiBC
YXItTGV2IDxhbG9uLmJhcmxldkBnbWFpbC5jb20+Ci0tLQogTWFrZWZpbGUuYW0gfCAgICAzICst
LQogMSBmaWxlcyBjaGFuZ2VkLCAxIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pCgpkaWZm
IC0tZ2l0IGEvTWFrZWZpbGUuYW0gYi9NYWtlZmlsZS5hbQppbmRleCA3ZjJjMTU2Li4wMTQwZTM5
IDEwMDY0NAotLS0gYS9NYWtlZmlsZS5hbQorKysgYi9NYWtlZmlsZS5hbQpAQCAtNDY5LDggKzQ2
OSw3IEBAIE1BSU5UQUlORVJDTEVBTkZJTEVTID0gTWFrZWZpbGUuaW4gXAogCWFjbG9jYWwubTQg
Y29uZmlndXJlIGNvbmZpZy5oLmluIGNvbmZpZy5zdWIgY29uZmlnLmd1ZXNzIFwKIAlsdG1haW4u
c2ggZGVwY29tcCBjb21waWxlIG1pc3NpbmcgaW5zdGFsbC1zaCBta2luc3RhbGxkaXJzIHlsd3Jh
cAogCi1zcmMvcGx1Z2luLiQoT0JKRVhUKTogc3JjL2J1aWx0aW4uaAotCitCVUlMVF9TT1VSQ0VT
ICs9IHNyYy9idWlsdGluLmgKIHNyYy9idWlsdGluLmg6IHNyYy9nZW5idWlsdGluICQoYnVpbHRp
bl9zb3VyY2VzKQogCSQoQU1fVl9HRU4pJChzcmNkaXIpL3NyYy9nZW5idWlsdGluICQoYnVpbHRp
bl9tb2R1bGVzKSA+ICRACiAKLS0gCjEuNy4zLjQKCg==
--20cf307f32542b15e604b18e6e4d--
