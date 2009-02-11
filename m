Return-Path: <cyrus@holtmann.org>
Message-ID: <4992A467.2030504@isc.cnr.it>
Date: Wed, 11 Feb 2009 11:11:51 +0100
From: GianPiero Puccioni <gianpiero.puccioni@isc.cnr.it>
MIME-Version: 1.0
To: "Li, Zhigang" <zhigang.li@intel.com>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: Obex Push
References: <49929929.5090206@isc.cnr.it> <B94C62E7C2870743865418621F040C13069A3431@pdsmsx502.ccr.corp.intel.com>
In-Reply-To: <B94C62E7C2870743865418621F040C13069A3431@pdsmsx502.ccr.corp.intel.com>
Content-Type: text/plain; charset=GB2312
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Li, Zhigang wrote:
>> -----Original Message----- From: linux-bluetooth-owner@vger.kernel.org 
>> [mailto:linux-bluetooth-owner@vger.kernel.org] On Behalf Of GianPiero Puccioni Sent:
>> 2009Äê2ÔÂ11ÈÕ 17:24 To: linux-bluetooth@vger.kernel.org Subject: Obex Push
>> 
>> Hi,
>> 
>> I am trying to write a small program to do an Obex push of a text file to a cell 
>> phone but I am having problems finding info on how to do this using the Bluez
>> library. Where can I find a manual or an example about this?
> 
> In test folder of obexd there was a test script:send-files It's ok to send file.
> 
Hi,

I have seen it but I don't know python, in fact I forgot to say the program should be a
small command line C program, something like "opush  00:11:9F:4B:A1:D9 text.txt" as I have
to use it in bash script.

Thanks
GiP
-- 
GianPiero Puccioni               |Istituto dei Sistemi Complessi-CNR
gianpiero.puccioni(AT)isc.cnr.it |Via Madonna del Piano, 10
T:+39 0555226682 F:+39 0555226683|50019 Sesto F. (Firenze)
