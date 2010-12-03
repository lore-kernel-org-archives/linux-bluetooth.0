Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <000301cb931c$74e56870$5eb03950$@org>
References: <1291305728-3463-1-git-send-email-ext-jablonski.radoslaw@nokia.com>
	<20101202162236.GA1291@jh-x301>
	<000001cb927b$08458e80$18d0ab80$@org>
	<35B17FE5076C7040809188FBE7913F98406D794075@SC1EXMB-MBCL.global.atheros.com>
	<AANLkTi=gWTQXcfisupHXs9qVpHbUbYZ1yxxqKf2Mm9EU@mail.gmail.com>
	<000301cb931c$74e56870$5eb03950$@org>
Date: Fri, 3 Dec 2010 15:09:18 -0400
Message-ID: <AANLkTiny7yAwumNyjSsdQVXgpOk8jMYD5OdBT+=ywArW@mail.gmail.com>
Subject: Re: Are LE connections possible yet?
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Brian Gix <bgix@codeaurora.org>
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>,
	Mike Tsai <Mike.Tsai@atheros.com>,
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Fri, Dec 3, 2010 at 3:01 PM, Brian Gix <bgix@codeaurora.org> wrote:
> [Gix] And how do I get gatttool to build? This may be academic until I get fixed channel 4 access via the new kernel.

gatttool is built along with bluez. Just be sure to use latest code
from GIT, and pass "--enable-attrib" to ./configure (or use
./bootstrap-configure)

Regards,
-- 
Anderson Lizardo
OpenBossa Labs - INdT
Manaus - Brazil
