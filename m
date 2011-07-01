Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1308741214.6042.81.camel@novo.hadess.net>
References: <1308275200-17393-1-git-send-email-lucas.demarchi@profusion.mobi> <1308741214.6042.81.camel@novo.hadess.net>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Date: Fri, 1 Jul 2011 19:43:39 -0300
Message-ID: <BANLkTimZvHdFCHMfTAHXjXzzre6ccMO9CQ@mail.gmail.com>
Subject: Re: [PATCH v2] build: Add support for systemd service configuration
To: Bastien Nocera <hadess@hadess.net>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Bastien,

On Wed, Jun 22, 2011 at 8:13 AM, Bastien Nocera <hadess@hadess.net> wrote:
> On Thu, 2011-06-16 at 22:46 -0300, Lucas De Marchi wrote:
>> ---
>>  .gitignore               |    1 +
>>  Makefile.am              |    8 +++++++-
>>  configure.ac             |   11 ++++++++++-
>>  src/bluetooth.service.in |   12 ++++++++++++
>>  4 files changed, 30 insertions(+), 2 deletions(-)
>>  create mode 100644 src/bluetooth.service.in
>
> It seems to be pretty much the same as Lennart's patch which I posted
> last year:
> http://thread.gmane.org/gmane.linux.bluez.kernel/8645
>
> Any reasons why you cooked up your own? What are the differences?

I didn't see that patch before sending these ones.

But it's a bit different from what we have in ConnMan and oFono. I've
based mine on these other projects since I already participated on
them and I'm starting on BlueZ now.

regards,
Lucas De Marchi
