Return-Path: <noring@nocrew.org>
Subject: Re: [Bluez-devel] D-Bus interfaces
From: Fredrik Noring <noring@nocrew.org>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1076331669.6869.164.camel@pegasus>
References: <1076265358.2670.36.camel@pegasus>
	 <1076266267.14742.38.camel@akka.yeti.nocrew.org>
	 <1076267396.2670.58.camel@pegasus>
	 <1076275689.14742.93.camel@akka.yeti.nocrew.org>
	 <1076277250.6869.24.camel@pegasus>
	 <1076278554.14742.112.camel@akka.yeti.nocrew.org>
	 <1076279508.6869.54.camel@pegasus>
	 <1076280612.14742.147.camel@akka.yeti.nocrew.org>
	 <1076282343.6869.65.camel@pegasus>
	 <1076284317.14742.179.camel@akka.yeti.nocrew.org>
	 <1076287085.6869.70.camel@pegasus>
	 <1076311376.14742.202.camel@akka.yeti.nocrew.org>
	 <1076321200.6869.75.camel@pegasus>
	 <1076322129.5263.28.camel@kalkyl.roxen.com>
	 <1076323138.6869.93.camel@pegasus>
	 <1076323602.5263.41.camel@kalkyl.roxen.com>
	 <1076324584.6869.109.camel@pegasus>
	 <1076327592.5263.64.camel@kalkyl.roxen.com>
	 <1076331669.6869.164.camel@pegasus>
Content-Type: text/plain; charset=iso-8859-1
Message-Id: <1076333024.5263.116.camel@kalkyl.roxen.com>
Mime-Version: 1.0
Date: Mon, 09 Feb 2004 14:23:44 +0100
List-ID: <bluez-devel.lists.sourceforge.net>

Marcel,

mån 2004-02-09 klockan 14.01 skrev Marcel Holtmann:
> this is only true if the plain file itself is designed in somekind of
> database format like /etc/passwd, but for hcid.conf that is not
> acceptable. The format of hcid.conf is more flexible and if a user has
> to edit this file, I don't wanna allow a program do edit it as well and
> introduce its own format style.

Why is the formating style a problem?

> So we have to separate some settings.

Is the formating style issue the main reason for introducing a binary
database instead of plain text?

> If we want a clean interface for the configuration stuff that is not
> covered by the HCI specification (like name cache etc.) we must go
> through these interface in all cases, because the hcid implementation is
> replaceable and the storage format also.

It would be great to have file storage documented and part of the interface 
as well. Forcing specialized tools isn't flexible and user/admin friendly.

Fredrik
