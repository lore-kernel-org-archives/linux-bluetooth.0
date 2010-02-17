Return-Path: <cyrus@holtmann.org>
Date: Wed, 17 Feb 2010 10:32:29 +0000 (GMT)
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] bluez-hcidump fix SDP universal attributes
In-Reply-To: <1266400962.8849.55.camel@localhost.localdomain>
References: <1259610176.010210.13279.nullmailer@galant.ukfsn.org>  <1263901312.199442.295.nullmailer@galant.ukfsn.org>  <1266312330.230253.2026.nullmailer@galant.ukfsn.org>  <1266334962.8849.8.camel@localhost.localdomain>  <1266360907.186765.4119.nullmailer@galant.ukfsn.org>
 <1266400962.8849.55.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="0-1710667430-1266402749=:1763"
Message-Id: <1266402749.757708.1900.nullmailer@galant.ukfsn.org>
From: Iain Hibbert <plunky@rya-online.net>
List-ID: <linux-bluetooth.vger.kernel.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--0-1710667430-1266402749=:1763
Content-Type: TEXT/PLAIN; charset=US-ASCII

On Wed, 17 Feb 2010, Marcel Holtmann wrote:

> Hi Iain,
>
> > > > > > hcidump shows SDP universal attribute 0x000d as IconURL but in fact it is
> > > > > > defined as "Additional Protocol Descriptor Lists". IconURL is 0x000c and I
> > > > > > don't know what Icon_10 was, perhaps an older name?
> > > > > >
> > > > > > Eg, from an SDP probe of a mouse:
> > > > > >
> > > > > >       aid 0x000d (IconURL)
> > > > > >          < < < uuid-16 0x0100 (L2CAP) uint 0x13 > < uuid-16 0x0011 (HIDP) > > >
> > > > >
> > > > > Reposting because there was no response to this, patch is attached..
> > > > >
> > > > > See "5.1.6 AdditionalProtocolDescriptorList attribute" and "5.1.14 IconURL
> > > > > Attribute" sections in the core specification for reference..
> > > > >
> > > > > (they sometimes call it AdditionalProtocolDescriptorLists and that is more
> > > > > accurate as more than one protocol descriptor list may be included)
> > > >
> > > > posting this simple (and easily verified) patch for hcidump for the third
> > > > time..
> > >
> > > sorry for having missed it. For some reason it got sorted away. Can you
> > > create a proper patch with git format-patch. That makes it way easier
> > > for me to apply them.
> >
> > I am not a git user but perhaps this is correct?
>
> almost, but you need to edit your .gitconfig to create a proper author
> name and more specific author email entry.

Perhaps this is finally correct, but you discourage contributions by being
so restrictive in accepting submissions.  Also, you really do need a bug
tracker.

regards,
iain
--0-1710667430-1266402749=:1763
Content-Type: TEXT/PLAIN; charset=US-ASCII; name=0001-correct-SDP-Universal-Attribute-name-printing.patch
Content-Transfer-Encoding: BASE64
Content-ID: <alpine.NEB.2.00.1002171032290.1763@localhost.>
Content-Description: 
Content-Disposition: attachment; filename=0001-correct-SDP-Universal-Attribute-name-printing.patch

