Return-Path: <cyrus@holtmann.org>
Date: Wed, 11 Feb 2009 11:24:15 +0000 (GMT)
To: GianPiero Puccioni <gianpiero.puccioni@isc.cnr.it>
Cc: "Li\, Zhigang" <zhigang.li@intel.com>,
	"linux-bluetooth\@vger\.kernel\.org"
	<linux-bluetooth@vger.kernel.org>
Subject: Re: Obex Push
In-Reply-To: <4992A7A4.1010802@isc.cnr.it>
References: <49929929.5090206@isc.cnr.it>
 <B94C62E7C2870743865418621F040C13069A3431@pdsmsx502.ccr.corp.intel.com>
 <4992A467.2030504@isc.cnr.it> <B94C62E7C2870743865418621F040C13069A3435@pdsmsx502.ccr.corp.intel.com>
 <4992A7A4.1010802@isc.cnr.it>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Message-Id: <1234351455.708556.26913.nullmailer@galant.ukfsn.org>
From: Iain Hibbert <plunky@rya-online.net>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Wed, 11 Feb 2009, GianPiero Puccioni wrote:

> Li, Zhigang wrote:
>
> .....
>
> >> I have seen it but I don't know python, in fact I forgot to say the program should be
> >>  a small command line C program, something like "opush  00:11:9F:4B:A1:D9 text.txt"
> >> as I have to use it in bash script.
> > ./send-files [target address] /home/text.txt
> >
> Unfortunately I cannot use it as I cannot compile obexd (my linux is a little outdated and
> my libglib is too old). That's why I was trying to write my own C prog as I used Bluez
> before for another project.

you could use 'obexftp' or 'obexapp' either directly or as examples to do
this, both use 'openobex' library. See

	http://openobex.triq.net/
	http://www.geocities.com/m_evmenkin/

(obexapp was written for FreeBSD and provides server capability also but
perhaps it would be possible to adapt it to bluez..)

iain
