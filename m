Return-Path: <sjoerd@spring.luon.net>
Date: Wed, 30 Jun 2004 23:30:36 +0200
From: Sjoerd Simons <sjoerd@spring.luon.net>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
Subject: Re: [Bluez-devel] btaddr <-> name bug ?
Message-ID: <20040630213036.GA4801@spring.luon.net>
References: <20040630190206.GB26352@spring.luon.net> <1088630304.4540.188.camel@pegasus>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="gBBFr7Ir9EOA20Yy"
In-Reply-To: <1088630304.4540.188.camel@pegasus>
List-ID: <bluez-devel.lists.sourceforge.net>


--gBBFr7Ir9EOA20Yy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jun 30, 2004 at 11:18:24PM +0200, Marcel Holtmann wrote:
> Hi Sjoerd,
> 
> >   Doing hcitool scan a few times gives some weird output:
> > 
> > $ hcitool scan
> > Scanning ...
> >         00:0D:93:08:60:89       familiar (0)
> >         00:02:C7:0B:97:F9       spring-0
> > $ hcitool scan
> > Scanning ...
> >         00:0D:93:08:60:89       spring-0
> >         00:02:C7:0B:97:F9       familiar (0)
> > $ hcitool scan
> > Scanning ...
> >         00:0D:93:08:60:89       spring-0
> >         00:02:C7:0B:97:F9       familiar (0)
> > $ hcitool scan
> > Scanning ...
> >         00:0D:93:08:60:89       familiar (0)
> >         00:02:C7:0B:97:F9       spring-0
> > 
> > The second and third run provide the right information, the first and last are 
> > wrong.
> 
> provide us with the output of "hcidump -x" while you are running
> "hcitool scan".

Attached is the hcidump -x output, while doing a hcitool scan which provided
the wrong information.

  Sjoerd
-- 
Let us not look back in anger or forward in fear, but around us in awareness.
		-- James Thurber

--gBBFr7Ir9EOA20Yy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=hcidump-namemixup

HCIDump - HCI packet analyzer ver 1.5
device: hci0 snap_len: 1028 filter: 0xffffffff
< HCI Command: Inquiry(0x01|0x0001) plen 5
  33 8B 9E 08 64 
> HCI Event: Command Status(0x0f) plen 4
  00 01 01 04 
> HCI Event: Inquiry Result(0x02) plen 15
  01 89 60 08 93 0D 00 01 00 00 00 01 00 55 09 
> HCI Event: Inquiry Result(0x02) plen 15
  01 F9 97 0B C7 02 00 01 00 00 12 01 12 33 6C 
> HCI Event: Inquiry Complete(0x01) plen 1
  00 
< HCI Command: Remote Name Request(0x01|0x0019) plen 10
  89 60 08 93 0D 00 01 00 00 00 
> HCI Event: Command Status(0x0f) plen 4
  00 01 19 04 
< HCI Command: Remote Name Request(0x01|0x0019) plen 10
  F9 97 0B C7 02 00 02 00 00 00 
> HCI Event: Command Status(0x0f) plen 4
  00 00 19 04 
> HCI Event: Remote Name Req Complete(0x07) plen 255
  00 89 60 08 93 0D 00 73 70 72 69 6E 67 2D 30 00 00 00 00 00 
  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
> HCI Event: Command Status(0x0f) plen 4
  00 01 00 00 
< HCI Command: Remote Name Request(0x01|0x0019) plen 10
  89 60 08 93 0D 00 02 00 00 00 
> HCI Event: Command Status(0x0f) plen 4
  00 00 19 04 
> HCI Event: Remote Name Req Complete(0x07) plen 255
  00 F9 97 0B C7 02 00 66 61 6D 69 6C 69 61 72 20 28 30 29 00 
  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
> HCI Event: Command Status(0x0f) plen 4
  00 01 00 00 
< HCI Command: Remote Name Request(0x01|0x0019) plen 10
  F9 97 0B C7 02 00 01 00 00 00 
> HCI Event: Command Status(0x0f) plen 4
  00 00 19 04 
> HCI Event: Remote Name Req Complete(0x07) plen 255
  00 89 60 08 93 0D 00 73 70 72 69 6E 67 2D 30 00 00 00 00 00 
  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
> HCI Event: Command Status(0x0f) plen 4
  00 01 00 00 
> HCI Event: Remote Name Req Complete(0x07) plen 255
  00 F9 97 0B C7 02 00 66 61 6D 69 6C 69 61 72 20 28 30 29 00 
  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 

--gBBFr7Ir9EOA20Yy--