RnJvbSA0YzM4NWEyZWU2Y2Q0OWFlYWE1ZTUwZDBkNDI1Mzc5ZDkyOTYyNGQw
IE1vbiBTZXAgMTcgMDA6MDA6MDAgMjAwMQ0KRnJvbTogSWFpbiBIaWJiZXJ0
IDxwbHVua3lAcnlhLW9ubGluZS5uZXQ+DQpEYXRlOiBXZWQsIDE3IEZlYiAy
MDEwIDEwOjI2OjA0ICswMDAwDQpTdWJqZWN0OiBbUEFUQ0hdIGNvcnJlY3Qg
U0RQIFVuaXZlcnNhbCBBdHRyaWJ1dGUgbmFtZSBwcmludGluZw0KDQogICAg
MHgwMDBjID0gSWNvbiBVUkwNCiAgICAweDAwMGQgPSBBZGRpdGlvbmFsIFBy
b3RvY29sIERlc2NyaXB0b3IgTGlzdHMNCi0tLQ0KIHBhcnNlci9zZHAuYyB8
ICAgIDIgKy0NCiBwYXJzZXIvc2RwLmggfCAgICA0ICsrLS0NCiAyIGZpbGVz
IGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkNCg0K
ZGlmZiAtLWdpdCBhL3BhcnNlci9zZHAuYyBiL3BhcnNlci9zZHAuYw0KaW5k
ZXggNWYyYzFjNi4uYjlmOTkwZSAxMDA2NDQNCi0tLSBhL3BhcnNlci9zZHAu
Yw0KKysrIGIvcGFyc2VyL3NkcC5jDQpAQCAtMTk0LDggKzE5NCw4IEBAIHN0
YXRpYyBzZHBfYXR0cl9pZF9uYW1fbG9va3VwX3RhYmxlX3Qgc2RwX2F0dHJf
aWRfbmFtX2xvb2t1cF90YWJsZVtdID0gew0KIAl7IFNEUF9BVFRSX0lEX0JM
VUVUT09USF9QUk9GSUxFX0RFU0NSSVBUT1JfTElTVCwgIkJUUHJvZmlsZURl
c2NMaXN0IiAgfSwNCiAJeyBTRFBfQVRUUl9JRF9ET0NVTUVOVEFUSU9OX1VS
TCwgICAgICAgICAgICAgICAgICJEb2NVUkwiICAgICAgICAgICAgIH0sDQog
CXsgU0RQX0FUVFJfSURfQ0xJRU5UX0VYRUNVVEFCTEVfVVJMLCAgICAgICAg
ICAgICAiQ2xpZW50RXhlVVJMIiAgICAgICB9LA0KLQl7IFNEUF9BVFRSX0lE
X0lDT05fMTAsICAgICAgICAgICAgICAgICAgICAgICAgICAgIkljb24xMCIg
ICAgICAgICAgICAgfSwNCiAJeyBTRFBfQVRUUl9JRF9JQ09OX1VSTCwgICAg
ICAgICAgICAgICAgICAgICAgICAgICJJY29uVVJMIiAgICAgICAgICAgIH0s
DQorCXsgU0RQX0FUVFJfSURfQURESVRJT05BTF9QUk9UT0NPTF9ERVNDX0xJ
U1RTLCAgICAiQWRkaXRpb25hbFByb3RvY29sRGVzY0xpc3RzIiB9LA0KIAl7
IFNEUF9BVFRSX0lEX1NFUlZJQ0VfTkFNRSwgICAgICAgICAgICAgICAgICAg
ICAgIlNydk5hbWUiICAgICAgICAgICAgfSwNCiAJeyBTRFBfQVRUUl9JRF9T
RVJWSUNFX0RFU0NSSVBUSU9OLCAgICAgICAgICAgICAgICJTcnZEZXNjIiAg
ICAgICAgICAgIH0sDQogCXsgU0RQX0FUVFJfSURfUFJPVklERVJfTkFNRSwg
ICAgICAgICAgICAgICAgICAgICAiUHJvdmlkZXJOYW1lIiAgICAgICB9LA0K
ZGlmZiAtLWdpdCBhL3BhcnNlci9zZHAuaCBiL3BhcnNlci9zZHAuaA0KaW5k
ZXggMDllNDQzMi4uNDc2OWZkMCAxMDA2NDQNCi0tLSBhL3BhcnNlci9zZHAu
aA0KKysrIGIvcGFyc2VyL3NkcC5oDQpAQCAtMTI5LDggKzEyOSw4IEBADQog
I2RlZmluZSBTRFBfQVRUUl9JRF9CTFVFVE9PVEhfUFJPRklMRV9ERVNDUklQ
VE9SX0xJU1QgIDB4MDAwOQ0KICNkZWZpbmUgU0RQX0FUVFJfSURfRE9DVU1F
TlRBVElPTl9VUkwgICAgICAgICAgICAgICAgICAweDAwMEENCiAjZGVmaW5l
IFNEUF9BVFRSX0lEX0NMSUVOVF9FWEVDVVRBQkxFX1VSTCAgICAgICAgICAg
ICAgMHgwMDBCDQotI2RlZmluZSBTRFBfQVRUUl9JRF9JQ09OXzEwICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIDB4MDAwQw0KLSNkZWZpbmUgU0RQX0FU
VFJfSURfSUNPTl9VUkwgICAgICAgICAgICAgICAgICAgICAgICAgICAweDAw
MEQNCisjZGVmaW5lIFNEUF9BVFRSX0lEX0lDT05fVVJMICAgICAgICAgICAg
ICAgICAgICAgICAgICAgMHgwMDBDDQorI2RlZmluZSBTRFBfQVRUUl9JRF9B
RERJVElPTkFMX1BST1RPQ09MX0RFU0NfTElTVFMgICAgIDB4MDAwRA0KICNk
ZWZpbmUgU0RQX0FUVFJfSURfU0VSVklDRV9OQU1FICAgICAgICAgICAgICAg
ICAgICAgICAweDAxMDANCiAjZGVmaW5lIFNEUF9BVFRSX0lEX1NFUlZJQ0Vf
REVTQ1JJUFRJT04gICAgICAgICAgICAgICAgMHgwMTAxDQogI2RlZmluZSBT
RFBfQVRUUl9JRF9QUk9WSURFUl9OQU1FICAgICAgICAgICAgICAgICAgICAg
IDB4MDEwMg0KLS0gDQoxLjYuNg0KDQo=

--0-1710667430-1266402749=:1763--
