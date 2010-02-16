Return-Path: <cyrus@holtmann.org>
Date: Tue, 16 Feb 2010 22:55:07 +0000 (GMT)
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] bluez-hcidump fix SDP universal attributes
In-Reply-To: <1266334962.8849.8.camel@localhost.localdomain>
References: <1259610176.010210.13279.nullmailer@galant.ukfsn.org>  <1263901312.199442.295.nullmailer@galant.ukfsn.org>  <1266312330.230253.2026.nullmailer@galant.ukfsn.org> <1266334962.8849.8.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="0-1141480257-1266360907=:26788"
Message-Id: <1266360907.186765.4119.nullmailer@galant.ukfsn.org>
From: Iain Hibbert <plunky@rya-online.net>
List-ID: <linux-bluetooth.vger.kernel.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--0-1141480257-1266360907=:26788
Content-Type: TEXT/PLAIN; charset=US-ASCII

On Tue, 16 Feb 2010, Marcel Holtmann wrote:

> > > > hcidump shows SDP universal attribute 0x000d as IconURL but in fact it is
> > > > defined as "Additional Protocol Descriptor Lists". IconURL is 0x000c and I
> > > > don't know what Icon_10 was, perhaps an older name?
> > > >
> > > > Eg, from an SDP probe of a mouse:
> > > >
> > > >       aid 0x000d (IconURL)
> > > >          < < < uuid-16 0x0100 (L2CAP) uint 0x13 > < uuid-16 0x0011 (HIDP) > > >
> > >
> > > Reposting because there was no response to this, patch is attached..
> > >
> > > See "5.1.6 AdditionalProtocolDescriptorList attribute" and "5.1.14 IconURL
> > > Attribute" sections in the core specification for reference..
> > >
> > > (they sometimes call it AdditionalProtocolDescriptorLists and that is more
> > > accurate as more than one protocol descriptor list may be included)
> >
> > posting this simple (and easily verified) patch for hcidump for the third
> > time..
>
> sorry for having missed it. For some reason it got sorted away. Can you
> create a proper patch with git format-patch. That makes it way easier
> for me to apply them.

I am not a git user but perhaps this is correct?

regards,
iain
--0-1141480257-1266360907=:26788
Content-Type: TEXT/PLAIN; charset=US-ASCII; name=0001-correct-SDP-Universal-Attribute-name-printing.patch
Content-Transfer-Encoding: BASE64
Content-ID: <alpine.NEB.2.00.1002162255070.26788@localhost.>
Content-Description: git format-patch
Content-Disposition: attachment; filename=0001-correct-SDP-Universal-Attribute-name-printing.patch

