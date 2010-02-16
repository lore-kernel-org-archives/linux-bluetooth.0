Return-Path: <cyrus@holtmann.org>
Date: Tue, 16 Feb 2010 09:25:29 +0000 (GMT)
To: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] bluez-hcidump fix SDP universal attributes
In-Reply-To: <1263901312.199442.295.nullmailer@galant.ukfsn.org>
References: <1259610176.010210.13279.nullmailer@galant.ukfsn.org> <1263901312.199442.295.nullmailer@galant.ukfsn.org>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="0-1804564332-1266312330=:1624"
Message-Id: <1266312330.230253.2026.nullmailer@galant.ukfsn.org>
From: Iain Hibbert <plunky@rya-online.net>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--0-1804564332-1266312330=:1624
Content-Type: TEXT/PLAIN; charset=US-ASCII

On Tue, 19 Jan 2010, Iain Hibbert wrote:

> On Mon, 30 Nov 2009, Iain Hibbert wrote:
>
> > hcidump shows SDP universal attribute 0x000d as IconURL but in fact it is
> > defined as "Additional Protocol Descriptor Lists". IconURL is 0x000c and I
> > don't know what Icon_10 was, perhaps an older name?
> >
> > Eg, from an SDP probe of a mouse:
> >
> >       aid 0x000d (IconURL)
> >          < < < uuid-16 0x0100 (L2CAP) uint 0x13 > < uuid-16 0x0011 (HIDP) > > >
>
> Reposting because there was no response to this, patch is attached..
>
> See "5.1.6 AdditionalProtocolDescriptorList attribute" and "5.1.14 IconURL
> Attribute" sections in the core specification for reference..
>
> (they sometimes call it AdditionalProtocolDescriptorLists and that is more
> accurate as more than one protocol descriptor list may be included)

posting this simple (and easily verified) patch for hcidump for the third
time..

regards,
iain
--0-1804564332-1266312330=:1624
Content-Type: TEXT/PLAIN; charset=US-ASCII; name=patch.txt
Content-Transfer-Encoding: BASE64
Content-ID: <alpine.NEB.2.00.1002160925290.1624@localhost.>
Content-Description: fix SDP universal attributes
Content-Disposition: attachment; filename=patch.txt

LS0tIHBhcnNlci9zZHAuYy5vcmlnCTIwMDktMTEtMzAgMTk6Mjk6MzEuMDAw
MDAwMDAwICswMDAwDQorKysgcGFyc2VyL3NkcC5jDQpAQCAtMTk0LDggKzE5
NCw4IEBAIHN0YXRpYyBzZHBfYXR0cl9pZF9uYW1fbG9va3VwX3RhYmxlX3Qg
c2QNCiAJeyBTRFBfQVRUUl9JRF9CTFVFVE9PVEhfUFJPRklMRV9ERVNDUklQ
VE9SX0xJU1QsICJCVFByb2ZpbGVEZXNjTGlzdCIgIH0sDQogCXsgU0RQX0FU
VFJfSURfRE9DVU1FTlRBVElPTl9VUkwsICAgICAgICAgICAgICAgICAiRG9j
VVJMIiAgICAgICAgICAgICB9LA0KIAl7IFNEUF9BVFRSX0lEX0NMSUVOVF9F
WEVDVVRBQkxFX1VSTCwgICAgICAgICAgICAgIkNsaWVudEV4ZVVSTCIgICAg
ICAgfSwNCi0JeyBTRFBfQVRUUl9JRF9JQ09OXzEwLCAgICAgICAgICAgICAg
ICAgICAgICAgICAgICJJY29uMTAiICAgICAgICAgICAgIH0sDQogCXsgU0RQ
X0FUVFJfSURfSUNPTl9VUkwsICAgICAgICAgICAgICAgICAgICAgICAgICAi
SWNvblVSTCIgICAgICAgICAgICB9LA0KKwl7IFNEUF9BVFRSX0lEX0FERElU
SU9OQUxfUFJPVE9DT0xfREVTQ19MSVNUUywgICAgIkFkZGl0aW9uYWxQcm90
b2NvbERlc2NMaXN0cyIgfSwNCiAJeyBTRFBfQVRUUl9JRF9TRVJWSUNFX05B
TUUsICAgICAgICAgICAgICAgICAgICAgICJTcnZOYW1lIiAgICAgICAgICAg
IH0sDQogCXsgU0RQX0FUVFJfSURfU0VSVklDRV9ERVNDUklQVElPTiwgICAg
ICAgICAgICAgICAiU3J2RGVzYyIgICAgICAgICAgICB9LA0KIAl7IFNEUF9B
VFRSX0lEX1BST1ZJREVSX05BTUUsICAgICAgICAgICAgICAgICAgICAgIlBy
b3ZpZGVyTmFtZSIgICAgICAgfSwNCi0tLSBwYXJzZXIvc2RwLmgub3JpZwky
MDA5LTExLTMwIDE5OjI5OjM1LjAwMDAwMDAwMCArMDAwMA0KKysrIHBhcnNl
ci9zZHAuaA0KQEAgLTEyOSw4ICsxMjksOCBAQA0KICNkZWZpbmUgU0RQX0FU
VFJfSURfQkxVRVRPT1RIX1BST0ZJTEVfREVTQ1JJUFRPUl9MSVNUICAweDAw
MDkNCiAjZGVmaW5lIFNEUF9BVFRSX0lEX0RPQ1VNRU5UQVRJT05fVVJMICAg
ICAgICAgICAgICAgICAgMHgwMDBBDQogI2RlZmluZSBTRFBfQVRUUl9JRF9D
TElFTlRfRVhFQ1VUQUJMRV9VUkwgICAgICAgICAgICAgIDB4MDAwQg0KLSNk
ZWZpbmUgU0RQX0FUVFJfSURfSUNPTl8xMCAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAweDAwMEMNCi0jZGVmaW5lIFNEUF9BVFRSX0lEX0lDT05fVVJM
ICAgICAgICAgICAgICAgICAgICAgICAgICAgMHgwMDBEDQorI2RlZmluZSBT
RFBfQVRUUl9JRF9JQ09OX1VSTCAgICAgICAgICAgICAgICAgICAgICAgICAg
IDB4MDAwQw0KKyNkZWZpbmUgU0RQX0FUVFJfSURfQURESVRJT05BTF9QUk9U
T0NPTF9ERVNDX0xJU1RTICAgICAweDAwMEQNCiAjZGVmaW5lIFNEUF9BVFRS
X0lEX1NFUlZJQ0VfTkFNRSAgICAgICAgICAgICAgICAgICAgICAgMHgwMTAw
DQogI2RlZmluZSBTRFBfQVRUUl9JRF9TRVJWSUNFX0RFU0NSSVBUSU9OICAg
ICAgICAgICAgICAgIDB4MDEwMQ0KICNkZWZpbmUgU0RQX0FUVFJfSURfUFJP
VklERVJfTkFNRSAgICAgICAgICAgICAgICAgICAgICAweDAxMDINCg==

--0-1804564332-1266312330=:1624--


