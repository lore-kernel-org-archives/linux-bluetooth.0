Return-Path: <cyrus@holtmann.org>
Message-ID: <4992A7A4.1010802@isc.cnr.it>
Date: Wed, 11 Feb 2009 11:25:40 +0100
From: GianPiero Puccioni <gianpiero.puccioni@isc.cnr.it>
MIME-Version: 1.0
To: "Li, Zhigang" <zhigang.li@intel.com>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: Obex Push
References: <49929929.5090206@isc.cnr.it> <B94C62E7C2870743865418621F040C13069A3431@pdsmsx502.ccr.corp.intel.com> <4992A467.2030504@isc.cnr.it> <B94C62E7C2870743865418621F040C13069A3435@pdsmsx502.ccr.corp.intel.com>
In-Reply-To: <B94C62E7C2870743865418621F040C13069A3435@pdsmsx502.ccr.corp.intel.com>
Content-Type: text/plain; charset=GB2312
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Li, Zhigang wrote:

.....

>> I have seen it but I don't know python, in fact I forgot to say the program should be
>>  a small command line C program, something like "opush  00:11:9F:4B:A1:D9 text.txt"
>> as I have to use it in bash script.
> ./send-files [target address] /home/text.txt
> 
Unfortunately I cannot use it as I cannot compile obexd (my linux is a little outdated and
my libglib is too old). That's why I was trying to write my own C prog as I used Bluez
before for another project.

GiP
-- 
GianPiero Puccioni               |Istituto dei Sistemi Complessi-CNR
gianpiero.puccioni(AT)isc.cnr.it |Via Madonna del Piano, 10
T:+39 0555226682 F:+39 0555226683|50019 Sesto F. (Firenze)
