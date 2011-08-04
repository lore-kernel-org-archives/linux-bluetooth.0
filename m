Return-Path: <cyrus@holtmann.org>
Message-ID: <4E3A36BE.5050409@gmail.com>
Date: Thu, 04 Aug 2011 10:05:50 +0400
From: Nikolay Kachanov <nikolay.kachanov@gmail.com>
MIME-Version: 1.0
To: Gustavo Padovan <padovan@profusion.mobi>
CC: linux-bluetooth@vger.kernel.org
Subject: Re: BCM2035 problem
References: <CA+16OfjbEJmKrog5aMXCNLyBrqW7sMCoqV4QvkYgn765LWsvsg@mail.gmail.com> <20110803174652.GB28119@joana>
In-Reply-To: <20110803174652.GB28119@joana>
Content-Type: multipart/mixed;
 boundary="------------060706020005030902010007"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This is a multi-part message in MIME format.
--------------060706020005030902010007
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hi Gustavo,

On 08/03/2011 09:46 PM, Gustavo Padovan wrote:
> * Nikolay Kachanov <nikolay.kachanov@gmail.com> [2011-08-03 09:15:40 +0400]:
>> With all versions of bluez above 4.84, including 4.96, my cellular
>> phone and PC can pair via Broadcom BCM2035 USB dongle, but every
>> attempt of file exchange ends with a complain about other side is not
>> responding.
>> Is that a bug or BCM2035 is not supported any more?
>> My OS is Arch Linux, both i686 and x86_64. I can provide more
>> information if necessary.
> 
> An hcidump output would be good. Also send the log of obexd -nd.

Please see attachment. I'm sending you the output of obex-data-server
-nd, not obexd. As far as I understand, obex-data-server is installed on
my PCs as a mandatory dependency of gnome-shell. There is obexd-server
package in official Arch repository, but it conflicts with obex-data-server.

Nikolay

--------------060706020005030902010007
Content-Type: application/x-gzip;
 name="dump.tar.gz"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="dump.tar.gz"

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
HQBoAQA=
--------------060706020005030902010007--
