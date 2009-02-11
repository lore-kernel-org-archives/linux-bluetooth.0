Return-Path: <cyrus@holtmann.org>
Message-ID: <4992B59D.4090205@isc.cnr.it>
Date: Wed, 11 Feb 2009 12:25:17 +0100
From: GianPiero Puccioni <gianpiero.puccioni@isc.cnr.it>
MIME-Version: 1.0
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: Obex Push
References: <49929929.5090206@isc.cnr.it> <B94C62E7C2870743865418621F040C13069A3431@pdsmsx502.ccr.corp.intel.com> <4992A467.2030504@isc.cnr.it> <B94C62E7C2870743865418621F040C13069A3435@pdsmsx502.ccr.corp.intel.com>
In-Reply-To: <B94C62E7C2870743865418621F040C13069A3435@pdsmsx502.ccr.corp.intel.com>
Content-Type: text/plain; charset=GB2312
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Thierry Pierret wrote:
> I'm using obexd-0.8 on my iMX31 platform. Since I could not compile the
> D-Bus Python binding, I could not use the test Python scripts. Hence I
> create some small C programs to replace the send-file and the
> pull-business-card scripts. Here is the package I created. I provide it
> as-is.
>
>
>
> 2 programs available :
>
>    sender <00:11:22:33:44:55:66> <filename>
>    puller <00:11:22:33:44:55:66> <filename>
>
> The puller program could not be fully tested (cf. a former topic "Obexd
> 0.8 : pull failure").
>
> Hoping this helps.
>
> Regards.
> Thierry

Thanks, I tried it but it doesn't seem to work on my phone, it's a good starting point to
study 'tho. Just as an info, it does an Obex "Send" (FTP like) not a "Push"? From what I
understand there is a difference but I am not sure as I cannot find info on the subject.

I was able to use "gnome-obex-send" which seems to work. Does anyone knows where can I
find the source of that?

Thaks,
GiP
-- 
GianPiero Puccioni               |Istituto dei Sistemi Complessi-CNR
gianpiero.puccioni(AT)isc.cnr.it |Via Madonna del Piano, 10
T:+39 0555226682 F:+39 0555226683|50019 Sesto F. (Firenze)