RnJvbSA1NjE1ZjEzNmZiNTdhOTdkYTE1YTI5YzhiMjdjZWYxYTcwN2VmYWEz
IE1vbiBTZXAgMTcgMDA6MDA6MDAgMjAwMQ0KRnJvbTogSWFpbiBIaWJiZXJ0
IDxwbHVua3lAZ2FsYW50Lihub25lKT4NCkRhdGU6IFR1ZSwgMTYgRmViIDIw
MTAgMjI6NDc6MTkgKzAwMDANClN1YmplY3Q6IFtQQVRDSF0gY29ycmVjdCBT
RFAgVW5pdmVyc2FsIEF0dHJpYnV0ZSBuYW1lIHByaW50aW5nDQoNCiAgICAw
eDAwMGMgPSBJY29uVVJMDQogICAgMHgwMDBkID0gQXR0cmlidXRlUHJvdG9j
b2xEZXNjcmlwdG9yTGlzdHMNCi0tLQ0KIHBhcnNlci9zZHAuYyB8ICAgIDIg
Ky0NCiBwYXJzZXIvc2RwLmggfCAgICA0ICsrLS0NCiAyIGZpbGVzIGNoYW5n
ZWQsIDMgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkNCg0KZGlmZiAt
LWdpdCBhL3BhcnNlci9zZHAuYyBiL3BhcnNlci9zZHAuYw0KaW5kZXggNWYy
YzFjNi4uYjlmOTkwZSAxMDA2NDQNCi0tLSBhL3BhcnNlci9zZHAuYw0KKysr
IGIvcGFyc2VyL3NkcC5jDQpAQCAtMTk0LDggKzE5NCw4IEBAIHN0YXRpYyBz
ZHBfYXR0cl9pZF9uYW1fbG9va3VwX3RhYmxlX3Qgc2RwX2F0dHJfaWRfbmFt
X2xvb2t1cF90YWJsZVtdID0gew0KIAl7IFNEUF9BVFRSX0lEX0JMVUVUT09U
SF9QUk9GSUxFX0RFU0NSSVBUT1JfTElTVCwgIkJUUHJvZmlsZURlc2NMaXN0
IiAgfSwNCiAJeyBTRFBfQVRUUl9JRF9ET0NVTUVOVEFUSU9OX1VSTCwgICAg
ICAgICAgICAgICAgICJEb2NVUkwiICAgICAgICAgICAgIH0sDQogCXsgU0RQ
X0FUVFJfSURfQ0xJRU5UX0VYRUNVVEFCTEVfVVJMLCAgICAgICAgICAgICAi
Q2xpZW50RXhlVVJMIiAgICAgICB9LA0KLQl7IFNEUF9BVFRSX0lEX0lDT05f
MTAsICAgICAgICAgICAgICAgICAgICAgICAgICAgIkljb24xMCIgICAgICAg
ICAgICAgfSwNCiAJeyBTRFBfQVRUUl9JRF9JQ09OX1VSTCwgICAgICAgICAg
ICAgICAgICAgICAgICAgICJJY29uVVJMIiAgICAgICAgICAgIH0sDQorCXsg
U0RQX0FUVFJfSURfQURESVRJT05BTF9QUk9UT0NPTF9ERVNDX0xJU1RTLCAg
ICAiQWRkaXRpb25hbFByb3RvY29sRGVzY0xpc3RzIiB9LA0KIAl7IFNEUF9B
VFRSX0lEX1NFUlZJQ0VfTkFNRSwgICAgICAgICAgICAgICAgICAgICAgIlNy
dk5hbWUiICAgICAgICAgICAgfSwNCiAJeyBTRFBfQVRUUl9JRF9TRVJWSUNF
X0RFU0NSSVBUSU9OLCAgICAgICAgICAgICAgICJTcnZEZXNjIiAgICAgICAg
ICAgIH0sDQogCXsgU0RQX0FUVFJfSURfUFJPVklERVJfTkFNRSwgICAgICAg
ICAgICAgICAgICAgICAiUHJvdmlkZXJOYW1lIiAgICAgICB9LA0KZGlmZiAt
LWdpdCBhL3BhcnNlci9zZHAuaCBiL3BhcnNlci9zZHAuaA0KaW5kZXggMDll
NDQzMi4uNDc2OWZkMCAxMDA2NDQNCi0tLSBhL3BhcnNlci9zZHAuaA0KKysr
IGIvcGFyc2VyL3NkcC5oDQpAQCAtMTI5LDggKzEyOSw4IEBADQogI2RlZmlu
ZSBTRFBfQVRUUl9JRF9CTFVFVE9PVEhfUFJPRklMRV9ERVNDUklQVE9SX0xJ
U1QgIDB4MDAwOQ0KICNkZWZpbmUgU0RQX0FUVFJfSURfRE9DVU1FTlRBVElP
Tl9VUkwgICAgICAgICAgICAgICAgICAweDAwMEENCiAjZGVmaW5lIFNEUF9B
VFRSX0lEX0NMSUVOVF9FWEVDVVRBQkxFX1VSTCAgICAgICAgICAgICAgMHgw
MDBCDQotI2RlZmluZSBTRFBfQVRUUl9JRF9JQ09OXzEwICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIDB4MDAwQw0KLSNkZWZpbmUgU0RQX0FUVFJfSURf
SUNPTl9VUkwgICAgICAgICAgICAgICAgICAgICAgICAgICAweDAwMEQNCisj
ZGVmaW5lIFNEUF9BVFRSX0lEX0lDT05fVVJMICAgICAgICAgICAgICAgICAg
ICAgICAgICAgMHgwMDBDDQorI2RlZmluZSBTRFBfQVRUUl9JRF9BRERJVElP
TkFMX1BST1RPQ09MX0RFU0NfTElTVFMgICAgIDB4MDAwRA0KICNkZWZpbmUg
U0RQX0FUVFJfSURfU0VSVklDRV9OQU1FICAgICAgICAgICAgICAgICAgICAg
ICAweDAxMDANCiAjZGVmaW5lIFNEUF9BVFRSX0lEX1NFUlZJQ0VfREVTQ1JJ
UFRJT04gICAgICAgICAgICAgICAgMHgwMTAxDQogI2RlZmluZSBTRFBfQVRU
Ul9JRF9QUk9WSURFUl9OQU1FICAgICAgICAgICAgICAgICAgICAgIDB4MDEw
Mg0KLS0gDQoxLjYuNg0KDQo=

--0-1141480257-1266360907=:26788--
