Return-Path: <cyrus@holtmann.org>
Message-ID: <4DCCEB4E.7040600@nokia.com>
Date: Fri, 13 May 2011 11:26:54 +0300
From: Mika Linnanoja <mika.linnanoja@nokia.com>
MIME-Version: 1.0
To: ext Suraj Sumangala <Suraj.Sumangala@Atheros.com>
CC: Eponymous - <the.epon@gmail.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: HCI data payload not getting through when using BlueZ
References: <BANLkTimHaJaCjawT2JuW0kH18ihkyVr5Yg@mail.gmail.com>	<20110511164736.GA22065@joana>	<BANLkTimFMZ+ohvJsmD9NV7WqFqtX1W4yXw@mail.gmail.com>,<BANLkTi=t-0QPSV4ZOqCA=OMZaGRhcga+FA@mail.gmail.com> <44EE5C37ADC36343B0625A05DD408C48517CE84134@CHEXMB-01.global.atheros.com>
In-Reply-To: <44EE5C37ADC36343B0625A05DD408C48517CE84134@CHEXMB-01.global.atheros.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On 05/13/2011 11:13 AM, ext Suraj Sumangala wrote:
> You have to enable it in the cofigure file and change "test_enable" from "no" to "yes".
> Edit the file "configure", search for "test_enable"
> change "test_enable=no" to "test_enable=yes"
>
> That is what I do to enable l2test. I guess there could be some other cleaner way to do it.

./configure --help :)

If you pull from the git repo ./bootstrap-configure already enables most of them.

Although lately configure is often *not* complaining if something is missing 
from build dependencies, have to do a bit of trial & error to get it right.

This is very easy to notice when trying to 'make' bluez on a clean system 
where it hasn't ever been built before.

Cheers,
Mika
